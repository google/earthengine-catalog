local id = 'ESA/GLOBCOVER_L4_200901_200912_V2_3';
local subdir = 'ESA';

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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'GlobCover: Global Land Cover Map',
  version: 'V2.3',
  'gee:type': ee_const.gee_type.image,
  description: |||
    GlobCover 2009 is a global land cover map based on ENVISAT's Medium
    Resolution Imaging Spectrometer (MERIS) Level 1B data acquired in full
    resolution mode with a spatial resolution of approximately 300 meters.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['landuse-landcover'],
  keywords: [
    'esa',
    'globcover',
    'landcover',
  ],
  providers: [
    ee.producer_provider('ESA', 'http://dup.esrin.esa.int/page_globcover.php'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2009-01-01T00:00:00Z', '2010-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      300.0,
    ],
    'eo:bands': [
      {
        name: 'landcover',
        description: |||
          The land cover map is derived by an automatic and
          regionally-tuned classification of a time series of global MERIS FR
          mosaics for the year 2009. The global land cover map counts 22 land cover
          classes defined with the United Nations (UN) Land Cover Classification
          System (LCCS).
        |||,
        'gee:classes': [
          {
            value: 11,
            color: 'aaefef',
            description: 'Post-flooding or irrigated croplands',
          },
          {
            value: 14,
            color: 'ffff63',
            description: 'Rainfed croplands',
          },
          {
            value: 20,
            color: 'dcef63',
            description: 'Mosaic cropland (50-70%) / vegetation (grassland, shrubland, forest) (20-50%)',
          },
          {
            value: 30,
            color: 'cdcd64',
            description: 'Mosaic vegetation (grassland, shrubland, forest) (50-70%) / cropland (20-50%)',
          },
          {
            value: 40,
            color: '006300',
            description: 'Closed to open (>15%) broadleaved evergreen and/or semi-deciduous forest (>5m)',
          },
          {
            value: 50,
            color: '009f00',
            description: 'Closed (>40%) broadleaved deciduous forest (>5m)',
          },
          {
            value: 60,
            color: 'aac700',
            description: 'Open (15-40%) broadleaved deciduous forest (>5m)',
          },
          {
            value: 70,
            color: '003b00',
            description: 'Closed (>40%) needleleaved evergreen forest (>5m)',
          },
          {
            value: 90,
            color: '286300',
            description: 'Open (15-40%) needleleaved deciduous or evergreen forest (>5m)',
          },
          {
            value: 100,
            color: '788300',
            description: 'Closed to open (>15%) mixed broadleaved and needleleaved forest (>5m)',
          },
          {
            value: 110,
            color: '8d9f00',
            description: 'Mosaic forest-shrubland (50-70%) / grassland (20-50%)',
          },
          {
            value: 120,
            color: 'bd9500',
            description: 'Mosaic grassland (50-70%) / forest-shrubland (20-50%)',
          },
          {
            value: 130,
            color: '956300',
            description: 'Closed to open (>15%) shrubland (<5m)',
          },
          {
            value: 140,
            color: 'ffb431',
            description: 'Closed to open (>15%) grassland',
          },
          {
            value: 150,
            color: 'ffebae',
            description: 'Sparse (>15%) vegetation (woody vegetation, shrubs, grassland)',
          },
          {
            value: 160,
            color: '00785a',
            description: 'Closed (>40%) broadleaved forest regularly flooded - Fresh water',
          },
          {
            value: 170,
            color: '009578',
            description: 'Closed (>40%) broadleaved semi-deciduous and/or evergreen forest regularly flooded - saline water',
          },
          {
            value: 180,
            color: '00dc83',
            description: |||
              Closed to open (>15%) vegetation (grassland, shrubland, woody vegetation) on regularly flooded or waterlogged soil - fresh, brackish or saline water
            |||,
          },
          {
            value: 190,
            color: 'c31300',
            description: 'Artificial surfaces and associated areas (urban areas >50%) GLOBCOVER 2009',
          },
          {
            value: 200,
            color: 'fff5d6',
            description: 'Bare areas',
          },
          {
            value: 210,
            color: '0046c7',
            description: 'Water bodies',
          },
          {
            value: 220,
            color: 'ffffff',
            description: 'Permanent snow and ice',
          },
          {
            value: 230,
            color: '743411',
            description: 'Unclassified',
          },
        ],
      },
      {
        name: 'qa',
        description: |||
          Binary quality band indicating whether the reference dataset has been used instead of the output of the GlobCover classification scheme.
        |||,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Information on dataset used for classification',
              bit_count: 1,
              values: [
                {
                  description: 'Areas classified using the output of the GlobCover classification scheme.',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Areas classified using the reference dataset.',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Landcover',
        lookat: {
          lat: 26.4,
          lon: -88.6,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              11.0,
            ],
            max: [
              230.0,
            ],
            palette: [
              'aaefef',
              'ffff63',
              'dcef63',
              'cdcd64',
              '006300',
              '009f00',
              'aac700',
              '003b00',
              '286300',
              '788300',
              '8d9f00',
              'bd9500',
              '956300',
              'ffb431',
              'ffebae',
              '00785a',
              '009578',
              '00dc83',
              'c31300',
              'fff5d6',
              '0046c7',
              'ffffff',
              '743411',
            ],
            bands: [
              'landcover',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': 'ESA 2010 and UCLouvain. [http://due.esrin.esa.int/page_globcover.php](http://due.esrin.esa.int/page_globcover.php)',
  'gee:terms_of_use': |||
    The GlobCover products have been processed by ESA and by the Université
    Catholique de Louvain. They are made available to the public by ESA.
    You may use the GlobCover land cover map for educational and/or scientific
    purposes, without any fee on the condition that you credit ESA and the
    Université Catholique de Louvain as the source of the GlobCover products.
  |||,
  'gee:unusual_terms_of_use': true,
}
