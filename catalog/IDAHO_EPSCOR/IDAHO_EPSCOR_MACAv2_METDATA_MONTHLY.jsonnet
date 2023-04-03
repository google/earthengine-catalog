local id = 'IDAHO_EPSCOR/MACAv2_METDATA_MONTHLY';
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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MACAv2-METDATA Monthly Summaries: University of Idaho, Multivariate Adaptive Constructed Analogs Applied to Global  Climate Models',
  version: '2',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MACAv2-METDATA dataset is a collection of 20 global
    climate models covering the conterminous USA. The Multivariate Adaptive
    Constructed Analogs (MACA) method is a statistical downscaling
    method which utilizes a training dataset (i.e. a meteorological
    observation dataset) to remove historical biases and match spatial
    patterns in climate model output.

    The MACA method was used to downscale the model output from 20
    global climate models (GCMs) of the Coupled Model Inter-Comparison
    Project 5 (CMIP5) for the historical GCM forcings (1950-2005) and
    the future Representative Concentration Pathways (RCPs) RCP 4.5
    and RCP 8.5 scenarios (2006-2100) from the native resolution of
    the GCMS to 4km.

    This version contains monthly summaries.

    The full list of models can be found at:
    [https://climate.northwestknowledge.net/MACA/GCMs.php](https://climate.northwestknowledge.net/MACA/GCMs.php)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'climate',
    'conus',
    'geophysical',
    'idaho',
    'maca',
    'monthly',
  ],
  providers: [
    ee.producer_provider('University of California Merced', 'http://www.climatologylab.org/maca.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-124.9, 24.9, -67.0, 49.6,
                    '1900-01-01T00:00:00Z', '2099-12-31T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'scenario',
        description: "Name of the CMIP5 scenario, one of 'rcp85', 'rcp45', or 'historical'",
        type: ee_const.var_type.string,
      },
      {
        name: 'model',
        description: "Name of the CMIP5 model, eg 'inmcm4'",
        type: ee_const.var_type.string,
      },
      {
        name: 'ensemble',
        description: "Either 'r1i1p1' or 'r6i1p1'",
        type: ee_const.var_type.string,
      },
      {
        name: 'month',
        description: 'The index of the month in the year, ie 1-12',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      4638.3,
    ],
    'eo:bands': [
      {
        name: 'tasmax',
        description: 'Monthly average of maximum daily temperature near surface',
        'gee:units': units.kelvin,
      },
      {
        name: 'tasmin',
        description: 'Monthly average of minimum daily temperature near surface',
        'gee:units': units.kelvin,
      },
      {
        name: 'huss',
        description: 'Monthly average of mean daily specific humidity near surface',
        'gee:units': units.mass_fraction,
      },
      {
        name: 'pr',
        description: 'Total monthly precipitation amount at surface',
        'gee:units': units.millimeter,
      },
      {
        name: 'rsds',
        description: 'Monthly average of mean daily downward shortwave radiation at surface',
        'gee:units': 'W/m^2',
      },
      {
        name: 'was',
        description: 'Monthly average of mean daily near surface wind speed',
        'gee:units': units.velocity_si,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Maximum Temperature',
        lookat: {
          lat: 38.686,
          lon: -115.356,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              290.0,
            ],
            max: [
              314.0,
            ],
            palette: [
              'd8d8d8',
              '4addff',
              '5affa3',
              'f2ff89',
              'ff725c',
            ],
            bands: [
              'tasmax',
            ],
          },
        },
      },
    ],
    tasmax: {
      minimum: 251.95,
      maximum: 330.64,
      'gee:estimated_range': true,
    },
    tasmin: {
      minimum: 239.47,
      maximum: 316.2,
      'gee:estimated_range': true,
    },
    huss: {
      minimum: 0.0,
      maximum: 0.03,
      'gee:estimated_range': true,
    },
    pr: {
      minimum: 0.0,
      maximum: 3691.91,
      'gee:estimated_range': true,
    },
    rsds: {
      minimum: 15.84,
      maximum: 419.0,
      'gee:estimated_range': true,
    },
    was: {
      minimum: 0.23,
      maximum: 14.16,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Abatzoglou J.T. and Brown T.J., A comparison of statistical downscaling
    methods suited for wildfire applications, International Journal
    of Climatology(2012) [doi:10.1002/joc.2312](https://doi.org/10.1002/joc.2312).
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': |||
    The MACA datasets were created with funding from the
    US government and are in the public domain in the United States.
    For further clarity, unless otherwise noted, the MACA datasets
    are made available with a Creative Commons CC0 1.0 Universal dedication.
    In short, John Abatzoglou waives all rights to the work worldwide
    under copyright law, including all related and neighboring rights,
    to the extent allowed by law. You can copy, modify, distribute,
    and perform the work, even for commercial purposes, all without
    asking permission. John Abatzoglou makes no warranties about the
    work, and disclaims liability for all uses of the work, to the
    fullest extent permitted by applicable law. Users should properly
    cite the source used in the creation of any reports and publications
    resulting from the use of this dataset and note the date when the
    data was acquired. For more information refer to the [MACA References
    and License](https://climate.northwestknowledge.net/MACA/MACAreferences.php)
    page.
  |||,
}
