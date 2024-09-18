local id = 'BNETD/land_cover/v1';
local subdir = 'BNETD';
local version = 'v1';
local latest_id = id;

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local latest_basename = std.strReplace(latest_id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: "Cote d'Ivoire BNETD 2020 Land Cover Map",
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  'gee:status': 'beta',
  description: |||
    The Cote d'Ivoire BNETD 2020 Land Cover Map was produced by the Ivorian
    Government through a national institution, the Center for Geographic
    Information and Digital from the National Study Office Techniques and
    Development (BNETD-CIGN), with technical and financial support from the
    European Union. The methodology used to produce the map was transparent,
    participatory and in line with international standards.

    To develop this map, a mosaic of satellite images (Sentinel 2) from 2020 was
    processed via Google Earth Engine and supplemented with data collected in the
    field, to train a supervised classification algorithm (Random Forest).
    Two field campaigns were conducted, from 10 November to 9 December 2022 and
    from 26 January to 13 February 2023, throughout the country. These missions
    mobilized 33 people, census or inventory because the data collection methods,
    definitions used and purpose of the exercise are different.

    As part of the EUDR due diligence process, geolocation data for plots of
    land producing EUDR-relevant products could be overlaid with 2020 forest
    cover data in order to assess the risk that the plot is located in an area
    that was forested before the 2020 cut-off date. To do this, forest cover
    data aligned with the FAO definition of forests and the 2020 cut-off date
    is required. The 2020 land cover map of Cote d'Ivoire meets these needs.
    Indeed, the classes in the land cover map can be combined to create a
    forest/non-forest map that is aligned with the FAO definition of forests.

    A platform for accessing 2020 land cover data has been developed using ESRI
    solutions, from Africa GeoPortal, for data analysis and visualisation.
    The address is: [https://bit.ly/carte-ci-2020](https://bit.ly/carte-ci-2020)

    Documentation:

    * [Detailed documentation](https://drive.google.com/file/d/1c2ej637TRmbwvJqzdElf64-aahb1Sbw2/view)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.source,
      href: 'https://africageoportal.maps.arcgis.com/home/item.html?id=46348aa12a3d46e592584737de64f72a',
    },
  ],
  keywords: [
    'landcover',
    'forest',
    'classification',
    'deforestation'
  ],
  providers: [
    ee.producer_provider('BNETD-CIGN', 'https://africageoportal.maps.arcgis.com/home/user.html?user=bnetdcignCI'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-8.6020, 4.3603, -2.4930, 10.7400, '2020-01-01T00:00:00Z', '2021-01-01T00:00:00Z'),
  summaries: {
    gsd:[10],
    'eo:bands': [
      {
        name: 'classification',
        description: |||
          Land Cover class
        |||,
        'gee:classes': [
          {
            description: 'Dense forest (For&ecirc;t dense)',
            value: 1,
            color: '276300'
          },
          {
            description: 'Light forest (For&ecirc;t claire)',
            value: 2,
            color: '59D757'
          },
          {
            description: 'Forest gallery (For&ecirc;t galerie)',
            value: 3,
            color: '569D6E'
          },
          {
            description: 'Secondary forest/degraded forest (For&ecirc;t secondaire/for&ecirc;t d&eacute;grad&eacute;e)',
            value: 4,
            color: '79CFAD'
          },
          {
            description: 'Mangrove',
            value: 5,
            color: '34734C'
          },
          {
            description: 'Forest plantation/Reforestation (Plantation foresti&egrave;re/Reboisement)',
            value: 6,
            color: 'B4FFAD'
          },
          {
            description: 'Swamp forest/Forest on hydromorphic soil (For&ecirc;t mar&eacute;cageuse/For&ecirc;t sur sol hydromorphe)',
            value: 7,
            color: '6EFA9A'
          },
          {
            description: 'Coffee Plantation (Plantation de Caf&eacute;)',
            value: 8,
            color: 'D68589'
          },
          {
            description: 'Cocoa Plantation (Plantation de Cacao)',
            value: 9,
            color: 'EBD37F'
          },
          {
            description: 'Rubber plantation (Plantation d&#39;H&eacute;v&eacute;a)',
            value: 10,
            color: 'D0E09D'
          },
          {
            description: 'Oil palm plantation (Plantation de Palmier &agrave; huile)',
            value: 11,
            color: 'E8BEFF'
          },
          {
            description: 'Coconut Plantation (Plantation de Coco)',
            value: 12,
            color: 'E751FE'
          },
          {
            description: 'Cashew plantation (Plantation d&#39;Anacarde)',
            value: 13,
            color: 'F3BFF2'
          },
          {
            description: 'Fruit plantation / Arboriculture (Plantation fruiti&egrave;re / Arboricultures)',
            value: 14,
            color: '9DFD00'
          },
          {
            description: 'Agricultural development/Other crops/Orchards/Fallow land (Am&eacute;nagement agricole/Autres cultures/Vergers/Jach&egrave;res)',
            value: 15,
            color: 'F2F38D'
          },
          {
            description: 'Tree savannah (Savane arbor&eacute;e)',
            value: 16,
            color: 'B6D322'
          },
          {
            description: 'Shrub formations/ Thickets (Formations arbustives/ Fourr&eacute;s)',
            value: 17,
            color: 'E2FE5F'
          },
          {
            description: 'Herbaceous formations (Formations herbac&eacute;es)',
            value: 18,
            color: 'F9FDCC'
          },
          {
            description: 'Body of water, Courses and waterways (Plan d&#39;eau, Cours et voies deau)',
            value: 19,
            color: '4A70C0'
          },
          {
            description: 'Swampy area (Zone mar&eacute;cageuse)',
            value: 20,
            color: 'BEFFE8'
          },
          {
            description: 'Human habitat, Infrastructure (Habitat humain, Infrastructures)',
            value: 21,
            color: 'D20A02'
          },
          {
            description: 'Rocky outcrop (Affleurement rocheux)',
            value: 22,
            color: 'DBECEF'
          },
          {
            description: 'Bare ground (Sol nu)',
            value: 23,
            color: 'DCDCDC'
          },
        ]
      },
    ],
    'gee:visualizations': [
      {
        display_name: "Cote d'Ivoire Land Cover Map 2020",
        lookat: {
          lon : -5.4400,
          lat : 7.5500,
          zoom: 7,
        },
        image_visualization: {
          band_vis: {bands: ['classification']},
        },
      },
    ],
    classification: {
      minimum: 1,
      maximum: 23,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    BNETD Land Cover Map 2020.
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  }
}
