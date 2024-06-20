local id = 'CANADA/NFIS/NTEMS/CA_FOREST_AGE';
local subdir = 'CANADA';

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
  id: id,
  title: 'Landsat-derived forest age for Canada 2019',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Canadian primary forest dataset is a satellite-based forest age map for
    2019 across Canada's forested ecozones at a 30-m spatial resolution.
    Remotely-sensed data from Landsat (disturbances, surface
    reflectance composites, forest structure) and MODIS (Gross Primary
    Production) are utilized to determine age.

    Forest age can be determined where disturbance can be identified directly
    (disturbance approach) or inferred using spectral information (recovery
    approach) or using inverted allometric equations to model age where there
    is no evidence of disturbance (allometric approach). The disturbance
    approach is based upon satellite data and mapped changes and is the most
    accurate. The recovery approach also avails upon satellite data plus logic
    regarding forest succession, with an accuracy that is greater than pure
    modeling.

    Given the lack of widespread recent disturbance over Canada's forests, the
    allometric approach is required over the greatest area (86.6%). Using
    information regarding realized heights and growth and yield modeling, ages
    are estimated where none are otherwise possible. Trees of all ages are
    mapped, with trees >150 years old combined in an "old tree" category.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.source,
      href: 'https://opendata.nfis.org/downloads/forest_change/CA_forest_age_2019.zip',
    },
  ],
  keywords: [
    'canada',
    'forest',
  ],
  providers: [
    ee.producer_provider(
      'National Forest Information System',
      'https://opendata.nfis.org/mapserver/nfis-change_eng.html'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2019-01-01T01:00:00Z', '2020-01-01T01:00:00Z'),
  summaries: {
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'forest',
        description: 'Forest age',
        'gee:units': units.year,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Forest age',
        lookat: {
          lat: 58.18,
          lon: -107.94,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              1000.0,
            ],
            palette: [
              'ff0000',
            ],
            bands: [
              'forest',
            ],
          },
        },
      },
    ],
  },
  'gee:terms_of_use': |||

    The forest age map described herein for Canada's forested ecosystems is
    declared open source and supported by the Government of Canada. The dataset
    is licensed under the [CC-BY 4.0 license](https://creativecommons.org/licenses/by/4.0/).
  |||,
}
