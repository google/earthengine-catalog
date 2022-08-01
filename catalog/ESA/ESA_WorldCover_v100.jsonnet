local id = 'ESA/WorldCover/v100';
local subdir = 'ESA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

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
  title: 'ESA WorldCover 10m v100',
  version: 'v100',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The European Space Agency (ESA) WorldCover 10 m 2020 product provides a
    global land cover map for 2020 at 10 m resolution based on Sentinel-1 and
    Sentinel-2 data. The WorldCover product comes with 11 land cover classes and
    has been generated in the framework of the ESA WorldCover project, part of the
    5th Earth Observation Envelope Programme (EOEP-5) of the European Space Agency.

    See also:

    * [ESA WorldCover website](https://esa-worldcover.org)
    * [User Manual and Validation Report](https://esa-worldcover.org/en/data-access)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://esa-worldcover.org/en/data-access',
    },
  ],
  keywords: [
    'esa',
    'landcover',
    'landuse',
    'sentinel1-derived',
    'sentinel2-derived',
  ],
  providers: [
    ee.producer_provider('ESA/VITO/Brockmann Consult/CS/GAMMA Remote Sensing/IIASA/WUR', 'https://esa-worldcover.org/en'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2020-01-01T00:00:00Z', '2021-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      10.0,
    ],
    'eo:bands': [
      {
        name: 'Map',
        description: 'Landcover class',
        'gee:classes': [
          {
            value: 10,
            color: '006400',
            description: 'Trees',
          },
          {
            value: 20,
            color: 'ffbb22',
            description: 'Shrubland',
          },
          {
            value: 30,
            color: 'ffff4c',
            description: 'Grassland',
          },
          {
            value: 40,
            color: 'f096ff',
            description: 'Cropland',
          },
          {
            value: 50,
            color: 'fa0000',
            description: 'Built-up',
          },
          {
            value: 60,
            color: 'b4b4b4',
            description: 'Barren / sparse vegetation',
          },
          {
            value: 70,
            color: 'f0f0f0',
            description: 'Snow and ice',
          },
          {
            value: 80,
            color: '0064c8',
            description: 'Open water',
          },
          {
            value: 90,
            color: '0096a0',
            description: 'Herbaceous wetland',
          },
          {
            value: 95,
            color: '00cf75',
            description: 'Mangroves',
          },
          {
            value: 100,
            color: 'fae6a0',
            description: 'Moss and lichen',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Landcover',
        lookat: {
          lat: -11.2,
          lon: 29.5,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'Map',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': 'A publication is under preparation.',
  'gee:terms_of_use': 'CC-BY-4.0',
  'gee:user_uploaded': true,
}
