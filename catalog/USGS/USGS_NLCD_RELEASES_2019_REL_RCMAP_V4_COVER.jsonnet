local id = 'USGS/NLCD_RELEASES/2019_REL/RCMAP/V4/COVER';
local subdir = 'USGS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc0_1_0;

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
  title: 'RCMAP Rangeland Component Timeseries v4 (1985-2020)',
  version: 'v4',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Rangeland ecosystems in the western United States have a dynamic response
    to climate change, fire, and other anthropogenic disturbances. The Rangeland
    Condition, Monitoring, Assessment, and Projection (RCMAP) product aims to
    capture this response by quantifying the percent cover of rangeland
    components, associated error, and trends across the western U.S. using
    Landsat imagery from 1985-2020.

    RCMAP quantifies the percent cover of components across the western U.S.
    rangelands (after Rigge et al. 2020) using Landsat imagery from 1985-2020.
    The RCMAP timeseries consists of eight fractional components: annual
    herbaceous, bare ground, herbaceous, litter, non-sagebrush shrub, perennial
    herbaceous, sagebrush and shrub, and the temporal trends of each. The four
    primary components (bare ground, shrub, litter, and herbaceous) are designed
    to sum to 100% in each pixel when added to tree canopy cover. The secondary
    components annual herbaceous and perennial herbaceous are subsets of the
    primary component herbaceous, while non-sagebrush shrub and sagebrush are
    subsets of shrub. Secondary components cannot have cover greater than their
    respective primary component. One year, 2012, was excluded from
    the timeseries due to a lack of quality imagery.

    MRLC developed an automated method to identify change in spectral
    conditions between each year in the Landsat archive and the circa 2016 base
    map. Regression tree models were trained from the unchanged portions of each
    year in the time series. Post-processing models corrected post-burn
    trajectories and eliminated noise and illogical change in the predictions.
    The current generation of RCMAP has been improved with more training data,
    regional-scale Landsat composites, and more robust change detection. MRLC
    assessed the temporal patterns in each component with a linear model and
    structural change method which determines break points in the timeseries
    using an 8-year temporal moving window. The linear and structural change
    methods generally agreed on gross patterns of change, but the latter found
    breaks more often with most pixels having at least one break point. Data
    provide spatiotemporal information on the occurrence of breaks, but even
    more critically, attribute those change events to specific component(s).
    The spatially, temporally, and thematically (i.e., multi-component) detailed
    specific information on rangeland condition can contribute to understanding
    major patterns of change at local, regional, and continental levels.

    See also:

    * Rigge, M., C. Homer, L. Cleeves, D. K. Meyer, B. Bunde, H. Shi, G. Xian,
      S. Schell, and M. Bobo. 2020. Quantifying western U.S. rangelands as
      fractional components with multi-resolution remote sensing and in situ
      data. Remote Sensing 12.
      [doi:10.3390/rs12030412](https://doi.org/10.3390/rs12030412)

    * Rigge, M., C. Homer, H. Shi, D. Meyer, B.
      Bunde, B. Granneman, K. Postma, P. Danielson, A. Case, and G. Xian. 2021.
      Rangeland Fractional Components Across the Western United States
      from 1985 to 2018. Remote Sensing 13:813.
      [doi:10.3390/rs13040813](https://doi.org/10.3390/rs13040813)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'climate_change',
    'disturbance',
    'landsat_derived',
    'nlcd',
    'rangeland',
    'trends',
  ],
  providers: [
    ee.producer_provider('United States Geological Survey and Bureau of Land Management', 'https://www.mrlc.gov/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(
      -125.0683594, 28.45903302, -101.0742188, 49.32512199,
      '1985-01-01T00:00:00Z',
      '2020-12-31T00:00:00Z'),
  'sci:citation': |||
    Rigge, M.B., Bunde, B., Shi, H., Postma, K., 2021, Rangeland Condition Monitoring Assessment and Projection (RCMAP) Fractional Component Time-Series Across the Western U.S. 1985-2020 (ver. 2.0, October 2021): U.S. Geological Survey data release.
    [doi:10.5066/P95IQ4BT](https://doi.org/10.5066/P95IQ4BT)
  |||,
  'gee:user_uploaded': true,
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
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_bare_ground',
        description: |||
          Percent of the pixel covered by bare ground.
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_non_sagebrush_shrub',
        description: |||
          Percent of the pixel covered by non-sagebrush shrubs.
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_herbaceous',
        description: |||
          Percent of the pixel covered by herbaceous vegetation.
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_litter',
        description: |||
          Percent of the pixel covered by litter.
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_sagebrush',
        description: |||
          Percent of the pixel covered by sagebrush (*Artemisia* spp).
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_shrub',
        description: |||
          Percent of the pixel covered by shrub.
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_perennial_herbaceous',
        description: |||
          Percent of the pixel covered by perennial herbaceous vegetation.
        |||,
        'gee:units': units.percent,
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
  },
}

