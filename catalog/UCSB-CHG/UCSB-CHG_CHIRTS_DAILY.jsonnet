local id = 'UCSB-CHG/CHIRTS/DAILY';
local subdir = 'UCSB-CHG';

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
  title: 'CHIRTS-daily: Climate Hazards Center InfraRed Temperature with Stations daily temperature data product',
  version: 'v1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Climate Hazards Center InfraRed Temperature with Stations daily
    temperature data product (CHIRTS-daily; Verdin et al. 2020) is a quasi
    global, high-resolution gridded dataset
    (0.05&deg;&thinsp;&times;&thinsp;0.05&deg; resolution, 60&deg;S - 70&deg;N)
    that provides daily minimum (Tmin) and maximum 2-meter temperatures (Tmax)
    and four derived variables: saturation vapor pressure (SVP),
    vapor pressure deficit (VPD), relative humidity (RH), and heat index (HI).
    CHIRTS temperature products are designed to support analysis of temperature
    extremes and variability, especially in regions with a low density of
    station observations.

    CHIRTS-daily is created by merging a high-quality, high-resolution monthly
    maximum temperature dataset, the Climate Hazards Center InfraRed
    Temperature with Stations monthly maximum temperature climate record
    (CHIRTSmax; Funk et al. 2019), with daily temperatures from the European
    Centre for Medium-Range Weather Forecasts (ECMWF) Reanalysis v5 (ERA5).
    The result is a high-resolution, daily temperature dataset that maintains
    spatio-temporal information from monthly CHIRTSmax and the daily and diurnal
    temperature variability from ERA5. Monthly CHIRTSmax are based on:

       1. A Tmax climatology constructed using geostatistical regressions and
          long-term averages of FAO station observations, ERA5 temperatures, and
          several other geographic predictors.

       2. Estimates of Tmax variability using approximately 15,000 in situ
          observations and high-resolution
          (0.05&deg;&thinsp;&times;&thinsp;0.05&deg;) satellite observations.
          These data are from Berkeley Earth and Global Telecommunication
          System (GTS) station reports and cloud-screened GridSat geostationary
          satellite thermal infrared brightness temperatures.

    Daily Tmax values are produced using downscaled ERA5 Tmax anomalies and
    high-resolution CHIRTSmax. Daily Tmin values are created by removing the
    downscaled ERA5 diurnal temperature range (Tmax - Tmin).
    Daily SVP, VPD, RH, and HI are computed using CHIRTS-daily Tmin and Tmax,
    alongside hourly ERA5 inputs for other meteorological variables
    (see Williams et al., 2024, for details). CHIRTS-daily, version 1, covers
    the period from 1983 to 2016.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['climate'],
  keywords: [
    'chg',
    'climate',
    'daily',
    'era5',
    'geophysical',
    'reanalysis',
    'temperature',
    'ucsb',
    'wind',
  ],
  providers: [
    ee.producer_provider('UCSB/CHG', 'https://chc.ucsb.edu/data/chirtsdaily'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -60.0, 180.0, 70.0, '1983-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      5566.0,
    ],
    'eo:bands': [
      {
        name: 'minimum_temperature',
        description: |||
          The lowest air temperature recorded at 2 meters above the ground
          surface over a 24-hour period.
        |||,
        'gee:units': units.celsius,
      },
      {
        name: 'maximum_temperature',
        description: |||
          The highest air temperature recorded at 2 meters above the ground
          surface over a 24-hour period.
        |||,
        'gee:units': units.celsius,
      },
      {
        name: 'saturation_vapor_pressure',
        description: |||
          The maximum amount of water vapor that the air can hold at a given
          temperature and pressure at 2 meters above ground.
        |||,
        'gee:units': units.kilopascal,
      },
      {
        name: 'vapor_pressure_deficit',
        description: |||
          The difference between the saturation vapor pressure and the actual
          vapor pressure at 2 meters above ground.
        |||,
        'gee:units': units.kilopascal,
      },
      {
        name: 'relative_humidity',
        description: |||
          The ratio of the actual amount of water vapor in the air to the
          maximum amount it could hold at that temperature and pressure
          (saturation vapor pressure) at 2 meters above ground.
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'heat_index',
        description: |||
          A measure of how hot it feels when temperature and humidity are
          combined.
        |||,
        'gee:units': units.fahrenheit,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'CHIRTS-daily 2m Maximum Temperature',
        lookat: {
          lat: 0.00,
          lon: 0.00,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              10,
            ],
            max: [
              40,
            ],
            palette:  [
              '00008B',
              '0000FF',
              '00FFFF',
              '008000',
              'FFFF00',
              'FFA500',
              'FF0000',
              '8B0000',
            ],
            bands: [
              'maximum_temperature',
            ],
          },
        },
      },
    ],
    maximum_temperature: {
      minimum: 10,
      maximum: 40,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Verdin, A., C. Funk, P. Peterson, M. Landsfeld, C. Tuholske, and Grace, K.,
    2020: Development and validation of the CHIRTS-daily quasi-global
    high-resolution daily temperature data set. Scientific Data, 7(1), 303.
    [doi: 10.1038/s41597-020-00643-7](https://doi.org/10.1038/s41597-020-00643-7)
  |||,
  'sci:publications': [
    {
      citation: |||
        Funk, C., P. Peterson, S. Peterson, S. Shukla,
        F. Davenport, J. Michaelsen, K.R. Knapp, M. Landsfeld, G. Husak,
        L. Harrison, J. Rowland, M. Budde, A. Meiburg, T. Dinku, D. Pedreros,
        and N. Mata, 2019: A High-Resolution 1983-2016 Tmax Climate Data Record
        Based on Infrared Temperatures and Stations by the Climate Hazard
        Center. J. Climate, 32, 5639-5658.
        [doi:10.1175/JCLI-D-18-0698.1](https://doi.org/10.1175/JCLI-D-18-0698.1)
      |||,
      doi: '10.1175/JCLI-D-18-0698.1',
    },
    {
      citation: |||
        Williams, E., C. Funk, P. Peterson, and C. Tuholske (2024). High
        resolution climate change observations and projections for the
        evaluation of heat-related extremes. Scientific Data, 11(1), 261.
        [doi: 10.1038/s41597-024-03074-w](https://doi.org/10.1038/s41597-024-03074-w)
      |||,
      doi: '10.1038/s41597-024-03074-w',
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    This datasets are in the public domain. To the extent possible under law,
    [Chris Funk](https://chc.ucsb.edu/people/chris-funk) has waived all
    copyright and related or neighboring rights to Climate Hazards InfraRed
    Temperature with Stations daily temperature data product (CHIRTS-daily).
  |||,
}
