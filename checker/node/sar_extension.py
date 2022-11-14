"""Checks for the Synthetic-Aperture Radar (SAR) Extension.

Earth Engine doesn't directly follow the SAR extension as it is designed
for STAC Items.  Instead, 'sar:' entries are under summaries rather than
'properties'.

Requirements:
- Sar extension fields are underneath 'summaries'
- There are two required fields:
  - sar:polarizations - List of str that are one or more of 'HH', 'HV', 'VH',
    'VV' in sorted order
  - sar:product_type - List of str one of the allowed product type strings
- The allowed optional fields are:
  - sar:center_frequency - List of center frequencies of the instrument (GHz)
  - sar:frequency_band - List of common names for the frequency band
  - sar:instrument_mode - List of short names of the sensor acquisition mode
    that are commonly used. https://github.com/stac-extensions/sar/issues/9
    http://www.cripe.ca/docs/proceedings/19/Beaton-et-al-2017.pdf
  - sar:resolution_range - maximum ability to distinguish two adjacent targets
    perpendicular to the flight path (m)
  - sar:resolution_azimuth - maximum ability to distinguish two adjacent targets
    parallel to the flight path (m)
- Currently not allowed in Earth Engine catalog:
  - sar:looks_azimuth
  - sar:looks_equivalent_number
  - sar:looks_range
  - sar:pixel_spacing_azimuth
  - sar:pixel_spacing_range
  - sar:observation_direction

See also:

- https://github.com/stac-extensions/sar
- https://en.wikipedia.org/wiki/Synthetic-aperture_radar
- https://eoreader.readthedocs.io/en/latest/sar.html
- https://sentinels.copernicus.eu/web/sentinel/user-guides/sentinel-1-sar/acquisition-modes
"""

# TODO(schwehr): Check eo:band gee:polarization
# TODO(schwehr): Will there ever be more than one entry for these?
#   center_frequency, frequency_band, resolution_range, resolution_azimuth

import re
from typing import Iterator

from checker import stac

EXTENSION_VERSION = '1.0.0'

SUMMARIES = 'summaries'

CENTER_FREQUENCY = 'sar:center_frequency'
FREQUENCY_BAND = 'sar:frequency_band'
INSTRUMENT_MODE = 'sar:instrument_mode'
POLARIZATIONS = 'sar:polarizations'
PRODUCT_TYPE = 'sar:product_type'
RESOLUTION_RANGE = 'sar:resolution_range'
RESOLUTION_AZIMUTH = 'sar:resolution_azimuth'

REQUIRED_FIELDS = frozenset({POLARIZATIONS, PRODUCT_TYPE})
OPTIONAL_FIELDS = frozenset({
    CENTER_FREQUENCY, FREQUENCY_BAND, INSTRUMENT_MODE,
    RESOLUTION_AZIMUTH, RESOLUTION_RANGE})
ALL_FIELDS = REQUIRED_FIELDS.union(OPTIONAL_FIELDS)

FREQUENCY_BAND_VALUES = frozenset({'P', 'L', 'S', 'C', 'X', 'Ku', 'K', 'Ka'})
INSTRUMENT_MODE_VALUES = frozenset({'EW', 'IW', 'ScanSAR', 'SM', 'WV'})
POLARIZATION_VALUES = frozenset({'HH', 'HV', 'VH', 'VV'})
PRODUCT_TYPE_VALUES = frozenset({
    'GRD', 'MGD', 'GEC', 'GTC', 'Normalised Radar Backscatter',
    'OSW', 'OWI', 'RAW', 'RTC', 'RVL', 'SGC', 'SLC', 'SSC'})


