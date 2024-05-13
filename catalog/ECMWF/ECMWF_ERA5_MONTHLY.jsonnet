local id = 'ECMWF/ERA5/MONTHLY';
local subdir = 'ECMWF';

local cds_notice = import 'templates/cds_notice.libsonnet';
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
  title: 'ERA5 Monthly Aggregates - Latest Climate Reanalysis Produced by ECMWF / Copernicus Climate Change Service',
  'gee:type': ee_const.gee_type.image_collection,
  description: cds_notice.body + |||

    ERA5 is the fifth generation ECMWF atmospheric reanalysis of the global climate.
    Reanalysis combines model data with observations from across the world into
    a globally complete and consistent dataset. ERA5 replaces its predecessor,
    the ERA-Interim reanalysis.

    ERA5 MONTHLY provides aggregated values for each month for seven ERA5
    climate reanalysis  parameters: 2m air temperature, 2m dewpoint temperature,
    total precipitation,
    mean sea level pressure, surface pressure, 10m u-component of wind and
    10m v-component of wind. Additionally, monthly minimum and maximum air
    temperature at 2m has been calculated based on the hourly 2m air temperature
    data. Monthly total precipitation values are given as monthly sums.
    All other parameters are provided as monthly averages.

    ERA5 data is available from 1940 to three months from real-time, the version in the EE Data Catalog is available from 1979. More information
    and more ERA5 atmospheric parameters can be found at the
    [Copernicus Climate Data Store](https://cds.climate.copernicus.eu/cdsapp#!/dataset/reanalysis-era5-single-levels-monthly-means?tab=overview).

    Provider's Note: Monthly aggregates have been calculated based on the ERA5 hourly values
    of each parameter.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'climate',
    'copernicus',
    'dewpoint',
    'ecmwf',
    'era5',
    'precipitation',
    'pressure',
    'reanalysis',
    'surface',
    'temperature',
    'wind',
  ],
  providers: [
    ee.producer_provider('ECMWF / Copernicus Climate Change Service', 'https://cds.climate.copernicus.eu/cdsapp#!/dataset/reanalysis-era5-single-levels-monthly-means?tab=overview'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1979-01-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'month',
        description: 'Month of the data',
        type: ee_const.var_type.int,
      },
      {
        name: 'year',
        description: 'Year of the data',
        type: ee_const.var_type.int,
      },
    ],
    gsd: [
      27830.0,
    ],
    'eo:bands': [
      {
        name: 'mean_2m_air_temperature',
        description: 'Average air temperature at 2m height (monthly average)',
        'gee:units': units.kelvin,
      },
      {
        name: 'minimum_2m_air_temperature',
        description: 'Minimum air temperature at 2m height (monthly minimum)',
        'gee:units': units.kelvin,
      },
      {
        name: 'maximum_2m_air_temperature',
        description: 'Maximum air temperature at 2m height (monthly maximum)',
        'gee:units': units.kelvin,
      },
      {
        name: 'dewpoint_2m_temperature',
        description: 'Dewpoint temperature at 2m height (monthly average)',
        'gee:units': units.kelvin,
      },
      {
        name: 'total_precipitation',
        description: 'Total precipitation (monthly sums)',
        'gee:units': units.meter,
      },
      {
        name: 'surface_pressure',
        description: 'Surface pressure (monthly average)',
        'gee:units': units.pascal,
      },
      {
        name: 'mean_sea_level_pressure',
        description: 'Mean sea level pressure (monthly average)',
        'gee:units': units.pascal,
      },
      {
        name: 'u_component_of_wind_10m',
        description: '10m u-component of wind (monthly average)',
        'gee:units': units.velocity_si,
      },
      {
        name: 'v_component_of_wind_10m',
        description: '10m v-component of wind (monthly average)',
        'gee:units': units.velocity_si,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Monthly average air temperature [K] at 2m height',
        lookat: {
          lat: 21.2,
          lon: 22.2,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              250.0,
            ],
            max: [
              320.0,
            ],
            palette: [
              '000080',
              '0000d9',
              '4000ff',
              '8000ff',
              '0080ff',
              '00ffff',
              '00ff80',
              '80ff00',
              'daff00',
              'ffff00',
              'fff500',
              'ffda00',
              'ffb000',
              'ffa400',
              'ff4f00',
              'ff2500',
              'ff0a00',
              'ff00ff',
            ],
            bands: [
              'mean_2m_air_temperature',
            ],
          },
        },
      },
      {
        display_name: 'Monthly sums of total precipitation in m',
        lookat: {
          lon: 21.2,
          lat: 22.2,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              0.5,
            ],
            palette: [
              'ffffff',
              '00ffff',
              '0080ff',
              'da00ff',
              'ffa400',
              'ff0000',
            ],
            bands: [
              'total_precipitation',
            ],
          },
        },
      },
      {
        display_name: 'Monthly mean surface pressure',
        lookat: {
          lon: 21.2,
          lat: 22.2,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              500.0,
            ],
            max: [
              1150.0,
            ],
            palette: [
              '01ffff',
              '058bff',
              '0600ff',
              'df00ff',
              'ff00ff',
              'ff8c00',
              'ff8c00',
            ],
            bands: [
              'surface_pressure',
            ],
          },
        },
      },
      {
        display_name: 'Monthly mean u-component of wind at 10m',
        lookat: {
          lon: 21.2,
          lat: 22.2,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              30.0,
            ],
            palette: [
              'ffffff',
              'ffff71',
              'deff00',
              '9eff00',
              '77b038',
              '007e55',
              '005f51',
              '004b51',
              '013a7b',
              '023aad',
            ],
            bands: [
              'u_component_of_wind_10m',
            ],
          },
        },
      },
    ],
    mean_2m_air_temperature: {
      minimum: 224.0,
      maximum: 304.0,
      'gee:estimated_range': true,
    },
    minimum_2m_air_temperature: {
      minimum: 213.1,
      maximum: 298.9,
      'gee:estimated_range': true,
    },
    maximum_2m_air_temperature: {
      minimum: 233.8,
      maximum: 314.3,
      'gee:estimated_range': true,
    },
    dewpoint_2m_temperature: {
      minimum: 219.8,
      maximum: 297.6,
      'gee:estimated_range': true,
    },
    total_precipitation: {
      minimum: 0.0,
      maximum: 0.4,
      'gee:estimated_range': true,
    },
    surface_pressure: {
      minimum: 65256.9,
      maximum: 102427.0,
      'gee:estimated_range': true,
    },
    mean_sea_level_pressure: {
      minimum: 98206.4,
      maximum: 102943.0,
      'gee:estimated_range': true,
    },
    u_component_of_wind_10m: {
      minimum: -8.7,
      maximum: 8.7,
      'gee:estimated_range': true,
    },
    v_component_of_wind_10m: {
      minimum: -6.8,
      maximum: 6.8,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Copernicus Climate Change Service (C3S) (2017): ERA5: Fifth generation of ECMWF atmospheric reanalyses of the global climate.
    Copernicus Climate Change Service Climate Data Store (CDS), (date of access), [https://cds.climate.copernicus.eu/cdsapp#!/home](https://cds.climate.copernicus.eu/cdsapp#!/home)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': |||
    Please acknowledge the use of ERA5 as stated in the [Copernicus C3S/CAMS License agreement](https://apps.ecmwf.int/datasets/licences/copernicus/):

    - 5.1.1 Where the Licensee communicates or distributes Copernicus Products to the public,
    the Licensee shall inform the recipients of the source by using the following or any similar notice: "Generated using
    Copernicus Climate Change Service information (Year)".
    - 5.1.2 Where the Licensee makes or contributes to a publication or distribution containing adapted or
    modified Copernicus Products, the Licensee shall provide the following or any similar notice: "Contains modified Copernicus
    Climate Change Service information (Year)".
    - 5.1.3 Any such publication or distribution covered by clauses 5.1.1 and 5.1.2 shall state that neither the European Commission
    nor ECMWF is responsible for any use that may be made of the Copernicus information or Data it contains.
  |||,
  'gee:user_uploaded': true,
}
