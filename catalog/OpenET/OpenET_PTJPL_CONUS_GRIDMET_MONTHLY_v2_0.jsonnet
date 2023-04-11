local id = 'OpenET/PTJPL/CONUS/GRIDMET/MONTHLY/v2_0';
local subdir = 'OpenET';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

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
  title: 'OpenET CONUS PT-JPL Monthly Evapotranspiration v2.0',
  version: '2.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Priestley-Taylor Jet Propulsion Laboratory (PT-JPL)

    The core formulation of the PT-JPL model within the OpenET framework has
    not changed from the original formulation detailed in Fisher et al. (2008).
    However, enhancements and updates to model inputs and time integration for
    PT-JPL were made to take advantage of contemporary gridded weather datasets,
    provide consistency with other models, improve open water evaporation
    estimates, and account for advection over crop and wetland areas in
    semiarid and arid environments. These changes include the use of
    Landsat surface reflectance and thermal radiation for calculating net
    radiation, photosynthetically active radiation, plant canopy and moisture
    variables, and use of NLDAS, Spatial CIMIS, and gridMET weather data for
    estimating insolation and ASCE reference ET. Similar to the implementation
    of other OpenET models, estimation of daily and monthly time integrated
    ET is based on the fraction of ASCE reference ET. Open water evaporation
    is estimated following a surface energy balance approach of Abdelrady
    et al. (2016) that is specific for water bodies by accounting for water
    heat flux as opposed to soil heat flux.

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
  extent: ee.extent(-126, 25, -66, 50, '2016-01-01T00:00:00Z', null),
  summaries: {
    gsd: [30],
    'eo:bands': [
      {
        name: 'et',
        description: 'PT-JPL ET value',
        'gee:units': units.millimeter,
      },

      {
        name: 'count',
        description: |||
           Number of cloud free values
        |||,
        'gee:units': 'count',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'OpenET PT-JPL Monthly ET',
        lookat: {
          lat: 38,
          lon: -100,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              1400,
            ],
            palette: [
              '9e6212',
              'ac7d1d',
              'ba9829',
              'c8b434',
              'd6cf40',
              'bed44b',
              '9fcb51',
              '80c256',
              '61b95c',
              '42b062',
              '45b677',
              '49bc8d',
              '4dc2a2',
              '51c8b8',
              '55cece',
              '4db4ba',
              '459aa7',
              '3d8094',
              '356681',
              '2d4c6e',
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
    Fisher, J.B., Tu, K.P. and Baldocchi, D.D., 2008. Global estimates of the land–atmosphere
    water flux based on monthly AVHRR and ISLSCP-II data, validated at 16 FLUXNET sites. Remote
    Sensing of Environment, 112(3), pp.901-919.

    Abdelrady, A., Timmermans, J., Vekerdy, Z. and Salama, M., 2016. Surface energy balance of
    fresh and saline waters: AquaSEBS. Remote sensing, 8(7), p.583.

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
