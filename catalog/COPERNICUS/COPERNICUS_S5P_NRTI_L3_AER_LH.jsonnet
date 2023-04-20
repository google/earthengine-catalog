local id = 'COPERNICUS/S5P/NRTI/L3_AER_LH';
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
  title: 'Sentinel-5P NRTI AER LH: Near Real-Time UV Aerosol Layer Height',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    ### NRTI/L3_AER_LH

    This dataset provides offline high-resolution imagery of the UV Aerosol Index
    (UVAI), also called the Absorbing Layer Height (ALH).

    The ALH is very sensitive to cloud contamination. However, aerosols and clouds can
    be difficult to distinguish, and ALH is computed for all FRESCO effective cloud
    fractions smaller than 0.05. Cloud masks are available from FRESCO and VIIRS, and
    are strongly recommended to filter for residual clouds. A sunglint mask is also
    available to screen sunglint regions, which are not filtered beforehand.

    It is known that high surface albedos negatively influence the ALH, biasing the ALH
    towards the surface. In general, the ALH over (dark) oceans is considered reliable
    to within the requirement of 1000 m or 100 hPa. Over land, especially bright surfaces,
    the accuracy may be lower, and the use of the ALH product over bright surfaces like
    deserts is not advisable.

    For this L3 AER_LH product, the aerosol_mid_pressure is calculated with a
    pair of measurements at the 354 nm and 388 nm wavelengths.  The
    [COPERNICUS/S5P/OFFL/L3_SO2](https://developers.google.com/earth-engine/datasets/catalog/COPERNICUS_S5P_OFFL_L3_SO2)
    product has the absorbing_aerosol_index calculated using the 340 nm and 380
    nm wavelengths.

    Example harpconvert invocation for one tile:
    ```
    harpconvert --format hdf5 --hdf5-compression 9
    -a 'aerosol_height_validity>50;derive(datetime_stop {time});
    bin_spatial(2001, 50.000000, 0.01, 2001, -120.000000, 0.01);
    keep(aerosol_height,aerosol_pressure,aerosol_optical_depth,
         sensor_zenith_angle,sensor_azimuth_angle,solar_azimuth_angle,solar_zenith_angle)'
    S5P_NRTI_L2__AER_LH_20191202T233055_20191202T233555_11074_01_010302_20191203T012120.nc
    output.h5
    ```

  ||| + s5p_desc  ,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'aerosol',
    'air_quality',
    'alh',
    'copernicus',
    'esa',
    'eu',
    'knmi',
    'pollution',
    's5p',
    'sentinel',
    'tropomi',
    'uvai',
  ],
  providers: COPERNICUS_S5P.providers(self_ee_catalog_url),
  extent: ee.extent_global('2018-07-10T11:17:44Z', null),
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
        name: 'aerosol_height',
        description: |||
          The aerosol layer pressure is converted into an aerosol layer altitude using an
          appropriate temperature profile, i.e. the temperature profile used in the retrieval.
          The value is given relative to the geoid.
        |||,
        'gee:units': units.meters,
      },
      {
        name: 'aerosol_pressure',
        description: |||
          Pressure of an aerosol layer with an assumed pressure thickness of (currently) 50
          hPa and a constant aerosol volume extinction coefficient and single scattering
          albedo.
        |||,
        'gee:units': 'Pa',
      },
      {
        name: 'aerosol_optical_depth',
        description: 'Aerosol optical thickness &tau; of the assumed aerosol layer. The optical thickness\nholds for 760 nm.',
        'gee:units': 'Pa',
      },
      {
        name: 'sensor_azimuth_angle',
        description: 'Azimuth angle of the satellite at the ground pixel location (WGS84); angle\nmeasured East-of-North.',
        'gee:units': units.degree,
      },
      {
        name: 'sensor_zenith_angle',
        description: |||
          Zenith angle of the satellite at the ground pixel location (WGS84); angle
          measured away from the vertical.
        |||,
        'gee:units': units.degree,
      },
      {
        name: 'solar_azimuth_angle',
        description: 'Azimuth angle of the Sun at the ground pixel location (WGS84); angle\nmeasured East-of-North.',
        'gee:units': units.degree,
      },
      {
        name: 'solar_zenith_angle',
        description: |||
          Zenith angle of the satellite at the ground pixel location (WGS84); angle
          measured away from the vertical.
        |||,
        'gee:units': units.degree,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'RGB',
        lookat: {
          lat: 24.27,
          lon: 44.09,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              -81.17,
            ],
            max: [
              67622.56,
            ],
            palette: [
              'blue',
              'purple',
              'cyan',
              'green',
              'yellow',
              'red',
            ],
            bands: [
              'aerosol_height',
            ],
          },
        },
      },
    ],
    aerosol_height: {
      minimum: -81.17,
      maximum: 67622.56,
      'gee:estimated_range': true,
    },
    aerosol_pressure: {
      minimum: 2.69,
      maximum: 102885.94,
      'gee:estimated_range': true,
    },
    aerosol_optical_depth: {
      minimum: -0.6,
      maximum: 37.42,
      'gee:estimated_range': true,
    },
    sensor_azimuth_angle: {
      minimum: -180.0,
      maximum: 180.0,
      'gee:estimated_range': true,
    },
    sensor_zenith_angle: {
      minimum: 0.098,
      maximum: 66.87,
      'gee:estimated_range': true,
    },
    solar_azimuth_angle: {
      minimum: -180.0,
      maximum: 180.0,
      'gee:estimated_range': true,
    },
    solar_zenith_angle: {
      minimum: 12.93,
      maximum: 74.7,
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
