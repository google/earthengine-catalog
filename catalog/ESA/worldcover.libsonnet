local subdir = 'ESA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';

{
  local collection_id(version) = 'ESA/WorldCover/' + version,
  local basename(version) = std.strReplace(collection_id(version), '/', '_'),
  local base_filename(version) = basename(version) + '.json',
  local self_ee_catalog_url(version) =
    ee_const.ee_catalog_url + basename(version),
  local self_url(version) = catalog_subdir_url + base_filename(version),

  catalog_entry(version, year_description, citation):
    {
      stac_version: ee_const.stac_version,
      type: ee_const.stac_type.collection,
      stac_extensions: [
        ee_const.ext_eo,
        ee_const.ext_sci,
        ee_const.ext_ver,
      ],
      id: collection_id(version),
      title: 'ESA WorldCover 10m ' + version,
      version: version,
      'gee:type': ee_const.gee_type.image_collection,
      description: |||
        %s The WorldCover product comes with 11 land cover classes and has been
        generated in the framework of the ESA WorldCover project, part of the
        5th Earth Observation Envelope Programme (EOEP-5) of the European Space
        Agency.

        See also:

        * [ESA WorldCover website](https://esa-worldcover.org)
        * [User Manual and Validation Report](https://esa-worldcover.org/en/data-access)
      ||| % year_description,
      license: license.id,
      links: ee.standardLinks(subdir, collection_id(version)) + [
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
        'sentinel1_derived',
        'sentinel2_derived',
      ],
      providers: [
        ee.producer_provider(
          'ESA/VITO/Brockmann Consult/CS/GAMMA Remote Sensing/IIASA/WUR',
          'https://esa-worldcover.org/en'),
        ee.host_provider(self_ee_catalog_url(version)),
      ],
      extent: ee.extent_global('2021-01-01T00:00:00Z', '2022-01-01T00:00:00Z'),
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
                description: 'Tree cover',
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
                description: 'Bare / sparse vegetation',
              },
              {
                value: 70,
                color: 'f0f0f0',
                description: 'Snow and ice',
              },
              {
                value: 80,
                color: '0064c8',
                description: 'Permanent water bodies',
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
      'sci:citation': citation,
      'gee:terms_of_use': ee.gee_terms_of_use(license),
      'gee:user_uploaded': true,
    },
}
