local id = 'FORMA/FORMA_500m';
local successor_id = 'WRI/GFW/FORMA/alerts';
local subdir = 'FORMA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

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
  title: 'FORMA Global Forest Watch Deforestation Alerts, 500m [deprecated]',
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image,
  description: |||
    FORMA is a MODIS-based deforestation alerting system for the humid tropical
    forests. FORMA is designed for quick identification of new areas of tree
    cover loss. The system analyzes data gathered daily by the MODIS sensor,
    which operates on NASA's Terra and Aqua satellites. The FORMA alerts system
    then detects pronounced changes in vegetation cover over time, as measured
    by the Normalized Difference Vegetation Index (NDVI), a measure of
    vegetation greenness. These pronounced changes in vegetation cover are
    likely to indicate forest being cleared, burned, or defoliated. An alert is
    added to the dataset by setting the pixel value to the date at which a
    change was detected. FORMA alerts only appear in areas where the probability
    of tree cover loss is greater than or equal to 50%. FORMA data has 500-meter
    spatial resolution and twice-monthly update interval. FORMA alerts start in
    January 2006.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.successor(
        successor_id, ee_const.catalog_base + 'WRI/WRI_GFW_FORMA_alerts.json'),
  ],
  keywords: [
    'alerts',
    'deforestation',
    'forest',
    'forma',
    'geophysical',
    'gfw',
    'modis',
    'nasa',
    'wri',
  ],
  providers: [
    ee.producer_provider('Global Forest Watch, World Resources Institute', 'https://www.globalforestwatch.org'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2006-01-01T00:00:00Z', '2015-06-10T00:00:00Z'),
  summaries: {
    gsd: [
      500.0,
    ],
    'eo:bands': [
      {
        name: 'constant',
        description: '[Seconds since Jan 1, 1970](https://en.wikipedia.org/wiki/Unix_time)',
        'gee:units': 'seconds',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Alert Areas',
        lookat: {
          lat: -0.835,
          lon: -51.482,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            min: [
              1134979200.0,
            ],
            max: [
              1433919600.0,
            ],
            palette: ['ff8800', 'ff0000'],
            bands: [
              'constant',
            ],
          },
        },
      },
    ],
    constant: {
      minimum: 1134979200.0,
      maximum: 1433919600.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Hammer, Dan, Robin Kraft, and David Wheeler. 2013. FORMA Alerts. World
    Resources Institute and Center for Global Development.
    [www.globalforestwatch.org](www.globalforestwatch.org).
  |||,
  'gee:terms_of_use': |||
    The FORMA datasets are available without restriction on use or distribution.
    WRI does request that the user give proper attribution and identify WRI and
    GFW, where applicable, as the source of the data.
  |||,
  version: ee_const.version_unknown,
}
