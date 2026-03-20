local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc0_1_0;

{
  license: license.id,
  title: 'TerraClimate: Monthly Climate and Climatic Water Balance for Global Terrestrial Surfaces',
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
  providers(self_ee_catalog_url): [
    ee.producer_provider('University of California Merced', 'http://www.climatologylab.org/terraclimate.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  bands: [
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
  visualizations: [
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
  summaries: {
    gsd: [
      4638.3,
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
  citation: |||
    Abatzoglou, J.T., S.Z. Dobrowski, S.A. Parks, K.C. Hegewisch, 2018,
    Terraclimate, a high-resolution global dataset of monthly climate and
    climatic water balance from 1958-2015, Scientific Data 5:170191,
    [doi:10.1038/sdata.2017.191](https://doi.org/10.1038/sdata.2017.191)
  |||,
  terms_of_use: |||
    The data set is in the public domain as licensed under the Creative Commons
    Public Domain (CC0) license.
  |||,
}
