local id = 'COPERNICUS/MARINE/OC_GLO_BGC/REFLECTANCE_OLCI_300M';
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
  title: 'Global Ocean Colour: Bio-Geo-Chemical, L4, from Satellite Observations, Reflectance, OLCI 300M',
  'gee:type': ee_const.gee_type.image_collection,
  description: template.description + template.reflectance_olci_description +
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
      300.0,
    ],
    'eo:bands': [
      {
        name: 'RRS400',
        description: 'Remote Sensing Reflectance at 400 nm',
        'gee:units': units.per_steradian,
      },
      {
        name: 'RRS400_uncertainty',
        description: |||
          Remote Sensing Reflectance at 400 nm - The uncertainty as measured in
          hundredths of a percent (e.g., a value of 5000 means 50%).
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'RRS412',
        description: 'Remote Sensing Reflectance at 412 nm',
        'gee:units': units.per_steradian,
      },
      {
        name: 'RRS412_uncertainty',
        description: |||
          Remote Sensing Reflectance at 412 nm - The uncertainty as measured in
          hundredths of a percent (e.g., a value of 5000 means 50%).
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'RRS443',
        description: 'Remote Sensing Reflectance at 443 nm',
        'gee:units': units.per_steradian,
      },
      {
        name: 'RRS443_uncertainty',
        description: |||
          Remote Sensing Reflectance at 443 nm - The uncertainty as measured in
          hundredths of a percent (e.g., a value of 5000 means 50%).
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'RRS490',
        description: 'Remote Sensing Reflectance at 490 nm',
        'gee:units': units.per_steradian,
      },
      {
        name: 'RRS490_uncertainty',
        description: |||
          Remote Sensing Reflectance at 490 nm - The uncertainty as measured in
          hundredths of a percent (e.g., a value of 5000 means 50%).
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'RRS510',
        description: 'Remote Sensing Reflectance at 510 nm',
        'gee:units': units.per_steradian,
      },
      {
        name: 'RRS510_uncertainty',
        description: |||
          Remote Sensing Reflectance at 510 nm - The uncertainty as measured in
          hundredths of a percent (e.g., a value of 5000 means 50%).
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'RRS560',
        description: 'Remote Sensing Reflectance at 560 nm',
        'gee:units': units.per_steradian,
      },
      {
        name: 'RRS560_uncertainty',
        description: |||
          Remote Sensing Reflectance at 560 nm - The uncertainty as measured in
          hundredths of a percent (e.g., a value of 5000 means 50%).
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'RRS620',
        description: 'Remote Sensing Reflectance at 620 nm',
        'gee:units': units.per_steradian,
      },
      {
        name: 'RRS620_uncertainty',
        description: |||
          Remote Sensing Reflectance at 620 nm - The uncertainty as measured in
          hundredths of a percent (e.g., a value of 5000 means 50%).
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'RRS665',
        description: 'Remote Sensing Reflectance at 665 nm',
        'gee:units': units.per_steradian,
      },
      {
        name: 'RRS665_uncertainty',
        description: |||
          Remote Sensing Reflectance at 665 nm - The uncertainty as measured in
          hundredths of a percent (e.g., a value of 5000 means 50%).
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'RRS674',
        description: 'Remote Sensing Reflectance at 674 nm',
        'gee:units': units.per_steradian,
      },
      {
        name: 'RRS674_uncertainty',
        description: |||
          Remote Sensing Reflectance at 674 nm - The uncertainty as measured in
          hundredths of a percent (e.g., a value of 5000 means 50%).
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'RRS681',
        description: 'Remote Sensing Reflectance at 681 nm',
        'gee:units': units.per_steradian,
      },
      {
        name: 'RRS681_uncertainty',
        description: |||
          Remote Sensing Reflectance at 681 nm - The uncertainty as measured in
          hundredths of a percent (e.g., a value of 5000 means 50%).
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'RRS709',
        description: 'Remote Sensing Reflectance at 709 nm',
        'gee:units': units.per_steradian,
      },
      {
        name: 'RRS709_uncertainty',
        description: |||
          Remote Sensing Reflectance at 709 nm - The uncertainty as measured in
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
      }
    ],
    'gee:visualizations': [
      {
        display_name: 'RRS412',
        lookat: {
          lat: 52.0,
          lon: 71.0,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.000069,
            ],
            max: [
              0.017,
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
              'RRS412',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': template.citation,
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': template.term_of_use,
}
