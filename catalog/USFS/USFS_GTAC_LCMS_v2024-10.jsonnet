local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local versions = import 'versions.libsonnet';
local version_table = import 'USFS_GTAC_LCMS_versions.libsonnet';

local subdir = 'USFS';
local id = 'USFS/GTAC/LCMS/v2024-10';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'USFS Landscape Change Monitoring System ' + ' ' + version + ' ' +
    '(CONUS and OCONUS)',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This product is part of the Landscape Change Monitoring System (LCMS) data suite.
    It shows LCMS-modeled change, land cover, and/or land use classes for each year and
    covers the Conterminous United States (CONUS) as well as areas outside the CONUS (OCONUS)
    including Alaska (AK), Puerto Rico-US Virgin Islands (PRUSVI), and Hawaii (HI). PRUSVI and HI
    v2024.10 data will be released late summer 2025. For now v2023.9 PRUSVI and HI LCMS data can
    be used (USFS/GTAC/LCMS/v2023-9).

    LCMS is a remote sensing-based system for mapping and monitoring landscape change across the
    United States. Its objective is to develop a consistent approach using the latest technology
    and advancements in change detection to produce a "best available" map of landscape change.

    Outputs include three annual products: change, land cover, and land use. The change model output relates specifically to vegetation cover and includes slow loss, fast loss (which also includes hydrologic changes such as inundation or desiccation), and gain. These values are predicted for each year of the Landsat time series and serve as the foundational products for LCMS. We apply a ruleset based on ancillary datasets to create the final change product, which is a
    refinement/reclassification of the modeled change to 15 classes that explicitly provide information on the cause of landscape change (e.g., Tree Removal, Wildfire, Wind damage). Land cover and land use maps depict life-form level land cover and broad-level land use for each year.

    Because no algorithm performs best in all situations, LCMS uses an ensemble of models as
    predictors, which improves map accuracy across a range of ecosystems and change processes
    (Healey et al., 2018). The resulting suite of LCMS change, land cover, and land use maps offer
    a holistic depiction of landscape change across the United States since 1985.

    Predictor layers for the LCMS model include outputs from the LandTrendr and CCDC change detection
    algorithms, and terrain information. These components are all accessed and processed using Google
    Earth Engine (Gorelick et al., 2017).

    To produce annual composites for LandTrendr, USGS Collection 2 Landsat Tier 1 and Sentinel 2A,
    2B Level-1C top of atmosphere reflectance data were used. The cFmask cloud masking algorithm
    (Foga et al., 2017), which is an implementation of Fmask 2.0 (Zhu and Woodcock, 2012)
    (Landsat-only), cloudScore (Chastain et al., 2019) (Landsat-only), s2cloudless
    (Sentinel-Hub, 2021) and Cloud Score plus (Pasquarella et al., 2023) (Sentinel 2-only) are
    used to mask clouds, while TDOM (Chastain et al., 2019) is used to mask cloud shadows (Landsat and Sentinel
    2). For LandTrendr, the annual medoid is then computed to summarize cloud and cloud shadow-free values
    from each year into a single composite. For CCDC, United States Geological Survey (USGS) Collection 2
    Landsat Tier 1 surface reflectance data were used for the CONUS, and Landsat Tier 1 top of atmosphere
    reflectance data for AK, PRUSVI, and HI.

    The composite time series is temporally segmented using LandTrendr
    (Kennedy et al., 2010; Kennedy et al., 2018; Cohen et al., 2018).

    All cloud and cloud shadow free values are also temporally segmented using the CCDC algorithm
    (Zhu and Woodcock, 2014).

    Predictor data include raw composite values, LandTrendr fitted values, pair-wise differences,
    segment duration, change magnitude, and slope, and CCDC sine and
    cosine coefficients (first 3 harmonics), fitted values, and pairwise
    differences, along with elevation, slope, sine of aspect, cosine of aspect,
    and topographic position indices (Weiss, 2001) from the 10 m USGS 3D Elevation
    Program (3DEP) data (U.S. Geological Survey, 2019).

    Reference data are collected using TimeSync, a web-based tool that helps
    analysts visualize and interpret the Landsat data record from 1984-present (Cohen et al., 2010).

    Random Forest models (Breiman, 2001) were trained using reference data from TimeSync and predictor data
    from LandTrendr, CCDC, and terrain indices to predict annual change, land cover, and land use classes.
    Following modeling, we institute a series of probability thresholds and rulesets using ancillary datasets
    to improve qualitative map outputs and reduce commission and omission. More information can be found in
    the LCMS Methods Brief included in the Description.

    **Additional Resources**

    * [A more detailed code example of using LCMS data](https://github.com/google/earthengine-community/blob/master/datasets/scripts/LCMS_Visualization.js).

    * The [LCMS Data Explorer](https://apps.fs.usda.gov/lcms-viewer) is a web-based application that
      provides users the ability to view, analyze, summarize and download LCMS data.

    * Please see the [LCMS Methods Brief](https://data.fs.usda.gov/geodata/rastergateway/LCMS/LCMS_v2024-10_Methods.pdf)
      for more detailed information regarding methods and accuracy assessment, or the
      [LCMS Geodata Clearinghouse](https://data.fs.usda.gov/geodata/rastergateway/LCMS/index.php)
      for data downloads, metadata, and support documents.

    * PRUSVI and HI data will be released late summer 2025. Previously released v2023.9 PRUSVI and HI LCMS data are available
    (USFS/GTAC/LCMS/v2023-9)

    Contact [sm.fs.lcms@usda.gov] with any
    questions or specific data requests.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.source,
      href: 'https://data.fs.usda.gov/geodata/rastergateway/LCMS/index.php',
    },
  ] + version_config.version_links,
  'gee:categories': ['landuse-landcover'],
  keywords: [
    'lcms',
    'usda',
    'usfs',
    'change_detection',
    'landcover',
    'landuse',
    'forest',
    'gtac',
    'redcastle_resources',
  ],
  providers: [
    ee.producer_provider('USDA Forest Service (USFS) Field Services and Innovation Center Geospatial Office (FSIC-GO)', 'https://apps.fs.usda.gov/lcms-viewer/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-135.286387, 20.38379, -56.446306, 52.459364,
                    '1985-01-01T00:00:00Z', '2024-12-31T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'study_area',
        description: |||
          LCMS currently covers the conterminous United States, Alaska,
          Puerto Rico-US Virgin Islands, and Hawaii. This version contains CONUS. The
          data for AK, PRUSVI, and HI will be released late summer 2025.
          Possible values: 'CONUS, AK'
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'version',
        description: 'Version of the product',
        type: ee_const.var_type.string,
      },
      {
        name: 'startYear',
        description: 'Start year of the product',
        type: ee_const.var_type.int,
      },
      {
        name: 'endYear',
        description: 'End year of the product',
        type: ee_const.var_type.int,
      },
      {
        name: 'year',
        description: 'Year of the product',
        type: ee_const.var_type.int,
      },
    ],
    gsd: [30],
    'eo:bands': [
      {
        name: 'Change',
        description: |||
          Final thematic LCMS change product. A total of fifteen change classes are mapped for each year. Foundationally, change is modeled with three separate binary Random Forest models for each study area: slow loss, fast loss, and gain. Each pixel is assigned to the modeled change class with the highest probability that is also above a specified threshold. Any pixel that does not have any value above each class's respective threshold is assigned to the Stable class. Following a ruleset using the modeled change class, ancillary datasets (such as TCC, MTBS, and IDS), and LCMS Land Cover data, one of the 15 refined, cause of change classes is assigned to each pixel. See the LCMS Methods Brief linked to in the Description for full details on the ruleset and the ancillary datasets used.
        |||,
        'gee:classes': [
          {
            value: 1,
            color: 'ff09f3',
            description: 'Wind',
          },
          {
            value: 2,
            color: '541aff',
            description: 'Hurricane',
          },
          {
            value: 3,
            color: 'e4f5fd',
            description: 'Snow or Ice Transition',
          },
                    {
            value: 4,
            color: 'cc982e',
            description: 'Desiccation',
          },
                    {
            value: 5,
            color: '0adaff',
            description: 'Inundation',
          },
                    {
            value: 6,
            color: 'a10018',
            description: 'Prescribed Fire',
          },
                    {
            value: 7,
            color: 'd54309',
            description: 'Wildfire',
          },
                    {
            value: 8,
            color: 'fafa4b',
            description: 'Mechanical Land Transformation',
          },
                    {
            value: 9,
            color: 'afde1c',
            description: 'Tree Removal',
          },
                    {
            value: 10,
            color: 'ffc80d',
            description: 'Defoliation',
          },
                    {
            value: 11,
            color: 'a64c28',
            description: 'Southern Pine Beetle',
          },
                    {
            value: 12,
            color: 'f39268',
            description: 'Insect, Disease, or Drought Stress',
          },
                    {
            value: 13,
            color: 'c291d5',
            description: 'Other Loss',
          },
          {
            value: 14,
            color: '00a398',
            description: 'Vegetation Successional Growth',
          },
          {
            value: 15,
            color: '3d4551',
            description: 'Stable',
          },
          {
            value: 16,
            color: '1b1716',
            description: 'Non-Processing Area Mask',
          },
        ],
      },
      {
        name: 'Land_Cover',
        description: |||
          Final thematic LCMS land cover product. A total of 14 land cover classes are mapped on an
          annual basis using TimeSync reference data and spectral information derived from Landsat
          imagery. Land cover is predicted using a single multiclass Random Forest model, which outputs an array of the probabilities of each class (proportion of the trees within the Random Forest model that 'chose' each class). Final classes are assigned to the land use with the highest probability. Prior to assigning the land cover class with the highest probability, depending on the study area, one to several probability thresholds and rulesets using ancillary datasets were applied. More information on the probability thresholds and rulesets can be found in the LCMS Methods Brief linked to in the Description. Seven land cover classes indicate a single land cover, where that land cover type covers most of the pixel's area and no other class covers more than 10% of the pixel. There are also seven mixed classes. These represent pixels in which an additional land cover class covers at least 10% of the pixel.
        |||,
        'gee:classes': [
          {
            value: 1,
            color: '004e2b',
            description: 'Trees',
          },
          {
            value: 2,
            color: '009344',
            description: 'Tall Shrubs & Trees Mix (AK Only)',
          },
          {
            value: 3,
            color: '61bb46',
            description: 'Shrubs & Trees Mix',
          },
          {
            value: 4,
            color: 'acbb67',
            description: 'Grass/Forb/Herb & Trees Mix',
          },
          {
            value: 5,
            color: '8b8560',
            description: 'Barren & Trees Mix',
          },
          {
            value: 6,
            color: 'cafd4b',
            description: 'Tall Shrubs (AK Only)',
          },
          {
            value: 7,
            color: 'f89a1c',
            description: 'Shrubs',
          },
          {
            value: 8,
            color: '8fa55f',
            description: 'Grass/Forb/Herb & Shrubs Mix',
          },
          {
            value: 9,
            color: 'bebb8e',
            description: 'Barren & Shrubs Mix',
          },
          {
            value: 10,
            color: 'e5e98a',
            description: 'Grass/Forb/Herb',
          },
          {
            value: 11,
            color: 'ddb925',
            description: 'Barren & Grass/Forb/Herb Mix',
          },
          {
            value: 12,
            color: '893f54',
            description: 'Barren or Impervious',
          },
          {
            value: 13,
            color: 'e4f5fd',
            description: 'Snow or Ice',
          },
          {
            value: 14,
            color: '00b6f0',
            description: 'Water',
          },
          {
            value: 15,
            color: '1b1716',
            description: 'Non-Processing Area Mask',
          },
        ],
      },
      {
        name: 'Land_Use',
        description: |||
          Final thematic LCMS land use product. A total of 5 land use classes are mapped on an annual basis using TimeSync reference data and spectral information derived from Landsat imagery. Land use is predicted using a single multiclass Random Forest model, which outputs an array of the probabilities of each class (proportion of the trees within the Random Forest model that 'chose' each class). Final classes are assigned to the land use with the highest probability. Prior to assigning the land use class with the highest probability, a series of probability thresholds and rulesets using ancillary datasets were applied. More information on the probability thresholds and rulesets can be found in the LCMS Methods Brief linked to in the Description.
        |||,
        'gee:classes': [
          {
            value: 1,
            color: 'fbff97',
            description: 'Agriculture',
          },
          {
            value: 2,
            color: 'e6558b',
            description: 'Developed',
          },
          {
            value: 3,
            color: '004e2b',
            description: 'Forest',
          },
          {
            value: 4,
            color: '9dbac5',
            description: 'Other',
          },
          {
            value: 5,
            color: 'a6976a',
            description: 'Rangeland or Pasture',
          },
          {
            value: 6,
            color: '1b1716',
            description: 'Non-Processing Area Mask',
          },
        ],
      },
      {
        name: 'Change_Raw_Probability_Slow_Loss',
        description: |||
          Raw LCMS modeled probability of Slow Loss. Slow Loss includes the following
          classes from the TimeSync change process interpretation:

            * Structural Decline - Land where trees or other woody vegetation is physically altered by
            unfavorable growing conditions brought on by non-anthropogenic or non-mechanical factors.
            This type of loss should generally create a trend in the spectral signal(s) (e.g. NDVI
            decreasing, Wetness decreasing; SWIR increasing; etc.) however the trend can be subtle.
            Structural decline occurs in woody vegetation environments, most likely from insects,
            disease, drought, acid rain, etc. Structural decline can include defoliation events that do
            not result in mortality such as in Gypsy moth and spruce budworm infestations which may
            recover within 1 or 2 years.

            * Spectral Decline - A plot where the spectral signal shows a
            trend in one or more of the spectral bands or indices (e.g. NDVI decreasing, Wetness
            decreasing; SWIR increasing; etc.). Examples include cases where: a) non-forest/non-woody
            vegetation shows a trend suggestive of decline (e.g. NDVI decreasing, Wetness decreasing;
            SWIR increasing; etc.), or b) where woody vegetation shows a decline trend which is not
            related to the loss of woody vegetation, such as when mature tree canopies close resulting
            in increased shadowing, when species composition changes from conifer to hardwood, or when
            a dry period (as opposed to stronger, more acute drought) causes an apparent decline in
            vigor, but no loss of woody material or leaf area.
        |||,
      },
      {
        name: 'Change_Raw_Probability_Fast_Loss',
        description: |||
          Raw LCMS modeled probability of Fast Loss. Fast Loss includes the following
          classes from the TimeSync change process interpretation:

          * Fire - Land altered by fire, regardless of the cause of the ignition (natural or
          anthropogenic), severity, or land use.

          * Harvest - Forest land where trees, shrubs or other vegetation have been severed or removed
          by anthropogenic means. Examples include clearcutting, salvage logging after fire or insect
          outbreaks, thinning and other forest management prescriptions (e.g. shelterwood/seedtree
          harvest).

          * Mechanical - Non-forest land where trees, shrubs or other vegetation has been mechanically
          severed or removed by chaining, scraping, brush sawing, bulldozing, or any other methods of
          non-forest vegetation removal.

          * Wind/ice - Land (regardless of use) where vegetation is altered by wind from hurricanes,
          tornados, storms and other severe weather events including freezing rain from ice
          storms.

          * Hydrology - Land where flooding has significantly altered woody cover or other Land cover
          elements regardless of land use (e.g. new mixtures of gravel and vegetation in and around
          streambeds after a flood).

          * Debris - Land (regardless of use) altered by natural material movement associated with
          landslides, avalanches, volcanos, debris flows, etc.

          * Other - Land (regardless of use) where the spectral trend or other supporting evidence
          suggests a disturbance or change event has occurred but the definitive cause cannot be
          determined or the type of change fails to meet any of the change process categories defined
          above.
        |||,
      },
      {
        name: 'Change_Raw_Probability_Gain',
        description: |||
          Raw LCMS modeled probability of Gain. Defined as: Land exhibiting an increase in vegetation
          cover due to growth and succession over one or more years. Applicable to any areas that may
          express spectral change associated with vegetation regrowth. In developed areas, growth can
          result from maturing vegetation and/or newly installed lawns and landscaping. In forests,
          growth includes vegetation growth from bare ground, as well as the over topping of
          intermediate and co-dominate trees and/or lower-lying grasses and shrubs. Growth/Recovery
          segments recorded following forest harvest will likely transition through different land
          cover classes as the forest regenerates. For these changes to be considered growth/recovery,
          spectral values should closely adhere to an increasing trend line (e.g. a positive slope
          that would, if extended to ~20 years, be on the order of .10 units of NDVI) which persists
          for several years.
        |||,
      },
      {
        name: 'Land_Cover_Raw_Probability_Trees',
        description: |||
          Raw LCMS modeled probability of Trees. Defined as: The majority of the pixel is comprised
          of live or standing dead trees.
        |||,
      },
      {
        name: 'Land_Cover_Raw_Probability_Tall-Shrubs-and-Trees-Mix',
        description: |||
          Raw LCMS modeled probability of Tall Shrubs and Trees Mix (AK Only). Defined
          as: The majority of the pixel is comprised of shrubs greater than 1m in height and is also
          comprised of at least 10% live or standing dead trees.
        |||,
      },
      {
        name: 'Land_Cover_Raw_Probability_Shrubs-and-Trees-Mix',
        description: |||
          Raw LCMS modeled probability of Shrubs and Trees Mix. Defined as: The majority of the pixel
          is comprised of shrubs and is also comprised of at least 10% live or standing dead trees.
        |||,
      },
      {
        name: 'Land_Cover_Raw_Probability_Grass-Forb-Herb-and-Trees-Mix',
        description: |||
          Raw LCMS modeled probability of Grass/Forb/Herb and Trees Mix. Defined as: The majority of
          the pixel is comprised of perennial grasses, forbs, or other forms of herbaceous vegetation
          and is also comprised of at least 10% live or standing dead trees.
        |||,
      },
      {
        name: 'Land_Cover_Raw_Probability_Barren-and-Trees-Mix',
        description: |||
          Raw LCMS modeled probability of Barren and Trees Mix. Defined as: The majority of the pixel
          is comprised of bare soil exposed by disturbance (e.g., soil uncovered by mechanical
          clearing or forest harvest), as well as perennially barren areas such as deserts, playas,
          rock outcroppings (including minerals and other geologic materials exposed by surface mining
          activities), sand dunes, salt flats, and beaches. Roads made of dirt and gravel are also
          considered barren and is also comprised of at least 10% live or standing dead trees.
        |||,
      },
      {
        name: 'Land_Cover_Raw_Probability_Tall-Shrubs',
        description: |||
          Raw LCMS modeled probability of Tall Shrubs (AK Only). Defined as: The majority of the
          pixel is comprised of shrubs greater than 1m in height.
        |||,
      },
      {
        name: 'Land_Cover_Raw_Probability_Shrubs',
        description: |||
          Raw LCMS modeled probability of Shrubs. Defined as: The majority of the pixel is comprised
          of shrubs.
        |||,
      },
      {
        name: 'Land_Cover_Raw_Probability_Grass-Forb-Herb-and-Shrubs-Mix',
        description: |||
          Raw LCMS modeled probability of Grass/Forb/Herb and Shrubs Mix. Defined as: The majority of
          the pixel is comprised of perennial grasses, forbs, or other forms of herbaceous vegetation
          and is also comprised of at least 10% shrubs.
        |||,
      },
      {
        name: 'Land_Cover_Raw_Probability_Barren-and-Shrubs-Mix',
        description: |||
          Raw LCMS modeled probability of Barren and Shrubs Mix. Defined as: The majority of the pixel
          is comprised of bare soil exposed by disturbance (e.g., soil uncovered by mechanical
          clearing or forest harvest), as well as perennially barren areas such as deserts, playas,
          rock outcroppings (including minerals and other geologic materials exposed by surface mining
          activities), sand dunes, salt flats, and beaches. Roads made of dirt and gravel are also
          considered barren and is also comprised of at least 10% shrubs.
        |||,
      },
      {
        name: 'Land_Cover_Raw_Probability_Grass-Forb-Herb',
        description: |||
          Raw LCMS modeled probability of Grass/Forb/Herb. Defined as: The majority of the pixel is
          comprised of perennial grasses, forbs, or other forms of herbaceous vegetation.
        |||,
      },
      {
        name: 'Land_Cover_Raw_Probability_Barren-and-Grass-Forb-Herb-Mix',
        description: |||
          Raw LCMS modeled probability of Barren and Grass/Forb/Herb Mix. Defined as: The majority of
          the pixel is comprised of bare soil exposed by disturbance (e.g., soil uncovered by
          mechanical clearing or forest harvest), as well as perennially barren areas such as deserts,
          playas, rock outcroppings (including minerals and other geologic materials exposed by
          surface mining activities), sand dunes, salt flats, and beaches. Roads made of dirt and
          gravel are also considered barren and is also comprised of at least 10% perennial grasses,
          forbs, or other forms of herbaceous vegetation.
        |||,
      },
      {
        name: 'Land_Cover_Raw_Probability_Barren-or-Impervious',
        description: |||
          Raw LCMS modeled probability of Barren or Impervious. Defined as: The majority of the pixel
          is comprised of 1.) bare soil exposed by disturbance (e.g., soil uncovered by mechanical
          clearing or forest harvest), as well as perennially barren areas such as deserts, playas,
          rock outcroppings (including minerals and other geologic materials exposed by surface mining
          activities), sand dunes, salt flats, and beaches. Roads made of dirt and gravel are also
          considered barren or 2.) man-made materials that water cannot penetrate, such as paved roads,
          rooftops, and parking lots.
        |||,
      },
      {
        name: 'Land_Cover_Raw_Probability_Snow-or-Ice',
        description: |||
          Raw LCMS modeled probability of Snow or Ice. Defined as: The majority of the pixel is
          comprised of snow or ice.
        |||,
      },
      {
        name: 'Land_Cover_Raw_Probability_Water',
        description: |||
          Raw LCMS modeled probability of Water. Defined as: The majority of
          the pixel is comprised of water.
        |||,
      },
      {
        name: 'Land_Use_Raw_Probability_Agriculture',
        description: |||
          Raw LCMS modeled probability of Agriculture. Defined as: Land used for the production of
          food, fiber and fuels which is in either a vegetated or non-vegetated state. This includes
          but is not limited to cultivated and uncultivated croplands, hay lands, orchards, vineyards,
          confined livestock operations, and areas planted for production of fruits, nuts or berries.
          Roads used primarily for agricultural use (i.e. not used for public transport from town to
          town) are considered agriculture land use.
        |||,
      },
      {
        name: 'Land_Use_Raw_Probability_Developed',
        description: |||
          Raw LCMS modeled probability of Developed. Defined as: Land covered by man-made structures
          (e.g. high density residential, commercial, industrial, mining or transportation), or a
          mixture of both vegetation (including trees) and structures (e.g., low density residential,
          lawns, recreational facilities, cemeteries, transportation and utility corridors, etc.),
          including any land functionally altered by human activity.
        |||,
      },
      {
        name: 'Land_Use_Raw_Probability_Forest',
        description: |||
          Raw LCMS modeled probability of Forest. Defined as: Land that is planted or naturally
          vegetated and which contains (or is likely to contain) 10% or greater tree cover at some
          time during a near-term successional sequence. This may include deciduous, evergreen and/or
          mixed categories of natural forest, forest plantations, and woody wetlands.
        |||,
      },
      {
        name: 'Land_Use_Raw_Probability_Other',
        description: |||
          Raw LCMS modeled probability of Other. Defined as: Land (regardless of use) where the
          spectral trend or other supporting evidence suggests a disturbance or change event has
          occurred but the definitive cause cannot be determined or the type of change fails to meet
          any of the change process categories defined above.
        |||,
      },
      {
        name: 'Land_Use_Raw_Probability_Rangeland-or-Pasture',
        description: |||
          Raw LCMS modeled probability of Rangeland or Pasture. Defined as: This class includes any
          area that is either a.) Rangeland, where vegetation is a mix of native grasses, shrubs, forbs
          and grass-like plants largely arising from natural factors and processes such as rainfall,
          temperature, elevation and fire, although limited management may include prescribed burning
          as well as grazing by domestic and wild herbivores; or b.) Pasture, where vegetation may
          range from mixed, largely natural grasses, forbs and herbs to more managed vegetation
          dominated by grass species that have been seeded and managed to maintain near monoculture.
        |||,
      },
      {
        name: 'QA_Bits',
        description: |||
          Ancillary information on the origin of the annual LCMS product output
          values.
        |||,
        'gee:bitmask': {
           bitmask_parts: [
             {
               description: 'Whether the pixel is interpolated.',
               first_bit: 0,
               bit_count: 1,
               values: [
                 {value: 0, description: 'Interpolated'},
                 {value: 1, description: 'Not interpolated'},
               ],
             },
             {
               description: 'Which sensor the pixel came from.',
               first_bit: 1,
               bit_count: 5,
               values: [
                 {value: 4, description: 'Landsat 4'},
                 {value: 5, description: 'Landsat 5'},
                 {value: 7, description: 'Landsat 7'},
                 {value: 8, description: 'Landsat 8'},
                 {value: 9, description: 'Landsat 9'},
                 {value: 21, description: 'Sentinel 2A'},
                 {value: 22, description: 'Sentinel 2B'},
               ],
             },
             {
               description: 'Which Julian day the pixel came from (1-365).',
               first_bit: 6,
               bit_count: 9,
             },
           ],
           total_bit_count: 15,
         },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'ChangeViz',
        lookat: {
          lat: 37.09024,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              5.0,
            ],
            palette: [
              '3d4551',
              'f39268',
              'd54309',
              '00a398',
              '1b1716',
              'b30088',
            ],
            bands: [
              'Change',
            ],
          },
        },
      },
      {
        display_name: 'lcViz',
        lookat: {
          lat: 37.09024,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              15.0,
            ],
            palette: [
              '005e00',
              '008000',
              '00cc00',
              'b3ff1a',
              '99ff99',
              'b30088',
              'e68a00',
              'ffad33',
              'ffe0b3',
              'ffff00',
              'aa7700',
              'd3bf9b',
              'ffffff',
              '4780f3',
              '1b1716',
            ],
            bands: [
              'Land_Cover',
            ],
          },
        },
      },
      {
        display_name: 'luViz',
        lookat: {
          lat: 37.09024,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              7.0,
            ],
            palette: [
              '3d4551',
              'f39268',
              'd54309',
              '00a398',
              '1b1716',
            ],
            bands: [
              'Land_Use',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    USDA Forest Service. 2025. USFS Landscape Change Monitoring System
    v2024.10 (Conterminous United States and  Outer Conterminous United States).
    Salt Lake City, Utah.
  |||,
  'sci:publications': [
    {
      citation: |||
        Breiman, L., 2001. Random Forests. In Machine Learning. Springer, 45: 5-32.
        [doi:10.1023/A:1010933404324](https://doi.org/10.1023/A:1010933404324)
      |||,
      doi:'10.1023/A:1010933404324',
    },
    {
      citation: |||
        Chastain, R., Housman, I., Goldstein, J., Finco, M., and Tenneson, K., 2019.
        Empirical cross sensor comparison of Sentinel-2A and 2B MSI, Landsat-8 OLI,
        and Landsat-7 ETM top of atmosphere spectral characteristics over the
        conterminous United States. In Remote Sensing of Environment. Science Direct,
        221: 274-285. [doi:10.1016/j.rse.2018.11.012](https://doi.org/10.1016/j.rse.2018.11.012)
      |||,
      doi:'10.1016/j.rse.2018.11.012',
    },
    {
      citation: |||
        Cohen, W. B., Yang, Z., and Kennedy, R., 2010. Detecting trends in forest
        disturbance and recovery using yearly Landsat time series: 2. TimeSync -
        Tools for calibration and validation. In Remote Sensing of Environment.
        Science Direct, 114(12): 2911-2924. [doi:10.1016/j.rse.2010.07.010]
        (https://doi.org/10.1016/j.rse.2010.07.010)
      |||,
      doi:'10.1016/j.rse.2010.07.010',
    },
    {
      citation: |||
        Cohen, W. B., Yang, Z., Healey, S. P., Kennedy, R. E., and Gorelick, N.,
        2018. A LandTrendr multispectral ensemble for forest disturbance detection.
        In Remote Sensing of Environment. Science Direct, 205: 131-140.
        [doi:10.1016/j.rse.2017.11.015](https://doi.org/10.1016/j.rse.2017.11.015)
      |||,
      doi:'10.1016/j.rse.2017.11.015',
    },
    {
      citation: |||
        Foga, S., Scaramuzza, P.L., Guo, S., Zhu, Z., Dilley, R.D., Beckmann,
        T., Schmidt, G.L., Dwyer, J.L., Hughes, M.J., Laue, B., 2017. Cloud
        detection algorithm comparison and validation for operational Landsat data
        products. In Remote Sensing of Environment. Science Direct, 194: 379-390.
        [doi:10.1016/j.rse.2017.03.026](http://doi.org/10.1016/j.rse.2017.03.026)
      |||,
      doi:'10.1016/j.rse.2017.03.026',
    },
    {
      citation: |||
        U.S. Geological Survey, 2019. USGS 3D Elevation Program Digital Elevation
        Model, accessed August 2022 at
        https://developers.google.com/earth-engine/datasets/catalog/USGS_3DEP_10m
      |||,
    },
    {
      citation: |||
        Healey, S. P., Cohen, W. B., Yang, Z., Kenneth Brewer, C., Brooks, E. B.,
        Gorelick, N., Hernandez, A. J., Huang, C., Joseph Hughes, M., Kennedy,
        R. E., Loveland, T. R., Moisen, G. G., Schroeder, T. A., Stehman, S. V.,
        Vogelmann, J. E., Woodcock, C. E., Yang, L., and Zhu, Z., 2018. Mapping
        forest change using stacked generalization: An ensemble approach. In
        Remote Sensing of Environment. Science Direct, 204: 717-728.
        [doi:10.1016/j.rse.2017.09.029](https://doi.org/10.1016/j.rse.2017.09.029)
      |||,
      doi:'10.1016/j.rse.2017.09.029',
    },
    {
      citation: |||
        Kennedy, R. E., Yang, Z., and Cohen, W. B., 2010. Detecting trends
        in forest disturbance and recovery using yearly Landsat time series: 1.
        LandTrendr - Temporal segmentation algorithms. In Remote Sensing of Environment.
        Science Direct, 114(12): 2897-2910. [doi:10.1016/j.rse.2010.07.008]
        (https://doi.org/10.1016/j.rse.2010.07.008)
      |||,
      doi:'10.1016/j.rse.2010.07.008',
    },
    {
      citation: |||
        Kennedy, R., Yang, Z., Gorelick, N., Braaten, J., Cavalcante, L.,
        Cohen, W., and Healey, S. 2018. Implementation of the LandTrendr
        Algorithm on Google Earth Engine. In Remote Sensing. MDPI,
        10(5): 691. [doi:10.3390/rs10050691](https://doi.org/10.3390/rs10050691)
      |||,
      doi:'10.3390/rs10050691',
    },
    {
      citation: |||
        Pasquarella, V. J., Brown, C. F., Czerwinski, W., and Rucklidge, W. J., 2023.
        Comprehensive Quality Assessment of Optical Satellite Imagery Using
        Weakly Supervised Video Learning. In Proceedings of the IEEE/CVF Conference
        on Computer Vision and Pattern Recognition. 2124-2134.
      |||,
      doi:'10.3390/rs10050691',
    },
    {
      citation: |||
        Sentinel-Hub, 2021. Sentinel 2 Cloud Detector. [Online]. Available at:
        [https://github.com/sentinel-hub/sentinel2-cloud-detector](https://github.com/sentinel-hub/sentinel2-cloud-detector)
      |||,
    },
    {
      citation: |||
        Weiss, A.D., 2001. Topographic position and landforms analysis
        Poster Presentation, ESRI Users Conference, San Diego, CAZhu, Z.,
        and Woodcock, C. E. 2012. Object-based cloud and cloud shadow
        detection in Landsat imagery. 118: 83-94.
      |||,
    },
    {
      citation: |||
        Zhu, Z., and Woodcock, C. E., 2012. Object-based cloud and cloud shadow
        detection in Landsat imagery. In Remote Sensing of Environment. Science Direct,
        118: 83-94. [doi:10.1016/j.rse.2011.10.028](https://doi.org/10.1016/j.rse.2011.10.028)
      |||,
      doi:'10.1016/j.rse.2011.10.028',
    },
    {
      citation: |||
        Zhu, Z., and Woodcock, C. E., 2014. Continuous change detection
        and classification of land cover using all available Landsat data.
        In Remote Sensing of Environment. Science Direct, 144: 152-171.
        [doi:10.1016/j.rse.2014.01.011](https://doi.org/10.1016/j.rse.2014.01.011)
      |||,
      doi:'10.1016/j.rse.2014.01.011',
    },
  ],
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

    USDA Forest Service. 2025. USFS Landscape Change Monitoring System v2024.10
    (Conterminous United States and Outer Conterminous United States). Salt Lake City, Utah.
  |||,
  'gee:user_uploaded': true,
}