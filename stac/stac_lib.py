"""Utilities for working with the Earth Engine STAC catalog."""

from __future__ import annotations

import dataclasses
import datetime
import enum
import functools
from typing import Any, Iterable, Iterator, Optional, Sequence, Union

from absl import logging
import iso8601
import stringcase

from checker import stac as stac_checker
from stac import bboxes
from stac import constants
from stac import errors


# STAC field names
ID: str = 'id'
FEATURE_VIEW_INGESTION_PARAMS: str = 'gee:feature_view_ingestion_params'
INTERVAL: str = 'gee:interval'
IS_DERIVED: str = 'gee:is_derived'
USER_UPLOADED: str = 'gee:user_uploaded'

CATALOG_OWNER_ID = 'gee:catalog_owner_id'
CATALOG_OWNER_TYPE = 'gee:catalog_owner_type'


def listify(gen):
  """Converts a generator into a function that returns a list."""

  @functools.wraps(gen)
  def wrapped(*args, **kwargs):
    return list(gen(*args, **kwargs))

  return wrapped


def iso_format(dt: datetime.datetime) -> str:
  """Drops the UTC timezone suffix and uses Z to match STAC."""
  return dt.isoformat().replace('+00:00', 'Z')


class Role(enum.Enum):
  HOST = 'host'
  LICENSOR = 'licensor'
  PROCESSOR = 'processor'
  PRODUCER = 'producer'


@dataclasses.dataclass
class Provider:
  """Represents a STAC Provider.

  https://github.com/radiantearth/stac-spec/blob/master/item-spec/common-metadata.md#provider
  """
  name: str
  description: Optional[str] = None
  roles: list[Role] = dataclasses.field(default_factory=list)
  url: Optional[str] = None

  # Fields that are not in the STAC provider section.
  # However, they are in dataset_pb2.Provider.
  instruments: list[str] = dataclasses.field(default_factory=list)
  platforms: list[str] = dataclasses.field(default_factory=list)
  file_links: list[str] = dataclasses.field(default_factory=list)

  @classmethod
  def from_stac(cls, stac_provider: dict[str, str]) -> Provider:
    """Creates a Link from a STAC provider dictionary."""
    provider = cls(stac_provider['name'])
    for field in ('description', 'url'):
      value = stac_provider.get(field)
      if value is not None:
        setattr(provider, field, value)

    roles = stac_provider.get('roles')
    if roles:
      roles = [Role(role) for role in roles]
      provider.roles.extend(roles)

    return provider


class Rel(enum.Enum):
  """All the possible link relationship types for Earth Engine STAC.

  https://www.iana.org/assignments/link-relations/link-relations.xhtml
  """
  CHILD = 'child'
  CITE = 'cite-as'
  LICENSE = 'license'
  PARENT = 'parent'
  PREVIEW = 'preview'
  RELATED = 'related'
  ROOT = 'root'
  SELF = 'self'
  SOURCE = 'source'
  # https://github.com/stac-extensions/version
  LATEST = 'latest-version'
  PREDECESSOR = 'predecessor-version'
  SUCCESSOR = 'successor-version'

  def __str__(self):
    return self._value_


@dataclasses.dataclass
class Link:
  """Represents a STAC Link."""
  rel: Rel  # The only required member is the relationship

  href: Optional[str] = None
  code: Optional[str] = None  # Programming language
  media_type: Optional[str] = None
  title: Optional[str] = None

  @classmethod
  def from_stac(cls, link: dict[str, str]) -> Link:
    """Creates a Link from a STAC link dictionary."""
    return cls(
        Rel(link['rel']), link.get('href'), link.get('code'),
        link.get('type'), link.get('title'))


@dataclasses.dataclass
class PropertyValue:
  value: str
  description: str


@dataclasses.dataclass
class Property:
  """Represents a STAC gee:property."""
  name: str
  description: str
  type: str

  # TODO(simonf): Handle repeated PropertyValue values
  # https://www.attrs.org/en/stable/types.html

  units: Optional[str] = None
  minimum: Optional[float] = None
  maximum: Optional[float] = None
  estimated_range: Optional[bool] = None

  @classmethod
  def from_stac(cls, stac_property: dict[str, Any]) -> Property:
    """Creates a Property from a STAC property dictionary."""
    prop = cls(stac_property['name'], stac_property['description'],
               stac_property['type'])
    # The range statistics fields current sit outside the properties:
    #  gee:estimated_range, minimum, and maximum
    for field in ['units']:
      value = stac_property.get(field)
      dest_field = field.replace('gee:', '')
      if value is not None:
        setattr(prop, dest_field, value)
    return prop

  def set_range_stats(self, range_stats: dict[str, Any]) -> None:
    stats = range_stats.get(self.name)
    if not stats:
      return

    self.estimated_range = stats['gee:estimated_range']
    self.minimum = stats['minimum']
    self.maximum = stats['maximum']


