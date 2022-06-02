local id = 'GFW/GFF/V1/fishing_hours';
local subdir = 'GFW';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_sa_4_0;

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
  title: 'GFW (Global Fishing Watch) Daily Fishing Hours',
  version: 'V1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Fishing effort, measured in hours of inferred fishing activity. Each asset
    is the effort for a given flag state and day, with one band for the
    fishing activity of each gear type.

    See [sample Earth Engine
    scripts](https://globalfishingwatch.org/research/global-footprint-of-fisheries/).
    Also see [the main GFW site](https://GlobalFishingWatch.org) for program
    information, fully interactive visualization maps, and impacts.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'fishing',
    'gfw',
    'marine',
    'monthly',
    'ocean',
  ],
  providers: [
    ee.producer_provider('Global Fishing Watch', 'https://globalfishingwatch.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2012-01-01T00:00:00Z', '2017-01-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'country',
        description: 'ISO3 country code of the vessel flag state. For all countries, use “WLD”.',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      1113.2,
    ],
    'eo:bands': [
      {
        name: 'drifting_longlines',
        description: 'Hours per sq. km of fishing with drifting longlines.',
        'gee:units': 'hours/sq. km',
      },
      {
        name: 'fixed_gear',
        description: 'Hours per sq. km of fishing with fixed gear.',
        'gee:units': 'hours/sq. km',
      },
      {
        name: 'other_fishing',
        description: 'Hours per sq. km of fishing with other gear types.',
        'gee:units': 'hours/sq. km',
      },
      {
        name: 'purse_seines',
        description: 'Hours per sq. km of fishing with purse seines.',
        'gee:units': 'hours/sq. km',
      },
      {
        name: 'squid_jigger',
        description: 'Hours per sq. km of fishing with squid jiggers.',
        'gee:units': 'hours/sq. km',
      },
      {
        name: 'trawlers',
        description: 'Hours per sq. km of fishing with trawlers.',
        'gee:units': 'hours/sq. km',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Trawlers',
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              5.0,
            ],
            bands: [
              'trawlers',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': 'Global Fishing Watch, “Tracking the Global Footprint of Fisheries.” Science 361.6378 (2018).',
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    This work is licensed under a Creative Commons Attribution-ShareAlike 4.0
    International license. (CC-BY-SA)
  |||,
  'gee:unusual_terms_of_use': true,
  'gee:user_uploaded': true,
}
