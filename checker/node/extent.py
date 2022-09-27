"""Checks for the spatial and temporal extents.

The meaning of time is still an open issue:

https://github.com/radiantearth/stac-spec/issues/1182

https://github.com/radiantearth/stac-spec/blob/master/collection-spec/collection-spec.md#extent-object

Example valid extents at python:

{'extent': {
    'spatial': {'bbox': [[-1.2, 7.8, 2.3, 8.9]]},
    'temporal': {
        'interval': [['2009-01-01T00:00:00Z', '2055-01-01T00:00:00Z']]}}}

{'extent': {
    'spatial': {'bbox': [[-1.2, 7.8, 2.3, 8.9]]},
    'temporal': {'interval': [['2009-01-01T00:00:00Z', None]]}}}
"""

import datetime
from typing import Iterator

from checker import stac

BBOX = 'bbox'
EXTENT = 'extent'
INTERVAL = 'interval'
SPATIAL = 'spatial'
TEMPORAL = 'temporal'

COORD_SIZE = 4  # x1, y1, x2, y2
EARLIEST = datetime.datetime(1600, 1, 1, tzinfo=datetime.timezone.utc)
# TODO(schwehr): How far in the future is ok?  Assuming climate models.
NEWEST = datetime.datetime(2500, 1, 1, tzinfo=datetime.timezone.utc)
ISO8601 = '%Y-%m-%dT%H:%M:%S%z'


class Check(stac.NodeCheck):
  """Checks the extent field."""
  name = 'extent'

  @classmethod
  def check_spatial(
      cls: ..., node: stac.Node, extent: ...) -> Iterator[stac.Issue]:
    if SPATIAL not in extent:
      yield cls.new_issue(node, f'Extent must have "{SPATIAL}"')
      return

    spatial = extent[SPATIAL]

    if not isinstance(spatial, dict):
      yield cls.new_issue(node, f'"{SPATIAL}" must be a dict')
      return

    if BBOX not in spatial:
      yield cls.new_issue(node, f'"{SPATIAL}" must have: "{BBOX}"')
      return

    if list(spatial) != [BBOX]:
      yield cls.new_issue(node, f'"{SPATIAL}" must only have one key: "{BBOX}"')

    bbox = spatial[BBOX]
    if not isinstance(bbox, list):
      yield cls.new_issue(node, f'"{BBOX}" must be a list')
      return

    if len(bbox) != 1:
      yield cls.new_issue(node, f'"{BBOX}" must be a list of length 1')
      return

    coord = bbox[0]
    if not isinstance(coord, list):
      yield cls.new_issue(node, 'coord must be a list')
      return

    if len(coord) != COORD_SIZE:
      message = f'coord length must be {COORD_SIZE}.  Found {len(coord)}'
      yield cls.new_issue(node, message)
      return

    for val in coord:
      if not isinstance(val, (int, float)):
        yield cls.new_issue(node, f'coord must be a number.  Found {type(val)}')
        return

    x1, y1, x2, y2 = coord
    if x1 < -180:
      yield cls.new_issue(node, f'x1: {x1} < -180')
    if x2 > 180:
      yield cls.new_issue(node, f'x2: {x2} > 180')
    if y1 < -90:
      yield cls.new_issue(node, f'y1: {y1} < -90')
    if y2 > 90:
      yield cls.new_issue(node, f'y2: {y2} > 90')

    if x1 >= x2:
      yield cls.new_issue(node, f'x1 >= x2: {x1} >= {x2}')
    if y1 >= y2:
      yield cls.new_issue(node, f'y1 >= y2: {y1} >= {y2}')

  @classmethod
  def check_temporal(
      cls: ..., node: stac.Node, extent: ...) -> Iterator[stac.Issue]:
    if TEMPORAL not in extent:
      yield cls.new_issue(node, f'Extent must have "{TEMPORAL}"')
      return

    temporal = extent[TEMPORAL]
    if not isinstance(temporal, dict):
      yield cls.new_issue(node, f'"{TEMPORAL}" must be a dict')
      return

    if INTERVAL not in temporal:
      yield cls.new_issue(node, f'"{TEMPORAL}" have an "{INTERVAL}"')
      return

    if list(temporal) != [INTERVAL]:
      message = f'"{TEMPORAL}" must only have one key: "{INTERVAL}"'
      yield cls.new_issue(node, message)

    interval = temporal[INTERVAL]
    if not isinstance(interval, list):
      yield cls.new_issue(node, f'"{INTERVAL}" must be a list')
      return

    if len(interval) != 1:
      yield cls.new_issue(node, f'"{INTERVAL}" must be a list of len 1')
      return

    first_interval = interval[0]
    if not isinstance(first_interval, list):
      yield cls.new_issue(node, 'First interval must be a list of list')
      return

    if len(first_interval) != 2:
      message = 'First interval must have 2 elements: start and end'
      yield cls.new_issue(node, message)
      return

    # end is currently allowed be None for on going datasets. This may change.
    start, end = first_interval
    try:
      start_date = datetime.datetime.strptime(start, ISO8601)
    except ValueError:
      yield cls.new_issue(node, f'Unable to parse start date "{start}"')
      return

    if start_date < EARLIEST:
      yield cls.new_issue(node, f'{start_date} is before {EARLIEST}')

    if end:
      try:
        end_date = datetime.datetime.strptime(end, ISO8601)
      except ValueError:
        yield cls.new_issue(node, f'Unable to parse end date "{end}"')
        return

      if end_date > NEWEST:
        yield cls.new_issue(node, f'{end_date} is after {NEWEST}')

      if start_date > end_date:
        message = f'start is after end: {start_date} > {end_date}'
        yield cls.new_issue(node, message)

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if node.type == stac.StacType.CATALOG:
      if EXTENT in node.stac:
        yield cls.new_issue(node, 'Catalogs cannot have extent')
      return

    if EXTENT not in node.stac:
      yield cls.new_issue(node, 'Collections must have extent')
      return

    extent = node.stac[EXTENT]
    if not isinstance(extent, dict):
      yield cls.new_issue(node, f'"{EXTENT}" must be a dict')
      return

    yield from cls.check_spatial(node, extent)
    yield from cls.check_temporal(node, extent)