@dataclasses.dataclass
class CategoricalValue:
  """Represents a STAC gee:classes entry and CategoricalValue proto."""
  value: int
  description: str
  color: Optional[str] = None
  css_color: Optional[str] = None

  @classmethod
  def from_stac(cls, stac_class: dict[str, Any]) -> CategoricalValue:
    """Fills out a CategoricalValue from a STAC class dictionary."""
    cat = cls(value=stac_class['value'], description=stac_class['description'])

    color: Optional[str] = stac_class.get('color')
    if color:
      cat.color = cat.css_color = color
      if color not in constants.ALLOWED_COLOR_NAMES:
        # Then it has to be rrggbb hex. Make sure that it starts with #
        if color[0] != '#':
          cat.css_color = '#' + color

    return cat


@dataclasses.dataclass
class BitmaskValue:
  """Represents a Band Bitmask part's individual value."""
  value: int
  description: str

  @classmethod
  def from_stac(cls, stac_bitmask_value: dict[str, Any]) -> BitmaskValue:
    """Fills out a BitmaskValue from a STAC BitmaskValue dictionary."""

    bitmask_value = cls(
        value=stac_bitmask_value['value'],
        description=stac_bitmask_value['description'])

    return bitmask_value


@dataclasses.dataclass
class BitmaskPart:
  """Represents a Band Bitmask part."""
  description: str
  first_bit: int  # 0-based index of the lowest bit
  bit_count: int  # Number of bits in the pattern
  values: list[BitmaskValue] = dataclasses.field(default_factory=list)

  @classmethod
  def from_stac(cls, stac_bitmask_part: dict[str, Any]) -> BitmaskPart:
    """Fills out a BitmaskPart from a STAC BitmaskPart dictionary."""
    values = [
        BitmaskValue.from_stac(p) for p in stac_bitmask_part.get('values', [])
    ]
    return cls(
        description=stac_bitmask_part['description'],
        first_bit=stac_bitmask_part['first_bit'],
        bit_count=stac_bitmask_part['bit_count'],
        values=values)


@dataclasses.dataclass
class Bitmask:
  """Represents a Band Bitmask."""
  total_bit_count: int
  bitmask_parts: list[BitmaskPart] = dataclasses.field(default_factory=list)

  @classmethod
  def from_stac(cls, stac_bitmask: dict[str, Any]) -> Bitmask:
    """Fills out a Bitmask from a STAC Bitmask dictionary."""
    # Ignore the description as it is an aggregate of the components.
    parts = [
        BitmaskPart.from_stac(p) for p in stac_bitmask.get('bitmask_parts', [])
    ]
    return cls(
        total_bit_count=stac_bitmask['total_bit_count'], bitmask_parts=parts)


@dataclasses.dataclass
class Band:
  """Represents a STAC eo:band and Band proto.

  https://github.com/stac-extensions/eo
  """
  # eo:band standard fields
  name: str
  description: Optional[str] = None
  center_wavelength: Optional[float] = None
  full_width_half_max: Optional[float] = None
  # Unused standard fields: common_name, full_width_half_max, solar_illumination

  # Earth Engine-only fields
  offset: Optional[float] = None  # gee:offset
  classes: list[CategoricalValue] = dataclasses.field(
      default_factory=list
  )  # gee:classes
  polarization: Optional[str] = None  # gee:polarization - HH, HV, VV, VH
  scale: Optional[float] = None  # gee:scale
  units: str = ''  # gee:units
  wavelength: Optional[str] = None  # gee:wavelength
  center_frequency: Optional[float] = None  # sar:center_frequency
  bitmask: Optional[Bitmask] = None  # gee:bitmask
  gsd: Optional[float] = None  # Meters. Not in eo:band, but does not have gee:
  # The range info is stored in the summaries by band name.
  estimated_range: Optional[bool] = None
  minimum: Optional[float] = None
  maximum: Optional[float] = None

  @classmethod
  def from_stac(cls, stac_band: dict[str, Any]) -> Band:
    """Fills out a Band from a STAC band dictionary."""
    band = cls(name=stac_band['name'])

    stac_band_field_names = (
        'center_wavelength', 'description', 'full_width_half_max',
        'gee:offset', 'gee:polarization', 'gee:scale', 'gee:units',
        'gee:wavelength', 'gsd', 'sar:center_frequency')
    for field in stac_band_field_names:
      value = stac_band.get(field)
      if value is not None:
        dest_field = field.replace('gee:', '')
        dest_field = dest_field.replace('sar:', '')
        setattr(band, dest_field, value)

    band.classes = [
        CategoricalValue.from_stac(c) for c in stac_band.get('gee:classes', [])
    ]

    bitmask = stac_band.get('gee:bitmask')
    if bitmask:
      band.bitmask = Bitmask.from_stac(bitmask)

    return band


