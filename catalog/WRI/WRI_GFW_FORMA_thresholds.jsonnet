local id = 'WRI/GFW/FORMA/thresholds';
local subdir = 'WRI';

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
  ],
  id: id,
  title: 'FORMA Alert Thresholds',
  'gee:type': ee_const.gee_type.image,
  description: |||
    **NOTE from WRI**: WRI decided to stop updating FORMA alerts. The goal was
    to simplify the [Global Forest Watch](https://www.globalforestwatch.org)
    user experience and reduce redundancy.
    We found that [Terra-i](http://www.terra-i.org/terra-i.html) and
    [GLAD](https://glad-forest-alert.appspot.com/) were more frequently used.
    Moreover, using GLAD as a standard, found that Terra-i outperformed
    FORMA globally.

    FORMA alerts are detected using a combination of two MODIS
    products: NDVI (Normalized Difference Vegetation Index) and FIRMS
    (Fires Information for Resource Management System). NDVI updates are
    processed every 16 days, while fire updates are processed daily. Models
    are developed individually for each ecogroup to relate the two inputs to
    the area of clearing, using the Hansen annual tree cover loss data to train
    the model. The minimum threshold to qualify as an alert is 25% of the pixel
    cleared, though thresholds vary by ecogroup to minimize false positives.
    Here is an [example script](https://code.earthengine.google.com/f29b1e4360f3fc36847bd789ceeb20f6)
    for a quick introduction to the FORMA datasets.

    This image contains the thresholds at which, when crossed, a FORMA alert is
    produced. The values are equal to max(25,40%*RegionalMax), where RegionalMax
    is the historical maximum clearing for a pixel in this ecogroup.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'daily',
    'deforestation',
    'forest',
    'forma',
    'gfw',
    'modis',
    'monitoring',
    'wri',
  ],
  providers: [
    ee.producer_provider('World Resources Institute / Global Forest Watch', 'https://www.globalforestwatch.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-120.0, -50.0, 180.0, 40.0,
                    '2012-01-01T00:00:00Z', '2016-01-01T00:00:00Z'),
  summaries: {
    'gee:properties': [
      {
        name: 'start_year',
        description: 'The first year included in determining the historical max for the ecogroup',
        type: ee_const.var_type.int,
      },
      {
        name: 'year',
        description: 'The last year included in determining the historical max for the ecogroup',
        type: ee_const.var_type.int,
      },
    ],
    gsd: [
      250.0,
    ],
    'eo:bands': [
      {
        name: 'delta_bound',
        description: 'The thresholds at which, when crossed, a FORMA alert is produced',
        'gee:units': '%',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Thresholds for FORMA alerts',
        lookat: {
          lon: 25.73,
          lat: -7.61,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              50.0,
            ],
            bands: [
              'delta_bound',
            ],
          },
        },
      },
    ],
    delta_bound: {
      minimum: 25.0,
      maximum: 40.0,
      'gee:estimated_range': false,
    },
  },
  'gee:terms_of_use': |||
    The FORMA datasets are available without restriction
    on use or distribution. WRI does request that the
    user give proper attribution and identify WRI and GFW, where applicable,
    as the source of the data.
  |||,
  'gee:user_uploaded': true,
}
