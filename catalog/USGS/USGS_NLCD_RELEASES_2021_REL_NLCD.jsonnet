local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local nlcd = import 'nlcd.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local id = nlcd.id(2021);
local subdir = 'USGS';

local license = spdx.cc0_1_0;

local self_ee_catalog_url = nlcd.provider_url(id);

{
  id: id,
  title: 'NLCD 2021: USGS National Land Cover Database, 2021 release',
  version: '1.0',
  description: |||
    The U.S. Geological Survey (USGS), in partnership with several federal
    agencies, has now developed and released seven National Land Cover
    Database (NLCD) products: NLCD 1992, 2001, 2006, 2011, 2016, 2019,
    and 2021. Beginning with the 2016 release, land cover products were
    created for two-to-three-year intervals between 2001 and the most
    recent year. These products provide spatially explicit and reliable
    information on the Nation’s land cover and land cover change.
    NLCD continues to provide innovative, consistent, and robust
    methodologies for production of a multi-temporal land cover and
    land cover change database.
    
    The NLCD 2021 release is update based, so the Land Cover and Impervious
    Surface products released in [2019](USGS_NLCD_RELEASES_2019_REL_NLCD)
    are unchanged and used directly with NLCD 2021 for change analysis
    though the NLCD timespan. Science products and the change index are
    updated and will need to be reacquired to contain the additional 2021
    change. These new products use a streamlined compositing process for
    assembling and preprocessing Landsat imagery and geospatial ancillary
    datasets; a temporally, spectrally, and spatially integrated land cover
    change analysis strategy; a theme-based post-classification protocol for
    generating land cover and change products; a continuous fields
    biophysical parameters modeling method; and a scripted operational system.
    The overall accuracy of the 2019 Level I land cover was 91%. Results from
    this study confirm the robustness of this comprehensive and highly
    automated procedure for NLCD 2021 operational mapping
    (see [doi:10.1080/15481603](https://doi.org/10.1080/15481603.2023.2181143)
    for the latest accuracy assessment publication). Questions about the NLCD
    2021 land cover product can be directed to the NLCD 2021 land cover
    mapping team at USGS EROS, Sioux Falls, SD (605) 594-6151 or
    mrlc@usgs.gov. See included spatial metadata for more details.
    
    Please see National Land Cover Database (NLCD) [2019 NLCD release](https://doi.org/10.5066/P9KZCM54)
    for the 2019 release of NLCD which is used with the 2021 release for
    comparisons through the years. Also refer to the larger NLCD Community
    page for all things NLCD related National Land Cover Database (NLCD)
    [NLCD Community Page](https://www.sciencebase.gov/catalog/item/6345b637d34e342aee0863aa).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'blm',
    'landcover',
    'mrlc',
    'nlcd',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://www.mrlc.gov'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-130.24, 21.75, -63.66, 50,
                    '2021-01-01T00:00:00Z', '2022-01-01T00:00:00Z'),
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
    gsd: [30.0,],
    'eo:bands': [
      {
        name: 'landcover',
        description: |||
          All images include the landcover classification scheme described in
          the [Product Legend](https://www.mrlc.gov/data/legends/national-land-cover-database-class-legend-and-description).
          The legends are also available as metadata on each image. The classes
          in the product legend are given below.
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
          Percent of the pixel covered by developed impervious surface.
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'impervious_descriptor',
        description: |||
          Defines which impervious layer pixels are roads and provides the best fit description for impervious pixels that are not roads.
        |||,
        'gee:classes': [
          {
            value: 0,
            color: '000000',
            description: 'Unclassified.'
          },
          {
            value: 20,
            color: 'ff0000',
            description: |||
              Primary road. Interstates and other major roads. Pixels were
              derived from the 2018 NavStreets Street Data.
            |||,
          },
          {
            value: 21,
            color: 'ffff00',
            description: |||
              Secondary road. Non-interstate highways. Pixels were derived
               from the 2018 NavStreets Street Data.
            |||,
          },
          {
            value: 22,
            color: '0000ff',
            description: |||
              Tertiary road. Any two-lane road. Pixels were derived from the
              2018 NavStreets Street Data.
            |||,
          },
          {
            value: 23,
            color: 'ffffff',
            description: |||
              Thinned road. Small tertiary roads that generally are not paved
              and have been removed from the landcover but remain as part of
              the impervious surface product. Pixels were derived from the 2018
              NavStreets Street Data.
            |||,
          },
          {
            value: 24,
            color: 'ffc0c5',
            description: |||
              Non-road non-energy impervious. Developed areas that are
              generally not roads or energy production; includes
              residential/commercial/industrial areas, parks, and golf courses.
            |||,
          },
          {
            value: 25,
            color: 'eb82eb',
            description: |||
              Microsoft buildings. Buildings not captured in the NLCD
              impervious process, and not included in the nonroad impervious
              surface class. Pixels derived from the Microsoft US Building
              Footprints dataset.
            |||,
          },
          {
            value: 26,
            color: '9f1feb',
            description: |||
              LCMAP impervious. Impervious pixels from LCMAP that were used
              to fill in gaps left when roads were updated from previous
              versions of NLCD.
            |||,
          },
          {
            value: 27,
            color: '40dfd0',
            description: |||
              Wind turbines. Pixels derived from the US Wind Turbine Dataset,
              accessed on 1/9/2020.
            |||,
          },
          {
            value: 28,
            color: '79ff00',
            description: |||
              Well pads. Pixels derived from the 2019 Oil and Natural Gas Wells
              dataset from the Oak Ridge National Laboratory.
            |||,
          },
          {
            value: 29,
            color: '005f00',
            description: |||
              Other energy production. Areas previously identified as well pads
              and wind turbines and classified in coordination with the
              Landfire project.
            |||,
          },
        ],
      },
      {
        name: 'science_products_land_cover_change_count',
        description: |||
          These products were developed as both intermediate steps to generate
          the base NLCD products, and as value added products that standalone
          to provide additional insights. This product was derived using the
          9-epoch NLCD land cover (2001, 2003, 2006, 2008, 2011, 2013, 2016,
          2019, and 2021) from the released NLCD 2021 product suite. Any
          change between two consecutive epochs is calculated and the total
          change frequency/time for each pixel is recorded. This product
          shows an integer count total of any recorded change for the time
          period 2001-2021. This product is meant to be used with the change
          index and individual dates of Land Cover to provide users with a
          more in depth look at where multiple change events in the same
          location are occurring on the landscape. All images include the
          Science Products classification scheme follow the Land Cover system
          and are described in the
          [Product Legend](https://www.mrlc.gov/data/legends/national-land-cover-database-class-legend-and-description).
          The legends are also available as metadata on each image. The classes
          in the product legend are given below.
        |||,
        'gee:classes': [
          {
            value: 1,
            color: '0000ff',
            description: 'change once 2001-2019',
          },
          {
            value: 2,
            color: '00d0ff',
            description: 'change twice 2001-2019',
          },
          {
            value: 3,
            color: '00fffa',
            description: 'change three times 2001-2019',
          },
          {
            value: 4,
            color: '00ff7d',
            description: 'change four times 2001-2019',
          },
          {
            value: 5,
            color: '79ff00',
            description: 'change five times 2001-2019',
          },
          {
            value: 6,
            color: 'ffff00',
            description: 'change six times 2001-2019',
          },
          {
            value: 7,
            color: 'ffd000',
            description: 'change seven times 2001-2019',
          },
          {
            value: 8,
            color: 'ff0000',
            description: 'change eight times 2001-2021',
          },
         ],
      },
      {
        name: 'science_products_land_cover_change_first_disturbance_date',
        description: |||
          These products were developed as both intermediate steps to generate
          the base NLCD products, and as value added products that standalone
          to provide additional insights. This product was derived using the
          nine release dates of NLCD land cover (2001, 2003, 2006, 2008, 2011,
          2013, 2016, 2019, 2021). This product shows the date of the first
          land cover change event from these 9 dates of landcover. All images
          include the Science Products classification scheme follow the
          Land Cover system and are described in the
          [Product Legend](https://www.mrlc.gov/data/legends/national-land-cover-database-class-legend-and-description).
          The legends are also available as metadata on each image. The classes
          in the product legend are given below.
        |||,
        'gee:classes': [
          {
            value: 1,
            color: '005f00',
            description: 'land cover no change',
          },
          {
            value: 2,
            color: '0000ff',
            description: 'land cover change 2001-2004',
          },
          {
            value: 3,
            color: '00d0ff',
            description: 'land cover change 2004-2006',
          },
          {
            value: 4,
            color: '00fffa',
            description: 'land cover change 2006-2008',
          },
          {
            value: 5,
            color: '00ff7d',
            description: 'land cover change 2008-2011',
          },
          {
            value: 6,
            color: '79ff00',
            description: 'land cover change 2011-2013',
          },
          {
            value: 7,
            color: 'ffff00',
            description: 'land cover change 2013-2016',
          },
          {
            value: 8,
            color: 'ffd000',
            description: 'land cover change 2016-2019',
          },
          {
            value: 9,
            color: 'ff0000',
            description: 'land cover change 2019-2021',
          },
         ],
      },
      {
        name: 'science_products_land_cover_change_index',
        description: |||
          These products were developed as both intermediate steps to generate
          the base NLCD products, and as value added products that standalone
          to provide additional insights. The NLCD Land Cover change index
          combines information from all years of land cover change and
          provides a simple and comprehensive way to visualize change from all
          9 dates of land cover in a single layer. The change index was
          designed to assist NLCD users to understand complex land cover
          change with a single product. NLCD 2021 does not yet contain updated
          products for Alaska, Hawaii and Puerto Rico. All images include the
          Science Products classification scheme follow the Land Cover system
          and are described in the
          [Product Legend](https://www.mrlc.gov/data/legends/national-land-cover-database-class-legend-and-description).
          The legends are also available as metadata on each image. The classes
          in the product legend are given below.
        |||,
        'gee:classes': [
          {
            value: 1,
            color: '005f00',
            description: 'no change',
          },
          {
            value: 2,
            color: '0000ff',
            description: 'water change',
          },
          {
            value: 3,
            color: 'eb82eb',
            description: 'urban change',
          },
          {
            value: 4,
            color: '79ffd2',
            description: 'wetland within class change',
          },
          {
            value: 5,
            color: '009ede',
            description: 'herbaceous wetland change',
          },
          {
            value: 6,
            color: 'ffd000',
            description: 'agriculture within class change',
          },
          {
            value: 7,
            color: '9f2828',
            description: 'cultivated crop change',
          },
          {
            value: 8,
            color: 'ffff00',
            description: 'hay/pasture change',
          },
          {
            value: 9,
            color: 'dfdfc2',
            description: 'rangeland herbaceous and shrub change',
          },
          {
            value: 10,
            color: 'b3ac9f',
            description: 'barren change',
          },
          {
            value: 11,
            color: '79ff00',
            description: 'forest change',
          },
          {
            value: 12,
            color: 'ff0000',
            description: 'woody wetland change',
          },
          {
            value: 13,
            color: 'ffffff',
            description: 'snow change',
          },
        ],
      },
      {
        name: 'science_products_land_cover_science_product',
        description: |||
          These products were developed as both intermediate steps to generate
          the base NLCD products, and as value added products that standalone
          to provide additional insights. To better develop NLCD 2021
          landcover, spectrally stable grass and shrub areas were separated
          from the spectrally changing areas of shrub and grass represented by
          forest harvest, burns, regrowth, and other disturbances.
          Essentially, this separation usually identifies shrub and grass
          climax areas from shrub and grass areas in transition back to a
          forest. This difference is expressed with two extra classes of
          land cover, called Shrub-Forest and Herbaceous-Forest which are
          representing areas of current shrub and grass expected to transition
          back to a forest. Alternatively, the shrub and grass classes of
          Shrub/Scrub and Grassland/Herbaceous will likely not transition to
          a forest. However, be cautioned that no extensive ecological
          analysis went into these class delineations, they are primarily
          spectral based separations used to delineate broad classes of grass
          and shrub. All images include the Science Products classification
          scheme follow the Land Cover system and are described in the
          [Product Legend](https://www.mrlc.gov/data/legends/national-land-cover-database-class-legend-and-description).
          The legends are also available as metadata on each image. The classes
          in the product legend are given below.
        |||,
        'gee:classes': [
          {
            value: 11,
            color: '466b9f',
            description: 'Open Water',
          },
          {
            value: 12,
            color: 'd1def8',
            description: 'Perennial Snow/Ice',
          },
          {
            value: 21,
            color: 'dec5c5',
            description: 'Developed, Open Space',
          },
          {
            value: 22,
            color: 'd99282',
            description: 'Developed, Low Intensity',
          },
          {
            value: 23,
            color: 'eb0000',
            description: 'Developed, Medium Intensity',
          },
          {
            value: 24,
            color: 'ab0000',
            description: 'Developed, High Intensity',
          },
          {
            value: 31,
            color: 'b3ac9f',
            description: 'Barren Land',
          },
          {
            value: 41,
            color: '68ab5f',
            description: 'Deciduous Forest',
          },
          {
            value: 42,
            color: '1c5f2c',
            description: 'Evergreen Forest',
          },
          {
            value: 43,
            color: 'b5c58f',
            description: 'Mixed Forest',
          },
          {
            value: 45,
            color: '79ffd2',
            description: 'Shrub-Forest',
          },
          {
            value: 46,
            color: '9f1feb',
            description: 'Herbaceous-Forest',
          },
          {
            value: 52,
            color: 'ccb879',
            description: 'Shrub/Scrub',
          },
          {
            value: 71,
            color: 'dfdfc2',
            description: 'Herbaceous',
          },
          {
            value: 81,
            color: 'dcd939',
            description: 'Hay/Pasture',
          },
          {
            value: 82,
            color: 'ab6c28',
            description: 'Cultivated Crops',
          },
          {
            value: 90,
            color: 'b8d9eb',
            description: 'Woody Wetlands',
          },
          {
            value: 95,
            color: '6c9fb8',
            description: 'Emergent Herbaceous Wetlands',
          },
        ],
      },
      {
        name: 'science_products_forest_disturbance_date',
        description: |||
          These products were developed as both intermediate steps to generate
          the base NLCD products, and as value added products that standalone
          to provide additional insights. This product shows the most recent
          forest disturbance date between the years 1986-2021 for every year.
          This product combines information from the NLCD 2021 change
          detection, land cover classification, and the LANDFIRE Vegetation
          Change Tracker (VCT) disturbance product from 1984-2010. For NLCD
          2021, this product was used to assess where disturbance occurred for
          forest areas. This product was originally intended only for forest
          areas, but it also can be useful for other landcover classes.
          For example, agricultural areas, which are typically disturbed
          yearly by tillage, are represented as being disturbed prior to 1986.
          This "prior to 86" disturbance call was used in some instances as a
          delineation between forested and non-forest areas. Other classes
          that are not forest may also be represented with a disturbance
          indication if the area was forest at some time point during
          1986-2021. All images include the Science Products classification
          scheme follow the Land Cover system and are described in the
          [Product Legend](https://www.mrlc.gov/data/legends/national-land-cover-database-class-legend-and-description).
          The legends are also available as metadata on each image. The classes
          in the product legend are given below.
        |||,
        'gee:classes': [
          {
            value: 83,
            color: '0000ff',
            description: 'non-forest or forest before 1983',
          },
          {
            value: 84,
            color: '0033ff',
            description: 'forest disturbed before/at 1984',
          },
          {
            value: 85,
            color: '005fff',
            description: 'forest disturbed before/at 1985',
          },
          {
            value: 86,
            color: '0087ff',
            description: 'forest disturbed before/at 1986',
          },
          {
            value: 87,
            color: '00aaff',
            description: 'forest disturbed before/at 1987',
          },
          {
            value: 88,
            color: '00c5ff',
            description: 'forest disturbed before/at 1988',
          },
          {
            value: 89,
            color: '00dcff',
            description: 'forest disturbed before/at 1989',
          },
          {
            value: 90,
            color: '00ecff',
            description: 'forest disturbed before/at 1990',
          },
          {
            value: 91,
            color: '00f8ff',
            description: 'forest disturbed before/at 1991',
          },
          {
            value: 92,
            color: '00fdff',
            description: 'forest disturbed before/at 1992',
          },
          {
            value: 93,
            color: '00fffd',
            description: 'forest disturbed before/at 1993',
          },
          {
            value: 94,
            color: '00fff8',
            description: 'forest disturbed before/at 1994',
          },
          {
            value: 95,
            color: '00ffec',
            description: 'forest disturbed before/at 1995',
          },
          {
            value: 96,
            color: '00ffdc',
            description: 'forest disturbed before/at 1996',
          },
          {
            value: 97,
            color: '00ffc5',
            description: 'forest disturbed before/at 1997',
          },
          {
            value: 98,
            color: '00ffaa',
            description: 'forest disturbed before/at 1998',
          },
          {
            value: 99,
            color: '00ff87',
            description: 'forest disturbed before/at 1999',
          },
          {
            value: 100,
            color: '00ff5f',
            description: 'forest disturbed before/at 2000',
          },
          {
            value: 101,
            color: '00ff33',
            description: 'forest disturbed before/at 2001',
          },
          {
            value: 102,
            color: '00ff00',
            description: 'forest disturbed before/at 2002',
          },
          {
            value: 103,
            color: '33ff00',
            description: 'forest disturbed before/at 2003',
          },
          {
            value: 104,
            color: '5fff00',
            description: 'forest disturbed before/at 2004',
          },
          {
            value: 105,
            color: '87ff00',
            description: 'forest disturbed before/at 2005',
          },
          {
            value: 106,
            color: 'aaff00',
            description: 'forest disturbed before/at 2006',
          },
          {
            value: 107,
            color: 'c5ff00',
            description: 'forest disturbed before/at 2007',
          },
          {
            value: 108,
            color: 'dcff00',
            description: 'forest disturbed before/at 2008',
          },
          {
            value: 109,
            color: 'ecff00',
            description: 'forest disturbed before/at 2009',
          },
          {
            value: 110,
            color: 'f8ff00',
            description: 'forest disturbed before/at 2010',
          },
          {
            value: 111,
            color: 'fdff00',
            description: 'forest disturbed before/at 2011',
          },
          {
            value: 112,
            color: 'fffd00',
            description: 'forest disturbed before/at 2012',
          },
          {
            value: 113,
            color: 'fff800',
            description: 'forest disturbed before/at 2013',
          },
          {
            value: 114,
            color: 'ffec00',
            description: 'forest disturbed before/at 2014',
          },
          {
            value: 115,
            color: 'ffdc00',
            description: 'forest disturbed before/at 2015',
          },
          {
            value: 116,
            color: 'ffc500',
            description: 'forest disturbed before/at 2016',
          },
          {
            value: 117,
            color: 'ffaa00',
            description: 'forest disturbed before/at 2017',
          },
          {
            value: 118,
            color: 'ff8700',
            description: 'forest disturbed before/at 2018',
          },
          {
            value: 119,
            color: 'ff5f00',
            description: 'forest disturbed before/at 2019',
          },
          {
            value: 120,
            color: 'ff3300',
            description: 'forest disturbed before/at 2020',
          },
          {
            value: 121,
            color: 'ff0000',
            description: 'forest disturbed before/at 2021',
          },
          {
            value: 200,
            color: 'ffffff',
            description: 'forest no change',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'landcover',
        lookat: {
          lat: 38.68,
          lon: -115.36,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              95,
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
              'ccb879',
              'dfdfc2',
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
      minimum: 11,
      maximum: 95,
      'gee:estimated_range': false,
    },
    impervious: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
    impervious_descriptor: {
      minimum: 20,
      maximum: 29,
      'gee:estimated_range': false,
    },
    science_products_land_cover_change_count: {
      minimum: 1,
      maximum: 8,
      'gee:estimated_range': false,
    },
    science_products_land_cover_change_first_disturbance_date: {
      minimum: 1,
      maximum: 9,
      'gee:estimated_range': false,
    },
    science_products_land_cover_change_index: {
      minimum: 1,
      maximum: 13,
      'gee:estimated_range': false,
    },
    science_products_land_cover_science_product: {
      minimum: 11,
      maximum: 95,
      'gee:estimated_range': false,
    },
    science_products_forest_disturbance_date: {
      minimum: 83,
      maximum: 200,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Dewitz, J., 2023, National Land Cover Database (NLCD) 2021 Products:
    U.S. Geological Survey data release, [doi:10.5066/P9JZ7AO3](https://doi.org/10.5066/P9JZ7AO3)
  |||,
  'sci:doi': '10.5066/P9JZ7AO3',
  'gee:terms_of_use': |||
    Most U.S. Geological Survey (USGS) information is federally created data and
    therefore reside in the public domain and may be used, transferred, or
    reproduced without copyright restriction.
    Additional information on [Acknowledging or Crediting USGS as Information
    Source](https://www.usgs.gov/centers/eros/data-citation) is available.
    
    This work was authored as part of the Contributor's official duties as an
    Employee of the United States Government and is therefore a work of the
    United States Government. In accordance with 17 U.S.C. 105, no copyright
    protection is available for such works under U.S. Law. This is an Open
    Access article that has been identified as being free of known restrictions
    under copyright law, including all related and neighboring rights
    (https://creativecommons.org/publicdomain/mark/1.0/). You can copy, modify,
    distribute and perform the work, even for commercial purposes, all without
    asking permission.
  |||,
  'gee:user_uploaded': true,
  'gee:type': ee_const.gee_type.image_collection,
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