# See google3/geo/gestalt/proto/dataset.proto ImageCollection.time_interval
class IntervalType(enum.Enum):
  CADENCE = 'cadence'
  REVISIT = 'revisit_interval'
  CLIMATOLOGICAL = 'climatological_interval'


@dataclasses.dataclass
class Interval:
  """Represents a STAC gee:interval.

  Legacy info for Explorer.
  """
  interval_type: IntervalType
  unit: str
  interval: int

  @classmethod
  def from_stac(cls, stac_gee_interval: dict[str, Any]) -> Interval:
    """Fills out a Interval from a STAC Json dictionary."""
    interval = cls(interval_type=IntervalType(stac_gee_interval['type']),
                   unit=stac_gee_interval['unit'],
                   interval=int(stac_gee_interval['interval']))
    return interval

  def period(self) -> Optional[int]:
    """Returns days for the Explorer period for a given dataset cadence."""
    # Most things return zero to match the legacy behavior.
    if self.unit == 'day' and self.interval in [1, 8, 32]:
      return self.interval
    elif self.unit == 'year' and self.interval == 1:
      return 365
    else:
      logging.warning(
          'Unsupported Period unit: %s, interval: %d', self.unit, self.interval)
      return 0


@dataclasses.dataclass
class FeatureViewIngestionParams:
  """Represents a STAC gee:feature_view_ingestion_params."""
  max_features_per_tile: Optional[int] = None
  thinning_strategy: Optional[str] = None
  thinning_ranking: Optional[Union[str, list[str]]] = None
  z_order_ranking: Optional[Union[str, list[str]]] = None
  prerender_tiles: Optional[bool] = None
  min_vertices_per_tile: Optional[int] = None

  @classmethod
  def from_stac(cls, stac: dict[str, Any]) -> FeatureViewIngestionParams:
    """Fills out a GeeFeatureViewIngestionParams from a STAC Json dictionary."""
    return cls(
        max_features_per_tile=stac.get('max_features_per_tile'),
        thinning_strategy=stac.get('thinning_strategy'),
        thinning_ranking=stac.get('thinning_ranking'),
        z_order_ranking=stac.get('z_order_ranking'),
        prerender_tiles=stac.get('prerender_tiles'),
        min_vertices_per_tile=stac.get('min_vertices_per_tile'))

  def to_dict(self) -> dict[str, Any]:
    """Populates a dict with the attributes."""
    with_values_only = {
        k: v for k, v in dataclasses.asdict(self).items() if v is not None
    }
    # The keys are camel-cased because this dict is passed to the batch
    # Export.table.toFeatureView function.
    return {stringcase.camelcase(k): v for k, v in with_values_only.items()}


