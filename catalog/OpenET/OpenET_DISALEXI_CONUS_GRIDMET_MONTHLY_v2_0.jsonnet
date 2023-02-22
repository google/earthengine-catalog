local id = 'OpenET/DISALEXI/CONUS/GRIDMET/MONTHLY/v2_0';
local subdir = 'OpenET';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

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
  title: 'OpenET CONUS DisALEXI Monthly Evapotranspiration v2.0',
  version: '2.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Atmosphere-Land Exchange Inverse / Disaggregation of the Atmosphere-Land Exchange Inverse (ALEXI/DisALEXI)
    DisALEXI was recently ported to Google Earth Engine as part of the OpenET framework and the baseline
    ALEXI/DisALEXI model structure is described by Anderson et al. (2012, 2018). The ALEXI evapotranspiration (ET)
    model specifically uses time differential land surface temperature (LST) measurements from geostationary or
    moderate resolution polar orbiting platforms to generate regional ET maps. DisALEXI then disaggregates the
    regional ALEXI ET to finer scales using Landsat data (30 m; biweekly) to resolve individual farm fields and
    other landscape features.

    [Additional information](https://openetdata.org/methodologies/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'conus',
    'evapotranspiration',
    'gridmet_derived',
    'landsat_derived',
    'monthly',
    'water',
  ],
  providers: [
    ee.producer_provider('OpenET, Inc.', 'https://openetdata.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-126.0, 25.0, -66.0, 50.0, '2016-01-01T00:00:00Z', null),
  summaries: {
    gsd: [30],
    'eo:bands': [
      {
        name: 'et',
        description: |||
          DisALEXI ET value
        |||,
        'gee:units': 'mm',
      },

      {
        name: 'count',
        description: |||
           Number of cloud free values
        |||
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'OpenET DisALEXI Monthly ET',
        lookat: {
          lat: 38.0,
          lon: -100.0,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              1400.0,
            ],
            palette: [
              '9E6212',
              'AC7D1D',
              'BA9829',
              'C8B434',
              'D6CF40',
              'BED44B',
              '9FCB51',
              '80C256',
              '61B95C',
              '42B062',
              '45B677',
              '49BC8D',
              '4DC2A2',
              '51C8B8',
              '55CECE',
              '4DB4BA',
              '459AA7',
              '3D8094',
              '356681',
              '2D4C6E',
            ],
            bands: [
              'et',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Anderson, M.C., Norman, J.M., Mecikalski, J.R., Otkin, J.A. and Kustas, W.P., 2007.
    A climatological study of evapotranspiration and moisture stress across the continental
    United States based on thermal remote sensing: 1. Model formulation. Journal of
    Geophysical Research: Atmospheres, 112(D10).

    Anderson, M., Gao, F., Knipper, K., Hain, C., Dulaney, W., Baldocchi, D., Eichelmann, E.,
    Hemes, K., Yang, Y., Medellin-Azuara, J. and Kustas, W., 2018. Field-scale assessment of
    land and water use change over the California Delta using remote sensing. Remote Sensing,
    10(6), p.889.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
