local id = 'WRI/GFW/FORMA/alerts';
local subdir = 'WRI';

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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'FORMA Alerts',
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

    The percentage of clearing takes a value of 0, no clearing detected,
    or in the range [ecogroup_bound:100), where ecogroup_bound is given by
    WRI/GFW/FORMA/thresholds .
    The time periods over which data is collected varies by N-days, where N is the number
    of days between the alert_date and the last MODIS NDVI update.
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
                    '2012-01-01T00:00:00Z', '2019-05-18T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'date',
        description: 'Date, in "YYYY-MM-DD" format, of the last available data in this dataset',
        type: ee_const.var_type.string,
      },
      {
        name: 'last_firms_date',
        description: 'Date, in "YYYY-MM-DD" format, of the last available FIRMS data included in this dataset',
        type: ee_const.var_type.string,
      },
      {
        name: 'last_modis_date',
        description: 'Date, in "YYYY-MM-DD" format, of the last available MODIS NDVI data included in this dataset',
        type: ee_const.var_type.string,
      },
      {
        name: 'nday',
        description: 'Number of days since last MODIS NDVI update',
        type: ee_const.var_type.int,
      },
      {
        name: 'year',
        description: 'Year of the most recent data included in the dataset',
        type: ee_const.var_type.int,
      },
    ],
    gsd: [
      250.0,
    ],
    'eo:bands': [
      {
        name: 'alert_delta',
        description: |||
          Percentage of clearing which during the 6 MODIS periods (96 + N days)
          preceding the corresponding alert_date value for the pixel
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'alert_date',
        description: 'Timestamp in milliseconds since 1970/01/01',
        'gee:units': 'ms',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'FORMA Alerts',
        lookat: {
          lon: 6.746,
          lat: 39,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            min: [
              25.0,
            ],
            max: [
              75.0,
            ],
            palette: [
              'd65898',
              'da68a2',
            ],
            bands: [
              'alert_delta',
            ],
          },
        },
      },
    ],
    alert_delta: {
      minimum: 0.0,
      maximum: 100.0,
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
  version: ee_const.version_unknown,
}
