local id = 'USGS/NLCD_RELEASES/USGS_NLCD_RELEASES_2019_REL_RCMAP_V5_COVER';
local subdir = 'USGS/NLCD_RELEASES';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local license = spdx.cc0_1_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  'gee:skip_indexing': true,
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Rangeland Condition Monitoring Assessment and Projection (RCMAP) Fractional Component Time-Series Across the Western U.S. 1985-2021',
  version: 'v5',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The RCMAP (Rangeland Condition Monitoring Assessment and Projection) dataset quantifies the percent cover of rangeland components across the western U.S. using Landsat imagery from 1985-2021.

    The RCMAP product suite consists of nine fractional components: annual herbaceous, bare ground, herbaceous, litter, non-sagebrush shrub, perennial herbaceous, sagebrush, shrub, and tree, in addition to the temporal trends of each component. Several enhancements were made to the RCMAP process relative to prior generations. First, we have trained time-series predictions directly from 331 high-resolution sites collected from 2013-2018 from Assessment, Inventory, and Monitoring (AIM) instead of using the 2016 “base” map as an intermediary. This removes one level of model error and allows the direct association of high-resolution derived training data to the corresponding year of Landsat imagery. We have incorporated all available (as of 10/1/22) Bureau of Land Management (BLM), Assessment, Inventory, and Monitoring (AIM), and Landscape Monitoring Framework (LMF) observations. LANDFIRE public reference database training observations spanning 1985-2015 have been added. Neural network models with Keras tuner optimization have replaced Cubist models as our classifier. We have added a tree canopy cover component. Our study area has expanded to include all of California, Oregon, and Washington; in prior generations landscapes to the west of the Cascades were excluded. Additional spectral indices have been added as predictor variables, tasseled cap wetness, brightness, and greenness. Location information (i.e., latitude and longitude/ x and y coordinates) and elevation above sea level have been added as predictor variables. CCDC-Synthetic Landsat images were obtained for 6 monthly periods for each region and were added as predictors. These data augment the phenologic detail of the 2 seasonal Landsat composites.

    Post-processing has been improved with updated fire recovery equations stratified by ecosystem resistance and resilience (R and R) classes (Maestas and Campbell 2016) to stratify recovery rates. Ecosystem R and R maps are only available for the sagebrush biome. We intersected classes with 1985-2020 average water year precipitation to identify precipitation thresholds corresponding to R and R classes. Outside of the sagebrush biome, precipitation was used to produce R and R equivalent (low, medium, high). Due to the fast recovery following fire in California chapparal (e.g., Keeley and Keeley 1981, Storey et al. 2016), we used EPA level 3 ecoregions to define a 4th R and R zone. Recovery rates are based on (Arkle et al (in press)) who evaluated the recovery of plant functional groups in 1278 post-fire rehab plots by time since disturbance stratified by ecosystem resistance and resilience. We have expanded this analysis by evaluated postfire-recovery in all AIM and LMF data across the West to establish maximum sage, shrub, and tree cover by time-since fire. Recovery limits in California follow (Keeley and Keeley 1981 and Storey et al. 2016). Second, post-processing has been enhanced through a revised noise detection model. For each pixel, we fit a third order polynomial model for each component cover time-series. Observations with a z-score more than 2 standard deviations from the mean are removed, and a new third order polynomial model (i.e., cleaned fit) is fit to observations within this threshold. Finally, looking again at all observations, those observations with a z-score more than 2 standard deviations from the mean of the cleaned fit are replaced with the mean of the prior and subsequent year component cover values.

    Processing efficiency has been increased using open-source software and USGS High-Performance Computing (HPC) resources. The mapping area included eight regions which were subsequently mosaicked for all nine components. These data can be used to answer critical questions regarding the influence of climate change and the suitability of management practices.

    Component products can be downloaded https://www.mrlc.gov/data.

    The goal of this project is to provide a dense Landsat imagery time series of rangeland fractional components across the Western U.S. from 1985 to 2021. These data will provide an inventory of land cover validated products with estimates of precision for the western rangelands. Climate change, shifting fire regimes, and management practices are increasingly impacting the health of the ecosystem. This dataset will fill the need for improved monitoring change within the large rangeland habitat.

    Components are defined as:

    Bare Ground is a continuous field component including exposed soil, sand and rocks.

    Annual Herbaceous is a continuous field component including grasses and forbs whose life history is complete in one growing season. This component is primarily dominated by annual invasive species including Cheatgrass (Bromus tectorum), Medusahead (Taeniatherum caput-medusae), Red Brome (Bromus rebens), or annual mustards such as Tumble Mustard (Sisymbrium altissimum) and Tansy Mustard (Descurainia pinnata), but it may contain substantial native annual herbaceous vegetation at higher elevations and in California. This component is nested within Herbaceous as a secondary component.

    Herbaceous is a continuous field component consisting of grasses, forbs and cacti which were photosynthetically active at any point in the year of mapping.

    Non-sagebrush shrub is a continuous field component encompassing all shrub species not of the sagebrush (Artemisia spp.) genus. Shrubs, in general, are discriminated by the presence of woody stems and &lt; 6-m in height.

    Perennial herbaceous is a continuous field component consisting of grasses, forbs and cacti which were photosynthetically active at any point in the year of mapping and whose lifecycle includes more than one growing season (includes biennials).

    Litter is a continuous field component including dead standing woody vegetation, detached plant organic matter and biological soil crusts.

    Sagebrush is a continuous field component encompassing almost all species of Sagebrush (Artemisia spp.) including Big Sagebrush (A. tridentata spp.), Low Sagebrush (A. arbuscula), Black Sagebrush (A. nova), Three-tip Sagebrush (A. triparta) and Silver Sagebrush (A. cana). This component is nested within Shrub as a secondary component. Excludes the low stature prairie sage (A. frigida) and white sagebrush (A. ludoviciana).

    Shrub is a continuous field component encompassing all shrub species discriminated by the presence of woody stems and &lt; 6-m in height.

    Tree cover is defined as vegetation with persistent woody stems &gt; 6m in height. Mature stand of pinyon (Pinus spp.  and juniper (Juniperus spp.) are included regardless of height.

    See also:
    Hua Shi, Matthew Rigge, Kory Postma & Brett Bunde (2022) Trends analysis of rangeland condition monitoring assessment and projection (RCMAP) fractional component time series (1985–2020), GIScience & Remote Sensing, 59:1, 1243-1265, DOI: 10.1080/15481603.2022.2104786

    Rigge, M., H. Shi, C. Homer, P. Danielson, and B. Granneman. 2019. Long-term trajectories of fractional component change in the Northern Great Basin, USA. Ecosphere: e02762.

     Rigge, M., C. Homer, L. Cleeves, D. Meyer, B. Bunde, H. Shi, G. Xian, and M. Bobo. 2020. Quantifying western U.S. rangelands as fractional components with multi-resolution remote sensing and in situ data. Remote Sensing. 12: 412.

     Rigge, M., Homer, C., Shi, H., Meyer, D., Bunde, B., Granneman, B., Postma, K., Danielson, P., Case, A., and Xian, G. 2021. Rangeland Fractional Components Across the Western United States from 1985 to 2018. Remote Sensing, 13: 813.
|||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'annual herbaceous',
    'back-in-time',
    'bare ground',
    'big sagebrush',
    'climate change',
    'grass',
    'grassland change',
    'herbaceous',
    'litter',
    'rangeland',
    'rangeland management',
    'sagebrush',
    'shrub',
    'shrubland',
    'shrublands',
    'shrubland change',
    'time series',
    'trends',
    'vegetation change',
    'vegetation',
  ],
  providers: [
    ee.producer_provider('United States Geological Survey and Bureau of Land Management', 'https://www.mrlc.gov/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(
      -128.0026, 26.4827, -99.6407, 51.5777,
      '1985-01-01T00:00:00Z',
      '2021-12-31T00:00:00Z'),
  'sci:citation': |||
    Rigge, M.B., Bunde, B., Postma, K., Shi, H., 2022, Rangeland Condition Monitoring Assessment and Projection (RCMAP) Fractional Component Time-Series Across the Western U.S. 1985-2021: U.S. Geological Survey data release, https://doi.org/10.5066/P9ODAZHC.
    [doi:10.5066/P9ODAZHC](https://doi.org/10.5066/P9ODAZHC)
  |||,
  'gee:user_uploaded': true,
  'gee:skip_indexing': true,
  'gee:terms_of_use': |||
    This work was authored as part of the Contributor's official duties as an Employee of the United States Government and is therefore a work of the United States Government. In accordance with 17 U.S.C. 105, no copyright protection is available for such works under U.S. Law. This is an Open Access article that has been identified as being free of known restrictions under copyright law, including all related and neighboring rights (https://creativecommons.org/publicdomain/mark/1.0/). You can copy, modify, distribute and perform the work, even for commercial purposes, all without asking permission.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  summaries: {
    gsd: [
      30
    ],
    'gee:visualizations': [
      {
        display_name: 'Rangeland Annual Herbaceous %',
        lookat: {
          lat: 38,
          lon: -114,
          zoom: 6,
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
              "000000",
              "f9e8b7",
              "f7e3ac",
              "f0dfa3",
              "eedf9c",
              "eada91",
              "e8d687",
              "e0d281",
              "ddd077",
              "d6cc6d",
              "d3c667",
              "d0c55e",
              "cfc555",
              "c6bd4f",
              "c4ba46",
              "bdb83a",
              "bbb534",
              "b7b02c",
              "b0ad1f",
              "adac17",
              "aaaa0a",
              "a3a700",
              "9fa700",
              "9aa700",
              "92a700",
              "8fa700",
              "87a700",
              "85a700",
              "82aa00",
              "7aaa00",
              "77aa00",
              "70aa00",
              "6caa00",
              "67aa00",
              "5fa700",
              "57a700",
              "52a700",
              "4fa700",
              "4aa700",
              "42a700",
              "3ca700",
              "37a700",
              "37a300",
              "36a000",
              "369f00",
              "349d00",
              "339900",
              "339900",
              "2f9200",
              "2d9100",
              "2d8f00",
              "2c8a00",
              "2c8800",
              "2c8500",
              "2c8400",
              "2b8200",
              "297d00",
              "297a00",
              "297900",
              "277700",
              "247400",
              "247000",
              "29700f",
              "2c6d1c",
              "2d6d24",
              "336d2d",
              "366c39",
              "376c44",
              "396a4a",
              "396a55",
              "3a6a5f",
              "3a696a",
              "396774",
              "3a6782",
              "39668a",
              "376292",
              "34629f",
              "2f62ac",
              "2c5fb7",
              "245ec4",
              "1e5ed0",
              "115cdd",
              "005ae0",
              "0057dd",
              "0152d6",
              "0151d0",
              "014fcc",
              "014ac4",
              "0147bd",
              "0144b8",
              "0142b0",
              "0141ac",
              "013da7",
              "013aa0",
              "01399d",
              "013693",
              "013491",
              "012f8a",
              "012d85",
              "012c82",
              "01297a"
            ],
            bands: [
              'rangeland_annual_herbaceous',
            ],
          },
        },
      },
    ],
    'eo:bands': [
      {
        name: 'rangeland_annual_herbaceous',
        description: |||
          Percent of the pixel covered by annual herbaceous vegetation.
        |||,
        'gee:units': '%',
      },
      {
        name: 'rangeland_bare_ground',
        description: |||
          Percent of the pixel covered by bare ground.
        |||,
        'gee:units': '%',
      },
      {
        name: 'rangeland_non_sagebrush_shrub',
        description: |||
          Percent of the pixel covered by non-sagebrush shrubs.
        |||,
        'gee:units': '%',
      },
      {
        name: 'rangeland_herbaceous',
        description: |||
          Percent of the pixel covered by herbaceous vegetation.
        |||,
        'gee:units': '%',
      },
      {
        name: 'rangeland_litter',
        description: |||
          Percent of the pixel covered by litter.
        |||,
        'gee:units': '%',
      },
      {
        name: 'rangeland_sagebrush',
        description: |||
          Percent of the pixel covered by sagebrush (*Artemisia* spp).
        |||,
        'gee:units': '%',
      },
      {
        name: 'rangeland_shrub',
        description: |||
          Percent of the pixel covered by shrub.
        |||,
        'gee:units': '%',
      },
      {
        name: 'rangeland_perennial_herbaceous',
        description: |||
          Percent of the pixel covered by perennial herbaceous vegetation.
        |||,
        'gee:units': '%',
      },
      {
        name: 'rangeland_tree',
        description: |||
          Percent of the pixel covered by tree.
        |||,
        'gee:units': '%',
      },
    ],
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
    rangeland_non_sagebrush_shrub: {
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
    rangeland_shrub: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    rangeland_perennial_herbaceous: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    rangeland_tree: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
  },
}
