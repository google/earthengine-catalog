"""Querying EE STAC JSON files."""

from concurrent import futures
import datetime
import json
import logging
from typing import Iterable, Optional, Sequence

from google.cloud import storage
from google.cloud.storage import blob
import iso8601
import tenacity
import tqdm
from typing_extensions import Self

from checker import stac as stac_checker
from stac import bboxes
from stac import stac_lib


def matches_interval(
    collection_interval: tuple[datetime.datetime, datetime.datetime],
    query_interval: tuple[datetime.datetime, datetime.datetime],
):
  """Checks if the collection's datetime interval matches the query datetime.

  Args:
    collection_interval: Temporal interval of the collection.
    query_interval: a tuple with the query interval start and end

  Returns:
    True if the datetime interval matches
  """
  start_query, end_query = query_interval
  start_collection, end_collection = collection_interval
  if end_collection is None:
    # End date should always be set in STAC JSON files, but just in case...
    end_collection = datetime.datetime.now(tz=datetime.UTC)
  return end_query > start_collection and start_query <= end_collection


def matches_datetime(
    collection_interval: tuple[datetime.datetime, Optional[datetime.datetime]],
    query_datetime: datetime.datetime,
):
  """Checks if the collection's datetime interval matches the query datetime.

  Args:
    collection_interval: Temporal interval of the collection.
    query_datetime: a datetime coming from a query

  Returns:
    True if the datetime interval matches
  """
  if collection_interval[1] is None:
    # End date should always be set in STAC JSON files, but just in case...
    end_date = datetime.datetime.now(tz=datetime.UTC)
  else:
    end_date = collection_interval[1]
  return collection_interval[0] <= query_datetime <= end_date


class CollectionList(Sequence[stac_lib.Collection]):
  """List of stac.Collections; can be filtered to return a smaller sublist."""

  _collections = Sequence[stac_lib.Collection]

  def __init__(self, collections: Sequence[stac_lib.Collection]):
    self._collections = tuple(collections)

  # Define immutable list interface for convenience, though one could
  # argue this should be more like a set.
  def __iter__(self):
    return iter(self._collections)

  def __getitem__(self, index):
    return self._collections[index]

  def __len__(self):
    return len(self._collections)

  def __eq__(self, other: object) -> bool:
    if isinstance(other, CollectionList):
      return self._collections == other._collections
    return False

  def __hash__(self) -> int:
    return hash(self._collections)

  def filter_by_ids(self, ids: Iterable[str]) -> Self:
    """Returns a sublist with only the collections matching the given ids."""
    # Save a local copy of the input for safe iterations.
    ids_copy = tuple(ids)
    return self.__class__(
        [c for c in self._collections if c.public_id() in ids_copy]
    )

  def filter_by_types(self, gee_types: Iterable[str]) -> Self:
    """Returns a sublist with only the collections matching the given types."""
    # Save a local copy of the input for safe iterations.
    gee_types_copy = tuple(gee_types)
    for gee_type in gee_types_copy:
      if (
          stac_checker.GeeType(gee_type)
          not in stac_checker.GeeType.allowed_collection_types()
      ):
        raise ValueError(f'Type {gee_type} is not a valid GEE type.')
    return self.__class__(
        [c for c in self._collections if c.dataset_type() in gee_types_copy]
    )

  def filter_by_datetime(
      self,
      query_datetime: datetime.datetime,
  ) -> Self:
    """Returns a sublist with the time interval matching the given time."""
    result = []
    for collection in self._collections:
      for datetime_interval in collection.datetime_interval_list():
        if matches_datetime(datetime_interval, query_datetime):
          result.append(collection)
          break
    return self.__class__(result)

  def filter_by_interval(
      self,
      query_interval: tuple[datetime.datetime, datetime.datetime],
  ) -> Self:
    """Returns a sublist with the time interval matching the given interval."""
    result = []
    for collection in self._collections:
      for datetime_interval in collection.datetime_interval_list():
        if matches_interval(datetime_interval, query_interval):
          result.append(collection)
          break
    return self.__class__(result)

  def filter_by_bounding_box(self, query_bbox: bboxes.BBox) -> Self:
    """Returns a sublist with the bbox matching the given bbox."""
    result = []
    for collection in self._collections:
      for collection_bbox in collection.bbox_list():
        if collection_bbox.intersects(query_bbox):
          result.append(collection)
          break
    return self.__class__(result)


class Catalog:
  """Class containing all collections in the EE STAC catalog."""

  collections: CollectionList

  def __init__(self, storage_client: storage.Client):
    self.collections = CollectionList(self._load_collections(storage_client))

  @tenacity.retry(
      stop=tenacity.stop_after_attempt(5),
      wait=tenacity.wait_exponential(multiplier=1, min=4, max=10),
  )
  def _read_file(self, file_blob: blob.Blob) -> stac_lib.Collection:
    """Reads the contents of a file from the specified bucket with retry logic."""
    file_contents = file_blob.download_as_string().decode()
    return stac_lib.Collection(json.loads(file_contents))

  def _read_files(
      self, file_blobs: list[blob.Blob]
  ) -> list[stac_lib.Collection]:
    """Processes files in parallel with a progress bar."""
    result = []
    with futures.ThreadPoolExecutor(max_workers=10) as executor:
      file_futures = [
          executor.submit(self._read_file, file_blob)
          for file_blob in file_blobs
      ]
      for future in tqdm.tqdm(
          futures.as_completed(file_futures),
          total=len(file_futures),
          desc='Reading files',
      ):
        result.append(future.result())
    return result

  def _load_collections(
      self, storage_client: storage.Client
  ) -> Sequence[stac_lib.Collection]:
    """Loads all EE STAC JSON files from GCS, with datetimes as objects."""
    bucket = storage_client.get_bucket('earthengine-stac')
    files = [
        x
        for x in bucket.list_blobs(prefix='catalog/')
        if x.name.endswith('.json')
        and not x.name.endswith('/catalog.json')
        and not x.name.endswith('/units.json')
    ]
    logging.warning('Found %d files, loading...', len(files))
    stac_objects = self._read_files(files)

    res = []
    for c in stac_objects:
      if c.is_deprecated():
        continue
      res.append(c)
    logging.warning(
        'Loaded %d collections (skipping deprecated ones)', len(res)
    )
    # Returning a tuple for immutability.
    return tuple(res)


def main():
  storage_client = storage.Client()
  catalog = Catalog(storage_client)
  collections = catalog.collections

  # Example usage
  start_time = iso8601.parse_date('2022-01-01T00:00:00Z')
  end_time = iso8601.parse_date('2022-12-31T23:59:59Z')
  filtered_by_interval = collections.filter_by_interval((start_time, end_time))
  print(f'Collections filtered by time interval ({start_time} - {end_time}):')
  print(len(filtered_by_interval))

  filtered_by_time = collections.filter_by_datetime(start_time)
  print(f'Collections filtered by time {start_time}:')
  print(len(filtered_by_time))

  bbox = bboxes.BBox.from_list([-120, 30, -100, 40])
  filtered_by_bbox = collections.filter_by_bounding_box(bbox)
  print(f'\nCollections filtered by bounding box {bbox}:')
  print(len(filtered_by_bbox))


if __name__ == '__main__':
  main()
