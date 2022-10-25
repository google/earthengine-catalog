local id = 'COPERNICUS/S5P/NRTI/L3_AER_AI';
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
  title: 'Sentinel-5P NRTI AER AI: Near Real-Time UV Aerosol Index',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    ### NRTI/L3_AER_AI

    This dataset provides near real-time high-resolution imagery of the UV Aerosol Index
    (UVAI), also called the Absorbing Aerosol Index (AAI).

    The AAI is based on wavelength-dependent changes in Rayleigh scattering in
    the UV spectral range for a pair of wavelengths.  The difference between
    observed and modelled reflectance results in the AAI.  When the AAI is
    positive, it indicates the presence of UV-absorbing aerosols like dust and
    smoke. It is useful for tracking the evolution of episodic aerosol plumes from
    dust outbreaks, volcanic ash, and biomass burning.

    The wavelengths used have very low ozone absorption, so unlike aerosol optical
    thickness measurements, AAI can be calculated in the presence of clouds.
    Daily global coverage is therefore possible.

    For this L3 AER_AI product, the absorbing_aerosol_index is calculated with a
    pair of measurements at the 354 nm and 388 nm wavelengths.

    ### NRTI L3 Product

    To make our NRTI L3 products, we use
    [harpconvert](https://stcorp.github.io/harp/doc/html/harpconvert.html) to grid the data.

    Example harpconvert invocation for one tile:
    ```
    harpconvert --format hdf5 --hdf5-compression 9
    -a 'absorbing_aerosol_index_validity>50;derive(datetime_stop {time});
    bin_spatial(2001, 50.000000, 0.01, 2001, -120.000000, 0.01);
    keep(absorbing_aerosol_index,sensor_altitude,sensor_azimuth_angle,
         sensor_zenith_angle,solar_azimuth_angle,solar_zenith_angle)'
    S5P_NRTI_L2__AER_AI_20181113T080042_20181113T080542_05618_01_010200_20181113T083707.nc
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
    'aai',
    'aerosol',
    'air_quality',
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
        name: 'absorbing_aerosol_index',
        description: |||
          A measure of the prevalence of aerosols in the atmosphere, calculated by
          [this equation](https://earth.esa.int/web/sentinel/technical-guides/sentinel-5p/level-2/aerosol-index) using the 354/388 wavelength pair.
        |||,
      },
      {
        name: 'sensor_altitude',
        description: 'Altitude of the satellite with respect to the geodetic sub-satellite point\n(WGS84).',
        'gee:units': 'm',
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
              -1.0,
            ],
            max: [
              1.5,
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
              'absorbing_aerosol_index',
            ],
          },
        },
      },
    ],
    absorbing_aerosol_index: {
      minimum: -25.0,
      maximum: 39.0,
      'gee:estimated_range': true,
    },
    sensor_altitude: {
      minimum: 828543.0,
      maximum: 856078.0,
      'gee:estimated_range': true,
    },
    sensor_azimuth_angle: {
      minimum: -180.0,
      maximum: 180.0,
      'gee:estimated_range': true,
    },
    sensor_zenith_angle: {
      minimum: 0.09,
      maximum: 67.0,
      'gee:estimated_range': true,
    },
    solar_azimuth_angle: {
      minimum: -180.0,
      maximum: 180.0,
      'gee:estimated_range': true,
    },
    solar_zenith_angle: {
      minimum: 8.0,
      maximum: 88.0,
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