class Collection:
  """A simple wrapper for a STAC Collection.

  Assumes a valid STAC Collection.  Only very minimal error checking.

  Tries to be as lazy as possible.  Lazy evaluation means tests inputs can
  be much smaller.  Many users will only want a small subset of the data
  structure, so do not always pay the cost.
  """
  stac_json: dict[str, Any]

  def __init__(self, stac_json: dict[str, Any]):
    self.stac_json = stac_json
    if stac_json.get(stac_checker.GEE_STATUS) == stac_checker.Status.DEPRECATED:
      # Set the STAC 'deprecated' field that we don't set in the jsonnet files
      stac_json['deprecated'] = True

  def __getitem__(self, item: str) -> Any:
    return self.stac_json[item]

  def get(self, item: str, default: Optional[Any] = None) -> Optional[Any]:
    """Matches dict's get by returning None if there is no item."""
    return self.stac_json.get(item, default)

  def public_id(self) -> str:
    return self['id']

  def title(self) -> str:
    return self.stac_json['title']

  def description(self) -> str:
    return self.stac_json.get('description', '')

  def dataset_type(self) -> stac_checker.GeeType:
    return stac_checker.GeeType(self.stac_json['gee:type'])

  def terms_of_use(self) -> str:
    return self.stac_json.get('gee:terms_of_use', '')

  def bbox(self) -> bboxes.BBox:
    return self.bbox_list()[0]

  def bbox_list(self) -> Sequence[bboxes.BBox]:
    if 'extent' not in self.stac_json:
      # For testing, assume global if nothing listed.
      return (bboxes.BBox(-180, -90, 180, 90),)
    return tuple([
        bboxes.BBox.from_list(x)
        for x in self.stac_json['extent']['spatial']['bbox']
    ])

  # See also interval(), which returns an Interval object
  def datetime_interval(
      self,
  ) -> tuple[datetime.datetime, Optional[datetime.datetime]]:
    """Returns a pair of datetime objects representing first temporal extent."""
    return list(self.datetime_interval_list())[0]

  @listify
  def datetime_interval_list(
      self,
  ) -> Iterable[tuple[datetime.datetime, Optional[datetime.datetime]]]:
    """Returns datetime objects representing temporal extents."""
    for stac_interval in self.stac_json['extent']['temporal']['interval']:
      if not stac_interval[0]:
        raise ValueError(
            'Expected a non-empty temporal interval start for '
            + self.public_id()
        )
      start_date = iso8601.parse_date(stac_interval[0])
      if stac_interval[1] is not None:
        end_date = iso8601.parse_date(stac_interval[1])
      else:
        end_date = None
      yield (start_date, end_date)

  def start(self) -> datetime.datetime:
    return self.datetime_interval()[0]

  def end(self) -> Optional[datetime.datetime]:
    return self.datetime_interval()[1]

  def set_end(self, dt: datetime.datetime):
    self.stac_json['extent']['temporal']['interval'][0][1] = iso_format(dt)

  @listify
  def links(self, rel: Optional[Rel] = None) -> Iterator[Link]:
    links = self.stac_json['links']
    for link in links:
      link_rel = Rel(link['rel'])
      if rel and link_rel != rel:
        continue

      yield Link.from_stac(link)

  def _populate_file_links(self) -> list[str]:
    """Extracts file links from the STAC JSON."""
    file_links = []
    for link in self.links(Rel.SOURCE):
      if link.href:
        file_links.append(link.href)
    return file_links

  def providers(self) -> Iterator[Provider]:
    """Returns a list of Provider objects."""
    first_valid_provider_found = False

    if 'providers' in self.stac_json:
      for stac_provider in self.stac_json['providers']:
        provider = Provider.from_stac(stac_provider)
        if provider.name == 'Google Earth Engine':
          roles = set(provider.roles)
          # Ignore GEE unless it does more than just host the data.
          roles.discard(Role.HOST)
          if not roles:
            continue

        if not first_valid_provider_found:
          provider.instruments = self.stac_json['summaries'].get(
              'instruments', []
          )
          provider.platforms = self.stac_json['summaries'].get('platform', [])
          provider.file_links = self._populate_file_links()
          first_valid_provider_found = True

        yield provider
    else:
      return

  def dois(self) -> list[str]:
    """Returns all the DOIs found in links and the doi fields."""
    dois: set[str] = set()
    for link in self.links(Rel.CITE):
      href = link.href
      if href:
        dois.add(href.replace('https://doi.org/', ''))

    sci_doi = self.stac_json.get('sci:doi')
    if sci_doi:
      dois.add(sci_doi)
    sci_publications = self.stac_json.get('sci:publications', [])
    for pub in sci_publications:
      if 'doi' in pub: dois.add(pub['doi'])

    return sorted(dois)

  def citations(self) -> Iterator[str]:
    sci_citation = self.stac_json.get('sci:citation')
    if sci_citation:
      yield sci_citation

    publications: list[dict[str, str]] = self.stac_json.get(
        'sci:publications', [])
    for pub in publications:
      yield pub['citation']

  def bands(self) -> Iterator[Band]:
    summaries = self.stac_json.get('summaries')
    if not summaries:
      return
    bands = summaries.get('eo:bands', [])
    for band in bands:
      yield Band.from_stac(band)

  def schemas(self) -> Iterator[Property]:
    summaries = self.stac_json.get('summaries')
    if not summaries:
      return
    schemas = summaries.get('gee:schema', [])
    for schema in schemas:
      yield Property.from_stac(schema)

  # See also datetime_interval(), which returns a pair of datetimes
  def interval(self) -> Optional[Interval]:
    gee_interval = self.stac_json.get(INTERVAL)
    if not gee_interval:
      return
    return Interval.from_stac(gee_interval)

  def feature_view_ingestion_params(
      self) -> Optional[FeatureViewIngestionParams]:
    summaries = self.stac_json.get('summaries', {})
    gee_params = summaries.get(FEATURE_VIEW_INGESTION_PARAMS)
    if not gee_params:
      return None
    return FeatureViewIngestionParams.from_stac(gee_params)

  def is_derived(self) -> bool:
    return self.stac_json.get(IS_DERIVED, False)

  def self_link(self) -> Optional[Link]:
    return self._link(Rel.SELF)

  def successor_link(self) -> Optional[Link]:
    return self._link(Rel.SUCCESSOR)

  def latest_link(self) -> Optional[Link]:
    return self._link(Rel.LATEST)

  def latest_successor_link(self) -> Optional[Link]:
    """Returns the latest dataset link that's not self.

    Returns:
      the contents of the latest() Link, if it's not self,
      otherwise return the contents of successor().
    """
    latest_link = self.latest_link()
    if latest_link and latest_link.title != self.public_id():
      return latest_link
    else:
      return self.successor_link()

  def latest_successor(self) -> Optional[str]:
    latest_successor_link = self.latest_successor_link()
    return latest_successor_link.title if latest_successor_link else None

  def _link(self, relation: Rel) -> Optional[Link]:
    relation_links = list(self.links(relation))
    if relation_links:
      relation_link = relation_links[0]
      if not relation_link.title and relation_link.rel != Rel.SELF:
        raise errors.InputError(
            f'{relation} link has no title in dataset {self.public_id()}'
        )
      # The title is the Earth Engine dataset_id
      return relation_link
    else:
      return None

  def successor(self) -> Optional[str]:
    successor_link = self.successor_link()
    return successor_link.title if successor_link else None

  def is_deprecated(self) -> bool:
    """Returns True for collections that are deprecated or have a successor."""
    if self.get('deprecated', False):
      logging.info('Skipping deprecated collection: %s', self.public_id())
      return True
    if self.latest_successor():
      logging.info(
          'Skipping superseded collection: %s (%s)',
          self.public_id(),
          self.latest_successor(),
      )
      return True
    return False

  def in_beta(self) -> bool:
    return self.get(stac_checker.GEE_STATUS) == stac_checker.Status.BETA

  def catalog_url(self):
    """Returns the URL of the dataset in the Earth Engine catalog."""
    links = self.stac_json['links']
    for link in links:
      if 'rel' in link and link['rel'] == 'catalog':
        return link['href']

      # Ideally there would be a 'catalog' link but sometimes there isn't.
      base_url = 'https://developers.google.com/earth-engine/datasets/catalog/'
      if link['href'].startswith(base_url):
        return link['href'].split('#')[0]

    logging.warning('No catalog link found for %s', self.public_id())
    return ''


class Catalog:
  """A simple wrapper for a STAC Catalog.

  Assumes a valid STAC Catalog.  Only very minimal error checking.
  """
  stac_json: dict[str, Any]

  def __init__(self, stac_json: dict[str, Any]):
    self.stac_json = stac_json

  def __getitem__(self, item: str) -> Any:
    return self.stac_json[item]

  def links(self, rel: Optional[Rel] = None) -> Iterator[Link]:
    links = self.stac_json['links']
    for link in links:
      link_rel = Rel(link['rel'])
      if rel and link_rel != rel:
        continue

      yield Link.from_stac(link)

  def root_url(self) -> Optional[str]:
    for link in self.links(Rel.ROOT):
      href = link.href
      if href:
        return href
