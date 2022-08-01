local id = 'WRI/GFW/FORMA/vegetation_tstats';
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
  title: 'FORMA Vegetation T-Statistics',
  'gee:type': ee_const.gee_type.image_collection,
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

    The images in this ImageCollection contain the “reversed rectified
    t-statistics” used in calculating NTT, the vegetation color index derived
    from MODIS NDVI that FORMA uses to measure browning. Using a sum reducer on
    over various date ranges in this ImageCollection produces an “NTT” image.

    The images are broken by "ecogroup".
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'daily',
    'deforestation',
    'forests',
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
                    '2012-01-01T00:00:00Z', '2019-04-23T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'year',
        description: 'Year of the most recent data included in the dataset',
        type: ee_const.var_type.int,
      },
      {
        name: 'biweekly',
        description: 'The biweekly (every 16 days) period of the year',
        type: ee_const.var_type.int,
      },
      {
        name: 'ecogroup_id',
        description: 'ID of associated ecogroup',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      250.0,
    ],
    'eo:bands': [
      {
        name: 'tstat_r',
        description: 'Reversed rectified, ie (max(0,-t_stat)), t-statistics.',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Reversed rectified t-statistics',
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
              1.0,
            ],
            bands: [
              'tstat_r',
            ],
          },
        },
      },
    ],
    tstat_r: {
      minimum: 0.0,
      maximum: 25.41,
      'gee:estimated_range': true,
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
