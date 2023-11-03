local id = 'USFS/GTAC/TreeMap/v2016';
local latest_id = id;
local predecessor_id = '';
local subdir = 'USFS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local latest_basename = std.strReplace(latest_id, '/', '_');
local predecessor_basename = std.strReplace(predecessor_id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';

{
  // TODO(schwehr): Remove when the dataset is ready.
  'gee:skip_indexing': true,

  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'USFS TreeMap v2016 (Conterminous United States)',
  version: 'v2016',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This product is part of the TreeMap data suite. It provides detailed spatial information on forest characteristics including
    number of live and dead trees, biomass, and carbon across the entire forested extent of the continental United States in 2016.

    TreeMap products are the output of a random forests machine learning algorithm that assigns the most similar Forest Inventory Analysis (FIA)
    plot to each pixel of gridded LANDFIRE input data. The objective is to combine the complimenting strengths of detailed-but-spatially-sparse
    FIA data with less-detailed-but-spatially-comprehensive LANDFIRE data to produce better estimations of forest characteristics at a variety of scales.
    TreeMap is being used in both the private and public sectors for projects including fuel treatment planning, snag hazard mapping, and estimation of
    terrestrial carbon resources.

    TreeMap is distinct from other imputed forest vegetation products in that it provides an FIA plot identifier to each pixel whereas other datasets
    provide forest characteristics such as live basal area (e.g., Ohmann and Gregory 2002; Pierce Jr et al. 2009; Wilson, Lister, and Riemann 2012).
    The FIA plot identifier can be linked to the hundreds of variables and attributes recorded for each tree and plot in the FIA DataMart, FIA's public
    repository of plot information (Forest Inventory Analysis 2022a).

    TreeMap v2016 contains one image, a 22-band 30 x 30m resolution gridded map of the forests of the continental United States circa 2016, with each band 
    representing an attribute derived from select FIA data (and one band representing the TreeMap ID). Examples of attributes include forest type, canopy 
    cover percent, live tree stocking, live/dead tree biomass, and carbon in live/dead trees.
    
    The 2016 methodology includes disturbance as a response variable, resulting in increased accuracy in mapping disturbed areas. Within-class accuracy was
    over 90% for forest cover, height, vegetation group, and disturbance code when compared to LANDFIRE maps. At least one pixel within the radius of
    validation plots matched the class of predicted values in 57.5% of cases for forest cover, 80.0% for height, 80.0% for tree species with highest basal
    area, and 87.4% for disturbance.

    **Additional Resources**

    * Please see the [TreeMap 2016 Publication](https://www.fs.usda.gov/research/treesearch/65597) for more detailed information regarding methods and accuracy assessment.

    * The [TreeMap 2016 Data Explorer](https://apps.fs.usda.gov/lcms-viewer/treemap.html) is a web-based application that
      provides users the ability to view TreeMap attribute data.

    * The [TreeMap Research Data Archive](https://www.fs.usda.gov/rds/archive/Catalog/RDS-2021-0074) for the full dataset download, metadata,
      and support documents.

    * [TreeMap Raster Data Gateway](https://data.fs.usda.gov/geodata/rastergateway/treemap/) for separated attribute data downloads, metadata, and support documents.

    * [FIA Database Manual version 8](https://www.fia.fs.usda.gov/library/database-documentation/current/ver80/FIADB%20User%20Guide%20P2_8-0.pdf)
      for more detailed information on the attributes included in TreeMap 2016.

    Contact [sm.fs.gtactreemap@usda.gov](mailto:sm.fs.gtactreemap@usda.gov) with any
    questions or specific data requests.

    * **Forest Inventory Analysis. 2022a.**
    Forest Inventory Analysis DataMart.
    Forest Inventory Analysis DataMart FIADB_1.9.0. 2022. https://apps.fs.usda.gov/fia/datamart/datamart.html.

    * **Ohmann, Janet L and Matthew J Gregory. 2002.**
    Predictive Mapping of Forest Composition and Structure with Direct Gradient Analysis and Nearest- Neighbor Imputation in Coastal Oregon, USA. 
    Can. J. For. Res. 32:725-741. [doi: 10.1139/X02-011](https://doi.org/10.1139/X02-011).

    * **Pierce, Kenneth B Jr, Janet L Ohmann, Michael C Wimberly, Matthew J Gregory, and Jeremy S Fried. 2009.**
    Mapping Wildland Fuels and Forest Structure for Land Management: A Comparison of Nearest Neighbor Imputation and Other Methods.
    Can. J. For. Res. 39: 1901-1916. [doi:10.1139/X09-102](https://doi.org/10.1139/X09-102).

    * **Riley, Karin L.; Grenfell, Isaac C.; Finney, Mark A.; Shaw, John D. 2021.** 
    TreeMap 2016: A tree-level model of the forests of the conterminous United States circa 2016. 
    Fort Collins, CO: Forest Service Research Data Archive. [https://doi.org/10.2737/RDS-2021-0074]https://doi.org/10.2737/RDS-2021-0074.

    * **Wilson, B Tyler, Andrew J Lister, and Rachel I Riemann. 2012.**
    A Nearest-Neighbor Imputation Approach to Mapping Tree Species over Large Areas Using Forest Inventory Plots and Moderate Resolution Raster Data.
    Forest Ecol. Manag. 271:182-198. [doi: 10.1016/j. foreco.2012.02.002](https://doi.org/10.1016/j.foreco.2012.02.002).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(
        'https://data.fs.usda.gov/geodata/rastergateway/treemap/'),
    {
      rel: ee_const.rel.source,
      href: 'https://data.fs.usda.gov/geodata/rastergateway/treemap/',
    },
    ee.link.latest(latest_id, catalog_subdir_url + latest_basename + '.json'),
    ee.link.predecessor(
        predecessor_id, catalog_subdir_url + predecessor_basename + '.json'),
  ],
  keywords: [
    'biota',
    'environment',
    'Ecology, Ecosystems, & Environment',
    'Forest & Plant Health',
    'Inventory, Monitoring, & Analysis',
    'Natural Resource Management & Use',
    'Ecosystem services',
    'Forest management',
    'redcastle_resources',
    'Restoration',
    'Timber',
    'Wilderness',
    'Forest Inventory and Analysis',
    'FIA',
    'imputation',
    'LANDFIRE',
    'random forests',
    'tree list',
    'CONUS',
    'conterminous United States'
  ],
  providers: [
    ee.producer_provider('USDA Forest Service (USFS) Geospatial Technology and Applications Center (GTAC)', 'https://apps.fs.usda.gov/lcms-viewer/treemap.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-128.97722, 22.76862, -65.25445, 51.64968,
                    '2016-01-01T00:00:00Z', '2017-01-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'year',
        description: |||
          Year of the product.
        |||,
        type: ee_const.var_type.number,
      },
      {
        name: 'study_area',
        description: |||
          TreeMap currently only covers CONUS.

          Possible values: 'CONUS'
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'landfire_ver',
        description: |||
          Landfire version used as reference and target data for imputation.
        |||,
        type: ee_const.var_type.string,
      },
    ],
    gsd: [30],
    'eo:bands': [
      {
        name: 'ALSTK',
        description: |||
          All-Live-Tree Stocking (percent) - The sum of stocking percent values of all live trees on the condition.
        |||,
      },
      {
        name: 'BALIVE',
        description: |||
          Live Tree Basal Area (square feet per acre) - Basal area in square feet per acre of all live trees ≥1.0 inch d.b.h./d.r.c. sampled in the condition.
        |||,
      },
      {
        name: 'CANOPYPCT',
        description: |||
          Live Canopy Cover (percent) - Derived from the Forest Vegetation Simulator.
        |||,
      },
      {
        name: 'CARBON_D',
        description: |||
          Carbon, Standing Dead (tons per acre) - Calculated via the following FIA query: Sum (DRYBIO_BOLE, DRYBIO_TOP, DRYBIO_STUMP, DRYBIO_SAPLING, DRYBIO_WDLD_SPP) / 2 /2000*TPA_UNADJ WHERE (((COND.COND_STATUS_CD)=1) AND ((TREE.STATUSCD)=2) AND ((TREE.DIA)>=5) AND ((TREE.STANDING_DEAD_CD)=1)) 
        |||,
      },
      {
        name: 'CARBON_DWN',
        description: |||
          Carbon, Down Dead (tons per acre) - Carbon (tons per acre) of woody material >3 inches in diameter on the ground, and stumps and their roots >3 inches in diameter. Estimated from models based on geographic area, forest type, and live tree carbon density (Smith and Heath 2008).
        |||,
      },
      {
        name: 'CARBON_L',
        description: |||
          Carbon, Live Above Ground (tons per acre) - Calculated via the following FIA query: Sum (DRYBIO_BOLE, DRYBIO_TOP, DRYBIO_STUMP, DRYBIO_SAPLING, DRYBIO_WDLD_SPP) / 2 /2000*TPA_UNADJ WHERE (((COND.COND_STATUS_CD)=1) AND ((TREE.STATUSCD)=1)) 
        |||,
      },
      {
        name: 'DRYBIO_D',
        description: |||
          Dry Standing Dead Tree Biomass, Above Ground (tons per acre) - Calculated via the following FIA query: Sum (DRYBIO_BOLE, DRYBIO_TOP, DRYBIO_STUMP, DRYBIO_SAPLING, DRYBIO_WDLD_SPP) /2000*TPA_UNADJ WHERE (((COND.COND_STATUS_CD)=1) AND ((TREE.STATUSCD)=2) AND ((TREE.DIA)>=5) AND ((TREE.STANDING_DEAD_CD)=1)) 
        |||,
      },
      {
        name: 'DRYBIO_L',
        description: |||
          Dry Live Tree Biomass, Above Ground (tons per acre) - Calculated via the following FIA query: Sum (DRYBIO_BOLE, DRYBIO_TOP, DRYBIO_STUMP, DRYBIO_SAPLING, DRYBIO_WDLD_SPP) /2000*TPA_UNADJ WHERE (((COND.COND_STATUS_CD)=1) AND ((TREE.STATUSCD)=1)) 
        |||,
      },
      {
        name: 'FLDSZCD',
        description: |||
          Field Stand-Size Class Code - Field-assigned classification of the predominant (based on stocking) diameter class of live trees within the condition.
        |||,
        'gee:classes': [
          {
            value: 0,
            color: 'C62363',
            description: 'Nonstocked - Meeting the definition of accessible land and one of the following applies (1) less than 10 percent stocked by trees, seedlings, and saplings and not classified as cover trees, or (2) for several woodland species where stocking standards are not available, less than 10 percent canopy cover of trees, seedlings, and saplings.',
          },
          {
            value: 1,
            color: 'FEBA12',
            description: '≤4.9 inches (seedlings/saplings). At least 10 percent stocking (or 10 percent canopy cover if stocking standards are not available) in trees, seedlings, and saplings, and at least 2/3 of the canopy cover is in trees less than 5.0 inches d.b.h./d.r.c.',
          },
          {
            value: 2,
            color: 'FFFF00',
            description: '5.0-8.9 inches (softwoods)/ 5.0-10.9 inches (hardwoods). At least 10 percent stocking (or 10 percent canopy cover if stocking standards are not available) in trees, seedlings, and saplings; and at least one-third of the canopy cover is in trees greater than 5.0 inches d.b.h./d.r.c. and the plurality of the canopy cover is in softwoods 5.0-8.9 inches diameter and/or hardwoods 5.0-10.9 inches d.b.h., and/or woodland trees 5.0-8.9 inches d.r.c.',
          },
          {
            value: 3,
            color: '38A800',
            description: '9.0-19.9 inches (softwoods)/ 11.0-19.9 inches (hardwoods). At least 10 percent stocking (or 10 percent canopy cover if stocking standards are not available) in trees, seedlings, and sapling; and at least one-third of the canopy cover is in trees greater than 5.0 inches d.b.h./d.r.c. and the plurality of the canopy cover is in softwoods 9.0-19.9 inches diameter and/or hardwoods between 11.0-19.9 inches d.b.h., and/or woodland trees 9.0-19.9 inches d.r.c.',
          },
          {
            value: 4,
            color: '73DFFF',
            description: '20.0-39.9 inches. At least 10 percent stocking (or 10 percent canopy cover if stocking standards are not available) in trees, seedlings, and saplings; and at least one-third of the canopy cover is in trees greater than 5.0 inches d.b.h./d.r.c. and the plurality of the canopy cover is in trees 20.0-39.9 inches d.b.h.',
          },
          {
            value: 5,
            color: '5C09FC',
            description: '40.0+ inches. At least 10 percent stocking (or 10 percent canopy cover if stocking standards are not available) in trees, seedlings, and saplings; and at least one-third of the canopy cover is in trees greater than 5.0 inches d.b.h./d.r.c. and the plurality of the canopy cover is in trees greater than or equal to 40.0 inches d.b.h.',
          },
        ],
      },
      {
        name: 'FLDTYPCD',
        description: |||
          Field Forest Type Code - A code indicating the forest type, assigned by the field crew, based on the tree species or species groups forming a plurality of all live stocking. The field crew assesses the forest type based on the acre of forest land around the plot, in addition to the species sampled on the condition.
        |||,
        'gee:classes': [
          {
          value: 101
          color: '6E26EC'
          description: 'Jack pine'
          },
          {
          value: 102
          color: 'C765EC'
          description: 'Red pine'
          },
          {
          value: 103
          color: 'EFDBCC'
          description: 'Eastern white pine'
          },
          {
          value: 104
          color: 'A8A9F2'
          description: 'Eastern white pine / eastern hemlock'
          },
          {
          value: 105
          color: 'D0CE83'
          description: 'Eastern hemlock'
          },
          {
          value: 121
          color: '47D0B6'
          description: 'Balsam fir'
          },
          {
          value: 122
          color: '9D86A6'
          description: 'White spruce'
          },
          {
          value: 123
          color: 'A5F77A'
          description: 'Red spruce'
          },
          {
          value: 124
          color: 'DCF4D9'
          description: 'Red spruce / balsam fir'
          },
          {
          value: 125
          color: '64E1F7'
          description: 'Black spruce'
          },
          {
          value: 126
          color: 'AFA9B0'
          description: 'Tamarack'
          },
          {
          value: 127
          color: 'F2C531'
          description: 'Northern white-cedar'
          },
          {
          value: 128
          color: '87CC75'
          description: 'Fraser fir'
          },
          {
          value: 141
          color: '84D7EB'
          description: 'Longleaf pine'
          },
          {
          value: 142
          color: 'EF4677'
          description: 'Slash pine'
          },
          {
          value: 161
          color: '97F2AD'
          description: 'Loblolly pine'
          },
          {
          value: 162
          color: 'D45549'
          description: 'Shortleaf pine'
          },
          {
          value: 163
          color: '63F3AC'
          description: 'Virginia pine'
          },
          {
          value: 164
          color: 'F58DE4'
          description: 'Sand pine'
          },
          {
          value: 165
          color: 'E9C991'
          description: 'Table Mountain pine'
          },
          {
          value: 166
          color: 'DDBEF2'
          description: 'Pond pine'
          },
          {
          value: 167
          color: 'BBA847'
          description: 'Pitch pine'
          },
          {
          value: 171
          color: '95EACD'
          description: 'Eastern redcedar'
          },
          {
          value: 182
          color: 'A6827B'
          description: 'Rocky Mountain juniper'
          },
          {
          value: 184
          color: 'BCA28A'
          description: 'Juniper woodland'
          },
          {
          value: 185
          color: 'CFF3F4'
          description: 'Pinyon / juniper woodland'
          },
          {
          value: 201
          color: 'C1DED5'
          description: 'Douglas-fir'
          },
          {
          value: 202
          color: '948EE9'
          description: 'Port-Orford-cedar'
          },
          {
          value: 221
          color: 'D0EF5B'
          description: 'Ponderosa pine'
          },
          {
          value: 222
          color: 'E29AF0'
          description: 'Incense-cedar'
          },
          {
          value: 224
          color: 'C34BC3'
          description: 'Sugar pine'
          },
          {
          value: 225
          color: 'E6ACB8'
          description: 'Jeffrey pine'
          },
          {
          value: 226
          color: 'EA3B34'
          description: 'Coulter pine'
          },
          {
          value: 241
          color: '724353'
          description: 'Western white pine'
          },
          {
          value: 261
          color: 'F2C7A0'
          description: 'White fir'
          },
          {
          value: 262
          color: '6AB27F'
          description: 'Red fir'
          },
          {
          value: 263
          color: 'F1F3D3'
          description: 'Noble fir'
          },
          {
          value: 264
          color: 'EA5ABA'
          description: 'Pacific silver fir'
          },
          {
          value: 265
          color: 'EDC7E1'
          description: 'Engelmann spruce'
          },
          {
          value: 266
          color: '4965E2'
          description: 'Engelmann spruce / subalpine fir'
          },
          {
          value: 267
          color: 'A0F4C4'
          description: 'Grand fir'
          },
          {
          value: 268
          color: '5697DE'
          description: 'Subalpine fir'
          },
          {
          value: 269
          color: '5DEFC4'
          description: 'Blue spruce'
          },
          {
          value: 270
          color: 'E8F384'
          description: 'Mountain hemlock'
          },
          {
          value: 271
          color: 'CC63BD'
          description: 'Alaska-yellow-cedar'
          },
          {
          value: 281
          color: 'E16F3D'
          description: 'Lodgepole pine'
          },
          {
          value: 301
          color: 'F5DA68'
          description: 'Western hemlock'
          },
          {
          value: 304
          color: 'A63BCF'
          description: 'Western redcedar'
          },
          {
          value: 305
          color: '51D0DD'
          description: 'Sitka spruce'
          },
          {
          value: 321
          color: '6BC5B6'
          description: 'Western larch'
          },
          {
          value: 341
          color: 'F2F4A5'
          description: 'Redwood'
          },
          {
          value: 361
          color: '576ABE'
          description: 'Knobcone pine'
          },
          {
          value: 362
          color: 'B56F7C'
          description: 'Southwestern white pine'
          },
          {
          value: 365
          color: 'DCA5CA'
          description: 'Foxtail pine / bristlecone pine'
          },
          {
          value: 366
          color: '67EFF4'
          description: 'Limber pine'
          },
          {
          value: 367
          color: 'CA5483'
          description: 'Whitebark pine'
          },
          {
          value: 368
          color: 'A8BF86'
          description: 'Miscellaneous western softwoods'
          },
          {
          value: 369
          color: 'AFF6E9'
          description: 'Western juniper'
          },
          {
          value: 371
          color: 'A53394'
          description: 'California mixed conifer'
          },
          {
          value: 381
          color: 'E9E2EB'
          description: 'Scotch pine'
          },
          {
          value: 383
          color: 'D0CFAD'
          description: 'Other exotic softwoods'
          },
          {
          value: 384
          color: 'EEE1B3'
          description: 'Norway spruce'
          },
          {
          value: 385
          color: 'E4DB79'
          description: 'Introduced larch'
          },
          {
          value: 401
          color: 'EC42F6'
          description: 'Eastern white pine / northern red oak / white ash'
          },
          {
          value: 402
          color: '7E9F81'
          description: 'Eastern redcedar / hardwood'
          },
          {
          value: 403
          color: '4A7196'
          description: 'Longleaf pine / oak'
          },
          {
          value: 404
          color: '5CD76E'
          description: 'Shortleaf pine / oak'
          },
          {
          value: 405
          color: '37999A'
          description: 'Virginia pine / southern red oak'
          },
          {
          value: 406
          color: 'ED54DD'
          description: 'Loblolly pine / hardwood'
          },
          {
          value: 407
          color: '6792F0'
          description: 'Slash pine / hardwood'
          },
          {
          value: 409
          color: '82EB3E'
          description: 'Other pine / hardwood'
          },
          {
          value: 501
          color: 'B8DB98'
          description: 'Post oak / blackjack oak'
          },
          {
          value: 502
          color: 'BCCC4B'
          description: 'Chestnut oak'
          },
          {
          value: 503
          color: 'F22AB1'
          description: 'White oak / red oak / hickory'
          },
          {
          value: 504
          color: 'F6E095'
          description: 'White oak'
          },
          {
          value: 505
          color: '77989D'
          description: 'Northern red oak'
          },
          {
          value: 506
          color: '718640'
          description: 'Yellow-poplar / white oak / northern red oak'
          },
          {
          value: 507
          color: '9D4F8D'
          description: 'Sassafras / persimmon'
          },
          {
          value: 508
          color: 'C376E4'
          description: 'Sweetgum / yellow-poplar'
          },
          {
          value: 509
          color: '7CB133'
          description: 'Bur oak'
          },
          {
          value: 510
          color: '5FA7CC'
          description: 'Scarlet oak'
          },
          {
          value: 511
          color: '9AE6E8'
          description: 'Yellow-poplar'
          },
          {
          value: 512
          color: 'DEF3B1'
          description: 'Black walnut'
          },
          {
          value: 513
          color: 'B88BF2'
          description: 'Black locust'
          },
          {
          value: 514
          color: 'A5F031'
          description: 'Southern scrub oak'
          },
          {
          value: 515
          color: 'EEAFA3'
          description: 'Chestnut oak / black oak / scarlet oak'
          },
          {
          value: 516
          color: '9BD763'
          description: 'Cherry / white ash / yellow-poplar'
          },
          {
          value: 517
          color: 'B838EE'
          description: 'Elm / ash / black locust'
          },
          {
          value: 519
          color: 'E88FBB'
          description: 'Red maple / oak'
          },
          {
          value: 520
          color: 'CCE5B9'
          description: 'Mixed upland hardwoods'
          },
          {
          value: 601
          color: 'ED8A9C'
          description: 'Swamp chestnut oak / cherrybark oak'
          },
          {
          value: 602
          color: 'C8ED2D'
          description: 'Sweetgum / Nuttall oak / willow oak'
          },
          {
          value: 605
          color: 'F0BD53'
          description: 'Overcup oak / water hickory'
          },
          {
          value: 606
          color: '60DAD1'
          description: 'Atlantic white-cedar'
          },
          {
          value: 607
          color: 'C790C1'
          description: 'Baldcypress / water tupelo'
          },
          {
          value: 608
          color: '54C7EF'
          description: 'Sweetbay / swamp tupelo / red maple'
          },
          {
          value: 609
          color: '8E6A31'
          description: 'Baldcypress / pondcypress'
          },
          {
          value: 701
          color: 'CECCEB'
          description: 'Black ash / American elm / red maple'
          },
          {
          value: 702
          color: 'B1BEF2'
          description: 'River birch / sycamore'
          },
          {
          value: 703
          color: 'F077EF'
          description: 'Cottonwood'
          },
          {
          value: 704
          color: '969ACA'
          description: 'Willow'
          },
          {
          value: 705
          color: 'C4EC84'
          description: 'Sycamore / pecan / American elm'
          },
          {
          value: 706
          color: 'EFADEC'
          description: 'Sugarberry / hackberry / elm / green ash'
          },
          {
          value: 707
          color: 'DA23CF'
          description: 'Silver maple / American elm'
          },
          {
          value: 708
          color: 'E4C3C0'
          description: 'Red maple / lowland'
          },
          {
          value: 709
          color: 'BF90E1'
          description: 'Cottonwood / willow'
          },
          {
          value: 722
          color: '52F3EB'
          description: 'Oregon ash'
          },
          {
          value: 801
          color: 'A2C9EB'
          description: 'Sugar maple / beech / yellow birch'
          },
          {
          value: 802
          color: '3FF451'
          description: 'Black cherry'
          },
          {
          value: 805
          color: '6AB7F2'
          description: 'Hard maple / basswood'
          },
          {
          value: 809
          color: 'B3714C'
          description: 'Red maple / upland'
          },
          {
          value: 901
          color: 'D28F25'
          description: 'Aspen'
          },
          {
          value: 902
          color: 'F59550'
          description: 'Paper birch'
          },
          {
          value: 903
          color: 'DD82C7'
          description: 'Gray birch'
          },
          {
          value: 904
          color: 'C5F2A0'
          description: 'Balsam poplar'
          },
          {
          value: 905
          color: 'E3F2E7'
          description: 'Pin cherry'
          },
          {
          value: 911
          color: 'B2C2B1'
          description: 'Red alder'
          },
          {
          value: 912
          color: '4FF389'
          description: 'Bigleaf maple'
          },
          {
          value: 921
          color: '8772E8'
          description: 'Gray pine'
          },
          {
          value: 922
          color: 'BB24A1'
          description: 'California black oak'
          },
          {
          value: 923
          color: 'C7F7CD'
          description: 'Oregon white oak'
          },
          {
          value: 924
          color: '8FC3C6'
          description: 'Blue oak'
          },
          {
          value: 931
          color: 'F13896'
          description: 'Coast live oak'
          },
          {
          value: 933
          color: 'EFE92F'
          description: 'Canyon live oak'
          },
          {
          value: 934
          color: '6C48AE'
          description: 'Interior live oak'
          },
          {
          value: 935
          color: 'B3E8CD'
          description: 'California white oak (valley oak)'
          },
          {
          value: 941
          color: 'E8A882'
          description: 'Tanoak'
          },
          {
          value: 942
          color: 'B3E0F0'
          description: 'California laurel'
          },
          {
          value: 943
          color: '6A48DE'
          description: 'Giant chinkapin'
          },
          {
          value: 961
          color: 'C3AB6E'
          description: 'Pacific madrone'
          },
          {
          value: 962
          color: 'F5F169'
          description: 'Other hardwoods'
          },
          {
          value: 971
          color: 'F3C66F'
          description: 'Deciduous oak woodland'
          },
          {
          value: 972
          color: '4ECB89'
          description: 'Evergreen oak woodland'
          },
          {
          value: 973
          color: '60B0C2'
          description: 'Mesquite woodland'
          },
          {
          value: 974
          color: '76E45F'
          description: 'Cercocarpus (mountain brush) woodland'
          },
          {
          value: 975
          color: 'B3C5CE'
          description: 'Intermountain maple woodland'
          },
          {
          value: 976
          color: 'EE73AF'
          description: 'Miscellaneous woodland hardwoods'
          },
          {
          value: 982
          color: '9473B4'
          description: 'Mangrove'
          },
          {
          value: 983
          color: '80D9A8'
          description: 'Palms'
          },
          {
          value: 995
          color: 'E67774'
          description: 'Other exotic hardwoods'
          },
        ],
      },
      {
        name: 'FORTYPCD',
        description: |||
          Algorithm Forest Type Code - This is the forest type used for reporting purposes. It is primarily derived using a computer algorithm, except when less than 25 percent of the plot samples a particular forest condition or in a few other cases.
        |||,
        'gee:classes': [
          {
          value: 101
          color: '6E26EC'
          description: 'Jack pine'
          },
          {
          value: 102
          color: 'C765EC'
          description: 'Red pine'
          },
          {
          value: 103
          color: 'EFDBCC'
          description: 'Eastern white pine'
          },
          {
          value: 104
          color: 'A8A9F2'
          description: 'Eastern white pine / eastern hemlock'
          },
          {
          value: 105
          color: 'D0CE83'
          description: 'Eastern hemlock'
          },
          {
          value: 121
          color: '47D0B6'
          description: 'Balsam fir'
          },
          {
          value: 122
          color: '9D86A6'
          description: 'White spruce'
          },
          {
          value: 123
          color: 'A5F77A'
          description: 'Red spruce'
          },
          {
          value: 124
          color: 'DCF4D9'
          description: 'Red spruce / balsam fir'
          },
          {
          value: 125
          color: '64E1F7'
          description: 'Black spruce'
          },
          {
          value: 126
          color: 'AFA9B0'
          description: 'Tamarack'
          },
          {
          value: 127
          color: 'F2C531'
          description: 'Northern white-cedar'
          },
          {
          value: 141
          color: '84D7EB'
          description: 'Longleaf pine'
          },
          {
          value: 142
          color: 'EF4677'
          description: 'Slash pine'
          },
          {
          value: 161
          color: '97F2AD'
          description: 'Loblolly pine'
          },
          {
          value: 162
          color: 'D45549'
          description: 'Shortleaf pine'
          },
          {
          value: 163
          color: '63F3AC'
          description: 'Virginia pine'
          },
          {
          value: 164
          color: 'F58DE4'
          description: 'Sand pine'
          },
          {
          value: 165
          color: 'E9C991'
          description: 'Table Mountain pine'
          },
          {
          value: 166
          color: 'DDBEF2'
          description: 'Pond pine'
          },
          {
          value: 167
          color: 'BBA847'
          description: 'Pitch pine'
          },
          {
          value: 171
          color: '95EACD'
          description: 'Eastern redcedar'
          },
          {
          value: 182
          color: 'A6827B'
          description: 'Rocky Mountain juniper'
          },
          {
          value: 184
          color: 'BCA28A'
          description: 'Juniper woodland'
          },
          {
          value: 185
          color: 'CFF3F4'
          description: 'Pinyon / juniper woodland'
          },
          {
          value: 201
          color: 'C1DED5'
          description: 'Douglas-fir'
          },
          {
          value: 202
          color: '948EE9'
          description: 'Port-Orford-cedar'
          },
          {
          value: 221
          color: 'D0EF5B'
          description: 'Ponderosa pine'
          },
          {
          value: 222
          color: 'E29AF0'
          description: 'Incense-cedar'
          },
          {
          value: 224
          color: 'C34BC3'
          description: 'Sugar pine'
          },
          {
          value: 225
          color: 'E6ACB8'
          description: 'Jeffrey pine'
          },
          {
          value: 226
          color: 'EA3B34'
          description: 'Coulter pine'
          },
          {
          value: 241
          color: '724353'
          description: 'Western white pine'
          },
          {
          value: 261
          color: 'F2C7A0'
          description: 'White fir'
          },
          {
          value: 262
          color: '6AB27F'
          description: 'Red fir'
          },
          {
          value: 263
          color: 'F1F3D3'
          description: 'Noble fir'
          },
          {
          value: 264
          color: 'EA5ABA'
          description: 'Pacific silver fir'
          },
          {
          value: 265
          color: 'EDC7E1'
          description: 'Engelmann spruce'
          },
          {
          value: 266
          color: '4965E2'
          description: 'Engelmann spruce / subalpine fir'
          },
          {
          value: 267
          color: 'A0F4C4'
          description: 'Grand fir'
          },
          {
          value: 268
          color: '5697DE'
          description: 'Subalpine fir'
          },
          {
          value: 269
          color: '5DEFC4'
          description: 'Blue spruce'
          },
          {
          value: 270
          color: 'E8F384'
          description: 'Mountain hemlock'
          },
          {
          value: 271
          color: 'CC63BD'
          description: 'Alaska-yellow-cedar'
          },
          {
          value: 281
          color: 'E16F3D'
          description: 'Lodgepole pine'
          },
          {
          value: 301
          color: 'F5DA68'
          description: 'Western hemlock'
          },
          {
          value: 304
          color: 'A63BCF'
          description: 'Western redcedar'
          },
          {
          value: 305
          color: '51D0DD'
          description: 'Sitka spruce'
          },
          {
          value: 321
          color: '6BC5B6'
          description: 'Western larch'
          },
          {
          value: 341
          color: 'F2F4A5'
          description: 'Redwood'
          },
          {
          value: 361
          color: '576ABE'
          description: 'Knobcone pine'
          },
          {
          value: 362
          color: 'B56F7C'
          description: 'Southwestern white pine'
          },
          {
          value: 365
          color: 'DCA5CA'
          description: 'Foxtail pine / bristlecone pine'
          },
          {
          value: 366
          color: '67EFF4'
          description: 'Limber pine'
          },
          {
          value: 367
          color: 'CA5483'
          description: 'Whitebark pine'
          },
          {
          value: 368
          color: 'A8BF86'
          description: 'Miscellaneous western softwoods'
          },
          {
          value: 369
          color: 'AFF6E9'
          description: 'Western juniper'
          },
          {
          value: 371
          color: 'A53394'
          description: 'California mixed conifer'
          },
          {
          value: 381
          color: 'E9E2EB'
          description: 'Scotch pine'
          },
          {
          value: 383
          color: 'D0CFAD'
          description: 'Other exotic softwoods'
          },
          {
          value: 384
          color: 'EEE1B3'
          description: 'Norway spruce'
          },
          {
          value: 385
          color: 'E4DB79'
          description: 'Introduced larch'
          },
          {
          value: 401
          color: 'EC42F6'
          description: 'Eastern white pine / northern red oak / white ash'
          },
          {
          value: 402
          color: '7E9F81'
          description: 'Eastern redcedar / hardwood'
          },
          {
          value: 403
          color: '4A7196'
          description: 'Longleaf pine / oak'
          },
          {
          value: 404
          color: '5CD76E'
          description: 'Shortleaf pine / oak'
          },
          {
          value: 405
          color: '37999A'
          description: 'Virginia pine / southern red oak'
          },
          {
          value: 406
          color: 'ED54DD'
          description: 'Loblolly pine / hardwood'
          },
          {
          value: 407
          color: '6792F0'
          description: 'Slash pine / hardwood'
          },
          {
          value: 409
          color: '82EB3E'
          description: 'Other pine / hardwood'
          },
          {
          value: 501
          color: 'B8DB98'
          description: 'Post oak / blackjack oak'
          },
          {
          value: 502
          color: 'BCCC4B'
          description: 'Chestnut oak'
          },
          {
          value: 503
          color: 'F22AB1'
          description: 'White oak / red oak / hickory'
          },
          {
          value: 504
          color: 'F6E095'
          description: 'White oak'
          },
          {
          value: 505
          color: '77989D'
          description: 'Northern red oak'
          },
          {
          value: 506
          color: '718640'
          description: 'Yellow-poplar / white oak / northern red oak'
          },
          {
          value: 507
          color: '9D4F8D'
          description: 'Sassafras / persimmon'
          },
          {
          value: 508
          color: 'C376E4'
          description: 'Sweetgum / yellow-poplar'
          },
          {
          value: 509
          color: '7CB133'
          description: 'Bur oak'
          },
          {
          value: 510
          color: '5FA7CC'
          description: 'Scarlet oak'
          },
          {
          value: 511
          color: '9AE6E8'
          description: 'Yellow-poplar'
          },
          {
          value: 512
          color: 'DEF3B1'
          description: 'Black walnut'
          },
          {
          value: 513
          color: 'B88BF2'
          description: 'Black locust'
          },
          {
          value: 514
          color: 'A5F031'
          description: 'Southern scrub oak'
          },
          {
          value: 515
          color: 'EEAFA3'
          description: 'Chestnut oak / black oak / scarlet oak'
          },
          {
          value: 516
          color: '9BD763'
          description: 'Cherry / white ash / yellow-poplar'
          },
          {
          value: 517
          color: 'B838EE'
          description: 'Elm / ash / black locust'
          },
          {
          value: 519
          color: 'E88FBB'
          description: 'Red maple / oak'
          },
          {
          value: 520
          color: 'CCE5B9'
          description: 'Mixed upland hardwoods'
          },
          {
          value: 601
          color: 'ED8A9C'
          description: 'Swamp chestnut oak / cherrybark oak'
          },
          {
          value: 602
          color: 'C8ED2D'
          description: 'Sweetgum / Nuttall oak / willow oak'
          },
          {
          value: 605
          color: 'F0BD53'
          description: 'Overcup oak / water hickory'
          },
          {
          value: 606
          color: '60DAD1'
          description: 'Atlantic white-cedar'
          },
          {
          value: 607
          color: 'C790C1'
          description: 'Baldcypress / water tupelo'
          },
          {
          value: 608
          color: '54C7EF'
          description: 'Sweetbay / swamp tupelo / red maple'
          },
          {
          value: 609
          color: '8E6A31'
          description: 'Baldcypress / pondcypress'
          },
          {
          value: 701
          color: 'CECCEB'
          description: 'Black ash / American elm / red maple'
          },
          {
          value: 702
          color: 'B1BEF2'
          description: 'River birch / sycamore'
          },
          {
          value: 703
          color: 'F077EF'
          description: 'Cottonwood'
          },
          {
          value: 704
          color: '969ACA'
          description: 'Willow'
          },
          {
          value: 705
          color: 'C4EC84'
          description: 'Sycamore / pecan / American elm'
          },
          {
          value: 706
          color: 'EFADEC'
          description: 'Sugarberry / hackberry / elm / green ash'
          },
          {
          value: 707
          color: 'DA23CF'
          description: 'Silver maple / American elm'
          },
          {
          value: 708
          color: 'E4C3C0'
          description: 'Red maple / lowland'
          },
          {
          value: 709
          color: 'BF90E1'
          description: 'Cottonwood / willow'
          },
          {
          value: 722
          color: '52F3EB'
          description: 'Oregon ash'
          },
          {
          value: 801
          color: 'A2C9EB'
          description: 'Sugar maple / beech / yellow birch'
          },
          {
          value: 802
          color: '3FF451'
          description: 'Black cherry'
          },
          {
          value: 805
          color: '6AB7F2'
          description: 'Hard maple / basswood'
          },
          {
          value: 809
          color: 'B3714C'
          description: 'Red maple / upland'
          },
          {
          value: 901
          color: 'D28F25'
          description: 'Aspen'
          },
          {
          value: 902
          color: 'F59550'
          description: 'Paper birch'
          },
          {
          value: 903
          color: 'DD82C7'
          description: 'Gray birch'
          },
          {
          value: 904
          color: 'C5F2A0'
          description: 'Balsam poplar'
          },
          {
          value: 905
          color: 'E3F2E7'
          description: 'Pin cherry'
          },
          {
          value: 911
          color: 'B2C2B1'
          description: 'Red alder'
          },
          {
          value: 912
          color: '4FF389'
          description: 'Bigleaf maple'
          },
          {
          value: 921
          color: '8772E8'
          description: 'Gray pine'
          },
          {
          value: 922
          color: 'BB24A1'
          description: 'California black oak'
          },
          {
          value: 923
          color: 'C7F7CD'
          description: 'Oregon white oak'
          },
          {
          value: 924
          color: '8FC3C6'
          description: 'Blue oak'
          },
          {
          value: 931
          color: 'F13896'
          description: 'Coast live oak'
          },
          {
          value: 933
          color: 'EFE92F'
          description: 'Canyon live oak'
          },
          {
          value: 934
          color: '6C48AE'
          description: 'Interior live oak'
          },
          {
          value: 935
          color: 'B3E8CD'
          description: 'California white oak (valley oak)'
          },
          {
          value: 941
          color: 'E8A882'
          description: 'Tanoak'
          },
          {
          value: 942
          color: 'B3E0F0'
          description: 'California laurel'
          },
          {
          value: 943
          color: '6A48DE'
          description: 'Giant chinkapin'
          },
          {
          value: 961
          color: 'C3AB6E'
          description: 'Pacific madrone'
          },
          {
          value: 962
          color: 'F5F169'
          description: 'Other hardwoods'
          },
          {
          value: 971
          color: 'F3C66F'
          description: 'Deciduous oak woodland'
          },
          {
          value: 972
          color: '4ECB89'
          description: 'Evergreen oak woodland'
          },
          {
          value: 973
          color: '60B0C2'
          description: 'Mesquite woodland'
          },
          {
          value: 974
          color: '76E45F'
          description: 'Cercocarpus (mountain brush) woodland'
          },
          {
          value: 975
          color: 'B3C5CE'
          description: 'Intermountain maple woodland'
          },
          {
          value: 976
          color: 'EE73AF'
          description: 'Miscellaneous woodland hardwoods'
          },
          {
          value: 982
          color: '9473B4'
          description: 'Mangrove'
          },
          {
          value: 983
          color: '80D9A8'
          description: 'Palms'
          },
          {
          value: 991
          color: 'E6A25E'
          description: 'Paulownia'
          },
          {
          value: 992
          color: 'F8F3B7'
          description: 'Melaleuca'
          },
          {
          value: 995
          color: 'E67774'
          description: 'Other exotic hardwoods'
          },
          {
          value: 999
          color: 'D5CC36'
          description: 'Nonstocked'
          },
        ],
      },
      {
        name: 'GSSTK',
        description: |||
          Growing-Stock Stocking (percent) - The sum of stocking percent values of all growing-stock trees on the condition.
        |||,
      },
      {
        name: 'QMD_RMRS',
        description: |||
          Stand Quadratic Mean Diameter (inches) - Rocky Mountain Research Station. The quadratic mean diameter, or the diameter of the tree of average basal area, on the condition. Based on live trees ≥1.0 inch d.b.h./d.r.c. Only collected by certain FIA work units.
        |||,
      },
      {
        name: 'SDIPCT_RMRS',
        description: |||
          Stand Density Index (percent of maximum) - Rocky Mountain Research Station. A relative measure of stand density for live trees (≥1.0 inch d.b.h./d.r.c.) on the condition, expressed as a percentage of the maximum stand density index (SDI). Only collected by certain FIA work units.
        |||,
      },
      {
        name: 'STANDHT',
        description: |||
          Height of dominant trees (feet) - Derived from the Forest Vegetation Simulator.
        |||,
      },
      {
        name: 'STDSZCD',
        description: |||
          Algorithm Stand-Size Class Code - A classification of the predominant (based on stocking) diameter class of live trees within the condition assigned using an algorithm.
        |||,
        'gee:classes': [
          {
            value: 1,
            color: '38A800',
            description: 'Large diameter - Stands with an all live stocking value of at least 10 (base 100); with more than 50 percent of the stocking in medium and large diameter trees; and with the stocking of large diameter trees equal to or greater than the stocking of medium diameter trees.',
          },
          {
            value: 2,
            color: 'FFFF00',
            description: 'Medium diameter - Stands with an all live stocking value of at least 10 (base 100); with more than 50 percent of the stocking in medium and large diameter trees; and with the stocking of large diameter trees less than the stocking of medium diameter trees.',
          },
          {
            value: 3,
            color: 'FEBA12',
            description: 'Small diameter - Stands with an all live stocking value of at least 10 (base 100) on which at least 50 percent of the stocking is in small diameter trees.',
          },
          {
            value: 5,
            color: 'C62363',
            description: 'Nonstocked - Forest land with all live stocking value less than 10.',
          },
        ],
      },
      {
        name: 'TPA_DEAD',
        description: |||
          Dead Trees Per Acre - Number of dead standing trees per acre (DIA >= 5”). Calculated via the following FIA query: Sum TREE.TPA_UNADJ WHERE (((COND.COND_STATUS_CD)=1) AND ((TREE.STATUSCD)=2) AND ((TREE.DIA)>=5) AND ((TREE.STANDING_DEAD_CD)=1)) 
        |||,
      }, 
      {
        name: 'TPA_LIVE',
        description: |||
          Live Trees Per Acre - Number of live trees per acre (DIA > 1"). Calculated via the following FIA query: Sum TREE.TPA_UNADJ WHERE (((COND.COND_STATUS_CD)=1) AND ((TREE.STATUSCD)=1) AND ((TREE.DIA)>=1)) 
        |||,
      },
      {
        name: 'Value',
        description: |||
          Raw TreeMap record number.
        |||,
      },
      {
        name: 'VOLBFNET_L',
        description: |||
          Volume, Live (sawlog board feet per acre) (log rule: Int’l ¼ inch) - Calculated via the following FIA query: Sum VOLBFNET * TPA_UNADJ WHERE (((TREE.TREECLCD)=2) AND ((COND.COND_STATUS_CD)=1) AND ((TREE.STATUSCD)=1)) 
        |||,
      },
      {
        name: 'VOLCFNET_D',
        description: |||
          Volume, Standing Dead (cubic feet per acre) - Calculated via the following FIA query: Sum VOLCFNET*TPA_UNADJ WHERE (((COND.COND_STATUS_CD)=1) AND ((TREE.STATUSCD)=2) AND ((TREE.DIA)>=5) AND ((TREE.STANDING_DEAD_CD)=1))
        |||,
      },   
      {
        name: 'VOLCFNET_L',
        description: |||
          Volume, Live (cubic feet per acre) - Calculated via the following FIA query: Sum VOLCFNET*TPA_UNADJ WHERE (((COND.COND_STATUS_CD)=1) AND ((TREE.STATUSCD)=1))
        |||,
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
              'FFE599',
              'E7CD68',
              'C5AE32',
              '969206',
              '71870B',
              '52741C',
              '3A652A',
              '265737',
              '134B42',
              '00404D'
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
              'FFE599',
              'E7CD68',
              'C5AE32',
              '969206',
              '71870B',
              '52741C',
              '3A652A',
              '265737',
              '134B42',
              '00404D'
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
              'FFE599',
              'E7CD68',
              'C5AE32',
              '969206',
              '71870B',
              '52741C',
              '3A652A',
              '265737',
              '134B42',
              '00404D'
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
            'FFFFCC',
            'FBEC9A',
            'F4CC68',
            'ECA855',
            'E48751',
            'D2624D',
            'A54742',
            '73382F',
            '422818',
            '1A1A01'
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
            'FFFFCC',
            'FBEC9A',
            'F4CC68',
            'ECA855',
            'E48751',
            'D2624D',
            'A54742',
            '73382F',
            '422818',
            '1A1A01'
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
            '1A1A01',
            '422818',
            '73382F',
            'A54742',
            'D2624D',
            'E48751',
            'ECA855',
            'F4CC68',
            'FBEC9A',
            'FFFFCC'
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
            'FFFFCC',
            'FBEC9A',
            'F4CC68',
            'ECA855',
            'E48751',
            'D2624D',
            'A54742',
            '73382F',
            '422818',
            '1A1A01'
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
            '1A1A01',
            '422818',
            '73382F',
            'A54742',
            'D2624D',
            'E48751',
            'ECA855',
            'F4CC68',
            'FBEC9A',
            'FFFFCC'
            ],
            bands: [
              'DRYBIO_L',
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
              'FFE599',
              'E7CD68',
              'C5AE32',
              '969206',
              '71870B',
              '52741C',
              '3A652A',
              '265737',
              '134B42',
              '00404D'
            ],
            bands: [
              'GSSTK',
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
              'FFE599',
              'E7CD68',
              'C5AE32',
              '969206',
              '71870B',
              '52741C',
              '3A652A',
              '265737',
              '134B42',
              '00404D'
            ],
            bands: [
              'QMD_RMRS',
            ],
          },
        },
      },
      {
        display_name: 'SDIPCT_Viz',
        lookat: {
          lat: 38,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              6,
            ],
            max: [
              99,
            ],
            palette: [
              'FFE599',
              'E7CD68',
              'C5AE32',
              '969206',
              '71870B',
              '52741C',
              '3A652A',
              '265737',
              '134B42',
              '00404D'
            ],
            bands: [
              'SDIPCT_RMR',
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
              'FFE599',
              'E7CD68',
              'C5AE32',
              '969206',
              '71870B',
              '52741C',
              '3A652A',
              '265737',
              '134B42',
              '00404D'
            ],
            bands: [
              'STANDHT',
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
            '00404D',
            '134B42',
            '265737',
            '3A652A',
            '52741C',
            '71870B',
            '969206',
            'C5AE32',
            'E7CD68',
            'FFE599'
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
              'FFE599',
              'E7CD68',
              'C5AE32',
              '969206',
              '71870B',
              '52741C',
              '3A652A',
              '265737',
              '134B42',
              '00404D'
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
            'FFFF66',
            'C4EA67',
            '98CB6D',
            '7BAE74',
            '60927B',
            '497B85',
            '396B94',
            '2E599F',
            '2446A9',
            '1A33B3'
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
            'FFFF66',
            'C4EA67',
            '98CB6D',
            '7BAE74',
            '60927B',
            '497B85',
            '396B94',
            '2E599F',
            '2446A9',
            '1A33B3'
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
            'FFFF66',
            'C4EA67',
            '98CB6D',
            '7BAE74',
            '60927B',
            '497B85',
            '396B94',
            '2E599F',
            '2446A9',
            '1A33B3'
            ],
            bands: [
              'VOLCFNET_L',
            ],
          },
        },
      },
    ],
  },
  },
  'sci:citation': |||
    Riley, Karin L.; Grenfell, Isaac C.; Finney, Mark A.; Shaw, John D. 2021. TreeMap 2016: A tree-level model of the forests of the conterminous United States circa 2016. Fort Collins, CO: Forest Service Research Data Archive. https://doi.org/10.2737/RDS-2021-0074.
  |||,
  'gee:terms_of_use': |||
    The USDA Forest Service makes no warranty, expressed or implied, including the warranties of
    merchantability and fitness for a particular purpose, nor assumes any legal liability or
    responsibility for the accuracy, reliability, completeness or utility of these geospatial data,
    or for the improper or incorrect use of these geospatial data. These geospatial data and
    related maps or graphics are not legal documents and are not intended to be used as such. The
    data and maps may not be used to determine title, ownership, legal descriptions or boundaries,
    legal jurisdiction, or restrictions that may be in place on either public or private land.
    Natural hazards may or may not be depicted on the data and maps, and land users should exercise
    due caution. The data are dynamic and may change over time. The user is responsible to verify
    the limitations of the geospatial data and to use the data accordingly.

    These data were collected using funding from the U.S. Government and can be used
    without additional permissions or fees. If you use these data in a publication, presentation, or
    other research product please use the following citation:

    Riley, Karin L.; Grenfell, Isaac C.; Finney, Mark A.; Shaw, John D. 2021. TreeMap 2016: A tree-level model of the forests of the conterminous United States circa 2016. Fort Collins, CO: Forest Service Research Data Archive. https://doi.org/10.2737/RDS-2021-0074.
  |||,
  'gee:user_uploaded': true,
}
