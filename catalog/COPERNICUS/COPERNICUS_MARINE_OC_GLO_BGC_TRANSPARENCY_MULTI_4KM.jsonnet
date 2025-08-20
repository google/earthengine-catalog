local id = 'COPERNICUS/MARINE/OC_GLO_BGC/TRANSPARENCY_MULTI_4KM';
local subdir = 'COPERNICUS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local template = import 'templates/COPERNICUS_MARINE_OC_GLO_BGC.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';

local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci
  ],
  id: id,
  title: 'Global Ocean Colour: Bio-Geo-Chemical, L4, from Satellite Observations, Transparency, Multi-Sensor, 4KM',
  'gee:type': ee_const.gee_type.image_collection,
  description: template.description + template.transparency_multi_description +
    template.documentation,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['oceans'],
  keywords: [
    'copernicus',
    'marine',
  ],
  providers: [
    ee.producer_provider('Copernicus', 'https://doi.org/10.48670/moi-00279'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2023-04-01T00:00:00Z', null),
  summaries: {
    gsd: [
      4000.0,
    ],
    'eo:bands': [
      {
        name: 'KD490',
        description: 'Diffuse attenuation coefficient at 490 nm',
        'gee:units': units.inverse_length,
      },
      {
        name: 'KD490_uncertainty',
        description: |||
          Diffuse attenuation coefficient at 490 nm - The uncertainty as
          measured in hundredths of a percent (e.g., a value of 5000 means 50%).
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'ZSD',
        description: 'Secchi disk depth Transparency',
        'gee:units': units.meter,
      },
      {
        name: 'ZSD_uncertainty',
        description: |||
          Secchi disk depth Transparency - The uncertainty as measured in
          hundredths of a percent (e.g., a value of 5000 means 50%).
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'flags',
        description: |||
          Land water mask bit.

            * 0: Water
            * 1: Land
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'ZSD',
        lookat: {
          lat: 52.0,
          lon: 71.0,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              5.712,
            ],
            max: [
              51.91,
            ],
            palette: [
              'D7F9D0',
              '91CA85',
              '5AB05D',
              '129450',
              '0F7347',
              '195437',
              '122414'
            ],
            bands: [
              'ZSD',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': template.citation,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': template.term_of_use,
}
