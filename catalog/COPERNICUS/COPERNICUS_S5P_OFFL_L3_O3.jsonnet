local id = 'COPERNICUS/S5P/OFFL/L3_O3';
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
  title: 'Sentinel-5P OFFL O3: Offline Ozone',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    ### OFFL/L3_O3

    This dataset provides offline high-resolution imagery of total column ozone
    concentrations. See also `COPERNICUS/S5P/OFFL/L3_O3_TCL` for the tropospheric
    column data.

    In the stratosphere, the ozone layer shields the biosphere from dangerous
    solar ultraviolet radiation. In the troposphere, it acts as an efficient
    cleansing agent, but at high concentration it also becomes harmful to the
    health of humans, animals, and vegetation. Ozone is also an important
    greenhouse-gas contributor to ongoing climate change. Since the discovery
    of the Antarctic ozone hole in the 1980s and the subsequent Montreal Protocol
    regulating the production of chlorine-containing ozone-depleting substances,
    ozone has been routinely monitored from the ground and from space.

    For this product, there are two algorithms that deliver total ozone: GDP for
    the near real-time and GODFIT for the offline products. GDP is currently
    being used for generating the operational total ozone products from GOME,
    SCIAMACHY and GOME-2; while GODFIT is being used in the ESA CCI and the
    Copernicus C3S projects.
    [More information.](http://www.tropomi.eu/data-products/total-ozone-column)
    [Product user manual](https://sentinel.esa.int/documents/247904/2474726/Sentinel-5P-Level-2-Product-User-Manual-Ozone-Total-Column)

    ### OFFL L3 Product

    To make our OFFL L3 products, we find areas within the product's bounding
    box with data using a command like this:

    ```
    harpconvert --format hdf5 --hdf5-compression 9
    -a 'O3_column_number_density_validity>50;derive(datetime_stop {time})'
    S5P_OFFL_L2__O3_____20181005T225147_20181006T003317_05073_01_010102_20181012T001415.nc
    grid_info.h5
    ```

    We then merge all the data into one large mosaic (area-averaging values for
    pixels that may have different values for different times).  From the
    mosaic, we create a set of tiles containing orthorectified raster data.

    The qa value is adjusted before running harpconvert to satisfy all of the
    following criteria:

    * ozone_total_vertical_column in [0, 0.45]
    * ozone_effective_temperature in [180, 260]
    * ring_scale_factor in [0, 0.15]
    * effective_albedo in [-0.5, 1.5]

    Example harpconvert invocation for one tile:
    ```
    harpconvert --format hdf5 --hdf5-compression 9
    -a 'O3_column_number_density_validity>50;derive(datetime_stop {time});
    bin_spatial(2001, 50.000000, 0.01, 2001, -120.000000, 0.01);
    keep(O3_column_number_density,O3_effective_temperature,cloud_fraction,
    sensor_altitude,sensor_azimuth_angle, sensor_zenith_angle,
    solar_azimuth_angle,solar_zenith_angle)'
    S5P_OFFL_L2__O3_____20181005T225147_20181006T003317_05073_01_010102_20181012T001415.nc
    output.h5
    ```

  ||| + s5p_desc,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'air_quality',
    'copernicus',
    'esa',
    'eu',
    'o3',
    'ozone',
    'pollution',
    's5p',
    'sentinel',
    'tropomi',
  ],
  providers: COPERNICUS_S5P.providers(self_ee_catalog_url),
  extent: ee.extent_global('2018-09-08T21:19:29Z', null),
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
      {
        name: 'STATUS_MET_2D',
        description: |||
          This dataset uses dynamic auxiliary weather data during L2 processing.
          This field has a value of "Nominal" if ECMWF dynamic auxiliary data was
          available or "Fallback" if not.
        |||,
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
        name: 'O3_column_number_density',
        description: |||
          Total atmospheric column of O<sub>3</sub> between the surface and the top of
          atmosphere, calculated with the [GODfit algorithm](http://adsabs.harvard.edu/full/2005ESASP.572E.204S).
        |||,
        'gee:units': 'mol/m^2',
      },
      {
        name: 'O3_effective_temperature',
        description: 'Ozone cross section effective temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'cloud_fraction',
        description: |||
          Effective cloud fraction.  See the [Sentinel 5P L2 Input/Output Data Definition Spec](https://sentinels.copernicus.eu/documents/247904/3119978/Sentinel-5P-Level-2-Input-Output-Data-Definition),
          p.220.
        |||,
        'gee:units': units.unspecified_fraction,
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
              0.12,
            ],
            max: [
              0.15,
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
              'O3_column_number_density',
            ],
          },
        },
      },
    ],
    O3_column_number_density: {
      minimum: 0.025,
      maximum: 0.3048,
      'gee:estimated_range': true,
    },
    O3_effective_temperature: {
      minimum: 19.92,
      maximum: 428.11,
      'gee:estimated_range': true,
    },
    cloud_fraction: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    sensor_azimuth_angle: {
      minimum: -180.0,
      maximum: 180.0,
      'gee:estimated_range': true,
    },
    sensor_zenith_angle: {
      minimum: 0.098,
      maximum: 66.57,
      'gee:estimated_range': true,
    },
    solar_azimuth_angle: {
      minimum: -180.0,
      maximum: 180.0,
      'gee:estimated_range': true,
    },
    solar_zenith_angle: {
      minimum: 8.0,
      maximum: 102.0,
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
