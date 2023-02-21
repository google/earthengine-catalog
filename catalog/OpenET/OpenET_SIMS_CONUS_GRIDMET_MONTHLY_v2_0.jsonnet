local id = 'OpenET/SIMS/CONUS/GRIDMET/MONTHLY/v2_0';
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
  title: 'OpenET CONUS SIMS Monthly Evapotranspiration v2.0',
  version: '2.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Satellite Irrigation Management Support
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
    'sims'
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
        name: '',
        description: |||
          SIMS ET value
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
        display_name: 'OpenET SIMS Monthly ET',
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
  'sci:doi': '10.1111/1752-1688.12956',
  'sci:citation': |||
    Melton, F.S., L.F. Johnson, C.P. Lund, L.L. Pierce, A.R. Michaelis, S.H. Hiatt,
    A. Guzman et al. 2012. “Satellite Irrigation Management Support with the Terrestrial Observation
    and Prediction System: A Framework for Integration of Satellite and Surface Observations to
    Support Improvements in Agricultural Water Resource Management.” IEEE Journal of Selected Topics
    in Applied Earth Observations and Remote Sensing 5 (6): 1709–21.

    Pereira, L.S., P. Paredes, F.S. Melton, L.F. Johnson, R. López-Urrea, J. Cancela, and R.G.
    Allen. 2020. “Prediction of Basal Crop Coefficients from Fraction of Ground Cover and Height.
    ” Agricultural Water Management, Special Issue on Updates to the FAO56 Crop Water Requirements
    Method 241, 106197.

    [doi:10.1111/1752-1688.12956](https://doi.org/10.1111/1752-1688.12956)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
