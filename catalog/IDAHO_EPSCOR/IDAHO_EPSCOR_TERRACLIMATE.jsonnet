local id = 'IDAHO_EPSCOR/TERRACLIMATE';
local subdir = 'IDAHO_EPSCOR';

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
  ],
  id: id,
  title: 'TerraClimate:  Monthly Climate and Climatic Water Balance for Global Terrestrial Surfaces, University of Idaho',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    TerraClimate is a dataset of monthly climate and climatic water balance for
    global terrestrial surfaces. It uses climatically aided interpolation,
    combining high-spatial resolution climatological normals from the
    [WorldClim dataset](https://www.worldclim.org/), with coarser spatial
    resolution, but time-varying data from
    [CRU Ts4.0](https://data.ceda.ac.uk/badc/cru/data/cru_ts/) and the
    [Japanese 55-year Reanalysis (JRA55)](https://jra.kishou.go.jp/JRA-55/index_en.html).
    Conceptually, the procedure applies interpolated time-varying anomalies
    from CRU Ts4.0/JRA55 to the high-spatial resolution climatology of
    WorldClim to create a high-spatial resolution dataset that covers a broader
    temporal record.

    Temporal information is inherited from CRU Ts4.0 for most global land
    surfaces for temperature, precipitation, and vapor pressure. However,
    JRA55 data is used for regions where CRU data had zero climate stations
    contributing (including all of Antarctica, and parts of Africa,
    South America, and scattered islands). For primary climate variables of
    temperature, vapor pressure, and precipitation, the University of Idaho
    provides additional data on the number of stations (between 0 and 8) that
    contributed to the CRU Ts4.0 data used by TerraClimate. JRA55 was used
    exclusively for solar radiation and wind speeds.

    TerraClimate additionally produces monthly surface water balance datasets
    using a water balance model that incorporates reference evapotranspiration,
    precipitation, temperature, and interpolated plant extractable soil water
    capacity. A modified Thornthwaite-Mather climatic water-balance model and
    extractable soil water storage capacity data was used at a 0.5° grid from
    Wang-Erlandsson et al. (2016).

    Data Limitations:

     1. Long-term trends in data are inherited from parent datasets.
        TerraClimate should not be used directly for independent assessments of
        trends.

     2. TerraClimate will not capture temporal variability at finer scales than
        parent datasets and thus is not able to capture variability in
        orographic precipitation ratios and inversions.

     3. The water balance model is very simple and does not account for
        heterogeneity in vegetation types or their physiological response to
        changing environmental conditions.

     4. Limited validation in data-sparse regions (e.g., Antarctica).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['climate', 'precipitation', 'water-vapor'],
  keywords: [
    'climate',
    'drought',
    'evapotranspiration',
    'geophysical',
    'global',
    'merced',
    'monthly',
    'palmer',
    'pdsi',
    'precipitation',
    'runoff',
    'temperature',
    'vapor',
    'wind',
  ],
  providers: [
    ee.producer_provider('University of California Merced', 'http://www.climatologylab.org/terraclimate.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1958-01-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'status',
        description: "'provisional' or 'permanent'",
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      4638.3,
    ],
    'eo:bands': [
      {
        name: 'aet',
        description: 'Actual evapotranspiration, derived using a one-dimensional soil water balance model',
        'gee:units': units.millimeter,
        'gee:scale': 0.1,
      },
      {
        name: 'def',
        description: 'Climate water deficit, derived using a one-dimensional soil water balance model',
        'gee:units': units.millimeter,
        'gee:scale': 0.1,
      },
      {
        name: 'pdsi',
        description: 'Palmer Drought Severity Index',
        'gee:scale': 0.01,
      },
      {
        name: 'pet',
        description: 'Reference evapotranspiration (ASCE Penman-Montieth)',
        'gee:units': units.millimeter,
        'gee:scale': 0.1,
      },
      {
        name: 'pr',
        description: 'Precipitation accumulation',
        'gee:units': units.millimeter,
      },
      {
        name: 'ro',
        description: 'Runoff, derived using a one-dimensional soil water balance model',
        'gee:units': units.millimeter,
      },
      {
        name: 'soil',
        description: 'Soil moisture, derived using a one-dimensional soil water balance model',
        'gee:units': units.millimeter,
        'gee:scale': 0.1,
      },
      {
        name: 'srad',
        description: 'Downward surface shortwave radiation',
        'gee:units': units.watt_per_meter_squared,
        'gee:scale': 0.1,
      },
      {
        name: 'swe',
        description: 'Snow water equivalent, derived using a one-dimensional soil water balance model',
        'gee:units': units.millimeter,
      },
      {
        name: 'tmmn',
        description: 'Minimum temperature',
        'gee:units': units.celsius,
        'gee:scale': 0.1,
      },
      {
        name: 'tmmx',
        description: 'Maximum temperature',
        'gee:units': units.celsius,
        'gee:scale': 0.1,
      },
      {
        name: 'vap',
        description: 'Vapor pressure',
        'gee:units': units.kilopascal,
        'gee:scale': 0.001,
      },
      {
        name: 'vpd',
        description: 'Vapor pressure deficit',
        'gee:units': units.kilopascal,
        'gee:scale': 0.01,
      },
      {
        name: 'vs',
        description: 'Wind-speed at 10m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.01,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Maximum Temperature',
        lookat: {
          lat: 52.48,
          lon: 71.72,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              -300.0,
            ],
            max: [
              300.0,
            ],
            palette: [
              '1a3678',
              '2955bc',
              '5699ff',
              '8dbae9',
              'acd1ff',
              'caebff',
              'e5f9ff',
              'fdffb4',
              'ffe6a2',
              'ffc969',
              'ffa12d',
              'ff7c1f',
              'ca531a',
              'ff0000',
              'ab0000',
            ],
            bands: [
              'tmmx',
            ],
          },
        },
      },
    ],
    aet: {
      minimum: 0.0,
      maximum: 3140.0,
      'gee:estimated_range': true,
    },
    def: {
      minimum: 0.0,
      maximum: 4548.0,
      'gee:estimated_range': true,
    },
    pdsi: {
      minimum: -4317.0,
      maximum: 3418.0,
      'gee:estimated_range': true,
    },
    pet: {
      minimum: 0.0,
      maximum: 4548.0,
      'gee:estimated_range': true,
    },
    pr: {
      minimum: 0.0,
      maximum: 7245.0,
      'gee:estimated_range': true,
    },
    ro: {
      minimum: 0.0,
      maximum: 12560.0,
      'gee:estimated_range': true,
    },
    soil: {
      minimum: 0.0,
      maximum: 8882.0,
      'gee:estimated_range': true,
    },
    srad: {
      minimum: 0.0,
      maximum: 5477.0,
      'gee:estimated_range': true,
    },
    swe: {
      minimum: 0.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    tmmn: {
      minimum: -770.0,
      maximum: 387.0,
      'gee:estimated_range': true,
    },
    tmmx: {
      minimum: -670.0,
      maximum: 576.0,
      'gee:estimated_range': true,
    },
    vap: {
      minimum: 0.0,
      maximum: 14749.0,
      'gee:estimated_range': true,
    },
    vpd: {
      minimum: 0.0,
      maximum: 1113.0,
      'gee:estimated_range': true,
    },
    vs: {
      minimum: 0.0,
      maximum: 2923.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Abatzoglou, J.T., S.Z. Dobrowski, S.A. Parks, K.C. Hegewisch, 2018,
    Terraclimate, a high-resolution global dataset of monthly climate and
    climatic water balance from 1958-2015, Scientific Data 5:170191,
    [doi:10.1038/sdata.2017.191](https://doi.org/10.1038/sdata.2017.191)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': |||
    The data set is in the public domain as licensed under the Creative Commons
    Public Domain (CC0) license.
  |||,
}
