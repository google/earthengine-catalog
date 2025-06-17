"""Checks for the Electro-Optical (eo) extension.

Earth Engine's use of the eo extension is a bit different than other STAC
Catalogs. Here it is used on STAC Collections, whereas others use it on
STAC Items.

eo:bands are located in 'summaries':

- All Earth Engine image and image_collection type STAC Collections must have
  one or more entries in an 'eo:bands' list
- table and table_collection STAC Collections cannot have 'eo:bands'
- eo:bands is directly under 'summaries'
- summaries cannot currently have 'eo:cloud_cover'. Cloud cover does not make
  sense for an ee.ImageCollection and there have yet to be any ee.Image
  datasets that have cloud_cover.

For each entry in the 'eo:band' list:
- 'name' and 'description' fields are required. Other fields are optional
- 'name' must be a string
- 'description' must be a string
- 'common_name' is not allowed
- 'center_wavelength' is center wavelength of the band, in micrometers (μm)
- 'full_width_half_max' (FWHM) is the width of the band, as measured at half
  the maximum transmission, in micrometers (μm)
- 'solar_illumination' is not allowed
- 'gsd' is the ground sample distance of pixels in meters (m)
  - https://en.wikipedia.org/wiki/Ground_sample_distance
  - Commonly, but incorrectly called 'resolution'
  - There are two ways of gsd can be specified:
    1. gsd under summaries that is a list of 1 or 2 values
      - This applies to all the bands
      - If there are 2 values, they are the pixel sizes in the X & Y directions
    2. all bands have their own gsd field with one value
- 'gee:bitmask' - See gee_bitmask.py
- 'gee:classes' - See gee_classes.py
- 'gee:offset' - What offset value should be added to the band
- 'gee:scale' - What number to multiply the band by
- 'gee:polarization' - SAR polarization string (HH, HV, VH, or VV)
- 'gee:units' - String with the units of the band
- 'gee:wavelength' - String with the range of wavelengths for the band
- Bands can only have one of gee:bitmask, gee_classes, or gee:offset/gee:scale
- Bands can have `Range Object`s at the summary level
  - summary.py checks if the field is allowed
  - The field is named the same as the band name
  - There are three required fields:
    - 'minimum' - must be a number
    - 'maximum' - must be a number greater than the minimum
    - 'gee:estimated_range' - set to false if the values were given by the
      dataset provider and to true if the range was estimated by the data
      ingestor

For scale and offset:

  correct_result = (stored_pixel * gee:scale) + gee:offset

See also:

- gee_bitmask.py
- gee_classes.py
- sar_extension.py
- https://github.com/stac-extensions/eo
- https://github.com/radiantearth/stac-spec/blob/master/item-spec/common-metadata.md#gsd

Jsonnet example:

{
  stac_extensions: [ee_const.ext_eo],
  summaries: {
    'eo:bands': [{description: 'Burn Area Index', gsd: 463, name: 'BAI'}],
  ...

JSON example:

{
  "stac_extensions": [
    "https://stac-extensions.github.io/eo/v1.0.0/schema.json"],
  "summaries": {
    "eo:bands": [{"description": "Burn Area Index", "gsd": 463, "name": "BAI"}],
  ...
"""

# TODO(schwehr): Add more examples to the module doc string

import collections
import re
from typing import Iterator

from checker import stac
from checker import units

EXTENSION_VERSION = '1.0.0'

STAC_EXTENSIONS = 'stac_extensions'
SUMMARIES = 'summaries'
EO_BANDS = 'eo:bands'
CLOUD_COVER = 'eo:cloud_cover'

NAME = 'name'
DESCRIPTION = 'description'
COMMON_NAME = 'common_name'
CENTER_WAVELENGTH = 'center_wavelength'
FULL_WIDTH_HALF_MAX = 'full_width_half_max'
GSD = 'gsd'

