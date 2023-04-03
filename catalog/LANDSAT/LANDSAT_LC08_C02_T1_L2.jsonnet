local id = 'LANDSAT/LC08/C02/T1_L2';
local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/LC08_C02_L2.libsonnet';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
  ],
  id: id,
  title: 'USGS Landsat 8 Level 2, Collection 2, Tier 1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset contains atmospherically corrected
    surface reflectance and land surface temperature derived from the data
    produced by the Landsat 8 OLI/TIRS sensors.
    These images contain 5 visible and near-infrared (VNIR) bands and
    2 short-wave infrared (SWIR) bands processed to orthorectified surface
    reflectance, and one thermal infrared (TIR) band processed to orthorectified
    surface temperature. They also contain intermediate bands used in
    calculation of the ST products, as well as QA bands.

    Landsat 8 SR products are created with the Land Surface Reflectance Code
    (LaSRC). All Collection 2 ST products are created with a single-channel
    algorithm jointly created by the Rochester Institute of Technology (RIT) and
    National Aeronautics and Space Administration (NASA)
    Jet Propulsion Laboratory (JPL).

    Strips of collected data are packaged into overlapping \"scenes\" covering approximately
    170km x 183km using a [standardized reference grid](https://landsat.gsfc.nasa.gov/about/worldwide-reference-system).

    Some assets have only SR data, in which case ST bands are present but empty.
    For assets with both ST and SR bands, 'PROCESSING_LEVEL' is set to 'L2SP'.
    For assets with only SR bands, 'PROCESSING_LEVEL' is set to 'L2SR'.

    [Additional documentation and usage examples.](/earth-engine/guides/landsat)

    Data provider notes:

    * Data products must contain both optical and thermal data to be
      successfully processed to surface temperature, as ASTER NDVI is
      required to temporally adjust the ASTER GED product to the target Landsat
      scene. Therefore, night time acquisitions cannot be processed to
      surface temperature.

    * A known error exists in the surface temperature retrievals relative
      to clouds and possibly cloud shadows. The characterization of these
      issues has been documented by
      [Cook et al., (2014)](https://doi.org/10.3390/rs61111244).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license('https://www.usgs.gov/centers/eros/data-citation'),
  ],
  keywords: [
    'cfmask',
    'cloud',
    'fmask',
    'global',
    'l8sr',
    'landsat',
    'lasrc',
    'lc08',
    'lst',
    'reflectance',
    'sr',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://www.usgs.gov/core-science-systems/nli/landsat/landsat-collection-2-level-2-science-products'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2013-03-18T15:58:14Z', null),
  summaries: template.summaries,
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
