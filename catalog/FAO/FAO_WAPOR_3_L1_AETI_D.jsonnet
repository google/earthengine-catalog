local id = 'FAO/WAPOR/3/L1_AETI_D';
local subdir = 'FAO';
local version = '3.0';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'WAPOR Actual Evapotranspiration and Interception ' + version,
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  // TODO(schwehr): Define WAPOR
  description: |||
    The actual evapotranspiration and interception (ETIa) (dekadal, in mm/day)
    is the sum of the soil evaporation (E), canopy transpiration (T), and
    evaporation from rainfall intercepted by leaves (I). The value of each pixel
    represents the average daily ETIa in a given dekad.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['water-vapor'],
  keywords: [
    'agriculture',
    'fao',
    'wapor',
    'water',
  ],
  providers: [
    ee.producer_provider(
      'FAO UN',
      'https://www.fao.org/in-action/remote-sensing-for-water-productivity/wapor-data-access/en'),
      ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2018-01-01T00:00:00Z', null),
  summaries: {
    gsd: [248.2],
    'eo:bands': [
      {
        name: 'L1-AETI-D',
        description:
          'Actual Evapotranspiration and Interception (Dekadal) [mm]',
        'gee:units': units.millimeter,
        'gee:scale': 0.1,
      },
    ],
    'gee:visualizations': [
      {
        display_name:
          'Actual Evapotranspiration and Interception (Dekadal) [mm]',
        lookat: {lon: 17.5, lat: 20.0, zoom: 3},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [50],
            bands: ['L1-AETI-D'],
          },
        },
      },
    ],
  },
  // TODO(schwehr): URLs for this report.
  'sci:citation': |||
    FAO 2018. WaPOR Database Methodology: Level 1. Remote Sensing for Water
    Productivity Technical Report: Methodology Series. Rome, FAO. 72 pages.
  |||,
  'sci:publications': [
    {
      citation: |||
        FAO 2020. WaPOR V2 Database Methodology. Remote Sensing for Water
        Productivity Technical Report: Methodology Series. Rome, FAO.
        [https://www.fao.org/3/ca9894en/CA9894EN.pdf](
          https://www.fao.org/3/ca9894en/CA9894EN.pdf)
      |||,
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 10,
  },
  'gee:terms_of_use': |||
    The Food and Agriculture Organization of the United Nations (FAO) is
    mandated to collect, analyze, interpret, and disseminate information related
    to nutrition, food, and agriculture. In this regard, it publishes a number
    of databases on topics related to FAO's mandate, and encourages the use of
    them for scientific and research purposes.  Consistent with the principles
    of openness and sharing envisioned under the [Open Data Licensing For
    Statistical Databases](http://www.fao.org/3/ca7570en/ca7570en.pdf), and
    consistent with the mandate of FAO, data from the [Water Productivity Open
    Access Portal (WaPOR)](https://www.fao.org/in-action/remote-sensing-for-water-productivity/wapor-data-access/en), as part
    of [AQUASTAT](http://www.fao.org/aquastat/en/) - FAO's Global Information
    System on Water and Agriculture, is available free to the user community.
  |||,
  'gee:user_uploaded': true,
}