# Range Objects constants
MINIMUM = 'minimum'
MAXIMUM = 'maximum'
ESTIMATED_RANGE = 'gee:estimated_range'

GEE_BITMASK = 'gee:bitmask'
GEE_CLASSES = 'gee:classes'
GEE_OFFSET = 'gee:offset'
GEE_POLARIZATION = 'gee:polarization'  # Duplicate to SAR?
GEE_SCALE = 'gee:scale'
GEE_UNITS = 'gee:units'
GEE_WAVELENGTH = 'gee:wavelength'

REQUIRED_KEYS = frozenset({DESCRIPTION, NAME})
OPTIONAL_KEYS = frozenset({
    CENTER_WAVELENGTH,
    FULL_WIDTH_HALF_MAX,
    GEE_BITMASK,
    GEE_CLASSES,
    GEE_OFFSET,
    GEE_POLARIZATION,
    GEE_SCALE,
    GEE_UNITS,
    GEE_WAVELENGTH,
    GSD})
ALL_KEYS = REQUIRED_KEYS.union(OPTIONAL_KEYS)

IMAGES_WITHOUT_BANDS = frozenset({
    'MODIS/MCD43A1',
    'MODIS/MCD43A2',
    'MODIS/MCD43A4',
    'MODIS/MOD09A1',
    'MODIS/MOD09GA',
    'MODIS/MOD09GQ',
    'MODIS/MOD09Q1',
    'MODIS/MOD11A1',
    'MODIS/MOD11A2',
    'MODIS/MOD13A1',
    'MODIS/MOD13Q1',
    'MODIS/MYD09A1',
    'MODIS/MYD09GA',
    'MODIS/MYD09GQ',
    'MODIS/MYD09Q1',
    'MODIS/MYD11A1',
    'MODIS/MYD11A2',
    'MODIS/MYD13A1',
    'MODIS/MYD13Q1'
})

GSD_EXCEPTIONS = frozenset({
    'LANDSAT/LT04/C02/T1',
    'LANDSAT/LT04/C02/T1_TOA',
    'LANDSAT/LT04/C02/T2',
    'LANDSAT/LT04/C02/T2_TOA',
    'LANDSAT/LT05/C02/T1',
    'LANDSAT/LT05/C02/T1_TOA',
    'LANDSAT/LT05/C02/T2',
    'LANDSAT/LT05/C02/T2_TOA',
})

MIN_DESCRIPTION_LEN = 3
MAX_DESCRIPTION_LEN = 1600
MAX_BANDS = 2000
MAX_GSD = 3e5
POLARIZATIONS = frozenset({'HH', 'HV', 'VH', 'VV'})

# TODO(b/198646525): Migrate these units to ../units.py as they units get
# added to units.libsonnet.
UNITS = units.UNITS.union({
    '% (kg / kg)',
    '(kg/m^3)/(m/s)',
    '1.0e15 molec cm-2',
    'AU',
    'Coefficient of Variation',
    'Equivalent gauges per 2.5 degree box',
    'J/m^2/day',
    'Julian Day',
    'MJ m^-2 day^-1',
    'NFDRS fire danger index',
    'Number of people/ha',
    'Number of upstream pixels',
    'Number per pixel',
    'Pa/s',
    'Quality Flag',
    'Reflectance factor',
    'Spectral reflectance',
    'Standard deviation',
    'W m^-2 sr^-1 &micro;m^-1',
    'W/(m^2*sr*um)/ DN',
    'W/m^2 SR&mu;m',
    'cm^3/cm^3',
    'cmol(+)/kg',
    'g/cm^2',
    'g/cm^3',
    'g/kg',  # per mille
    'g/m^2',
    'gC m-2 d-1',
    'gpm',
    'index',
    'kg m^-2 s^-2',
    'kg*C/m^2',
    'kg*C/m^2/16-day',
    'kg*C/m^2/8-day',
    'kg/m/s',
    'kg/m^2/8day',
    'kg/kg',
    'm of water equivalent',
    'mW cm-2 &mu;m-1 sr-1',
    'nanoWatts/sr/cm^2/nm',
    'm^2',
    'm^2 s-2',
    'm^2/s^2',
    'm^2/m^3',
    'm^2/s',
    'm^3',
    'meq/100g',
    'meter/year',
    'min. into half hour',
    'minutes/meter',
    'mm, daily total',
    'mm/hr',
    'mm/pentad',
    'mol/m^2',
    'molecules/cm^2',
    'molec cm-2 s-1',
    'ms',
    'occurrence',
    'ppm',
    'ppm m',
    'seconds',
    'sr-1',
    'ug m-3',
    'tonnes/hectare',
})


