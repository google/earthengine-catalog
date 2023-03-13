local id = 'IDAHO_EPSCOR/GRIDMET';
local subdir = 'IDAHO_EPSCOR';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

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
  title: 'GRIDMET: University of Idaho Gridded Surface Meteorological Dataset',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Gridded Surface Meteorological dataset provides
    high spatial resolution (~4-km) daily surface fields of temperature,
    precipitation, winds, humidity and radiation across the contiguous
    United States from 1979. The dataset blends the high resolution
    spatial data from PRISM with the high temporal resolution data
    from the National Land Data Assimilation System (NLDAS) to produce
    spatially and temporally continuous fields that lend themselves
    to additional land surface modeling.

    This dataset contains provisional products that are replaced with
    updated versions when the complete source data become available.
    Products can be distinguished by the value of the 'status' property.
    At first, assets are ingested with status='early'. After several
    days, they are replaced by assets with status='provisional'.
    After about 2 months, they are replaced by the final assets with
    status='permanent'.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'climate',
    'fireburning',
    'gridmet',
    'humidity',
    'merced',
    'metdata',
    'nfdrs',
    'precipitation',
    'radiation',
    'temperature',
    'wind',
  ],
  providers: [
    ee.producer_provider('University of California Merced', 'http://www.climatologylab.org/gridmet.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-124.9, 24.9, -66.8, 49.6, '1979-01-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'status',
        description: "'early', 'provisional', or 'permanent'",
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      4638.3,
    ],
    'eo:bands': [
      {
        name: 'pr',
        description: 'Precipitation amount',
        'gee:units': 'mm, daily total',
      },
      {
        name: 'rmax',
        description: 'Maximum relative humidity',
        'gee:units': units.percent,
      },
      {
        name: 'rmin',
        description: 'Minimum relative humidity',
        'gee:units': units.percent,
      },
      {
        name: 'sph',
        description: 'Specific humididy',
        'gee:units': units.mass_fraction,
      },
      {
        name: 'srad',
        description: 'Surface downward shortwave radiation',
        'gee:units': 'W/m^2',
      },
      {
        name: 'th',
        description: 'Wind direction',
        'gee:units': 'Degrees clockwise from North',
      },
      {
        name: 'tmmn',
        description: 'Minimum temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'tmmx',
        description: 'Maximum temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'vs',
        description: 'Wind velocity at 10m',
        'gee:units': units.velocity_si,
      },
      {
        name: 'erc',
        description: 'Energy release component',
        'gee:units': 'NFDRS fire danger index',
      },
      {
        name: 'eto',
        description: 'Daily reference evapotranspiration',
        'gee:units': 'grass, mm',
      },
      {
        name: 'bi',
        description: 'Burning index',
        'gee:units': 'NFDRS fire danger index',
      },
      {
        name: 'fm100',
        description: '100-hour dead fuel moisture',
        'gee:units': units.percent,
      },
      {
        name: 'fm1000',
        description: '1000-hour dead fuel moisture',
        'gee:units': units.percent,
      },
      {
        name: 'etr',
        description: 'Daily reference evapotranspiration',
        'gee:units': 'Alfalfa, mm',
      },
      {
        name: 'vpd',
        description: 'Mean vapor pressure deficit',
        'gee:units': 'kPa',
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
              'tmmx',
            ],
          },
        },
      },
    ],
    pr: {
      minimum: 0.0,
      maximum: 690.44,
      'gee:estimated_range': true,
    },
    rmax: {
      minimum: 1.05,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
    rmin: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
    sph: {
      minimum: 0.0,
      maximum: 0.02,
      'gee:estimated_range': true,
    },
    srad: {
      minimum: 0.0,
      maximum: 455.61,
      'gee:estimated_range': true,
    },
    tmmn: {
      minimum: 225.54,
      maximum: 314.88,
      'gee:estimated_range': true,
    },
    tmmx: {
      minimum: 233.08,
      maximum: 327.14,
      'gee:estimated_range': true,
    },
    vs: {
      minimum: 0.14,
      maximum: 29.13,
      'gee:estimated_range': true,
    },
    erc: {
      minimum: 0.0,
      maximum: 131.85,
      'gee:estimated_range': true,
    },
    eto: {
      minimum: 0.0,
      maximum: 17.27,
      'gee:estimated_range': true,
    },
    bi: {
      minimum: 0.0,
      maximum: 214.2,
      'gee:estimated_range': true,
    },
    fm100: {
      minimum: 0.28,
      maximum: 33.2,
      'gee:estimated_range': true,
    },
    fm1000: {
      minimum: 0.36,
      maximum: 47.52,
      'gee:estimated_range': true,
    },
    etr: {
      minimum: 0.0,
      maximum: 27.02,
      'gee:estimated_range': true,
    },
    vpd: {
      minimum: 0.0,
      maximum: 9.83,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Abatzoglou J. T., Development of gridded surface meteorological
    data for ecological applications and modelling, International Journal
    of Climatology. (2012) [doi:10.1002/joc.3413](https://doi.org/10.1002/joc.3413)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    This work (METDATA, by John Abatzoglou) is in the public
    domain and is free of known copyright restrictions. Users should
    properly cite the source used in the creation of any reports and
    publications resulting from the use of this dataset and note the
    date when the data was acquired.
  |||,
}
