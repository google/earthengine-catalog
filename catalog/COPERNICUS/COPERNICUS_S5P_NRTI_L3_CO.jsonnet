local id = 'COPERNICUS/S5P/NRTI/L3_CO';
local subdir = 'COPERNICUS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local s5p_desc = importstr 'COPERNICUS_S5P_description.md';
local COPERNICUS_S5P = import 'COPERNICUS_S5P.libsonnet';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
  ],
  id: id,
  title: 'Sentinel-5P NRTI CO: Near Real-Time Carbon Monoxide',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    ### NRTI/L3_CO

    This dataset provides near real-time high-resolution imagery of CO
    concentrations.

    Carbon monoxide (CO) is an important atmospheric trace gas for understanding
    tropospheric chemistry. In certain urban areas, it is a major atmospheric
    pollutant. Main sources of CO are combustion of fossil fuels, biomass burning,
    and atmospheric oxidation of methane and other hydrocarbons. Whereas fossil
    fuel combustion is the main source of CO at northern mid-latitudes, the oxidation
    of isoprene and biomass burning play an important role in the tropics. TROPOMI
    on the Sentinel 5 Precursor (S5P) satellite observes the CO global abundance
    exploiting clear-sky and cloudy-sky Earth radiance measurements in the 2.3 &mu;m
    spectral range of the shortwave infrared (SWIR) part of the solar spectrum.
    TROPOMI clear sky observations provide CO total columns with sensitivity to the
    tropospheric boundary layer. For cloudy atmospheres, the column sensitivity
    changes according to the light path. [[More information](http://www.tropomi.eu/data-products/carbon-monoxide)]

    ### NRTI L3 Product

    To make our NRTI L3 products, we use [harpconvert](https://stcorp.github.io/harp/doc/html/harpconvert.html)
    to grid the data.

    Example harpconvert invocation for one tile:
    ```
    harpconvert --format hdf5 --hdf5-compression 9
    -a 'CO_column_number_density_validity>50;derive(datetime_stop {time});
    bin_spatial(2001, 50.000000, 0.01, 2001, -120.000000, 0.01);
    keep(CO_column_number_density,H2O_column_number_density,cloud_height,
    sensor_altitude,sensor_azimuth_angle, sensor_zenith_angle,
    solar_azimuth_angle,solar_zenith_angle)'
    S5P_NRTI_L2__CO_____20181122T000018_20181122T000518_05741_01_010200_20181122T004844.nc
    output.h5
    ```

  ||| + s5p_desc,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'air_quality',
    'carbon_monoxide',
    'copernicus',
    'esa',
    'eu',
    'knmi',
    'pollution',
    's5p',
    'sentinel',
    'sron',
    'tropomi',
  ],
  providers: COPERNICUS_S5P.providers(self_ee_catalog_url),
  extent: ee.extent_global('2018-11-22T12:00:13Z', null),
  summaries: {
    'gee:schema': COPERNICUS_S5P.schema(),
    gsd: [
      1113.2,
    ],
    platform: [
      'Sentinel-5P',
    ],
    instruments: [
      'TROPOMI',
    ],
    'eo:bands': [
      {
        name: 'CO_column_number_density',
        description: 'Vertically integrated CO column density.',
        'gee:units': 'mol/m^2',
      },
      {
        name: 'H2O_column_number_density',
        description: 'Water vapor column.',
        'gee:units': 'mol/m^2',
      },
      {
        name: 'cloud_height',
        description: 'Scattering layer height.',
        'gee:units': units.meters,
      },
      {
        name: 'sensor_altitude',
        description: 'Altitude of the satellite with respect to the geodetic sub-satellite point\n(WGS84).',
        'gee:units': units.meters,
      },
    ] + COPERNICUS_S5P.bands_common,
    'gee:visualizations': [
      {
        display_name: 'RGB',
        lookat: {
          lat: 25.01,
          lon: 96.68,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              0.05,
            ],
            palette: [
              'black',
              'blue',
              'purple',
              'cyan',
              'green',
              'yellow',
              'red',
            ],
            bands: [
              'CO_column_number_density',
            ],
          },
        },
      },
    ],
    CO_column_number_density: {
      minimum: -279.0,
      maximum: 4.64,
      'gee:estimated_range': true,
    },
    H2O_column_number_density: {
      minimum: -465360.0,
      maximum: 34584412.0,
      'gee:estimated_range': true,
    },
    cloud_height: {
      minimum: -8341.0,
      maximum: 5000.0,
      'gee:estimated_range': true,
    },
    sensor_altitude: {
      minimum: 828542.0,
      maximum: 856078.0,
      'gee:estimated_range': true,
    },
    sensor_azimuth_angle: {
      minimum: -180.0,
      maximum: 180.0,
      'gee:estimated_range': true,
    },
    sensor_zenith_angle: {
      minimum: 1.0,
      maximum: 66.0,
      'gee:estimated_range': true,
    },
    solar_azimuth_angle: {
      minimum: -180.0,
      maximum: 180.0,
      'gee:estimated_range': true,
    },
    solar_zenith_angle: {
      minimum: 9.0,
      maximum: 80.0,
      'gee:estimated_range': true,
    },
  },
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 2,
  },
  'gee:terms_of_use': COPERNICUS_S5P.terms_of_use,
}
