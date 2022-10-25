local id = 'COPERNICUS/S5P/NRTI/L3_AER_LH';
local subdir = 'COPERNICUS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

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

    ### Sentinel-5 Precursor

    Sentinel-5 Precursor is a satellite launched on 13 October 2017
    by the European Space Agency to monitor air pollution.  The onboard sensor
    is frequently referred to as Tropomi (TROPOspheric Monitoring Instrument).

    All of the S5P datasets, except CH<sub>4</sub>, have two versions: Near Real-Time (NRTI) and Offline
    (OFFL). CH<sub>4</sub> is available as OFFL only. The NRTI assets cover a smaller area than the OFFL
    assets, but appear more quickly after acquisition.  The OFFL assets contain data
    from a single orbit (which, due to half the earth being dark, contains
    data only for a single hemisphere).

    Because of noise on the data, negative vertical column values are often
    observed in particular over clean regions or for low SO2 emissions. It is
    recommended not to filter these values except for outliers, i.e.
    for vertical columns lower than -0.001 mol/m^2.

    The original Sentinel 5P Level 2 (L2) data is binned
    by time, not by latitude/longitude.  To make it possible to ingest the data
    into Earth Engine, each Sentinel 5P L2 product is converted to L3, keeping
    a single grid per orbit (that is, no aggregation across products
    is performed).

    Source products spanning the antimeridian are ingested as two Earth Engine
    assets, with suffixes _1 and _2.

    The conversion to L3 is done by the [harpconvert](https://cdn.rawgit.com/stcorp/harp/master/doc/html/harpconvert.html)
    tool using the `bin_spatial` operation.  The source data is filtered to
    remove pixels with QA values less than:

    *  80% for AER_AI
    *  75% for the tropospheric_NO2_column_number_density band of NO2
    *  50% for all other datasets except for O3 and SO2

    The O3_TCL product is ingested directly (without running harpconvert).
  |||,
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
  providers: [
    ee.producer_provider('European Union/ESA/Copernicus', 'https://sentinel.esa.int/web/sentinel/user-guides/sentinel-5p-tropomi'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2018-07-10T11:17:44Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'ALGORITHM_VERSION',
        description: |||
          The algorithm version used in L2 processing. It is separate from the
          processor (framework) version, to accommodate different release
          schedules for different products.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'BUILD_DATE',
        description: |||
          The date, expressed as milliseconds since 1 Jan 1970,
          when the software used to perform L2 processing was built.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'HARP_VERSION',
        description: 'The version of the HARP tool used to grid the L2 data into an L3\nproduct.',
        type: ee_const.var_type.int,
      },
      {
        name: 'INSTITUTION',
        description: 'The institution where data processing from L1 to L2 was performed.',
        type: ee_const.var_type.string,
      },
      {
        name: 'L3_PROCESSING_TIME',
        description: |||
          The date, expressed as milliseconds since 1 Jan 1970,
          when Google processed the L2 data into L3 using harpconvert.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'LAT_MAX',
        description: 'The maximum latitude of the asset (degrees).',
        type: ee_const.var_type.double,
      },
      {
        name: 'LAT_MIN',
        description: 'The minimum latitude of the asset (degrees).',
        type: ee_const.var_type.double,
      },
      {
        name: 'LON_MAX',
        description: 'The maximum longitude of the asset (degrees).',
        type: ee_const.var_type.double,
      },
      {
        name: 'LON_MIN',
        description: 'The minimum longitude of the asset (degrees).',
        type: ee_const.var_type.double,
      },
      {
        name: 'ORBIT',
        description: 'The orbit number of the satellite when the data was acquired.',
        type: ee_const.var_type.int,
      },
      {
        name: 'PLATFORM',
        description: 'Name of the platform which acquired the data.',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROCESSING_STATUS',
        description: |||
          The processing status of the product on a global level, mainly based
          on the availability of auxiliary input data.  Possible values are
          "Nominal" and "Degraded".
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'PROCESSOR_VERSION',
        description: 'The version of the software used for L2 processing, as a string of\nthe form "major.minor.patch".',
        type: ee_const.var_type.string,
      },
      {
        name: 'PRODUCT_ID',
        description: 'Id of the L2 product used to generate this asset.',
        type: ee_const.var_type.string,
      },
      {
        name: 'PRODUCT_QUALITY',
        description: |||
          Indicator that specifies whether the product quality is degraded or
          not.  Allowed values are "Degraded" and "Nominal".
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SENSOR',
        description: 'Name of the sensor which acquired the data.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SPATIAL_RESOLUTION',
        description: |||
          Spatial resolution at nadir. For most products this is `3.5x7km2`,
          except for `L2__O3__PR`, which uses `28x21km2`, and
          `L2__CO____` and `L2__CH4___`, which both use `7x7km2`.
          This attribute originates from the CCI standard.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'TIME_REFERENCE_DAYS_SINCE_1950',
        description: 'Days from 1 Jan 1950 to when the data was acquired.',
        type: ee_const.var_type.int,
      },
      {
        name: 'TIME_REFERENCE_JULIAN_DAY',
        description: 'The Julian day number when the data was acquired.',
        type: ee_const.var_type.double,
      },
      {
        name: 'TRACKING_ID',
        description: 'UUID for the L2 product file.',
        type: ee_const.var_type.string,
      },
    ],
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
        'gee:units': 'm',
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
        'gee:units': 'degrees',
      },
      {
        name: 'sensor_zenith_angle',
        description: |||
          Zenith angle of the satellite at the ground pixel location (WGS84); angle
          measured away from the vertical.
        |||,
        'gee:units': 'degrees',
      },
      {
        name: 'solar_azimuth_angle',
        description: 'Azimuth angle of the Sun at the ground pixel location (WGS84); angle\nmeasured East-of-North.',
        'gee:units': 'degrees',
      },
      {
        name: 'solar_zenith_angle',
        description: |||
          Zenith angle of the satellite at the ground pixel location (WGS84); angle
          measured away from the vertical.
        |||,
        'gee:units': 'degrees',
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
  'gee:terms_of_use': |||
    The use of Sentinel data is governed by the [Copernicus
    Sentinel Data Terms and Conditions.](https://sentinel.esa.int/documents/247904/690755/Sentinel_Data_Legal_Notice)
  |||,
}
