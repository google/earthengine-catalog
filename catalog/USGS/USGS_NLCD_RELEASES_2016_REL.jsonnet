local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local nlcd = import 'nlcd.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local id = nlcd.id(2016);
local versions = import 'versions.libsonnet';
local version_table = import 'templates/NLCD_versions.libsonnet';

local subdir = 'USGS';

local license = spdx.cc0_1_0;
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'NLCD 2016: USGS National Land Cover Database, 2016 release [deprecated]',
  'gee:status': 'deprecated',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset is partially superseded by newer datasets:

    * Landcover and imperviousness data in
      [USGS/NLCD_RELEASES/2019_REL/NLCD](USGS_NLCD_RELEASES_2019_REL_NLCD).
    * Rangeland data in
      [USGS/NLCD_RELEASES/2019_REL/RCMAP/V4/COVER](USGS_NLCD_RELEASES_2019_REL_RCMAP_V4_COVER).

    NLCD (the National Land Cover Database) is a 30-m Landsat-based land cover
    database spanning 8 epochs (1992, 2001, 2004, 2006, 2008, 2011, 2013 and 2016).
    1992 data are primarily based on unsupervised classification of Landsat data,
    while the rest of the images rely on the imperviousness data layer for the
    urban classes and on a decision-tree classification for the rest. The 1992
    image is not directly comparable to any later editions of NLCD.

    This dataset has one image for the continental US for each of the
    eight epochs, plus separate images for Alaska, Hawaii, and Puerto Rico in 2001, 2011, and 2016.
    (They could not be merged in due to having a different projection from the continental US
    images.)

    Note that the impervious layers and tree cover layers for Alaska 2011
    only have data for parts of Alaska.  For the impervious layer, only the
    parts of Kenai Peninsula Borough and Anchorage Municipality are available.
    Tree cover is only available on a strip along the coast from the southern
    tip of the Alaskan Panhandle up through the Kenai Peninsula, plus Kodiak
    Island.

    NLCD 2016 Rangeland Component products characterize the percentage of each
    30-meter pixel in the Western United States covered by shrub, herbaceous,
    bare ground, litter, sagebrush, big sagebrush and annual herbaceous, along
    with estimating shrub height and sagebrush height. These products have
    been produced by USGS in collaboration with the Bureau of Land Management.

    NLCD products are created by the Multi-Resolution Land Characteristics
    (MRLC) Consortium, a partnership of federal agencies led by the
    U.S. Geological Survey.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'blm',
    'landcover',
    'mrlc',
    'nlcd',
    'rangeland',
    'shrub',
    'shrubland',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://www.mrlc.gov'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent(-130.24, 21.75, -63.66, 57.68,
                    '1992-01-01T00:00:00Z', '2017-01-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'landcover_class_names',
        description: 'Landcover class names',
        type: ee_const.var_type.double,
      },
      {
        name: 'landcover_class_palette',
        description: 'Landcover class palette',
        type: ee_const.var_type.double,
      },
      {
        name: 'landcover_class_values',
        description: 'Landcover class values',
        type: ee_const.var_type.double,
      },
      {
        name: 'impervious_descriptor_class_names',
        description: 'Impervious descriptor class names',
        type: ee_const.var_type.double,
      },
      {
        name: 'impervious_descriptor_class_palette',
        description: 'Impervious descriptor class palette',
        type: ee_const.var_type.double,
      },
      {
        name: 'impervious_descriptor_class_values',
        description: 'Impervious descriptor class values',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'landcover',
        description: |||
          All images except 2011_HI, 2011_PR, 2016_HI, and 2016_PR include the landcover classification scheme described in the [2016 Product Legend](https://www.mrlc.gov/data/legends/national-land-cover-database-2016-nlcd2016-legend). The legends are also available as metadata on each image. The classes in the 2016 product legend are given below.
        |||,
        'gee:classes': [
          {
            value: 11,
            color: '466b9f',
            description: 'Open water: areas of open water, generally with less than 25% cover of vegetation or soil.',
          },
          {
            value: 12,
            color: 'd1def8',
            description: |||
              Perennial ice/snow: areas characterized by a perennial cover of ice and/or snow, generally greater than 25% of total cover.
            |||,
          },
          {
            value: 21,
            color: 'dec5c5',
            description: |||
              Developed, open space: areas with a mixture of some constructed materials, but mostly vegetation in the form of lawn grasses. Impervious surfaces account for less than 20% of total cover. These areas most commonly include large-lot single-family housing units, parks, golf courses, and vegetation planted in developed settings for recreation, erosion control, or aesthetic purposes.
            |||,
          },
          {
            value: 22,
            color: 'd99282',
            description: |||
              Developed, low intensity: areas with a mixture of constructed materials and vegetation. Impervious surfaces account for 20% to 49% percent of total cover. These areas most commonly include single-family housing units.
            |||,
          },
          {
            value: 23,
            color: 'eb0000',
            description: |||
              Developed, medium intensity: areas with a mixture of constructed materials and vegetation. Impervious surfaces account for 50% to 79% of the total cover. These areas most commonly include single-family housing units.
            |||,
          },
          {
            value: 24,
            color: 'ab0000',
            description: |||
              Developed high intensity: highly developed areas where people reside or work in high numbers. Examples include apartment complexes, row houses, and commercial/industrial. Impervious surfaces account for 80% to 100% of the total cover.
            |||,
          },
          {
            value: 31,
            color: 'b3ac9f',
            description: |||
              Barren land (rock/sand/clay): areas of bedrock, desert pavement, scarps, talus, slides, volcanic material, glacial debris, sand dunes, strip mines, gravel pits, and other accumulations of earthen material. Generally, vegetation accounts for less than 15% of total cover.
            |||,
          },
          {
            value: 41,
            color: '68ab5f',
            description: |||
              Deciduous forest: areas dominated by trees generally greater than 5 meters tall, and greater than 20% of total vegetation cover. More than 75% of the tree species shed foliage simultaneously in response to seasonal change.
            |||,
          },
          {
            value: 42,
            color: '1c5f2c',
            description: |||
              Evergreen forest: areas dominated by trees generally greater than 5 meters tall, and greater than 20% of total vegetation cover. More than 75% of the tree species maintain their leaves all year. Canopy is never without green foliage.
            |||,
          },
          {
            value: 43,
            color: 'b5c58f',
            description: |||
              Mixed forest: areas dominated by trees generally greater than 5 meters tall, and greater than 20% of total vegetation cover. Neither deciduous nor evergreen species are greater than 75% of total tree cover.
            |||,
          },
          {
            value: 51,
            color: 'af963c',
            description: |||
              Dwarf scrub: Alaska only areas dominated by shrubs less than 20 centimeters tall with shrub canopy typically greater than 20% of total vegetation. This type is often co-associated with grasses, sedges, herbs, and non-vascular vegetation.
            |||,
          },
          {
            value: 52,
            color: 'ccb879',
            description: |||
              Shrub/scrub: areas dominated by shrubs less than 5 meters tall with shrub canopy typically greater than 20% of total vegetation. This class includes true shrubs, young trees in an early successional stage, or trees stunted from environmental conditions.
            |||,
          },
          {
            value: 71,
            color: 'dfdfc2',
            description: |||
              Grassland/herbaceous: areas dominated by gramanoid or herbaceous vegetation, generally greater than 80% of total vegetation. These areas are not subject to intensive management such as tilling, but can be utilized for grazing.
            |||,
          },
          {
            value: 72,
            color: 'd1d182',
            description: |||
              Sedge/herbaceous: Alaska only areas dominated by sedges and forbs, generally greater than 80% of total vegetation. This type can occur with significant other grasses or other grass like plants, and includes sedge tundra and sedge tussock tundra.
            |||,
          },
          {
            value: 73,
            color: 'a3cc51',
            description: |||
              Lichens: Alaska only areas dominated by fruticose or foliose lichens generally greater than 80% of total vegetation.
            |||,
          },
          {
            value: 74,
            color: '82ba9e',
            description: 'Moss: Alaska only areas dominated by mosses, generally greater than 80% of total vegetation.',
          },
          {
            value: 81,
            color: 'dcd939',
            description: |||
              Pasture/hay: areas of grasses, legumes, or grass-legume mixtures planted for livestock grazing or the production of seed or hay crops, typically on a perennial cycle. Pasture/hay vegetation accounts for greater than 20% of total vegetation.
            |||,
          },
          {
            value: 82,
            color: 'ab6c28',
            description: |||
              Cultivated crops: areas used for the production of annual crops, such as corn, soybeans, vegetables, tobacco, and cotton, and also perennial woody crops such as orchards and vineyards. Crop vegetation accounts for greater than 20% of total vegetation. This class also includes all land being actively tilled.
            |||,
          },
          {
            value: 90,
            color: 'b8d9eb',
            description: |||
              Woody wetlands: areas where forest or shrubland vegetation accounts for greater than 20% of vegetative cover and the soil or substrate is periodically saturated with or covered with water.
            |||,
          },
          {
            value: 95,
            color: '6c9fb8',
            description: |||
              Emergent herbaceous wetlands: areas where perennial herbaceous vegetation accounts for greater than 80% of vegetative cover and the soil or substrate is periodically saturated with or covered with water.
            |||,
          },
        ],
      },
      {
        name: 'impervious',
        description: |||
          Percent of the pixel covered by developed impervious surface. Included in images 2001, 2001_AK, 2001_HI, 2001_PR, 2006, 2011, 2011_AK, 2016, and 2016_AK.
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'impervious_descriptor',
        description: |||
          Defines which impervious layer pixels are roads and provides the best fit description for impervious pixels that are not roads. Included in images 2001, 2001_AK, 2006, 2011, 2016, and 2016_AK.
        |||,
        'gee:classes': [
          {
            value: 1,
            color: 'ff0000',
            description: 'Primary road in urban area : interstates and other major roads.',
          },
          {
            value: 2,
            color: 'a20000',
            description: 'Primary road outside urban area : interstates and other major roads.',
          },
          {
            value: 3,
            color: 'ffff00',
            description: 'Secondary road in urban area : non-interstate highways.',
          },
          {
            value: 4,
            color: 'ffd400',
            description: 'Secondary road outside urban area : non-interstate highways.',
          },
          {
            value: 5,
            color: '0000ff',
            description: 'Tertiary road in urban area : any two-lane road.',
          },
          {
            value: 6,
            color: '009ee0',
            description: 'Tertiary road outside urban area : any two-lane road.',
          },
          {
            value: 7,
            color: 'ffffff',
            description: |||
              Thinned road in urban area : small tertiary roads that generally are not paved and have been removed from the landcover but remain as part of the impervious surface product.  These roads have been separated in the western United States so that a better categorization of developed features is represented in the landcover.
            |||,
          },
          {
            value: 8,
            color: 'ffffff',
            description: |||
              Thinned road outside urban area : small tertiary roads that generally are not paved and have been removed from the landcover but remain as part of the impervious surface product.  These roads have been separated in the western United States so that a better categorization of developed features is represented in the landcover.
            |||,
          },
          {
            value: 9,
            color: 'ffc0c8',
            description: 'Nonroad impervious surface in urban area.',
          },
          {
            value: 10,
            color: 'ec82ec',
            description: 'Nonroad impervious surface outside urban area.',
          },
          {
            value: 11,
            color: '006100',
            description: |||
              Energy production site in urban area : areas identified from the FrackTracker points and classified in coordination with the Landfire project.
            |||,
          },
          {
            value: 12,
            color: '00ff00',
            description: |||
              Energy production site outside urban area : areas identified from the FrackTracker points and classified in coordination with the Landfire project.
            |||,
          },
        ],
      },
      {
        name: 'urban_descriptor',
        description: |||
          The developed urban descriptor (Alaska) represents delineation of the layers that were combined to create develop features where an impervious estimate was not able to be initialized. This additional layer gives description that is identical to the impervious descriptor. Included in images 2001_AK, 2011_AK, and 2016_AK.
        |||,
        'gee:classes': [
          {
            value: 1,
            color: 'ff0000',
            description: 'Primary road in urban area : interstates and other major roads.',
          },
          {
            value: 2,
            color: 'a20000',
            description: 'Primary road outside urban area : interstates and other major roads.',
          },
          {
            value: 3,
            color: 'ffff00',
            description: 'Secondary road in urban area : non-interstate highways.',
          },
          {
            value: 4,
            color: 'ffd400',
            description: 'Secondary road outside urban area : non-interstate highways.',
          },
          {
            value: 5,
            color: '0000ff',
            description: 'Tertiary road in urban area : any two-lane road.',
          },
          {
            value: 6,
            color: '009ee0',
            description: 'Tertiary road outside urban area : any two-lane road.',
          },
          {
            value: 7,
            color: 'ffffff',
            description: |||
              Thinned road in urban area : small tertiary roads that generally are not paved and have been removed from the landcover but remain as part of the impervious surface product.  These roads have been separated in the western United States so that a better categorization of developed features is represented in the landcover.
            |||,
          },
          {
            value: 8,
            color: 'ffffff',
            description: |||
              Thinned road outside urban area : small tertiary roads that generally are not paved and have been removed from the landcover but remain as part of the impervious surface product.  These roads have been separated in the western United States so that a better categorization of developed features is represented in the landcover.
            |||,
          },
          {
            value: 9,
            color: 'ffc0c8',
            description: 'Nonroad impervious surface in urban area.',
          },
          {
            value: 10,
            color: 'ec82ec',
            description: 'Nonroad impervious surface outside urban area.',
          },
          {
            value: 11,
            color: '006100',
            description: |||
              Energy production site in urban area : areas identified from the FrackTracker points and classified in coordination with the Landfire project.
            |||,
          },
          {
            value: 12,
            color: '00ff00',
            description: |||
              Energy production site outside urban area : areas identified from the FrackTracker points and classified in coordination with the Landfire project.
            |||,
          },
        ],
      },
      {
        name: 'percent_tree_cover',
        description: |||
          Percent of the pixel that's covered by tree canopy. No masking of obvious non-tree areas is performed for this product. Included in images 2011, 2011_AK, 2011_HI, 2011_PR, 2016, 2016_AK, 2016_HI, and 2016_PR.
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_annual_herbaceous',
        description: 'The annual only grass and forb proportion in each in 30m pixel. Included in 2016.',
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_bare_ground',
        description: 'The bare ground proportion in each 30m pixel. Included in 2016.',
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_big_sagebrush',
        description: 'The proportion of big sagebrush canopy in each 30m pixel. Included in 2016.',
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_herbaceous',
        description: 'The annual and perennial grass and forb proportion in each 30m pixel. Included in 2016.',
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_litter',
        description: 'The dead plant material proportion in each 30m pixel. Included in 2016.',
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_sagebrush',
        description: 'The proportion of sagebrush canopy in each 30m pixel. Included in 2016.',
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_sagebrush_height',
        description: 'Average height of sagebrush. Included in 2016.',
        'gee:units': units.centimeter,
      },
      {
        name: 'rangeland_shrub',
        description: 'The proportion of shrub canopy in each 30m pixel. Included in 2016.',
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_shrub_height',
        description: 'Average height of shrubs. Included in 2016.',
        'gee:units': units.centimeter,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Landcover',
        lookat: {
          lat: 38.686,
          lon: -115.356,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              95.0,
            ],
            palette: [
              '466b9f',
              'd1def8',
              'dec5c5',
              'd99282',
              'eb0000',
              'ab0000',
              'b3ac9f',
              '68ab5f',
              '1c5f2c',
              'b5c58f',
              'af963c',
              'ccb879',
              'dfdfc2',
              'd1d182',
              'a3cc51',
              '82ba9e',
              'dcd939',
              'ab6c28',
              'b8d9eb',
              '6c9fb8',
            ],
            bands: [
              'landcover',
            ],
          },
        },
      },
    ],
    landcover: {
      minimum: 0.0,
      maximum: 95.0,
      'gee:estimated_range': false,
    },
    impervious: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    percent_tree_cover: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    rangeland_annual_herbaceous: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    rangeland_bare_ground: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    rangeland_big_sagebrush: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    rangeland_herbaceous: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    rangeland_litter: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    rangeland_sagebrush: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    rangeland_sagebrush_height: {
      minimum: 0.0,
      maximum: 997.0,
      'gee:estimated_range': false,
    },
    rangeland_shrub: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    rangeland_shrub_height: {
      minimum: 0.0,
      maximum: 997.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Yang, L., Jin, S., Danielson, P., Homer, C., Gass, L., Case, A.,
    Costello, C., Dewitz, J., Fry, J., Funk, M., Grannemann, B., Rigge,
    M. and G. Xian. 2018,
    [A New Generation of the United States National Land Cover Database: Requirements, Research Priorities, Design, and Implementation Strategies](https://www.sciencedirect.com/science/article/abs/pii/S092427161830251X),
    p. 108-123.
  |||,
  'gee:terms_of_use': |||
    Most U.S. Geological Survey (USGS) information resides
    in the public domain and may be used without restriction. Additional
    information on [Acknowledging or Crediting USGS as Information
    Source](https://www.usgs.gov/information-policies-and-instructions/crediting-usgs) is available.
  |||,
}
