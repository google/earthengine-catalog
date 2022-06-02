local id = 'COPERNICUS/CORINE/V18_5_1/100m';
local successor_id = 'COPERNICUS/CORINE/V20/100m';
local subdir = 'COPERNICUS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local successor_basename = std.strReplace(successor_id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Copernicus CORINE Land Cover [deprecated]',
  version: 'V18.5.1',
  deprecated: true,
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
    ee.link.successor(
        successor_id, catalog_subdir_url + successor_basename + '.json'),
    {
      rel: 'source',
      href: 'https://land.copernicus.eu/pan-european/corine-land-cover/clc-1990?tab=download',
    },
    {
      rel: 'source',
      href: 'https://land.copernicus.eu/pan-european/corine-land-cover/clc-2000?tab=download',
    },
    {
      rel: 'source',
      href: 'https://land.copernicus.eu/pan-european/corine-land-cover/clc-2006?tab=download',
    },
    {
      rel: 'source',
      href: 'https://land.copernicus.eu/pan-european/corine-land-cover/clc-2012?tab=download',
    },
  ],
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
    ee.host_provider(self_ee_catalog_url),
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
            color: 'E6004D',
            description: 'Artificial surfaces > Urban fabric > Continuous urban fabric',
          },
          {
            value: 2,
            color: 'FF0000',
            description: 'Artificial surfaces > Urban fabric > Discontinuous urban fabric',
          },
          {
            value: 3,
            color: 'CC4DF2',
            description: 'Artificial surfaces > Industrial, commercial, and transport units > Industrial or commercial units',
          },
          {
            value: 4,
            color: 'CC0000',
            description: |||
              Artificial surfaces > Industrial, commercial, and
              transport units > Road and rail networks and associated land
            |||,
          },
          {
            value: 5,
            color: 'E6CCCC',
            description: 'Artificial surfaces > Industrial, commercial, and transport units > Port areas',
          },
          {
            value: 6,
            color: 'E6CCE6',
            description: 'Artificial surfaces > Industrial, commercial, and transport units > Airports',
          },
          {
            value: 7,
            color: 'A600CC',
            description: 'Artificial surfaces > Mine, dump, and construction sites > Mineral extraction sites',
          },
          {
            value: 8,
            color: 'A64DCC',
            description: 'Artificial surfaces > Mine, dump, and construction sites > Dump sites',
          },
          {
            value: 9,
            color: 'FF4DFF',
            description: 'Artificial surfaces > Mine, dump, and construction sites > Construction sites',
          },
          {
            value: 10,
            color: 'FFA6FF',
            description: 'Artificial surfaces > Artificial, non-agricultural vegetated areas > Green urban areas',
          },
          {
            value: 11,
            color: 'FFE6FF',
            description: 'Artificial surfaces > Artificial, non-agricultural vegetated areas > Sport and leisure facilities',
          },
          {
            value: 12,
            color: 'FFFFA8',
            description: 'Agricultural areas > Arable land > Non-irrigated arable land',
          },
          {
            value: 13,
            color: 'FFFF00',
            description: 'Agricultural areas > Arable land > Permanently irrigated land',
          },
          {
            value: 14,
            color: 'E6E600',
            description: 'Agricultural areas > Arable land > Rice fields',
          },
          {
            value: 15,
            color: 'E68000',
            description: 'Agricultural areas > Permanent crops > Vineyards',
          },
          {
            value: 16,
            color: 'F2A64D',
            description: 'Agricultural areas > Permanent crops > Fruit trees and berry plantations',
          },
          {
            value: 17,
            color: 'E6A600',
            description: 'Agricultural areas > Permanent crops > Olive groves',
          },
          {
            value: 18,
            color: 'E6E64D',
            description: 'Agricultural areas > Pastures > Pastures',
          },
          {
            value: 19,
            color: 'FFE6A6',
            description: 'Agricultural areas > Heterogeneous agricultural areas > Annual crops associated with permanent crops',
          },
          {
            value: 20,
            color: 'FFE64D',
            description: 'Agricultural areas > Heterogeneous agricultural areas > Complex cultivation patterns',
          },
          {
            value: 21,
            color: 'E6CC4D',
            description: |||
              Agricultural areas > Heterogeneous agricultural areas >
              Land principally occupied by agriculture, with significant areas of
              natural vegetation
            |||,
          },
          {
            value: 22,
            color: 'F2CCA6',
            description: 'Agricultural areas > Heterogeneous agricultural areas > Agro-forestry areas',
          },
          {
            value: 23,
            color: '80FF00',
            description: 'Forest and semi natural areas > Forests > Broad-leaved forest',
          },
          {
            value: 24,
            color: '00A600',
            description: 'Forest and semi natural areas > Forests > Coniferous forest',
          },
          {
            value: 25,
            color: '4DFF00',
            description: 'Forest and semi natural areas > Forests > Mixed forest',
          },
          {
            value: 26,
            color: 'CCF24D',
            description: 'Forest and semi natural areas > Scrub and/or herbaceous vegetation associations > Natural grasslands',
          },
          {
            value: 27,
            color: 'A6FF80',
            description: 'Forest and semi natural areas > Scrub and/or herbaceous vegetation associations > Moors and heathland',
          },
          {
            value: 28,
            color: 'A6E64D',
            description: |||
              Forest and semi natural areas > Scrub and/or herbaceous
              vegetation associations > Sclerophyllous vegetation
            |||,
          },
          {
            value: 29,
            color: 'A6F200',
            description: |||
              Forest and semi natural areas > Scrub and/or herbaceous
              vegetation associations > Transitional woodland-shrub
            |||,
          },
          {
            value: 30,
            color: 'E6E6E6',
            description: 'Forest and semi natural areas > Open spaces with little or no vegetation > Beaches, dunes, sands',
          },
          {
            value: 31,
            color: 'CCCCCC',
            description: 'Forest and semi natural areas > Open spaces with little or no vegetation > Bare rocks',
          },
          {
            value: 32,
            color: 'CCFFCC',
            description: 'Forest and semi natural areas > Open spaces with little or no vegetation > Sparsely vegetated areas',
          },
          {
            value: 33,
            color: '000000',
            description: 'Forest and semi natural areas > Open spaces with little or no vegetation > Burnt areas',
          },
          {
            value: 34,
            color: 'A6E6CC',
            description: 'Forest and semi natural areas > Open spaces with little or no vegetation > Glaciers and perpetual snow',
          },
          {
            value: 35,
            color: 'A6A6FF',
            description: 'Wetlands > Inland wetlands > Inland marshes',
          },
          {
            value: 36,
            color: '4D4DFF',
            description: 'Wetlands > Inland wetlands > Peat bogs',
          },
          {
            value: 37,
            color: 'CCCCFF',
            description: 'Wetlands > Maritime wetlands > Salt marshes',
          },
          {
            value: 38,
            color: 'E6E6FF',
            description: 'Wetlands > Maritime wetlands > Salines',
          },
          {
            value: 39,
            color: 'A6A6E6',
            description: 'Wetlands > Maritime wetlands > Intertidal flats',
          },
          {
            value: 40,
            color: '00CCF2',
            description: 'Water bodies > Inland waters > Water courses',
          },
          {
            value: 41,
            color: '80F2E6',
            description: 'Water bodies > Inland waters > Water bodies',
          },
          {
            value: 42,
            color: '00FFA6',
            description: 'Water bodies > Marine waters > Coastal lagoons',
          },
          {
            value: 43,
            color: 'A6FFE6',
            description: 'Water bodies > Marine waters > Estuaries',
          },
          {
            value: 44,
            color: 'E6F2FF',
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
              'E6004D',
              'FF0000',
              'CC4DF2',
              'CC0000',
              'E6CCCC',
              'E6CCE6',
              'A600CC',
              'A64DCC',
              'FF4DFF',
              'FFA6FF',
              'FFE6FF',
              'FFFFA8',
              'FFFF00',
              'E6E600',
              'E68000',
              'F2A64D',
              'E6A600',
              'E6E64D',
              'FFE6A6',
              'FFE64D',
              'E6CC4D',
              'F2CCA6',
              '80FF00',
              '00A600',
              '4DFF00',
              'CCF24D',
              'A6FF80',
              'A6E64D',
              'A6F200',
              'E6E6E6',
              'CCCCCC',
              'CCFFCC',
              '000000',
              'A6E6CC',
              'A6A6FF',
              '4D4DFF',
              'CCCCFF',
              'E6E6FF',
              'A6A6E6',
              '00CCF2',
              '80F2E6',
              '00FFA6',
              'A6FFE6',
              'E6F2FF',
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