class Check(stac.NodeCheck):
  """Checks for the eo extension."""
  name = 'eo_extension'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    extensions = node.stac.get(STAC_EXTENSIONS, [])
    for extension in extensions:
      if not isinstance(extension, str):
        yield cls.new_issue(node, 'Extensions must be a url str')
        return
    extension_list = [ex for ex in extensions if 'github.io/eo' in ex]
    extension_url = extension_list[0] if extension_list else None
    has_eo_extension = bool(extension_list)

    if node.type == stac.StacType.CATALOG:
      if has_eo_extension:
        yield cls.new_issue(node, 'Catalog must not have the eo extension')
      return

    if has_eo_extension:
      if node.gee_type in (stac.GeeType.TABLE, stac.GeeType.TABLE_COLLECTION):
        yield cls.new_issue(
            node, f'{node.gee_type} must not have the eo extension')
        return

      # TODO(schwehr): Factor out as a function when primary checkers are in
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

    if CLOUD_COVER in summaries:
      yield cls.new_issue(node, f'{CLOUD_COVER} not allowed')

    if GSD in summaries:
      summaries_gsd = summaries.get(GSD)
      if not isinstance(summaries_gsd, list):
        yield cls.new_issue(node, f'{SUMMARIES} {GSD} must be a list')
      else:
        gsd_len = len(summaries_gsd)
        if gsd_len not in (1, 2):
          yield cls.new_issue(
              node, f'{SUMMARIES} {GSD} length not 1 or 2: {gsd_len}')
        for gsd in summaries_gsd:
          if not isinstance(gsd, (int, float)):
            yield cls.new_issue(node, f'{SUMMARIES} {GSD} must be a number')
          else:
            if gsd <= 0:
              yield cls.new_issue(
                  node, f'{SUMMARIES} {GSD} too small: {gsd} m')
            if gsd > MAX_GSD:
              yield cls.new_issue(
                  node,
                  f'unreasonably large {SUMMARIES} {GSD}: {gsd} m')

    if node.gee_type in (stac.GeeType.TABLE, stac.GeeType.TABLE_COLLECTION):
      if EO_BANDS in summaries:
        yield cls.new_issue(node, f'{EO_BANDS} cannot be in {node.gee_type}')
      return

    if EO_BANDS not in summaries:
      if node.id not in IMAGES_WITHOUT_BANDS:
        yield cls.new_issue(node, f'Missing {EO_BANDS}')
      return

    bands = summaries[EO_BANDS]
    if not isinstance(bands, list):
      yield cls.new_issue(node, f'{EO_BANDS} must be a list')
      return

    if not bands:
      yield cls.new_issue(node, f'{EO_BANDS} must have at least one band')

    if len(bands) > MAX_BANDS:
      yield cls.new_issue(node, f'{EO_BANDS} has more than {MAX_BANDS} bands')

    name_counts = collections.Counter(
        [b[NAME] for b in bands if isinstance(b, dict) and NAME in b])
    duplicate_names = ', '.join(sorted(
        [name for name, count in name_counts.items() if count > 1]))
    if duplicate_names:
      yield cls.new_issue(
          node, f'Multiple bands with the same name(s): {duplicate_names}')

    # Check range objects at the summary level
    for band_name in name_counts:
      if band_name in summaries:
        range_object = summaries[band_name]
        minimum = range_object.get(MINIMUM)
        maximum = range_object.get(MAXIMUM)
        estimated = range_object.get(ESTIMATED_RANGE)
        if MINIMUM not in range_object:
          yield cls.new_issue(
              node, f'{band_name} range object must have {MINIMUM}')
        elif not isinstance(minimum, (int, float)):
          yield cls.new_issue(
              node, f'{band_name} range object {MINIMUM} must be a number')

        if MAXIMUM not in range_object:
          yield cls.new_issue(
              node, f'{band_name} range object must have {MAXIMUM}')
        elif not isinstance(maximum, (int, float)):
          yield cls.new_issue(
              node, f'{band_name} range object {MAXIMUM} must be a number')
        elif isinstance(minimum, (int, float)) and minimum > maximum:
          yield cls.new_issue(
              node,
              f'{band_name} range object {MINIMUM} > {MAXIMUM}: '
              f'{minimum} > {maximum}')

        if ESTIMATED_RANGE not in range_object:
          yield cls.new_issue(
              node, f'{band_name} range object must have {ESTIMATED_RANGE}')
        elif not isinstance(estimated, bool):
          yield cls.new_issue(
              node,
              f'{band_name} range object {ESTIMATED_RANGE} must be a bool')

    # Track all the valid gsd values to check that they are different.
    gsd_values = []

    for band in bands:
      if not isinstance(band, dict):
        yield cls.new_issue(node, 'band must be a dict')
        continue

      keys = set(band)
      name = band.get('name', 'unknown')
      missing_required = REQUIRED_KEYS.difference(keys)
      if missing_required:
        yield cls.new_issue(
            node,
            f'band "{name}" missing required key(s): ' +
            ', '.join(sorted(missing_required)))
        continue

      extra_keys = keys.difference(ALL_KEYS)
      if extra_keys:
        yield cls.new_issue(
            node, name + ' unexpected key(s): ' + ', '.join(sorted(extra_keys)))
        continue

      if not isinstance(name, str):
        yield cls.new_issue(node, f'{NAME} must be a str')
      else:
        if not re.fullmatch('[a-zA-Z0-9][-_a-zA-Z0-9]{0,79}', name):
          yield cls.new_issue(
              node, f'Bad {NAME}: "{name}". '
              'Must be 1-80 letters, numbers, and underscores')

      description = band[DESCRIPTION]
      if not isinstance(description, str):
        yield cls.new_issue(node, f'{name} {DESCRIPTION} must be a str')
      else:
        if len(description) < MIN_DESCRIPTION_LEN:
          yield cls.new_issue(
              node, f'{name} {DESCRIPTION} too short: {len(description)}')
        if len(description) > MAX_DESCRIPTION_LEN:
          yield cls.new_issue(
              node, f'{name} {DESCRIPTION} too long: {len(description)}')

      if CENTER_WAVELENGTH in band:
        center_wavelength = band[CENTER_WAVELENGTH]
        if not isinstance(center_wavelength, (int, float)):
          yield cls.new_issue(
              node, f'{name} {CENTER_WAVELENGTH} must be a number')
        else:
          if not 0 < center_wavelength < 15:
            yield cls.new_issue(
                node, f'{name} {CENTER_WAVELENGTH} must in (0, 15) μm')

      if FULL_WIDTH_HALF_MAX in band:
        full_width_half_max = band[FULL_WIDTH_HALF_MAX]
        if not isinstance(full_width_half_max, (int, float)):
          yield cls.new_issue(
              node, f'{name} {FULL_WIDTH_HALF_MAX} must be a number')
        else:
          if not 0 < full_width_half_max < 0.15:
            yield cls.new_issue(
                node, f'{name} {FULL_WIDTH_HALF_MAX} must in (0, 0.15) μm')

      # GEE_BITMASK: See gee_bitmask.py
      # GEE_CLASSES: See gee_classes.py
      if GEE_BITMASK in band and GEE_CLASSES in band:
        yield cls.new_issue(
            node, f'{name} cannot have both {GEE_BITMASK} and {GEE_CLASSES}')
      # TODO(schwehr): gee:offset and gee:scale cannot be present with
      # gee:bitmask or gee:classes.

      if GEE_OFFSET in band:
        offset = band[GEE_OFFSET]
        if not isinstance(offset, (int, float)):
          yield cls.new_issue(node, f'{name} {GEE_OFFSET} must be a number')
        else:
          if offset < -1e4:
            yield cls.new_issue(
                node, f'{name} {GEE_OFFSET} large negative offset: {offset}')
          if offset > 1e4:
            yield cls.new_issue(
                node, f'{name} {GEE_OFFSET} large offset: {offset}')
          if offset == 0:
            yield cls.new_issue(node, f'{name} zero {GEE_OFFSET} is redundant')

      if GEE_SCALE in band:
        scale = band[GEE_SCALE]
        if not isinstance(scale, (int, float)):
          yield cls.new_issue(node, f'{name} {GEE_SCALE} must be a number')
        else:
          if scale < 1e-6:
            yield cls.new_issue(node, f'{name} {GEE_SCALE} too small: {scale}')
          if scale > 1e5:
            yield cls.new_issue(
                node, f'{name} unreasonably large {GEE_SCALE}: {scale}')
          if scale == 1:
            yield cls.new_issue(node, f'{name} {GEE_SCALE} of one is redundant')

      if GEE_POLARIZATION in band:
        polarization = band[GEE_POLARIZATION]
        if not isinstance(polarization, str):
          yield cls.new_issue(node, f'{name} {GEE_POLARIZATION} must be a str')
        else:
          if polarization not in POLARIZATIONS:
            yield cls.new_issue(
                node,
                f'{name} {GEE_POLARIZATION} must be one of ' +
                ', '.join(sorted(POLARIZATIONS)))

      if GEE_UNITS in band:
        gee_units = band[GEE_UNITS]
        if not isinstance(gee_units, str):
          yield cls.new_issue(node, f'{name} {GEE_UNITS} must be a str')
        elif gee_units not in UNITS:
          yield cls.new_issue(
              node, f'{name} {GEE_UNITS} not known: {gee_units}')

      if GEE_WAVELENGTH in band:
        wavelength = band[GEE_WAVELENGTH]
        if not isinstance(wavelength, str):
          yield cls.new_issue(node, f'{name} {GEE_WAVELENGTH} must be a str')
        # TODO(schwehr): Check the contents of the str

      if GSD in summaries:
        if GSD in band:
          yield cls.new_issue(
              node, f'{SUMMARIES} and {name} {GSD} both set')
      else:
        if GSD not in band:
          yield cls.new_issue(
              node, f'Must set either {SUMMARIES} or {EO_BANDS} {name} {GSD}')
        else:
          # TODO(schwehr): Support X and Y being different
          gsd = band[GSD]
          if not isinstance(gsd, (int, float)):
            yield cls.new_issue(node, f'{name} {GSD} must be a number')
          else:
            if gsd <= 0:
              yield cls.new_issue(node, f'{name} {GSD} too small: {gsd} m')
            elif gsd > MAX_GSD:
              yield cls.new_issue(
                  node, f'{name} unreasonably large {GSD}: {gsd} m')
            else:
              gsd_values.append(gsd)

    if (len(gsd_values) > 1 and len(set(gsd_values)) == 1 and
        node.id not in GSD_EXCEPTIONS):
      yield cls.new_issue(
          node,
          f'Must use the {SUMMARIES} {GSD} field: {GSD} values are the same')
