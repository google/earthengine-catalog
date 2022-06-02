local id = 'COPERNICUS/CORINE/V20/100m';
local subdir = 'COPERNICUS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Copernicus CORINE Land Cover',
  version: 'V20',
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

    CLC2018 is one of the datasets produced within the frame the Corine Land Cover
    programme referring to land cover / land use status of year 2018.
    The reference year of the first CLC inventory was 1990 and the first update
    created in 2000. Later, the update cycle has become 6 years. Satellite
    imagery provides the geometrical and thematic basis for mapping with in-situ
    data as essential ancillary information. The basic technical parameters of
    CLC (i.e. 44 classes in nomenclature, 25 hectares minimum mapping unit
    (MMU), and 100 meters minimum mapping width) have not changed since the
    beginning, therefore the results of the different inventories are
    comparable.

    The time period covered by each asset is:
    *   1990 asset: 1989 to 1998
    *   2000 asset: 1999 to 2001
    *   2006 asset: 2005 to 2007
    *   2012 asset: 2011 to 2012
    *   2018 asset: 2017 to 2018
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
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
    {
      rel: 'source',
      href: 'https://land.copernicus.eu/pan-european/corine-land-cover/clc2018?tab=download',
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
                    '1986-01-01T00:00:00Z', '2018-12-31T00:00:00Z'),
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
            value: 111,
            color: 'E6004D',
            description: 'Artificial surfaces > Urban fabric > Continuous urban fabric',
          },
          {
            value: 112,
            color: 'FF0000',
            description: 'Artificial surfaces > Urban fabric > Discontinuous urban fabric',
          },
          {
            value: 121,
            color: 'CC4DF2',
            description: 'Artificial surfaces > Industrial, commercial, and transport units > Industrial or commercial units',
          },
          {
            value: 122,
            color: 'CC0000',
            description: |||
              Artificial surfaces > Industrial, commercial, and
              transport units > Road and rail networks and associated land
            |||,
          },
          {
            value: 123,
            color: 'E6CCCC',
            description: 'Artificial surfaces > Industrial, commercial, and transport units > Port areas',
          },
          {
            value: 124,
            color: 'E6CCE6',
            description: 'Artificial surfaces > Industrial, commercial, and transport units > Airports',
          },
          {
            value: 131,
            color: 'A600CC',
            description: 'Artificial surfaces > Mine, dump, and construction sites > Mineral extraction sites',
          },
          {
            value: 132,
            color: 'A64DCC',
            description: 'Artificial surfaces > Mine, dump, and construction sites > Dump sites',
          },
          {
            value: 133,
            color: 'FF4DFF',
            description: 'Artificial surfaces > Mine, dump, and construction sites > Construction sites',
          },
          {
            value: 141,
            color: 'FFA6FF',
            description: 'Artificial surfaces > Artificial, non-agricultural vegetated areas > Green urban areas',
          },
          {
            value: 142,
            color: 'FFE6FF',
            description: 'Artificial surfaces > Artificial, non-agricultural vegetated areas > Sport and leisure facilities',
          },
          {
            value: 211,
            color: 'FFFFA8',
            description: 'Agricultural areas > Arable land > Non-irrigated arable land',
          },
          {
            value: 212,
            color: 'FFFF00',
            description: 'Agricultural areas > Arable land > Permanently irrigated land',
          },
          {
            value: 213,
            color: 'E6E600',
            description: 'Agricultural areas > Arable land > Rice fields',
          },
          {
            value: 221,
            color: 'E68000',
            description: 'Agricultural areas > Permanent crops > Vineyards',
          },
          {
            value: 222,
            color: 'F2A64D',
            description: 'Agricultural areas > Permanent crops > Fruit trees and berry plantations',
          },
          {
            value: 223,
            color: 'E6A600',
            description: 'Agricultural areas > Permanent crops > Olive groves',
          },
          {
            value: 231,
            color: 'E6E64D',
            description: 'Agricultural areas > Pastures > Pastures',
          },
          {
            value: 241,
            color: 'FFE6A6',
            description: 'Agricultural areas > Heterogeneous agricultural areas > Annual crops associated with permanent crops',
          },
          {
            value: 242,
            color: 'FFE64D',
            description: 'Agricultural areas > Heterogeneous agricultural areas > Complex cultivation patterns',
          },
          {
            value: 243,
            color: 'E6CC4D',
            description: |||
              Agricultural areas > Heterogeneous agricultural areas >
              Land principally occupied by agriculture, with significant areas of
              natural vegetation
            |||,
          },
          {
            value: 244,
            color: 'F2CCA6',
            description: 'Agricultural areas > Heterogeneous agricultural areas > Agro-forestry areas',
          },
          {
            value: 311,
            color: '80FF00',
            description: 'Forest and semi natural areas > Forests > Broad-leaved forest',
          },
          {
            value: 312,
            color: '00A600',
            description: 'Forest and semi natural areas > Forests > Coniferous forest',
          },
          {
            value: 313,
            color: '4DFF00',
            description: 'Forest and semi natural areas > Forests > Mixed forest',
          },
          {
            value: 321,
            color: 'CCF24D',
            description: 'Forest and semi natural areas > Scrub and/or herbaceous vegetation associations > Natural grasslands',
          },
          {
            value: 322,
            color: 'A6FF80',
            description: 'Forest and semi natural areas > Scrub and/or herbaceous vegetation associations > Moors and heathland',
          },
          {
            value: 323,
            color: 'A6E64D',
            description: |||
              Forest and semi natural areas > Scrub and/or herbaceous
              vegetation associations > Sclerophyllous vegetation
            |||,
          },
          {
            value: 324,
            color: 'A6F200',
            description: |||
              Forest and semi natural areas > Scrub and/or herbaceous
              vegetation associations > Transitional woodland-shrub
            |||,
          },
          {
            value: 331,
            color: 'E6E6E6',
            description: 'Forest and semi natural areas > Open spaces with little or no vegetation > Beaches, dunes, sands',
          },
          {
            value: 332,
            color: 'CCCCCC',
            description: 'Forest and semi natural areas > Open spaces with little or no vegetation > Bare rocks',
          },
          {
            value: 333,
            color: 'CCFFCC',
            description: 'Forest and semi natural areas > Open spaces with little or no vegetation > Sparsely vegetated areas',
          },
          {
            value: 334,
            color: '000000',
            description: 'Forest and semi natural areas > Open spaces with little or no vegetation > Burnt areas',
          },
          {
            value: 335,
            color: 'A6E6CC',
            description: 'Forest and semi natural areas > Open spaces with little or no vegetation > Glaciers and perpetual snow',
          },
          {
            value: 411,
            color: 'A6A6FF',
            description: 'Wetlands > Inland wetlands > Inland marshes',
          },
          {
            value: 412,
            color: '4D4DFF',
            description: 'Wetlands > Inland wetlands > Peat bogs',
          },
          {
            value: 421,
            color: 'CCCCFF',
            description: 'Wetlands > Maritime wetlands > Salt marshes',
          },
          {
            value: 422,
            color: 'E6E6FF',
            description: 'Wetlands > Maritime wetlands > Salines',
          },
          {
            value: 423,
            color: 'A6A6E6',
            description: 'Wetlands > Maritime wetlands > Intertidal flats',
          },
          {
            value: 511,
            color: '00CCF2',
            description: 'Water bodies > Inland waters > Water courses',
          },
          {
            value: 512,
            color: '80F2E6',
            description: 'Water bodies > Inland waters > Water bodies',
          },
          {
            value: 521,
            color: '00FFA6',
            description: 'Water bodies > Marine waters > Coastal lagoons',
          },
          {
            value: 522,
            color: 'A6FFE6',
            description: 'Water bodies > Marine waters > Estuaries',
          },
          {
            value: 523,
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
              111.0,
            ],
            max: [
              523.0,
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
    [https://land.copernicus.eu/pan-european/corine-land-cover/clc2018?tab=metadata](https://land.copernicus.eu/pan-european/corine-land-cover/clc2018?tab=metadata).
  |||,
}
