local id = 'projects/gtac-data-publish/assets/TreeMap/Product_Version/2026-1';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/TreeMap_versions.libsonnet';
local subdir = 'gtac-data-publish';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  'gee:status': 'beta',
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'USFS TreeMap 2026-1',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    TreeMap datasets provide detailed spatial information on forest characteristics 
    across the entire forested extent of the Conterminous United States (CONUS) for 
    the years 2016, 2020, 2022, and 2023. TreeMap 2014 is also available for CONUS but 
    not included in this data archive. TreeMap 2024 is projected to be released in fall 2026. 
    
    For each year, TreeMap contains 22-band 30 x 30m resolution gridded map images of 
    the forests of the United States, with each band representing an attribute derived 
    from select Forest Inventory Analysis (FIA) data and one band representing the TreeMap ID 
    (TM_ID). Some commonly used attributes have already been generated for users and are 
    represented here, including forest type, canopy cover percent, live tree stocking, 
    live/dead tree biomass, and carbon in live/dead trees. 
    
    TreeMap datasets use [LANDFIRE](https://www.landfire.gov/) data as key input layers and 
    are constrained to years when LANDFIRE data are available. TreeMap includes only pixels 
    defined by LANDFIRE as at least 10% forest cover.
    
    TreeMap is produced using a Random Forest machine learning imputation algorithm that 
    assigns the most similar FIA plot to each pixel of gridded LANDFIRE input data. The 
    objective is to combine the complementary strengths of detailed-but-spatially-sparse 
    FIA data with less-detailed-but-spatially-comprehensive LANDFIRE data to produce better 
    estimates of forest characteristics at a variety of scales. 
    
    TreeMap is distinct from other imputed forest vegetation products in that it assigns an FIA 
    plot identifier to each pixel, whereas other datasets use separate models for each individual 
    forest characteristic such as live basal area (e.g., Ohmann and Gregory 2002; Pierce Jr et al. 
    2009; Wilson, Lister, and Riemann 2012). The FIA plot identifier can be linked to the hundreds 
    of variables and attributes recorded for each tree and plot in the FIA DataMart, FIA's public 
    repository of plot information (Forest Inventory Analysis 2022a). While we provide 21 attribute 
    rasters in this data package, users can generate other attributes by linking the TM_ID 
    to the FIA plot control number (PLT_CN), which corresponds to a unique plot visit. For 
    more information and a lookup table linking TM_ID to FIA PLT_CN, see the Forest Service 
    Research Data Archive (DOIs given below in “Additional Resources” section).
    
    TreeMap is used in both the private and public sectors for projects including fuel 
    treatment planning, snag hazard mapping, and estimation of terrestrial carbon resources.
    
    The TreeMap 2016 dataset was produced using the methods described in [Riley et al. (2022)](https://research.fs.usda.gov/treesearch/65597). 
    The TreeMap 2020, 2022, and 2023 datasets were produced using the methods described in 
    Riley et al. (2026, In Prep), 
    which are similar to those used for TreeMap 2016, but differ in that: 1) biophysical 
    variables were derived by overlay of the plot coordinates with Daymet rasters rather 
    than LANDFIRE biophysical variables and included average precipitation, average 
    maximum temperature, average minimum temperature, average vapor pressure, average soil 
    water equivalent, average vapor pressure deficit, average daily shortwave radiation; 
    and 2) plots available for imputation in each LANDFIRE zone were limited to those plots 
    with tree species that were present either in the FIA plots found within the LANDFIRE 
    zone, or in the zones immediately bordering it. This reduced the number of plots with 
    trees that were imputed outside of their observed range, an issue which affected a small number of pixels in previous TreeMap versions.
    
    The results for all years showed good correspondence between the target LANDFIRE data 
    and the imputed plot data. Values of overall within-class agreement for forest cover, 
    forest height, vegetation group, and disturbance code can be found in each vintage's 
    metadata in the USFS Research Data Archive and USFS Raster Data Gateway, as well as in 
    Riley et al (In Prep). 
    
    **Additional Resources**
    
    * See TreeMap in the Research Data Archive for CONUS-wide datasets, the TM_ID to FIA 
    PLT_CN lookup table, plot-level tree data (the Tree Table), and additional information on
    [TreeMap 2014](https://www.fs.usda.gov/rds/archive/catalog/RDS-2019-0026)
    [TreeMap 2016](https://www.fs.usda.gov/rds/archive/catalog/RDS-2021-0074), 
    [TreeMap 2020](https://www.fs.usda.gov/rds/archive/catalog/RDS-2025-0031), 
    [TreeMap 2022](https://www.fs.usda.gov/rds/archive/catalog/RDS-2025-0032), 
    [TreeMap 2023](https://www.fs.usda.gov/rds/archive/catalog/RDS-2026-0038).
    
    * See the [TreeMap 2016 Publication, Riley et al. 2022](https://www.fs.usda.gov/research/treesearch/65597)
    for more detailed information regarding methods and accuracy assessment.
    
    * The [TreeMap Data Explorer](https://apps.fs.usda.gov/lcms-viewer/treemap.html)
    is a web-based application that provides users with the ability to view and download 
    TreeMap attribute data.
    
    * Visit the [TreeMap Raster Data Gateway](https://data.fs.usda.gov/geodata/rastergateway/treemap/) for TreeMap attribute data downloads, metadata, and support documents.
    
    * See the [FIA Database Manual version 9.4](https://research.fs.usda.gov/understory/forest-inventory-and-analysis-database-user-guide-nfi) for more detailed information on the attributes included in TreeMap.
    
    Contact sm.fs.treemaphelp@usda.gov with any questions or specific data requests.



  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links + [
    ee.link.license(
        'https://data.fs.usda.gov/geodata/rastergateway/treemap/'),
    {
      rel: ee_const.rel.source,
      href: 'https://data.fs.usda.gov/geodata/rastergateway/treemap/',
    },
  ],
  'gee:categories': ['forest-biomass'],
  keywords: [
    'aboveground',
    'biomass',
    'carbon',
    'climate_change',
    'conus',
    'forest',
    'forest-biomass',
    'forest-type',
    'forest-inventory-and-analysis',
    'fsic-go',
    'gtac',
    'landcover',
    'landfire',
    'redcastle-resources',
    'tree-cover',
    'us',
    'usda',
    'usfs',
    'vegetation'
  ],
  providers: [
    ee.producer_provider('USDA Forest Service (USFS) Field Services and Innovation Center Geospatial Office (FSIC-GO)', 'https://data.fs.usda.gov/geodata/rastergateway/treemap/'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent(-128.97722, 22.76862, -65.25445, 51.64968,
                    '2020-01-01T00:00:00Z', '2023-12-31T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'year',
        description: |||
          Year of the product data.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'year_released',
        description: |||
          Year the product data was released.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'tm_methods_ver',
        description: |||
          Version of the methods used to generate the product, corresponds to a unique publication. E.g., '2.1' 
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'methods_publication',
        description: |||
          Short citation for the publication associated with the methods version.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'tm_dataset_release',
        description: |||
          Dataset release version - indicates the version of the annual dataset. Eg., '1.0'
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'tm_data_ver',
        description: |||
          Concatenated from publication year, methods version number, and dataset release number. E.g., "2025-2.0-1.0"
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'study_area',
        description: |||
          Study area of the product.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'landfire_ver_name',
        description: |||
          Name used to refer to the version of Landfire data used as reference and target data for imputation, e.g., "LF2022"
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'landfire_ver_num',
        description: |||
          Number used to refer to the version of Landfire data used as reference and target data for imputation, e.g., "2.3.0"
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'fiadb_ver',
        description: |||
          Version of Forest Inventory and Analysis Database used to generate the product, e.g., "1.9"
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'doi',
        description: |||
          Link to the official data publication in the FS Research Data Archive.
        |||,
        type: ee_const.var_type.string,
      },

    ],
    gsd: [30],
    'eo:bands': [
      {
        name: 'ALSTK',
        description: |||
          All-Live-Tree Stocking. The sum of stocking percent values of all live trees on 
          the condition.
        |||,
        'gee:units': units.percent,

      },
      {
        name: 'BALIVE',
        description: |||
          Live Tree Basal Area. Basal area in square feet per acre of all live trees 
          ≥1.0 inch d.b.h./d.r.c. sampled in the condition.
        |||,
        'gee:units': units.square_ft_per_acre,

      },
      {
        name: 'CANOPYPCT',
        description: |||
          Live Canopy Cover. Derived from the Forest Vegetation Simulator.
        |||,
        'gee:units': units.percent,

      },
      {
        name: 'CARBON_D',
        description: |||
          Carbon, Standing Dead. Calculated via the following FIA query: 
          Sum (DRYBIO_BOLE, DRYBIO_TOP, DRYBIO_STUMP, DRYBIO_SAPLING, DRYBIO_WDLD_SPP) 
          / 2 /2000*TPA_UNADJ WHERE (((COND.COND_STATUS_CD)=1) AND ((TREE.STATUSCD)=2) AND 
          ((TREE.DIA)>=5) AND ((TREE.STANDING_DEAD_CD)=1))
        |||,
        'gee:units': units.tons_per_acre,

      },
      {
        name: 'CARBON_DWN',
        description: |||
          Carbon, Down Dead. Carbon (tons per acre) of woody material >3 inches in 
          diameter on the ground, and stumps and their roots >3 inches in diameter. 
          Estimated from models based on geographic area, forest type, and live tree 
          carbon density (Smith and Heath 2008).
        |||,
        'gee:units': units.tons_per_acre,

      },
      {
        name: 'CARBON_L',
        description: |||
          Carbon, Live Above Ground. Calculated via the following FIA query: 
          Sum (DRYBIO_BOLE, DRYBIO_TOP, DRYBIO_STUMP, DRYBIO_SAPLING, DRYBIO_WDLD_SPP) 
          / 2 /2000*TPA_UNADJ WHERE (((COND.COND_STATUS_CD)=1) AND ((TREE.STATUSCD)=1))
        |||,
        'gee:units': units.tons_per_acre,

      },
      {
        name: 'DRYBIO_D',
        description: |||
          Dry Standing Dead Tree Biomass, Above Ground. Calculated via the following FIA 
          query: Sum (DRYBIO_BOLE, DRYBIO_TOP, DRYBIO_STUMP, DRYBIO_SAPLING, 
          DRYBIO_WDLD_SPP) /2000*TPA_UNADJ WHERE (((COND.COND_STATUS_CD)=1) AND 
          ((TREE.STATUSCD)=2) AND ((TREE.DIA)>=5) AND ((TREE.STANDING_DEAD_CD)=1))
        |||,
        'gee:units': units.tons_per_acre,

      },
      {
        name: 'DRYBIO_L',
        description: |||
          Dry Live Tree Biomass, Above Ground. Calculated via the following FIA query: 
          Sum (DRYBIO_BOLE, DRYBIO_TOP, DRYBIO_STUMP, DRYBIO_SAPLING, DRYBIO_WDLD_SPP) 
          /2000*TPA_UNADJ WHERE (((COND.COND_STATUS_CD)=1) AND ((TREE.STATUSCD)=1))
        |||,
        'gee:units': units.tons_per_acre,

      },
      {
        name: 'FLDSZCD',
        description: |||
          Field Stand-Size Class Code - Field-assigned classification of the predominant 
          (based on stocking) diameter class of live trees within the condition.
        |||,

        'gee:classes': [
          {
            value: 0,
            color: 'c62363',
            description: 'Nonstocked - Meeting the definition of accessible land and one of 
            the following applies (1) less than 10 percent stocked by trees, seedlings, and 
            saplings and not classified as cover trees, or (2) for several woodland species 
            where stocking standards are not available, less than 10 percent canopy cover of 
            trees, seedlings, and saplings.',
          },
          {
            value: 1,
            color: 'feba12',
            description: '≤4.9 inches (seedlings/saplings). At least 10 percent stocking 
            (or 10 percent canopy cover if stocking standards are not available) in trees, 
            seedlings, and saplings, and at least 2/3 of the canopy cover is in trees less 
            than 5.0 inches d.b.h./d.r.c.',
          },
          {
            value: 2,
            color: 'ffff00',
            description: '5.0-8.9 inches (softwoods)/ 5.0-10.9 inches (hardwoods). At least 
            10 percent stocking (or 10 percent canopy cover if stocking standards are not 
            available) in trees, seedlings, and saplings; and at least one-third of the 
            canopy cover is in trees greater than 5.0 inches d.b.h./d.r.c. and the plurality 
            of the canopy cover is in softwoods 5.0-8.9 inches diameter and/or hardwoods 
            5.0-10.9 inches d.b.h., and/or woodland trees 5.0-8.9 inches d.r.c.',
          },
          {
            value: 3,
            color: '38a800',
            description: '9.0-19.9 inches (softwoods)/ 11.0-19.9 inches (hardwoods). At 
            least 10 percent stocking (or 10 percent canopy cover if stocking standards are 
            not available) in trees, seedlings, and sapling; and at least one-third of the 
            canopy cover is in trees greater than 5.0 inches d.b.h./d.r.c. and the plurality 
            of the canopy cover is in softwoods 9.0-19.9 inches diameter and/or hardwoods 
            between 11.0-19.9 inches d.b.h., and/or woodland trees 9.0-19.9 inches d.r.c.',
          },
          {
            value: 4,
            color: '73dfff',
            description: '20.0-39.9 inches. At least 10 percent stocking (or 10 percent 
            canopy cover if stocking standards are not available) in trees, seedlings, and 
            saplings; and at least one-third of the canopy cover is in trees greater than 
            5.0 inches d.b.h./d.r.c. and the plurality of the canopy cover is in trees 
            20.0-39.9 inches d.b.h.',
          },
          {
            value: 5,
            color: '5c09fc',
            description: '40.0+ inches. At least 10 percent stocking (or 10 percent canopy 
            cover if stocking standards are not available) in trees, seedlings, and 
            saplings; and at least one-third of the canopy cover is in trees greater than 
            5.0 inches d.b.h./d.r.c. and the plurality of the canopy cover is in trees 
            greater than or equal to 40.0 inches d.b.h.',
          },
        ],
      },
      {
        name: 'FLDTYPCD',
        description: |||
          Field Forest Type Code - A code indicating the forest type, assigned by the 
          field crew, based on the tree species or species groups forming a plurality of 
          all live stocking. The field crew assesses the forest type based on the acre 
          of forest land around the plot, in addition to the species sampled on the 
          condition.
        |||,

        'gee:classes': [
            {
            value: 101,
            color: '6e26ec',
            description: 'Jack pine',
            },
            {
            value: 102,
            color: 'c765ec',
            description: 'Red pine',
            },
            {
            value: 103,
            color: 'efdbcc',
            description: 'Eastern white pine',
            },
            {
            value: 104,
            color: 'a8a9f2',
            description: 'Eastern white pine / eastern hemlock',
            },
            {
            value: 105,
            color: 'd0ce83',
            description: 'Eastern hemlock',
            },
            {
            value: 121,
            color: '47d0b6',
            description: 'Balsam fir',
            },
            {
            value: 122,
            color: '9d86a6',
            description: 'White spruce',
            },
            {
            value: 123,
            color: 'a5f77a',
            description: 'Red spruce',
            },
            {
            value: 124,
            color: 'dcf4d9',
            description: 'Red spruce / balsam fir',
            },
            {
            value: 125,
            color: '64e1f7',
            description: 'Black spruce',
            },
            {
            value: 126,
            color: 'afa9b0',
            description: 'Tamarack',
            },
            {
            value: 127,
            color: 'f2c531',
            description: 'Northern white-cedar',
            },
            {
            value: 128,
            color: '87cc75',
            description: 'Fraser fir',
            },
            {
            value: 141,
            color: '84d7eb',
            description: 'Longleaf pine',
            },
            {
            value: 142,
            color: 'ef4677',
            description: 'Slash pine',
            },
            {
            value: 161,
            color: '97f2ad',
            description: 'Loblolly pine',
            },
            {
            value: 162,
            color: 'd45549',
            description: 'Shortleaf pine',
            },
            {
            value: 163,
            color: '63f3ac',
            description: 'Virginia pine',
            },
            {
            value: 164,
            color: 'f58de4',
            description: 'Sand pine',
            },
            {
            value: 165,
            color: 'e9c991',
            description: 'Table Mountain pine',
            },
            {
            value: 166,
            color: 'ddbef2',
            description: 'Pond pine',
            },
            {
            value: 167,
            color: 'bba847',
            description: 'Pitch pine',
            },
            {
            value: 171,
            color: '95eacd',
            description: 'Eastern redcedar',
            },
            {
            value: 182,
            color: 'a6827b',
            description: 'Rocky Mountain juniper',
            },
            {
            value: 184,
            color: 'bca28a',
            description: 'Juniper woodland',
            },
            {
            value: 185,
            color: 'cff3f4',
            description: 'Pinyon / juniper woodland',
            },
            {
            value: 201,
            color: 'c1ded5',
            description: 'Douglas-fir',
            },
            {
            value: 202,
            color: '948ee9',
            description: 'Port-Orford-cedar',
            },
            {
            value: 221,
            color: 'd0ef5b',
            description: 'Ponderosa pine',
            },
            {
            value: 222,
            color: 'e29af0',
            description: 'Incense-cedar',
            },
            {
            value: 224,
            color: 'c34bc3',
            description: 'Sugar pine',
            },
            {
            value: 225,
            color: 'e6acb8',
            description: 'Jeffrey pine',
            },
            {
            value: 226,
            color: 'ea3b34',
            description: 'Coulter pine',
            },
            {
            value: 241,
            color: '724353',
            description: 'Western white pine',
            },
            {
            value: 261,
            color: 'f2c7a0',
            description: 'White fir',
            },
            {
            value: 262,
            color: '6ab27f',
            description: 'Red fir',
            },
            {
            value: 263,
            color: 'f1f3d3',
            description: 'Noble fir',
            },
            {
            value: 264,
            color: 'ea5aba',
            description: 'Pacific silver fir',
            },
            {
            value: 265,
            color: 'edc7e1',
            description: 'Engelmann spruce',
            },
            {
            value: 266,
            color: '4965e2',
            description: 'Engelmann spruce / subalpine fir',
            },
            {
            value: 267,
            color: 'a0f4c4',
            description: 'Grand fir',
            },
            {
            value: 268,
            color: '5697de',
            description: 'Subalpine fir',
            },
            {
            value: 269,
            color: '5defc4',
            description: 'Blue spruce',
            },
            {
            value: 270,
            color: 'e8f384',
            description: 'Mountain hemlock',
            },
            {
            value: 271,
            color: 'cc63bd',
            description: 'Alaska-yellow-cedar',
            },
            {
            value: 281,
            color: 'e16f3d',
            description: 'Lodgepole pine',
            },
            {
            value: 301,
            color: 'f5da68',
            description: 'Western hemlock',
            },
            {
            value: 304,
            color: 'a63bcf',
            description: 'Western redcedar',
            },
            {
            value: 305,
            color: '51d0dd',
            description: 'Sitka spruce',
            },
            {
            value: 321,
            color: '6bc5b6',
            description: 'Western larch',
            },
            {
            value: 341,
            color: 'f2f4a5',
            description: 'Redwood',
            },
            {
            value: 361,
            color: '576abe',
            description: 'Knobcone pine',
            },
            {
            value: 362,
            color: 'b56f7c',
            description: 'Southwestern white pine',
            },
            {
            value: 365,
            color: 'dca5ca',
            description: 'Foxtail pine / bristlecone pine',
            },
            {
            value: 366,
            color: '67eff4',
            description: 'Limber pine',
            },
            {
            value: 367,
            color: 'ca5483',
            description: 'Whitebark pine',
            },
            {
            value: 368,
            color: 'a8bf86',
            description: 'Miscellaneous western softwoods',
            },
            {
            value: 369,
            color: 'aff6e9',
            description: 'Western juniper',
            },
            {
            value: 371,
            color: 'a53394',
            description: 'California mixed conifer',
            },
            {
            value: 381,
            color: 'e9e2eb',
            description: 'Scotch pine',
            },
            {
            value: 383,
            color: 'd0cfad',
            description: 'Other exotic softwoods',
            },
            {
            value: 384,
            color: 'eee1b3',
            description: 'Norway spruce',
            },
            {
            value: 385,
            color: 'e4db79',
            description: 'Introduced larch',
            },
            {
            value: 401,
            color: 'ec42f6',
            description: 'Eastern white pine / northern red oak / white ash',
            },
            {
            value: 402,
            color: '7e9f81',
            description: 'Eastern redcedar / hardwood',
            },
            {
            value: 403,
            color: '4a7196',
            description: 'Longleaf pine / oak',
            },
            {
            value: 404,
            color: '5cd76e',
            description: 'Shortleaf pine / oak',
            },
            {
            value: 405,
            color: '37999a',
            description: 'Virginia pine / southern red oak',
            },
            {
            value: 406,
            color: 'ed54dd',
            description: 'Loblolly pine / hardwood',
            },
            {
            value: 407,
            color: '6792f0',
            description: 'Slash pine / hardwood',
            },
            {
            value: 409,
            color: '82eb3e',
            description: 'Other pine / hardwood',
            },
            {
            value: 501,
            color: 'b8db98',
            description: 'Post oak / blackjack oak',
            },
            {
            value: 502,
            color: 'bccc4b',
            description: 'Chestnut oak',
            },
            {
            value: 503,
            color: 'f22ab1',
            description: 'White oak / red oak / hickory',
            },
            {
            value: 504,
            color: 'f6e095',
            description: 'White oak',
            },
            {
            value: 505,
            color: '77989d',
            description: 'Northern red oak',
            },
            {
            value: 506,
            color: '718640',
            description: 'Yellow-poplar / white oak / northern red oak',
            },
            {
            value: 507,
            color: '9d4f8d',
            description: 'Sassafras / persimmon',
            },
            {
            value: 508,
            color: 'c376e4',
            description: 'Sweetgum / yellow-poplar',
            },
            {
            value: 509,
            color: '7cb133',
            description: 'Bur oak',
            },
            {
            value: 510,
            color: '5fa7cc',
            description: 'Scarlet oak',
            },
            {
            value: 511,
            color: '9ae6e8',
            description: 'Yellow-poplar',
            },
            {
            value: 512,
            color: 'def3b1',
            description: 'Black walnut',
            },
            {
            value: 513,
            color: 'b88bf2',
            description: 'Black locust',
            },
            {
            value: 514,
            color: 'a5f031',
            description: 'Southern scrub oak',
            },
            {
            value: 515,
            color: 'eeafa3',
            description: 'Chestnut oak / black oak / scarlet oak',
            },
            {
            value: 516,
            color: '9bd763',
            description: 'Cherry / white ash / yellow-poplar',
            },
            {
            value: 517,
            color: 'b838ee',
            description: 'Elm / ash / black locust',
            },
            {
            value: 519,
            color: 'e88fbb',
            description: 'Red maple / oak',
            },
            {
            value: 520,
            color: 'cce5b9',
            description: 'Mixed upland hardwoods',
            },
            {
            value: 601,
            color: 'ed8a9c',
            description: 'Swamp chestnut oak / cherrybark oak',
            },
            {
            value: 602,
            color: 'c8ed2d',
            description: 'Sweetgum / Nuttall oak / willow oak',
            },
            {
            value: 605,
            color: 'f0bd53',
            description: 'Overcup oak / water hickory',
            },
            {
            value: 606,
            color: '60dad1',
            description: 'Atlantic white-cedar',
            },
            {
            value: 607,
            color: 'c790c1',
            description: 'Baldcypress / water tupelo',
            },
            {
            value: 608,
            color: '54c7ef',
            description: 'Sweetbay / swamp tupelo / red maple',
            },
            {
            value: 609,
            color: '8e6a31',
            description: 'Baldcypress / pondcypress',
            },
            {
            value: 701,
            color: 'cecceb',
            description: 'Black ash / American elm / red maple',
            },
            {
            value: 702,
            color: 'b1bef2',
            description: 'River birch / sycamore',
            },
            {
            value: 703,
            color: 'f077ef',
            description: 'Cottonwood',
            },
            {
            value: 704,
            color: '969aca',
            description: 'Willow',
            },
            {
            value: 705,
            color: 'c4ec84',
            description: 'Sycamore / pecan / American elm',
            },
            {
            value: 706,
            color: 'efadec',
            description: 'Sugarberry / hackberry / elm / green ash',
            },
            {
            value: 707,
            color: 'da23cf',
            description: 'Silver maple / American elm',
            },
            {
            value: 708,
            color: 'e4c3c0',
            description: 'Red maple / lowland',
            },
            {
            value: 709,
            color: 'bf90e1',
            description: 'Cottonwood / willow',
            },
            {
            value: 722,
            color: '52f3eb',
            description: 'Oregon ash',
            },
            {
            value: 801,
            color: 'a2c9eb',
            description: 'Sugar maple / beech / yellow birch',
            },
            {
            value: 802,
            color: '3ff451',
            description: 'Black cherry',
            },
            {
            value: 805,
            color: '6ab7f2',
            description: 'Hard maple / basswood',
            },
            {
            value: 809,
            color: 'b3714c',
            description: 'Red maple / upland',
            },
            {
            value: 901,
            color: 'd28f25',
            description: 'Aspen',
            },
            {
            value: 902,
            color: 'f59550',
            description: 'Paper birch',
            },
            {
            value: 903,
            color: 'dd82c7',
            description: 'Gray birch',
            },
            {
            value: 904,
            color: 'c5f2a0',
            description: 'Balsam poplar',
            },
            {
            value: 905,
            color: 'e3f2e7',
            description: 'Pin cherry',
            },
            {
            value: 911,
            color: 'b2c2b1',
            description: 'Red alder',
            },
            {
            value: 912,
            color: '4ff389',
            description: 'Bigleaf maple',
            },
            {
            value: 921,
            color: '8772e8',
            description: 'Gray pine',
            },
            {
            value: 922,
            color: 'bb24a1',
            description: 'California black oak',
            },
            {
            value: 923,
            color: 'c7f7cd',
            description: 'Oregon white oak',
            },
            {
            value: 924,
            color: '8fc3c6',
            description: 'Blue oak',
            },
            {
            value: 931,
            color: 'f13896',
            description: 'Coast live oak',
            },
            {
            value: 933,
            color: 'efe92f',
            description: 'Canyon live oak',
            },
            {
            value: 934,
            color: '6c48ae',
            description: 'Interior live oak',
            },
            {
            value: 935,
            color: 'b3e8cd',
            description: 'California white oak (valley oak)',
            },
            {
            value: 941,
            color: 'e8a882',
            description: 'Tanoak',
            },
            {
            value: 942,
            color: 'b3e0f0',
            description: 'California laurel',
            },
            {
            value: 943,
            color: '6a48de',
            description: 'Giant chinkapin',
            },
            {
            value: 961,
            color: 'c3ab6e',
            description: 'Pacific madrone',
            },
            {
            value: 962,
            color: 'f5f169',
            description: 'Other hardwoods',
            },
            {
            value: 971,
            color: 'f3c66f',
            description: 'Deciduous oak woodland',
            },
            {
            value: 972,
            color: '4ecb89',
            description: 'Evergreen oak woodland',
            },
            {
            value: 973,
            color: '60b0c2',
            description: 'Mesquite woodland',
            },
            {
            value: 974,
            color: '76e45f',
            description: 'Cercocarpus (mountain brush) woodland',
            },
            {
            value: 975,
            color: 'b3c5ce',
            description: 'Intermountain maple woodland',
            },
            {
            value: 976,
            color: 'ee73af',
            description: 'Miscellaneous woodland hardwoods',
            },
            {
            value: 982,
            color: '9473b4',
            description: 'Mangrove',
            },
            {
            value: 983,
            color: '80d9a8',
            description: 'Palms',
            },
            {
            value: 995,
            color: 'e67774',
            description: 'Other exotic hardwoods',
            },
        ],
      },
      {
        name: 'FORTYPCD',
        description: |||
          Algorithm Forest Type Code - This is the forest type used for reporting 
          purposes. It is primarily derived using a computer algorithm, except when less 
          than 25 percent of the plot samples a particular forest condition or in a few 
          other cases.
        |||,

        'gee:classes': [
            {
            value: 101,
            color: '6e26ec',
            description: 'Jack pine',
            },
            {
            value: 102,
            color: 'c765ec',
            description: 'Red pine',
            },
            {
            value: 103,
            color: 'efdbcc',
            description: 'Eastern white pine',
            },
            {
            value: 104,
            color: 'a8a9f2',
            description: 'Eastern white pine / eastern hemlock',
            },
            {
            value: 105,
            color: 'd0ce83',
            description: 'Eastern hemlock',
            },
            {
            value: 121,
            color: '47d0b6',
            description: 'Balsam fir',
            },
            {
            value: 122,
            color: '9d86a6',
            description: 'White spruce',
            },
            {
            value: 123,
            color: 'a5f77a',
            description: 'Red spruce',
            },
            {
            value: 124,
            color: 'dcf4d9',
            description: 'Red spruce / balsam fir',
            },
            {
            value: 125,
            color: '64e1f7',
            description: 'Black spruce',
            },
            {
            value: 126,
            color: 'afa9b0',
            description: 'Tamarack',
            },
            {
            value: 127,
            color: 'f2c531',
            description: 'Northern white-cedar',
            },
            {
            value: 141,
            color: '84d7eb',
            description: 'Longleaf pine',
            },
            {
            value: 142,
            color: 'ef4677',
            description: 'Slash pine',
            },
            {
            value: 161,
            color: '97f2ad',
            description: 'Loblolly pine',
            },
            {
            value: 162,
            color: 'd45549',
            description: 'Shortleaf pine',
            },
            {
            value: 163,
            color: '63f3ac',
            description: 'Virginia pine',
            },
            {
            value: 164,
            color: 'f58de4',
            description: 'Sand pine',
            },
            {
            value: 165,
            color: 'e9c991',
            description: 'Table Mountain pine',
            },
            {
            value: 166,
            color: 'ddbef2',
            description: 'Pond pine',
            },
            {
            value: 167,
            color: 'bba847',
            description: 'Pitch pine',
            },
            {
            value: 171,
            color: '95eacd',
            description: 'Eastern redcedar',
            },
            {
            value: 182,
            color: 'a6827b',
            description: 'Rocky Mountain juniper',
            },
            {
            value: 184,
            color: 'bca28a',
            description: 'Juniper woodland',
            },
            {
            value: 185,
            color: 'cff3f4',
            description: 'Pinyon / juniper woodland',
            },
            {
            value: 201,
            color: 'c1ded5',
            description: 'Douglas-fir',
            },
            {
            value: 202,
            color: '948ee9',
            description: 'Port-Orford-cedar',
            },
            {
            value: 221,
            color: 'd0ef5b',
            description: 'Ponderosa pine',
            },
            {
            value: 222,
            color: 'e29af0',
            description: 'Incense-cedar',
            },
            {
            value: 224,
            color: 'c34bc3',
            description: 'Sugar pine',
            },
            {
            value: 225,
            color: 'e6acb8',
            description: 'Jeffrey pine',
            },
            {
            value: 226,
            color: 'ea3b34',
            description: 'Coulter pine',
            },
            {
            value: 241,
            color: '724353',
            description: 'Western white pine',
            },
            {
            value: 261,
            color: 'f2c7a0',
            description: 'White fir',
            },
            {
            value: 262,
            color: '6ab27f',
            description: 'Red fir',
            },
            {
            value: 263,
            color: 'f1f3d3',
            description: 'Noble fir',
            },
            {
            value: 264,
            color: 'ea5aba',
            description: 'Pacific silver fir',
            },
            {
            value: 265,
            color: 'edc7e1',
            description: 'Engelmann spruce',
            },
            {
            value: 266,
            color: '4965e2',
            description: 'Engelmann spruce / subalpine fir',
            },
            {
            value: 267,
            color: 'a0f4c4',
            description: 'Grand fir',
            },
            {
            value: 268,
            color: '5697de',
            description: 'Subalpine fir',
            },
            {
            value: 269,
            color: '5defc4',
            description: 'Blue spruce',
            },
            {
            value: 270,
            color: 'e8f384',
            description: 'Mountain hemlock',
            },
            {
            value: 271,
            color: 'cc63bd',
            description: 'Alaska-yellow-cedar',
            },
            {
            value: 281,
            color: 'e16f3d',
            description: 'Lodgepole pine',
            },
            {
            value: 301,
            color: 'f5da68',
            description: 'Western hemlock',
            },
            {
            value: 304,
            color: 'a63bcf',
            description: 'Western redcedar',
            },
            {
            value: 305,
            color: '51d0dd',
            description: 'Sitka spruce',
            },
            {
            value: 321,
            color: '6bc5b6',
            description: 'Western larch',
            },
            {
            value: 341,
            color: 'f2f4a5',
            description: 'Redwood',
            },
            {
            value: 361,
            color: '576abe',
            description: 'Knobcone pine',
            },
            {
            value: 362,
            color: 'b56f7c',
            description: 'Southwestern white pine',
            },
            {
            value: 365,
            color: 'dca5ca',
            description: 'Foxtail pine / bristlecone pine',
            },
            {
            value: 366,
            color: '67eff4',
            description: 'Limber pine',
            },
            {
            value: 367,
            color: 'ca5483',
            description: 'Whitebark pine',
            },
            {
            value: 368,
            color: 'a8bf86',
            description: 'Miscellaneous western softwoods',
            },
            {
            value: 369,
            color: 'aff6e9',
            description: 'Western juniper',
            },
            {
            value: 371,
            color: 'a53394',
            description: 'California mixed conifer',
            },
            {
            value: 381,
            color: 'e9e2eb',
            description: 'Scotch pine',
            },
            {
            value: 383,
            color: 'd0cfad',
            description: 'Other exotic softwoods',
            },
            {
            value: 384,
            color: 'eee1b3',
            description: 'Norway spruce',
            },
            {
            value: 385,
            color: 'e4db79',
            description: 'Introduced larch',
            },
            {
            value: 401,
            color: 'ec42f6',
            description: 'Eastern white pine / northern red oak / white ash',
            },
            {
            value: 402,
            color: '7e9f81',
            description: 'Eastern redcedar / hardwood',
            },
            {
            value: 403,
            color: '4a7196',
            description: 'Longleaf pine / oak',
            },
            {
            value: 404,
            color: '5cd76e',
            description: 'Shortleaf pine / oak',
            },
            {
            value: 405,
            color: '37999a',
            description: 'Virginia pine / southern red oak',
            },
            {
            value: 406,
            color: 'ed54dd',
            description: 'Loblolly pine / hardwood',
            },
            {
            value: 407,
            color: '6792f0',
            description: 'Slash pine / hardwood',
            },
            {
            value: 409,
            color: '82eb3e',
            description: 'Other pine / hardwood',
            },
            {
            value: 501,
            color: 'b8db98',
            description: 'Post oak / blackjack oak',
            },
            {
            value: 502,
            color: 'bccc4b',
            description: 'Chestnut oak',
            },
            {
            value: 503,
            color: 'f22ab1',
            description: 'White oak / red oak / hickory',
            },
            {
            value: 504,
            color: 'f6e095',
            description: 'White oak',
            },
            {
            value: 505,
            color: '77989d',
            description: 'Northern red oak',
            },
            {
            value: 506,
            color: '718640',
            description: 'Yellow-poplar / white oak / northern red oak',
            },
            {
            value: 507,
            color: '9d4f8d',
            description: 'Sassafras / persimmon',
            },
            {
            value: 508,
            color: 'c376e4',
            description: 'Sweetgum / yellow-poplar',
            },
            {
            value: 509,
            color: '7cb133',
            description: 'Bur oak',
            },
            {
            value: 510,
            color: '5fa7cc',
            description: 'Scarlet oak',
            },
            {
            value: 511,
            color: '9ae6e8',
            description: 'Yellow-poplar',
            },
            {
            value: 512,
            color: 'def3b1',
            description: 'Black walnut',
            },
            {
            value: 513,
            color: 'b88bf2',
            description: 'Black locust',
            },
            {
            value: 514,
            color: 'a5f031',
            description: 'Southern scrub oak',
            },
            {
            value: 515,
            color: 'eeafa3',
            description: 'Chestnut oak / black oak / scarlet oak',
            },
            {
            value: 516,
            color: '9bd763',
            description: 'Cherry / white ash / yellow-poplar',
            },
            {
            value: 517,
            color: 'b838ee',
            description: 'Elm / ash / black locust',
            },
            {
            value: 519,
            color: 'e88fbb',
            description: 'Red maple / oak',
            },
            {
            value: 520,
            color: 'cce5b9',
            description: 'Mixed upland hardwoods',
            },
            {
            value: 601,
            color: 'ed8a9c',
            description: 'Swamp chestnut oak / cherrybark oak',
            },
            {
            value: 602,
            color: 'c8ed2d',
            description: 'Sweetgum / Nuttall oak / willow oak',
            },
            {
            value: 605,
            color: 'f0bd53',
            description: 'Overcup oak / water hickory',
            },
            {
            value: 606,
            color: '60dad1',
            description: 'Atlantic white-cedar',
            },
            {
            value: 607,
            color: 'c790c1',
            description: 'Baldcypress / water tupelo',
            },
            {
            value: 608,
            color: '54c7ef',
            description: 'Sweetbay / swamp tupelo / red maple',
            },
            {
            value: 609,
            color: '8e6a31',
            description: 'Baldcypress / pondcypress',
            },
            {
            value: 701,
            color: 'cecceb',
            description: 'Black ash / American elm / red maple',
            },
            {
            value: 702,
            color: 'b1bef2',
            description: 'River birch / sycamore',
            },
            {
            value: 703,
            color: 'f077ef',
            description: 'Cottonwood',
            },
            {
            value: 704,
            color: '969aca',
            description: 'Willow',
            },
            {
            value: 705,
            color: 'c4ec84',
            description: 'Sycamore / pecan / American elm',
            },
            {
            value: 706,
            color: 'efadec',
            description: 'Sugarberry / hackberry / elm / green ash',
            },
            {
            value: 707,
            color: 'da23cf',
            description: 'Silver maple / American elm',
            },
            {
            value: 708,
            color: 'e4c3c0',
            description: 'Red maple / lowland',
            },
            {
            value: 709,
            color: 'bf90e1',
            description: 'Cottonwood / willow',
            },
            {
            value: 722,
            color: '52f3eb',
            description: 'Oregon ash',
            },
            {
            value: 801,
            color: 'a2c9eb',
            description: 'Sugar maple / beech / yellow birch',
            },
            {
            value: 802,
            color: '3ff451',
            description: 'Black cherry',
            },
            {
            value: 805,
            color: '6ab7f2',
            description: 'Hard maple / basswood',
            },
            {
            value: 809,
            color: 'b3714c',
            description: 'Red maple / upland',
            },
            {
            value: 901,
            color: 'd28f25',
            description: 'Aspen',
            },
            {
            value: 902,
            color: 'f59550',
            description: 'Paper birch',
            },
            {
            value: 903,
            color: 'dd82c7',
            description: 'Gray birch',
            },
            {
            value: 904,
            color: 'c5f2a0',
            description: 'Balsam poplar',
            },
            {
            value: 905,
            color: 'e3f2e7',
            description: 'Pin cherry',
            },
            {
            value: 911,
            color: 'b2c2b1',
            description: 'Red alder',
            },
            {
            value: 912,
            color: '4ff389',
            description: 'Bigleaf maple',
            },
            {
            value: 921,
            color: '8772e8',
            description: 'Gray pine',
            },
            {
            value: 922,
            color: 'bb24a1',
            description: 'California black oak',
            },
            {
            value: 923,
            color: 'c7f7cd',
            description: 'Oregon white oak',
            },
            {
            value: 924,
            color: '8fc3c6',
            description: 'Blue oak',
            },
            {
            value: 931,
            color: 'f13896',
            description: 'Coast live oak',
            },
            {
            value: 933,
            color: 'efe92f',
            description: 'Canyon live oak',
            },
            {
            value: 934,
            color: '6c48ae',
            description: 'Interior live oak',
            },
            {
            value: 935,
            color: 'b3e8cd',
            description: 'California white oak (valley oak)',
            },
            {
            value: 941,
            color: 'e8a882',
            description: 'Tanoak',
            },
            {
            value: 942,
            color: 'b3e0f0',
            description: 'California laurel',
            },
            {
            value: 943,
            color: '6a48de',
            description: 'Giant chinkapin',
            },
            {
            value: 961,
            color: 'c3ab6e',
            description: 'Pacific madrone',
            },
            {
            value: 962,
            color: 'f5f169',
            description: 'Other hardwoods',
            },
            {
            value: 971,
            color: 'f3c66f',
            description: 'Deciduous oak woodland',
            },
            {
            value: 972,
            color: '4ecb89',
            description: 'Evergreen oak woodland',
            },
            {
            value: 973,
            color: '60b0c2',
            description: 'Mesquite woodland',
            },
            {
            value: 974,
            color: '76e45f',
            description: 'Cercocarpus (mountain brush) woodland',
            },
            {
            value: 975,
            color: 'b3c5ce',
            description: 'Intermountain maple woodland',
            },
            {
            value: 976,
            color: 'ee73af',
            description: 'Miscellaneous woodland hardwoods',
            },
            {
            value: 982,
            color: '9473b4',
            description: 'Mangrove',
            },
            {
            value: 983,
            color: '80d9a8',
            description: 'Palms',
            },
            {
            value: 991,
            color: 'e6a25e',
            description: 'Paulownia',
            },
            {
            value: 992,
            color: 'f8f3b7',
            description: 'Melaleuca',
            },
            {
            value: 995,
            color: 'e67774',
            description: 'Other exotic hardwoods',
            },
            {
            value: 999,
            color: 'd5cc36',
            description: 'Nonstocked',
            },
        ],
      },
      {
        name: 'GSSTK',
        description: |||
          Growing-Stock Stocking. The sum of stocking percent values of all growing-stock 
          trees on the condition.
        |||,
        'gee:units': units.percent,

      },
      {
        name: 'QMD',
        description: |||
          Stand Quadratic Mean Diameter. The quadratic mean diameter, or the diameter of 
          the tree of average basal area, on the condition. Based on live trees 
          ≥1.0 inch d.b.h./d.r.c. 
        |||,
        'gee:units': units.inch,

      },
      {
        name: 'QMD_RMRS',
        description: |||
          Stand Quadratic Mean Diameter. Rocky Mountain Research Station. The quadratic 
          mean diameter, or the diameter of the tree of average basal area, on the 
          condition. Based on live trees ≥1.0 inch d.b.h./d.r.c. Only collected by certain
          FIA work units. 
        |||,
        'gee:units': units.inch,

      },
      {
        name: 'SDIsum',
        description: |||
          Sum of Stand Density Index. Stand density index (SDI). A relative measure of 
          stand density for live trees (greater than or equal to 1.0 inch d.b.h./d.r.c.) 
          on the condition, expressed as a sum of the maximum stand density index (SDI).
        |||,
        'gee:units': units.dimensionless,

      },
      {
        name: 'SDIPCT_RMRS',
        description: |||
          Stand Density Index. Rocky Mountain Research Station. A relative measure of 
          stand density for live trees (≥1.0 inch d.b.h./d.r.c.) on the condition, 
          expressed as a percentage of the maximum stand density index (SDI). Only 
          collected by certain FIA work units.
        |||,
        'gee:units': units.dimensionless,

      },
      {
        name: 'STANDHT',
        description: |||
          Height of dominant trees. Derived from the Forest Vegetation Simulator.
        |||,
        'gee:units': units.foot,

      },
      {
        name: 'STDSZCD',
        description: |||
          Algorithm Stand-Size Class Code - A classification of the predominant (based on 
          stocking) diameter class of live trees within the condition assigned using an 
          algorithm.
        |||,

        'gee:classes': [
          {
            value: 1,
            color: '38a800',
            description: 'Large diameter - Stands with an all live stocking value of at 
            least 10 (base 100); with more than 50 percent of the stocking in medium and 
            large diameter trees; and with the stocking of large diameter trees equal to or 
            greater than the stocking of medium diameter trees.',
          },
          {
            value: 2,
            color: 'ffff00',
            description: 'Medium diameter - Stands with an all live stocking value of at 
            least 10 (base 100); with more than 50 percent of the stocking in medium and 
            large diameter trees; and with the stocking of large diameter trees less than 
            the stocking of medium diameter trees.',
          },
          {
            value: 3,
            color: 'feba12',
            description: 'Small diameter - Stands with an all live stocking value of at 
            least 10 (base 100) on which at least 50 percent of the stocking is in small 
            diameter trees.',
          },
          {
            value: 5,
            color: 'c62363',
            description: 'Nonstocked - Forest land with all live stocking value less 
            than 10.',
          },
        ],
      },
      {
        name: 'TPA_DEAD',
        description: |||
          Dead Trees Per Acre. Number of dead standing trees per acre (DIA >= 5”). 
          Calculated via the following FIA query: Sum TREE.TPA_UNADJ WHERE 
          (((COND.COND_STATUS_CD)=1) AND ((TREE.STATUSCD)=2) AND ((TREE.DIA)>=5) 
          AND ((TREE.STANDING_DEAD_CD)=1))
        |||,
        'gee:units': units.count_per_acre,

      },
      {
        name: 'TPA_LIVE',
        description: |||
          Live Trees Per Acre. Number of live trees per acre (DIA > 1”). Calculated via 
          the following FIA query: Sum TREE.TPA_UNADJ WHERE (((COND.COND_STATUS_CD)=1) 
          AND ((TREE.STATUSCD)=1) AND ((TREE.DIA)>=1))
        |||,
        'gee:units': units.count_per_acre,

      },
      {
        name: 'TM_ID',
        description: |||
          Raw TreeMap identifier dataset values. This dataset is useful to see spatial groupings of individual modeled plot values. TM_ID mappings to FIA plot ids are specific to each year of data. TM_ID attribute layers should not be compared directly across years. If using TM_ID to calculate additional attributes from FIA data, use the year-specific Raster Attribute Table (RAT) to map TM_ID to PLT_CN. The RAT is provided at the USFS Research Data Archive (RDA) and the USFS Raster Data Gateway.
        |||,
        'gee:units': units.dimensionless,

      },
      {
        name: 'Value',
        description: |||
          Raw TreeMap identifier dataset values. This dataset is useful to see spatial 
          groupings of individual modeled plot values. Equivalent to TM_ID. See notes on TM_ID mappings to FIA plot ids.  
        |||,
        'gee:units': units.dimensionless,

      },
      {
        name: 'VOLBFNET_L',
        description: |||
          Volume, Live (log rule: Int’l ¼ inch). Calculated via the following FIA query: 
          Sum VOLBFNET * TPA_UNADJ WHERE (((TREE.TREECLCD)=2) AND 
          ((COND.COND_STATUS_CD)=1) AND ((TREE.STATUSCD)=1))
        |||,
        'gee:units': units.sawlog_board_ft_per_acre,

      },
      {
        name: 'VOLCFNET_D',
        description: |||
          Volume, Standing Dead. Calculated via the following FIA query: 
          Sum VOLCFNET*TPA_UNADJ WHERE (((COND.COND_STATUS_CD)=1) AND ((TREE.STATUSCD)=2) 
          AND ((TREE.DIA)>=5) AND ((TREE.STANDING_DEAD_CD)=1))
        |||,
        'gee:units': units.cubic_ft_per_acre,

      },
      {
        name: 'VOLCFNET_L',
        description: |||
          Volume, Live. Calculated via the following FIA query: 
          Sum VOLCFNET*TPA_UNADJ WHERE (((COND.COND_STATUS_CD)=1) AND ((TREE.STATUSCD)=1))
        |||,
        'gee:units': units.cubic_ft_per_acre,

      },
    ],
    'gee:visualizations': [
      {
        display_name: 'ALSTK_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              100,
            ],
            palette: [
              'ffe599',
              'e7cd68',
              'c5ae32',
              '969206',
              '71870b',
              '52741c',
              '3a652a',
              '265737',
              '134b42',
              '00404d',
            ],
            bands: [
              'ALSTK',
            ],
          },
        },
      },
      {
        display_name: 'BALIVE_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              24,
            ],
            max: [
              217,
            ],
            palette: [
              'ffe599',
              'e7cd68',
              'c5ae32',
              '969206',
              '71870b',
              '52741c',
              '3a652a',
              '265737',
              '134b42',
              '00404d',
            ],
            bands: [
              'BALIVE',
            ],
          },
        },
      },
      {
        display_name: 'CANOPYPCT_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              100,
            ],
            palette: [
              'ffe599',
              'e7cd68',
              'c5ae32',
              '969206',
              '71870b',
              '52741c',
              '3a652a',
              '265737',
              '134b42',
              '00404d',
            ],
            bands: [
              'CANOPYPCT',
            ],
          },
        },
      },
      {
        display_name: 'CARBON_D_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              9,
            ],
            palette: [
            'ffffcc',
            'fbec9a',
            'f4cc68',
            'eca855',
            'e48751',
            'd2624d',
            'a54742',
            '73382f',
            '422818',
            '1a1a01',
            ],
            bands: [
              'CARBON_D',
            ],
          },
        },
      },
      {
        display_name: 'CARBON_DWN_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              7,
            ],
            palette: [
            'ffffcc',
            'fbec9a',
            'f4cc68',
            'eca855',
            'e48751',
            'd2624d',
            'a54742',
            '73382f',
            '422818',
            '1a1a01',
            ],
            bands: [
              'CARBON_DWN',
            ],
          },
        },
      },
      {
        display_name: 'CARBON_L_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              2,
            ],
            max: [
              59,
            ],
            palette: [
            '1a1a01',
            '422818',
            '73382f',
            'a54742',
            'd2624d',
            'e48751',
            'eca855',
            'f4cc68',
            'fbec9a',
            'ffffcc',
            ],
            bands: [
              'CARBON_L',
            ],
          },
        },
      },
      {
        display_name: 'DRYBIO_D_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              10,
            ],
            palette: [
            'ffffcc',
            'fbec9a',
            'f4cc68',
            'eca855',
            'e48751',
            'd2624d',
            'a54742',
            '73382f',
            '422818',
            '1a1a01',
            ],
            bands: [
              'DRYBIO_D',
            ],
          },
        },
      },
      {
        display_name: 'DRYBIO_L_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              4,
            ],
            max: [
              118,
            ],
            palette: [
            '1a1a01',
            '422818',
            '73382f',
            'a54742',
            'd2624d',
            'e48751',
            'eca855',
            'f4cc68',
            'fbec9a',
            'ffffcc',
            ],
            bands: [
              'DRYBIO_L',
            ],
          },
        },
      },
      {
        display_name: 'FLDSZCD_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              5,
            ],
            palette: [
              'C62363',
              'FEBA12',
              'FFFF00',
              '38A800',
              '73DFFF',
              '5C09FC',
            ],
            bands: [
              'FLDSZCD',
            ],
          },
        },
      },
      {
        display_name: 'FLDTYPCD_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              101,
            ],
            max: [
              995,
            ],
            palette: [
              '94D0AA','81B0B6','7F6A37','C57F69','EEC289',
              'F08BF0','51A0B1','F3B035','EBA9D1','AF8DE6','BBB92D',
              'E48FC8','EEA97F','EAF5E0','D2D59B','DCC2C0','C7F0AA',
              'E51EEB','3A1591','C26DA6','67C6CA','95EF79','D5C7E9',
              'BC916F','D1DFD6','49F6AE','7B677B','F16791','DBF39C',
              'DAD9BD','7D2F2E','45E8D5','9BC5E5','4DEBBE','3A6A8B',
              '68F0EC','AAA7E7','4589D2','F4DF8E','F7D969','DFA098',
              'D8ECF0','CAF466','E64393','8CE7EF','EEC7EA','DFA9EF',
              'B7F2E0','BBBCC4','B2B1C8','ADF6D0','E2C8F9','BAE3F5',
              '8391A7','9A2D79','B4CFA7','93DBF2','BAAEA2','8FF390',
              'B2FA73','C6295F','EA6375','A1E073','2DB8AB','AE73B2',
              'E38BAE','CFB0FA','D3A9B3','90E5D5','F12C43','B2C387',
              '8FA42C','CDE353','7680AC','46D7ED','EECC39','D7BAF5',
              '9A29F0','A7C6D7','F28A8D','EBF385','A0CD4F','81B180',
              'CBA1FB','6BC35E','F5A3AD','D4DDEF','A049B7','E1A0B6',
              'F06748','7A9252','66D727','E645DC','AA8D8B','EE405D',
              'CFADD4','9190E6','4E655F','57ADF1','B2EB31','C6E377',
              'BEA664','C26262','4B9A91','72F4B9','DA90E3','3EBF45',
              'E973BF','AFE7B3','81629F','9144DD','E4C0A1','AC82A2',
              'F5A8E1','B486F5','ECBF68','F340AF','C0CAF5','C1F89A',
              'D3F3D2','EBEBC0','D350F4','D1CF7C','71F943','9E87C0',
              'B6707A','F7E6D7','8CAAF2','F1F2F3','A3D382','4EBF86',
              '8CF45A','F4F3B7','A1CFC9','F0DC9F','5971EF','699FCB',
              'F7A1F0','5E62F8','F0CDBD','A7902B','F2F875','E6A55A',
              'F068E4','DE55BF','CFF3C0','F7C1F3','90896C','F5BEB3',
              'B49EC7','6BC3F5','6226E8','7AEBCD','D2AB20','515891',
              'E47A65','97B45A','CBD14D','64C2A2','ADF2AD','DEEFB4',
              '52B8DC','E1F855','8FA792','EBE545','C676DF','489744',
              'E2F231','CFBC8F','51DC89','AA511D','846AC6','BB8FD3',
              'F1BCD8','4F45A6','C6F5F4','E5DD69','C0A8E1','7F5DD7',
              'DFD3D7','56F277','28703C','86E799','B9D1BF','A5BAEE',
              'F28E2E','E7DBED','5D84E4','BB68F3','D96F9B','EFCDDD',
            ],
            bands: [
              'FLDTYPCD',
            ],
          },
        },
      },
      {
        display_name: 'FORTYPCD_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              101,
            ],
            max: [
              999,
            ],
            palette: [
              '94D0AA','81B0B6','7F6A37','C57F69','EEC289',
              'F08BF0','51A0B1','F3B035','EBA9D1','AF8DE6','BBB92D',
              'E48FC8','EEA97F','EAF5E0','D2D59B','DCC2C0','C7F0AA',
              'E51EEB','3A1591','C26DA6','67C6CA','95EF79','D5C7E9',
              'BC916F','D1DFD6','49F6AE','7B677B','F16791','DBF39C',
              'DAD9BD','7D2F2E','45E8D5','9BC5E5','4DEBBE','3A6A8B',
              '68F0EC','AAA7E7','4589D2','F4DF8E','F7D969','DFA098',
              'D8ECF0','CAF466','E64393','8CE7EF','EEC7EA','DFA9EF',
              'B7F2E0','BBBCC4','B2B1C8','ADF6D0','E2C8F9','BAE3F5',
              '8391A7','9A2D79','B4CFA7','93DBF2','BAAEA2','8FF390',
              'B2FA73','C6295F','EA6375','A1E073','2DB8AB','AE73B2',
              'E38BAE','CFB0FA','D3A9B3','90E5D5','F12C43','B2C387',
              '8FA42C','CDE353','7680AC','46D7ED','EECC39','D7BAF5',
              '9A29F0','A7C6D7','F28A8D','EBF385','A0CD4F','81B180',
              'CBA1FB','6BC35E','F5A3AD','D4DDEF','A049B7','E1A0B6',
              'F06748','7A9252','66D727','E645DC','AA8D8B','EE405D',
              'CFADD4','9190E6','4E655F','57ADF1','B2EB31','C6E377',
              'BEA664','C26262','4B9A91','72F4B9','DA90E3','3EBF45',
              'E973BF','AFE7B3','81629F','9144DD','E4C0A1','AC82A2',
              'F5A8E1','B486F5','ECBF68','F340AF','C0CAF5','C1F89A',
              'D3F3D2','EBEBC0','D350F4','D1CF7C','71F943','9E87C0',
              'B6707A','F7E6D7','8CAAF2','F1F2F3','A3D382','4EBF86',
              '8CF45A','F4F3B7','A1CFC9','F0DC9F','5971EF','699FCB',
              'F7A1F0','5E62F8','F0CDBD','A7902B','F2F875','E6A55A',
              'F068E4','DE55BF','CFF3C0','F7C1F3','90896C','F5BEB3',
              'B49EC7','6BC3F5','6226E8','7AEBCD','D2AB20','515891',
              'E47A65','97B45A','CBD14D','64C2A2','ADF2AD','DEEFB4',
              '52B8DC','E1F855','8FA792','EBE545','C676DF','489744',
              'E2F231','CFBC8F','51DC89','AA511D','846AC6','BB8FD3',
              'F1BCD8','4F45A6','C6F5F4','E5DD69','C0A8E1','7F5DD7',
              'DFD3D7','56F277','28703C','86E799','B9D1BF','A5BAEE',
              'F28E2E','E7DBED','5D84E4','BB68F3','D96F9B','EFCDDD',
            ],
            bands: [
              'FORTYPCD',
            ],
          },
        },
      },
      {
        display_name: 'GSSTK_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              100,
            ],
            palette: [
              'ffe599',
              'e7cd68',
              'c5ae32',
              '969206',
              '71870b',
              '52741c',
              '3a652a',
              '265737',
              '134b42',
              '00404d',
            ],
            bands: [
              'GSSTK',
            ],
          },
        },
      },
      {
        display_name: 'QMD_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              2,
            ],
            max: [
              25,
            ],
            palette: [
              'ffe599',
              'e7cd68',
              'c5ae32',
              '969206',
              '71870b',
              '52741c',
              '3a652a',
              '265737',
              '134b42',
              '00404d',
            ],
            bands: [
              'QMD',
            ],
          },
        },
      },
      {
        display_name: 'QMD_RMRS_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              2,
            ],
            max: [
              25,
            ],
            palette: [
              'ffe599',
              'e7cd68',
              'c5ae32',
              '969206',
              '71870b',
              '52741c',
              '3a652a',
              '265737',
              '134b42',
              '00404d',
            ],
            bands: [
              'QMD_RMRS',
            ],
          },
        },
      },
      {
        display_name: 'SDIsum_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              30,
            ],
            max: [
              460,
            ],
            palette: [
              'ffe599',
              'e7cd68',
              'c5ae32',
              '969206',
              '71870b',
              '52741c',
              '3a652a',
              '265737',
              '134b42',
              '00404d',
            ],
            bands: [
              'SDIsum',
            ],
          },
        },
      },
      {
        display_name: 'SDIPCT_RMRS_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              30,
            ],
            max: [
              460,
            ],
            palette: [
              'ffe599',
              'e7cd68',
              'c5ae32',
              '969206',
              '71870b',
              '52741c',
              '3a652a',
              '265737',
              '134b42',
              '00404d',
            ],
            bands: [
              'SDIPCT_RMRS',
            ],
          },
        },
      },
      {
        display_name: 'STANDHT_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              23,
            ],
            max: [
              194,
            ],
            palette: [
              'ffe599',
              'e7cd68',
              'c5ae32',
              '969206',
              '71870b',
              '52741c',
              '3a652a',
              '265737',
              '134b42',
              '00404d',
            ],
            bands: [
              'STANDHT',
            ],
          },
        },
      },
      {
        display_name: 'STDSZCD_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              1,
            ],
            max: [
              5,
            ],
            palette: [
              '38A800',
              'FFFF00',
              'FEBA12',
              'C62363',
              'C62363',
            ],
            bands: [
              'STDSZCD',
            ],
          },
        },
      },
      {
        display_name: 'TPA_DEAD_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              38,
            ],
            max: [
              126,
            ],
            palette: [
            '00404d',
            '134b42',
            '265737',
            '3a652a',
            '52741c',
            '71870b',
            '969206',
            'c5ae32',
            'e7cd68',
            'ffe599',
            ],
            bands: [
              'TPA_DEAD',
            ],
          },
        },
      },
      {
        display_name: 'TPA_LIVE_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              252,
            ],
            max: [
              1666,
            ],
            palette: [
              'ffe599',
              'e7cd68',
              'c5ae32',
              '969206',
              '71870b',
              '52741c',
              '3a652a',
              '265737',
              '134b42',
              '00404d',
            ],
            bands: [
              'TPA_LIVE',
            ],
          },
        },
      },
      {
        display_name: 'VOLBFNET_L_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              441,
            ],
            max: [
              36522,
            ],
            palette: [
            'ffff66',
            'c4ea67',
            '98cb6d',
            '7bae74',
            '60927b',
            '497b85',
            '396b94',
            '2e599f',
            '2446a9',
            '1a33b3',
            ],
            bands: [
              'VOLBFNET_L',
            ],
          },
        },
      },
      {
        display_name: 'VOLCFNET_D_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              5,
            ],
            max: [
              1326,
            ],
            palette: [
            'ffff66',
            'c4ea67',
            '98cb6d',
            '7bae74',
            '60927b',
            '497b85',
            '396b94',
            '2e599f',
            '2446a9',
            '1a33b3',
            ],
            bands: [
              'VOLCFNET_D',
            ],
          },
        },
      },
      {
        display_name: 'VOLCFNET_L_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              137,
            ],
            max: [
              5790,
            ],
            palette: [
            'ffff66',
            'c4ea67',
            '98cb6d',
            '7bae74',
            '60927b',
            '497b85',
            '396b94',
            '2e599f',
            '2446a9',
            '1a33b3',
            ],
            bands: [
              'VOLCFNET_L',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    TreeMap is updated periodically. To ensure scientific reproducibility, please 
    cite the specific version(s) corresponding to the data year(s) used in your 
    analysis. Individual citations for each TreeMap vintage are listed below.
    
   |||,
   'sci:publications': [
        {
        citation: |||
            Zimmer, S. N., R. M. Houtman, L. S. T. Leatherman, J. D. Shaw, I. W. Housman, 
            A. Shrestha, M. O. Borja Arboleda, I. C. Grenfell, M. A. Finney, K. L. Riley: 
            2026, TreeMap 2023 CONUS: A tree-level model of the forests of the conterminous 
            United States circa 2023. Fort Collins, CO: Forest Service Research Data 
            Archive.
            [doi:10.2737/RDS-2026-0038](https://doi.org/10.2737/RDS-2026-0038)
        |||,
        doi:'10.2737/RDS-2026-0038',
        },
        {
        citation: |||
            Houtman, R. M., L. S. T. Leatherman, S. N. Zimmer, I. W. Housman, A. Shrestha,  
            J. D. Shaw, K. L. Riley:  2025. TreeMap 2022 CONUS: A tree-level model of the 
            forests of the conterminous United States circa 2022. Fort Collins, 
            CO: Forest Service Research Data Archive.
            [doi:10.2737/RDS-2025-0032](https://doi.org/10.2737/RDS-2025-0032)
        |||,
        doi:'10.2737/RDS-2025-0032',
        },
        {
        citation: |||
            Zimmer, S. N., R. M. Houtman, L. S. T. Leatherman, I. W. Housman, A. Shrestha, 
            J. D. Shaw, K. L. Riley: 2025, TreeMap 2020 CONUS: A tree-level model of the 
            forests of the conterminous United States circa 2020. Fort Collins, CO: Forest 
            Service Research Data Archive. 
            [doi:10.2737/RDS-2025-0031](https://doi.org/10.2737/RDS-2025-0031)
        |||,
        doi:'10.2737/RDS-2025-0031',
        },
        {
        citation: |||
            Riley, K. L., I. C. Grenfell, M. A. Finney and J. D. Shaw:  2021, TreeMap 2016: 
            A tree-level model of the forests of the conterminous United States circa 2016. 
            Fort Collins, CO: Forest Service Research Data Archive.
            [doi:10.2737/RDS-2021-0074](https://doi.org/10.2737/RDS-2021-0074)
        |||,
        doi:'10.2737/RDS-2021-0074',
        },
        {
        citation: |||
            Riley, K. L., I. C. Grenfell, J. M. Wiener and M. A. Finney:  2022, TreeMap 2016
            dataset generates CONUS-wide maps of forest characteristics including live basal
            area, aboveground carbon, and number of trees per acre. 
            Journal of Forestry. 2022: 607-632.
            [doi:10.1093/jofore/fvac022](https://doi.org/10.1093/jofore/fvac022)
            [https://research.fs.usda.gov/treesearch/65597](https://research.fs.usda.gov/treesearch/65597)
        |||,
        doi:'10.1093/jofore/fvac022',
        },
        {
        citation: |||
            Karin Riley, Rachel Houtman, Scott Zimmer, Lila Leatherman, Jamie Peeler, John Shaw, Isaac Grenfell, Maria Borja Arboleda, Abhinav Shrestha, Ian Housman, and Mark Finney. TreeMap 2020, 2022, and 2023: Improved species range mapping in a tree-level forest dataset for the conterminous United States. Earth Systems Science Data, in prep.
        |||,
        },
   ],
  'gee:terms_of_use': |||
    The USDA Forest Service makes no warranty, expressed or implied, including the 
    warranties of merchantability and fitness for a particular purpose, nor assumes 
    any legal liability or responsibility for the accuracy, reliability, 
    completeness or utility of these geospatial data, or for the improper or 
    incorrect use of these geospatial data. These geospatial data and related maps 
    or graphics are not legal documents and are not intended to be used as such. The 
    data and maps may not be used to determine title, ownership, legal descriptions 
    or boundaries, legal jurisdiction, or restrictions that may be in place on 
    either public or private land. Natural hazards may or may not be depicted on the 
    data and maps, and land users should exercise due caution. The data are dynamic 
    and may change over time. The user is responsible to verify the limitations of 
    the geospatial data and to use the data accordingly.

    These data were collected using funding from the U.S. Government and can be used 
    without additional permissions or fees. If you use these data in a publication, 
    presentation, or other research product please use the appropriate citation for 
    each year vintage.

    See TreeMap in the Research Data Archive for additional information on
      [TreeMap 2016](https://www.fs.usda.gov/rds/archive/catalog/RDS-2021-0074),  
      [TreeMap 2020](https://www.fs.usda.gov/rds/archive/catalog/RDS-2025-0031),  
      [TreeMap 2022](https://www.fs.usda.gov/rds/archive/catalog/RDS-2025-0032),  
      [TreeMap 2023](https://www.fs.usda.gov/rds/archive/catalog/RDS-2026-0038).

  |||,
}
