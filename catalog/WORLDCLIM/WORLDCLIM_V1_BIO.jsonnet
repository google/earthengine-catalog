local id = 'WORLDCLIM/V1/BIO';
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
  title: 'WorldClim BIO Variables V1',
  version: 'V1',
  'gee:type': ee_const.gee_type.image,
  description: |||
    WorldClim V1 Bioclim provides bioclimatic variables that are derived from
    the monthly temperature and rainfall in order to generate more biologically
    meaningful values.

    The bioclimatic variables represent annual trends (e.g., mean annual
    temperature, annual precipitation), seasonality (e.g., annual range in
    temperature and precipitation), and extreme or limiting environmental
    factors (e.g., temperature of the coldest and warmest month, and
    precipitation of the wet and dry quarters).

    The bands scheme follows that of ANUCLIM, except that for temperature
    seasonality the standard deviation was used because a coefficient of
    variation does not make sense with temperatures between -1 and 1.

    WorldClim version 1 was developed by Robert J. Hijmans, Susan Cameron,
    and Juan Parra, at the Museum of Vertebrate Zoology, University of
    California, Berkeley, in collaboration with Peter Jones and Andrew Jarvis
    (CIAT), and with Karen Richardson (Rainforest CRC).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
  ],
  keywords: [
    'berkeley',
    'bioclim',
    'climate',
    'coldest',
    'diurnal',
    'driest',
    'isothermality',
    'monthly',
    'precipitation',
    'seasonality',
    'temperature',
    'ucb',
    'warmest',
    'weather',
    'wettest',
    'worldclim',
  ],
  providers: [
    ee.producer_provider('University of California, Berkeley', 'https://www.worldclim.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1960-01-01T00:00:00Z', '1991-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      927.67,
    ],
    'eo:bands': [
      {
        name: 'bio01',
        description: 'Annual mean temperature',
        'gee:units': '°C',
        'gee:scale': 0.1,
      },
      {
        name: 'bio02',
        description: 'Mean diurnal range (mean of monthly (max temp - min temp))',
        'gee:units': '°C',
        'gee:scale': 0.1,
      },
      {
        name: 'bio03',
        description: 'Isothermality (bio02/bio07)',
        'gee:units': '%',
      },
      {
        name: 'bio04',
        description: 'Temperature seasonality (Standard deviation * 100)',
        'gee:units': '°C',
        'gee:scale': 0.01,
      },
      {
        name: 'bio05',
        description: 'Max temperature of warmest month',
        'gee:units': '°C',
        'gee:scale': 0.1,
      },
      {
        name: 'bio06',
        description: 'Min temperature of coldest month',
        'gee:units': '°C',
        'gee:scale': 0.1,
      },
      {
        name: 'bio07',
        description: 'Temperature annual range (bio05-bio06)',
        'gee:units': '°C',
        'gee:scale': 0.1,
      },
      {
        name: 'bio08',
        description: 'Mean temperature of wettest quarter',
        'gee:units': '°C',
        'gee:scale': 0.1,
      },
      {
        name: 'bio09',
        description: 'Mean temperature of driest quarter',
        'gee:units': '°C',
        'gee:scale': 0.1,
      },
      {
        name: 'bio10',
        description: 'Mean temperature of warmest quarter',
        'gee:units': '°C',
        'gee:scale': 0.1,
      },
      {
        name: 'bio11',
        description: 'Mean temperature of coldest quarter',
        'gee:units': '°C',
        'gee:scale': 0.1,
      },
      {
        name: 'bio12',
        description: 'Annual precipitation',
        'gee:units': 'mm',
      },
      {
        name: 'bio13',
        description: 'Precipitation of wettest month',
        'gee:units': 'mm',
      },
      {
        name: 'bio14',
        description: 'Precipitation of driest month',
        'gee:units': 'mm',
      },
      {
        name: 'bio15',
        description: 'Precipitation seasonality',
        'gee:units': 'Coefficient of Variation',
      },
      {
        name: 'bio16',
        description: 'Precipitation of wettest quarter',
        'gee:units': 'mm',
      },
      {
        name: 'bio17',
        description: 'Precipitation of driest quarter',
        'gee:units': 'mm',
      },
      {
        name: 'bio18',
        description: 'Precipitation of warmest quarter',
        'gee:units': 'mm',
      },
      {
        name: 'bio19',
        description: 'Precipitation of coldest quarter',
        'gee:units': 'mm',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Annual Mean Temperature',
        lookat: {
          lat: 52.48,
          lon: 71.72,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              -230.0,
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
              'bio01',
            ],
          },
        },
      },
    ],
    bio01: {
      minimum: -290.0,
      maximum: 320.0,
      'gee:estimated_range': true,
    },
    bio02: {
      minimum: 9.0,
      maximum: 214.0,
      'gee:estimated_range': true,
    },
    bio03: {
      minimum: 7.0,
      maximum: 96.0,
      'gee:estimated_range': true,
    },
    bio04: {
      minimum: 62.0,
      maximum: 22721.0,
      'gee:estimated_range': true,
    },
    bio05: {
      minimum: -96.0,
      maximum: 490.0,
      'gee:estimated_range': true,
    },
    bio06: {
      minimum: -573.0,
      maximum: 258.0,
      'gee:estimated_range': true,
    },
    bio07: {
      minimum: 53.0,
      maximum: 725.0,
      'gee:estimated_range': true,
    },
    bio08: {
      minimum: -285.0,
      maximum: 378.0,
      'gee:estimated_range': true,
    },
    bio09: {
      minimum: -521.0,
      maximum: 366.0,
      'gee:estimated_range': true,
    },
    bio10: {
      minimum: -143.0,
      maximum: 383.0,
      'gee:estimated_range': true,
    },
    bio11: {
      minimum: -521.0,
      maximum: 289.0,
      'gee:estimated_range': true,
    },
    bio12: {
      minimum: 0.0,
      maximum: 11401.0,
      'gee:estimated_range': true,
    },
    bio13: {
      minimum: 0.0,
      maximum: 2949.0,
      'gee:estimated_range': true,
    },
    bio14: {
      minimum: 0.0,
      maximum: 752.0,
      'gee:estimated_range': true,
    },
    bio15: {
      minimum: 0.0,
      maximum: 265.0,
      'gee:estimated_range': true,
    },
    bio16: {
      minimum: 0.0,
      maximum: 8019.0,
      'gee:estimated_range': true,
    },
    bio17: {
      minimum: 0.0,
      maximum: 2495.0,
      'gee:estimated_range': true,
    },
    bio18: {
      minimum: 0.0,
      maximum: 6090.0,
      'gee:estimated_range': true,
    },
    bio19: {
      minimum: 0.0,
      maximum: 5162.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Hijmans, R.J., S.E. Cameron, J.L. Parra, P.G. Jones and A. Jarvis,
    2005. Very High Resolution Interpolated Climate Surfaces for Global Land
    Areas. International Journal of Climatology 25: 1965-1978.
    [doi:10.1002/joc.1276](https://doi.org/10.1002/joc.1276).
  |||,
  'gee:terms_of_use': 'Licensed under the Creative Commons Attribution Share Alike 4.0 International License.',
  'gee:unusual_terms_of_use': true,
}
