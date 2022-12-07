local id = 'WORLDCLIM/V1/MONTHLY';
local subdir = 'WORLDCLIM';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_sa_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'WorldClim Climatology V1',
  version: 'V1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    WorldClim version 1 has average monthly global climate data for minimum,
    mean, and maximum temperature and for precipitation.

    WorldClim version 1 was developed by Robert J. Hijmans, Susan Cameron,
    and Juan Parra, at the Museum of Vertebrate Zoology, University
    of California, Berkeley, in collaboration with Peter Jones and
    Andrew Jarvis (CIAT), and with Karen Richardson (Rainforest CRC).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
  ],
  keywords: [
    'berkeley',
    'climate',
    'monthly',
    'precipitation',
    'temperature',
    'weather',
    'worldclim',
  ],
  providers: [
    ee.producer_provider('University of California, Berkeley', 'https://www.worldclim.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1960-01-01T00:00:00Z', '1991-01-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'month',
        description: 'Month',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      927.67,
    ],
    'eo:bands': [
      {
        name: 'tavg',
        description: 'Mean temperature',
        'gee:units': '°C',
        'gee:scale': 0.1,
      },
      {
        name: 'tmin',
        description: 'Minimum temperature',
        'gee:units': '°C',
        'gee:scale': 0.1,
      },
      {
        name: 'tmax',
        description: 'Maximum temperature',
        'gee:units': '°C',
        'gee:scale': 0.1,
      },
      {
        name: 'prec',
        description: 'Precipitation',
        'gee:units': 'mm',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Mean Temperature',
        lookat: {
          lat: 52.48,
          lon: 71.72,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              -400.0,
            ],
            max: [
              300.0,
            ],
            palette: [
              'blue',
              'purple',
              'cyan',
              'green',
              'yellow',
              'red',
            ],
            bands: [
              'tavg',
            ],
          },
        },
      },
    ],
    tavg: {
      minimum: -536.0,
      maximum: 394.0,
      'gee:estimated_range': true,
    },
    tmin: {
      minimum: -573.0,
      maximum: 325.0,
      'gee:estimated_range': true,
    },
    tmax: {
      minimum: -500.0,
      maximum: 490.0,
      'gee:estimated_range': true,
    },
    prec: {
      minimum: 0.0,
      maximum: 2949.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Hijmans, R.J., S.E. Cameron, J.L. Parra, P.G. Jones and A. Jarvis,
    2005. Very High Resolution Interpolated Climate Surfaces for Global Land
    Areas. International Journal of Climatology 25: 1965-1978.
    [doi:10.1002/joc.1276](https://doi.org/10.1002/joc.1276).
  |||,
  'gee:interval': {
    type: 'climatological_interval',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:unusual_terms_of_use': true,
}
