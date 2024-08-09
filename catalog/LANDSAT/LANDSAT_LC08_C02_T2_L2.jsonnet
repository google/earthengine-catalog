local id = 'LANDSAT/LC08/C02/T2_L2';
local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local template = import 'templates/LC08_C02_L2.libsonnet';
local notes = import 'templates/LANDSAT_L2.libsonnet';

local license = spdx.proprietary {
  reference: 'https://www.usgs.gov/centers/eros/data-citation',
};
local versions = import 'versions.libsonnet';
local version_table = import 'LC8_T2_L2_versions.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  version: version,
  title: 'USGS Landsat 8 Level 2, Collection 2, Tier 2',
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

  ||| + notes.description,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
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
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2013-03-18T15:58:38Z', null),
  summaries: template.summaries,
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
