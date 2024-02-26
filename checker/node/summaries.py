"""Check for the summaries field.

Requirements and specifications:

- 'summaries' are directly in the top-level dictionary of a STAC Collection
  for datasets
- 'summaries' cannot occur in STAC Catalogs
- 'summaries' must be a dict containing:
  - 'gee:visualizations' is required for all summaries
  - 'eo:bands' is required for Image or ImageCollection datasets
  - 'gee:schema' is required for Table and TableCollection datasets
- There are a large number of optional fields.
- 'Range Object' fields with minimum/maximum statistics for 'eo:bands' can
  optionally be in summaries

See also:
- https://github.com/radiantearth/stac-spec/blob/master/collection-spec/collection-spec.md#summaries
- eo_extension.py and https://github.com/stac-extensions/eo
- sar_extension.py and https://github.com/stac-extensions/sar
"""

from typing import Iterator

from checker import stac
from checker.node import eo_extension

SUMMARIES = 'summaries'

CONSTELLATION = 'constellation'
EO_BANDS = 'eo:bands'
GEE_FEATURE_VIEW_INGESTION_PARAMS = 'gee:feature_view_ingestion_params'
GEE_SCHEMA = 'gee:schema'
GEE_VISUALIZATIONS = 'gee:visualizations'
GSD = 'gsd'
INSTRUMENTS = 'instruments'
PLATFORM = 'platform'
SAR_CENTER_FREQUENCY = 'sar:center_frequency'
SAR_FREQUENCY_BAND = 'sar:frequency_band'
SAR_INSTRUMENT_MODE = 'sar:instrument_mode'
SAR_POLARIZATION = 'sar:polarizations'
SAR_PRODUCT_TYPE = 'sar:product_type'
SAR_RESOLUTION_AZIMUTH = 'sar:resolution_azimuth'
SAR_RESOLUTION_RANGE = 'sar:resolution_range'

REQUIRED_KEYS = frozenset({GEE_VISUALIZATIONS})
OPTIONAL_KEYS = frozenset({
    CONSTELLATION,
    EO_BANDS, GEE_FEATURE_VIEW_INGESTION_PARAMS,
    GEE_SCHEMA, GSD, INSTRUMENTS, PLATFORM,
    SAR_CENTER_FREQUENCY, SAR_FREQUENCY_BAND, SAR_INSTRUMENT_MODE,
    SAR_POLARIZATION, SAR_PRODUCT_TYPE, SAR_RESOLUTION_AZIMUTH,
    SAR_RESOLUTION_RANGE,
})
ALL_KEYS = REQUIRED_KEYS.union(OPTIONAL_KEYS)

NAME = 'name'


class Check(stac.NodeCheck):
  """Checks the summaries field."""
  name = 'summaries'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if SUMMARIES not in node.stac:
      if node.type == stac.StacType.COLLECTION:
        yield cls.new_issue(node, f'Missing: {SUMMARIES}')
      return

    if node.type == stac.StacType.CATALOG:
      yield cls.new_issue(node, f'{SUMMARIES} not allowed in {node.type}')
      return

    summaries = node.stac[SUMMARIES]
    if not isinstance(summaries, dict):
      yield cls.new_issue(node, f'{SUMMARIES} must be a dict')
      return

    keys = set(summaries)
    missing_keys = sorted(REQUIRED_KEYS.difference(keys))
    if missing_keys:
      message = ', '.join(missing_keys)
      yield cls.new_issue(node, f'{SUMMARIES} missing required keys: {message}')

    if node.gee_type in (stac.GeeType.IMAGE, stac.GeeType.IMAGE_COLLECTION):
      if (EO_BANDS not in summaries and node.id not
          in eo_extension.IMAGES_WITHOUT_BANDS):
        yield cls.new_issue(
            node, f'{node.gee_type} must have {EO_BANDS} in {SUMMARIES}')

    if node.gee_type in (stac.GeeType.TABLE, stac.GeeType.TABLE_COLLECTION):
      if GEE_SCHEMA not in summaries:
        yield cls.new_issue(
            node,
            f'{node.gee_type} must have {GEE_SCHEMA} in {SUMMARIES}')
      if EO_BANDS in summaries:
        yield cls.new_issue(
            node, f'{node.gee_type} cannot have {EO_BANDS} in {SUMMARIES}')

    # These are called 'Range Objects' fields in STAC.
    keys_from_bands = set()
    if EO_BANDS in summaries:
      bands = summaries[EO_BANDS]
      if isinstance(bands, list):
        for band in bands:
          if isinstance(band, dict):
            if NAME in band:
              name = band[NAME]
              if isinstance(name, str) and name:
                keys_from_bands.add(name)
                # A band name can have a dash, but its corresponding summary key
                # cannot.
                keys_from_bands.add(name.replace('-', '_'))

    all_keys = ALL_KEYS.union(keys_from_bands)
    extra_keys = sorted(keys.difference(all_keys))
    if extra_keys:
      message = ', '.join(extra_keys)
      yield cls.new_issue(
          node,
          f'{SUMMARIES} has unexpected keys: {message}. Each key must be a band'
          ' name.',
      )
