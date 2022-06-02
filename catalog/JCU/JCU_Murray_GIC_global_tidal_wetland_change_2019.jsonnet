local id = 'JCU/Murray/GIC/global_tidal_wetland_change/2019';
local subdir = 'JCU';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: 'Collection',
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Murray Global Tidal Wetland Change v1.0 (1999-2019)',
  version: '1.0',
  'gee:type': ee_const.gee_type.image_collection,
  description:  importstr 'description.md',
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
     ee.link.license(license.reference),
  ],
  keywords: [
    'coastal',
    'ecosystem',
    'intertidal',
    'landsat-derived',
    'mangrove',
    'murray',
    'saltmarsh',
    'tidal_flat',
    'tidal_marsh',
  ],
  providers: [
    ee.producer_provider('Murray/JCU', 'https://github.com/nick-murray/gee-global-intertidal-change-data-descriptor'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(
      -180.0, -90.0, 180.0, 90.0, '1999-01-01T00:00:00Z', '2019-12-31T00:00:00Z'),
  'sci:citation': |||
    Murray, N.J., Worthington, T.A., Bunting, P., Duce, S., Hagger, V.,
    Lovelock, C.E., Lucas, R., Saunders, M.I., Sheaves, M., Spalding, M.,
    Waltham, N.J., Lyons, M.B., 2022. High-resolution mapping of losses and
    gains of Earth's tidal wetlands. *Science*.
    [doi:10.1126/science.abm9583](https://doi.org/10.1126/science.abm9583)
  |||,
  'sci:doi': '10.1126/science.abm9583',
  'gee:user_uploaded': true,
  'gee:terms_of_use': license.id,
  summaries: {
    gsd: [
      30
    ],
    'gee:visualizations': [
      {
        display_name: 'Wetland Loss',
        lookat: {
          lat: 1.3,
          lon: 103.7,
          zoom: 12,
        },
        image_visualization: {
          band_vis: {
            min: [1], max: [1], bands: ['loss'],
          },
        },
      },
    ],
    'eo:bands': [
      {
        name: 'loss',
        description: 'Set to 1 for loss locations, masked out otherwise.',
      },
      {
        name: 'lossYear',
        description: |||
          Integer representing the end year of the time-step of loss analysis
          (e.g., 19 = 2017-2019).
        |||,
      },
      {
        name: 'lossType',
        description: |||
          Loss type

          * 2 - Tidal Flat
          * 3 - Mangrove
          * 5 - Tidal Marsh
        |||,
      },
      {
        name: 'gain',
        description: 'Set to 1 for gain locations, masked out otherwise.',
      },
      {
        name: 'gainYear',
        description: |||
          Integer representing the end year of the time-step of gain analysis
          (e.g., 19 = 2017-2019).
        |||,
      },
      {
        name: 'gainType',
        description: |||
          Gain type:

          * 2 - Tidal Flat
          * 3 - Mangrove
          * 5 - Tidal Marsh
        |||,
      },
      {
        name: 'twprobabilityStart',
        description: |||
          Random forest agreement of the overarching tidal wetland class for
          the first time step (1999-2001). Integer between 0 and 100.
        |||,
      },
      {
        name: 'twprobabilityEnd',
        description: |||
          Random forest agreement of the overarching tidal wetland class for
          the last time step (2017-2019). Integer between 0 and 100.
        |||,
      },
    ],
  },
}