class Check(stac.NodeCheck):
  """Checks the sar extension."""
  name = 'sar_extension'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    extensions = node.stac.get('stac_extensions', [])
    extension_list = [ex for ex in extensions if 'github.io/sar' in ex]
    extension_url = extension_list[0] if extension_list else None
    has_sar_extension = bool(extension_list)

    if node.type == stac.StacType.CATALOG:
      if has_sar_extension:
        yield cls.new_issue(
            node, f'{node.type} must not have the sar extension')
      return

    if node.gee_type in (stac.GeeType.TABLE, stac.GeeType.TABLE_COLLECTION):
      if has_sar_extension:
        yield cls.new_issue(node, f'{node.gee_type} cannot have sar extension')
      return

    if has_sar_extension:
      # TODO(schwehr): Factor out as a function when primary checkers are in?
      search = re.search(r'v([0-9]+\.[0-9]+\.[0-9]+)', extension_url)
      if search:
        extension_version = search.groups()[0]
        if extension_version != EXTENSION_VERSION:
          yield cls.new_issue(
              node, f'Extension\'s version must be: "{EXTENSION_VERSION}"')
          return

    if SUMMARIES not in node.stac: return

    summaries = node.stac[SUMMARIES]

    if not isinstance(summaries, dict): return

    fields = frozenset(key for key in summaries if key.startswith('sar:'))
    if not has_sar_extension:
      if fields:
        yield cls.new_issue(node, 'Found sar: entries, but no sar extension')
      return

    if not REQUIRED_FIELDS.issubset(fields):
      diff = ', '.join(sorted(REQUIRED_FIELDS.difference(fields)))
      yield cls.new_issue(node, f'{SUMMARIES} missing field(s): {diff}')
      return

    if not fields.issubset(ALL_FIELDS):
      diff = ', '.join(sorted(fields.difference(ALL_FIELDS)))
      yield cls.new_issue(node, f'Unexpected field(s): {diff}')
      return

    polarizations = summaries[POLARIZATIONS]
    if not isinstance(polarizations, list):
      yield cls.new_issue(node, f'{POLARIZATIONS} must be a list')
    elif not polarizations:
      yield cls.new_issue(node, f'{POLARIZATIONS} cannot be empty')
    else:
      if any(not isinstance(p, str) for p in polarizations):
        yield cls.new_issue(node, f'{POLARIZATIONS} entries must be str')
      else:
        diff = ', '.join(sorted(
            set(polarizations).difference(POLARIZATION_VALUES)))
        if diff:
          yield cls.new_issue(node, f'Invalid polarization(s): {diff}')
        if sorted(polarizations) != polarizations:
          yield cls.new_issue(node, f'{POLARIZATIONS} must be sorted')

    product_type = summaries[PRODUCT_TYPE]
    if not isinstance(product_type, list):
      yield cls.new_issue(node, f'{PRODUCT_TYPE} must be a list')
    elif not product_type:
      yield cls.new_issue(node, f'{PRODUCT_TYPE} cannot be empty')
    else:
      if any(not isinstance(p, str) for p in product_type):
        yield cls.new_issue(node, f'{PRODUCT_TYPE} entries must be str')
      else:
        diff = ', '.join(sorted(
            set(product_type).difference(PRODUCT_TYPE_VALUES)))
        if diff:
          yield cls.new_issue(node, f'Invalid product_type(s): {diff}')
        if sorted(product_type) != product_type:
          yield cls.new_issue(node, f'{PRODUCT_TYPE} must be sorted')

    if CENTER_FREQUENCY in summaries:
      center_frequency = summaries[CENTER_FREQUENCY]
      if not isinstance(center_frequency, list):
        yield cls.new_issue(node, f'{CENTER_FREQUENCY} must be a list')
      elif not center_frequency:
        yield cls.new_issue(node, f'{CENTER_FREQUENCY} cannot be empty')
      else:
        if any(not isinstance(cf, (int, float)) for cf in center_frequency):
          yield cls.new_issue(
              node, f'{CENTER_FREQUENCY} entries must be a number')
        else:
          for value in center_frequency:
            if value < 0.25:
              yield cls.new_issue(node, f'{CENTER_FREQUENCY} value too small')
            elif value > 40:
              yield cls.new_issue(node, f'{CENTER_FREQUENCY} value too large')

    if FREQUENCY_BAND in summaries:
      frequency_bands = summaries[FREQUENCY_BAND]
      if not isinstance(frequency_bands, list):
        yield cls.new_issue(node, f'{FREQUENCY_BAND} must be a list')
      elif not frequency_bands:
        yield cls.new_issue(node, f'{FREQUENCY_BAND} cannot be empty')
      else:
        if any(not isinstance(fb, str) for fb in frequency_bands):
          yield cls.new_issue(
              node, f'{FREQUENCY_BAND} entries must be a str')
        else:
          for fb in frequency_bands:
            if fb not in FREQUENCY_BAND_VALUES:
              yield cls.new_issue(node, f'{FREQUENCY_BAND} not valid')

    if INSTRUMENT_MODE in summaries:
      instrument_mode = summaries[INSTRUMENT_MODE]
      if not isinstance(instrument_mode, list):
        yield cls.new_issue(node, f'{INSTRUMENT_MODE} must be a list')
      elif not instrument_mode:
        yield cls.new_issue(node, f'{INSTRUMENT_MODE} cannot be empty')
      else:
        if any(not isinstance(im, str) for im in instrument_mode):
          yield cls.new_issue(
              node, f'{INSTRUMENT_MODE} entries must be a str')
        else:
          for im in instrument_mode:
            if im not in INSTRUMENT_MODE_VALUES:
              yield cls.new_issue(node, f'{INSTRUMENT_MODE} not valid: {im}')
          if sorted(instrument_mode) != instrument_mode:
            yield cls.new_issue(node, f'{INSTRUMENT_MODE} must be sorted')

    if RESOLUTION_AZIMUTH in summaries:
      resolution_azimuth = summaries[RESOLUTION_AZIMUTH]
      if not isinstance(resolution_azimuth, list):
        yield cls.new_issue(node, f'{RESOLUTION_AZIMUTH} must be a list')
      elif not resolution_azimuth:
        yield cls.new_issue(node, f'{RESOLUTION_AZIMUTH} cannot be empty')
      else:
        if any(not isinstance(cf, (int, float)) for cf in resolution_azimuth):
          yield cls.new_issue(
              node, f'{RESOLUTION_AZIMUTH} entries must be a number')
        else:
          for value in resolution_azimuth:
            if value < 1:
              yield cls.new_issue(node, f'{RESOLUTION_AZIMUTH} value too small')
            elif value > 100:
              yield cls.new_issue(node, f'{RESOLUTION_AZIMUTH} value too large')

    if RESOLUTION_RANGE in summaries:
      resolution_range = summaries[RESOLUTION_RANGE]
      if not isinstance(resolution_range, list):
        yield cls.new_issue(node, f'{RESOLUTION_RANGE} must be a list')
      elif not resolution_range:
        yield cls.new_issue(node, f'{RESOLUTION_RANGE} cannot be empty')
      else:
        if any(not isinstance(cf, (int, float)) for cf in resolution_range):
          yield cls.new_issue(
              node, f'{RESOLUTION_RANGE} entries must be a number')
        else:
          for value in resolution_range:
            if value < 1:
              yield cls.new_issue(node, f'{RESOLUTION_RANGE} value too small')
            elif value > 100:
              yield cls.new_issue(node, f'{RESOLUTION_RANGE} value too large')
