local id = 'COPERNICUS/CORINE/V18_5_1/100m';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/corine_100m_versions.libsonnet';

local subdir = 'COPERNICUS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Copernicus CORINE Land Cover [deprecated]',
  version: version,
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The CORINE (coordination of information on the environment) Land Cover
    (CLC) inventory was initiated in 1985 to standardize data collection on land
    in Europe to support environmental policy development. The project is
    coordinated by the European Environment Agency (EEA) in the frame of the EU
    Copernicus programme and implemented by national teams. The number of
    participating countries has increased over time currently including 33 (EEA)
    member countries and six cooperating countries (EEA39) with a total area of
    over 5.8 Mkm2.

    The reference year of the first CLC inventory was 1990 and the first update
    created in 2000. Later, the update cycle has become 6 years. Satellite
    imagery provides the geometrical and thematic basis for mapping with in-situ
    data as essential ancillary information. The basic technical parameters of
    CLC (i.e. 44 classes in nomenclature, 25 hectares minimum mapping unit
    (MMU), and 100 meters minimum mapping width) have not changed since the
    beginning, therefore the results of the different inventories are
    comparable.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.source,
      href: 'https://land.copernicus.eu/pan-european/corine-land-cover/clc-1990?tab=download',
    },
    {
      rel: ee_const.rel.source,
      href: 'https://land.copernicus.eu/pan-european/corine-land-cover/clc-2000?tab=download',
    },
    {
      rel: ee_const.rel.source,
      href: 'https://land.copernicus.eu/pan-european/corine-land-cover/clc-2006?tab=download',
    },
    {
      rel: ee_const.rel.source,
      href: 'https://land.copernicus.eu/pan-european/corine-land-cover/clc-2012?tab=download',
    },
  ] + version_config.version_links,
  keywords: [
    'clc',
    'copernicus',
    'corine',
    'eea',
    'esa',
    'eu',
    'landcover',
  ],
  providers: [
    ee.producer_provider('EEA/Copernicus', 'https://land.copernicus.eu/pan-european/corine-land-cover/view'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent(-81.77, -29.2, 94.13, 73.81,
                    '1986-01-01T00:00:00Z', '2012-12-31T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'landcover_class_names',
        description: 'Land cover class names',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'landcover_class_palette',
        description: 'Land cover class palette',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'landcover_class_values',
        description: 'Value of the land cover classification.',
        type: ee_const.var_type.int_list,
      },
    ],
    gsd: [
      100.0,
    ],
    'eo:bands': [
      {
        name: 'landcover',
        description: 'Land cover',
        'gee:classes': [
          {
            value: 1,
            color: 'e6004d',
            description: 'Artificial surfaces > Urban fabric > Continuous urban fabric',
          },
          {
            value: 2,
            color: 'ff0000',
            description: 'Artificial surfaces > Urban fabric > Discontinuous urban fabric',
          },
          {
            value: 3,
            color: 'cc4df2',
            description: 'Artificial surfaces > Industrial, commercial, and transport units > Industrial or commercial units',
          },
          {
            value: 4,
            color: 'cc0000',
            description: |||
              Artificial surfaces > Industrial, commercial, and
              transport units > Road and rail networks and associated land
            |||,
          },
          {
            value: 5,
            color: 'e6cccc',
            description: 'Artificial surfaces > Industrial, commercial, and transport units > Port areas',
          },
          {
            value: 6,
            color: 'e6cce6',
            description: 'Artificial surfaces > Industrial, commercial, and transport units > Airports',
          },
          {
            value: 7,
            color: 'a600cc',
            description: 'Artificial surfaces > Mine, dump, and construction sites > Mineral extraction sites',
          },
          {
            value: 8,
            color: 'a64dcc',
            description: 'Artificial surfaces > Mine, dump, and construction sites > Dump sites',
          },
          {
            value: 9,
            color: 'ff4dff',
            description: 'Artificial surfaces > Mine, dump, and construction sites > Construction sites',
          },
          {
            value: 10,
            color: 'ffa6ff',
            description: 'Artificial surfaces > Artificial, non-agricultural vegetated areas > Green urban areas',
          },
          {
            value: 11,
            color: 'ffe6ff',
            description: 'Artificial surfaces > Artificial, non-agricultural vegetated areas > Sport and leisure facilities',
          },
          {
            value: 12,
            color: 'ffffa8',
            description: 'Agricultural areas > Arable land > Non-irrigated arable land',
          },
          {
            value: 13,
            color: 'ffff00',
            description: 'Agricultural areas > Arable land > Permanently irrigated land',
          },
          {
            value: 14,
            color: 'e6e600',
            description: 'Agricultural areas > Arable land > Rice fields',
          },
          {
            value: 15,
            color: 'e68000',
            description: 'Agricultural areas > Permanent crops > Vineyards',
          },
          {
            value: 16,
            color: 'f2a64d',
            description: 'Agricultural areas > Permanent crops > Fruit trees and berry plantations',
          },
          {
            value: 17,
            color: 'e6a600',
            description: 'Agricultural areas > Permanent crops > Olive groves',
          },
          {
            value: 18,
            color: 'e6e64d',
            description: 'Agricultural areas > Pastures > Pastures',
          },
          {
            value: 19,
            color: 'ffe6a6',
            description: 'Agricultural areas > Heterogeneous agricultural areas > Annual crops associated with permanent crops',
          },
          {
            value: 20,
            color: 'ffe64d',
            description: 'Agricultural areas > Heterogeneous agricultural areas > Complex cultivation patterns',
          },
          {
            value: 21,
            color: 'e6cc4d',
            description: |||
              Agricultural areas > Heterogeneous agricultural areas >
              Land principally occupied by agriculture, with significant areas of
              natural vegetation
            |||,
          },
          {
            value: 22,
            color: 'f2cca6',
            description: 'Agricultural areas > Heterogeneous agricultural areas > Agro-forestry areas',
          },
          {
            value: 23,
            color: '80ff00',
            description: 'Forest and semi natural areas > Forests > Broad-leaved forest',
          },
          {
            value: 24,
            color: '00a600',
            description: 'Forest and semi natural areas > Forests > Coniferous forest',
          },
          {
            value: 25,
            color: '4dff00',
            description: 'Forest and semi natural areas > Forests > Mixed forest',
          },
          {
            value: 26,
            color: 'ccf24d',
            description: 'Forest and semi natural areas > Scrub and/or herbaceous vegetation associations > Natural grasslands',
          },
          {
            value: 27,
            color: 'a6ff80',
            description: 'Forest and semi natural areas > Scrub and/or herbaceous vegetation associations > Moors and heathland',
          },
          {
            value: 28,
            color: 'a6e64d',
            description: |||
              Forest and semi natural areas > Scrub and/or herbaceous
              vegetation associations > Sclerophyllous vegetation
            |||,
          },
          {
            value: 29,
            color: 'a6f200',
            description: |||
              Forest and semi natural areas > Scrub and/or herbaceous
              vegetation associations > Transitional woodland-shrub
            |||,
          },
          {
            value: 30,
            color: 'e6e6e6',
            description: 'Forest and semi natural areas > Open spaces with little or no vegetation > Beaches, dunes, sands',
          },
          {
            value: 31,
            color: 'cccccc',
            description: 'Forest and semi natural areas > Open spaces with little or no vegetation > Bare rocks',
          },
          {
            value: 32,
            color: 'ccffcc',
            description: 'Forest and semi natural areas > Open spaces with little or no vegetation > Sparsely vegetated areas',
          },
          {
            value: 33,
            color: '000000',
            description: 'Forest and semi natural areas > Open spaces with little or no vegetation > Burnt areas',
          },
          {
            value: 34,
            color: 'a6e6cc',
            description: 'Forest and semi natural areas > Open spaces with little or no vegetation > Glaciers and perpetual snow',
          },
          {
            value: 35,
            color: 'a6a6ff',
            description: 'Wetlands > Inland wetlands > Inland marshes',
          },
          {
            value: 36,
            color: '4d4dff',
            description: 'Wetlands > Inland wetlands > Peat bogs',
          },
          {
            value: 37,
            color: 'ccccff',
            description: 'Wetlands > Maritime wetlands > Salt marshes',
          },
          {
            value: 38,
            color: 'e6e6ff',
            description: 'Wetlands > Maritime wetlands > Salines',
          },
          {
            value: 39,
            color: 'a6a6e6',
            description: 'Wetlands > Maritime wetlands > Intertidal flats',
          },
          {
            value: 40,
            color: '00ccf2',
            description: 'Water bodies > Inland waters > Water courses',
          },
          {
            value: 41,
            color: '80f2e6',
            description: 'Water bodies > Inland waters > Water bodies',
          },
          {
            value: 42,
            color: '00ffa6',
            description: 'Water bodies > Marine waters > Coastal lagoons',
          },
          {
            value: 43,
            color: 'a6ffe6',
            description: 'Water bodies > Marine waters > Estuaries',
          },
          {
            value: 44,
            color: 'e6f2ff',
            description: 'Water bodies > Marine waters > Sea and ocean',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Land Cover',
        lookat: {
          lat: 39.825,
          lon: 16.436,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              44.0,
            ],
            palette: [
              'e6004d',
              'ff0000',
              'cc4df2',
              'cc0000',
              'e6cccc',
              'e6cce6',
              'a600cc',
              'a64dcc',
              'ff4dff',
              'ffa6ff',
              'ffe6ff',
              'ffffa8',
              'ffff00',
              'e6e600',
              'e68000',
              'f2a64d',
              'e6a600',
              'e6e64d',
              'ffe6a6',
              'ffe64d',
              'e6cc4d',
              'f2cca6',
              '80ff00',
              '00a600',
              '4dff00',
              'ccf24d',
              'a6ff80',
              'a6e64d',
              'a6f200',
              'e6e6e6',
              'cccccc',
              'ccffcc',
              '000000',
              'a6e6cc',
              'a6a6ff',
              '4d4dff',
              'ccccff',
              'e6e6ff',
              'a6a6e6',
              '00ccf2',
              '80f2e6',
              '00ffa6',
              'a6ffe6',
              'e6f2ff',
            ],
            bands: [
              'landcover',
            ],
          },
        },
      },
    ],
  },
  'gee:terms_of_use': |||
    Access to data is based on a principle of full, open, and free access as
    established by the Copernicus data and information policy Regulation (EU)
    No 1159/2013 of 12 July 2013. For more information visit:
    [https://land.copernicus.eu/pan-european/corine-land-cover/clc-2012?tab=metadata](https://land.copernicus.eu/pan-european/corine-land-cover/clc-2012?tab=metadata).
  |||,
}
