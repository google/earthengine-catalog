local id = 'COPERNICUS/S5P/OFFL/L3_CH4';
local subdir = 'COPERNICUS';

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
  ],
  id: id,
  title: 'Sentinel-5P OFFL CH4: Offline Methane',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    ### OFFL/L3_CH4

    This dataset provides offline high-resolution imagery of methane
    concentrations.

    Methane (CH<sub>4</sub>) is, after carbon dioxide (CO<sub>2</sub>), the most
    important contributor to the anthropogenically enhanced greenhouse effect.
    Roughly three-quarters of methane emissions are anthropogenic and as such it
    is important to continue the record of satellite based measurements. TROPOMI
    aims at providing CH<sub>4</sub> column concentrations with high sensitivity
    to the Earth's surface, good spatiotemporal coverage, and sufficient
    accuracy to facilitate inverse modeling of sources and sinks. TROPOMI uses
    absorption information from the Oxygen-A Band (760nm) and the SWIR spectral
    range to monitor CH<sub>4</sub> abundances in the Earth's atmosphere.
    [[More information](http://www.tropomi.eu/data-products/methane)]

    Currently, the following data quality issues are known, are not covered by
    the quality flags, and should be kept in mind when looking at the methane
    product and also at preliminary validation results. For more details, see
    the [MPC VDAF website](http://mpc-vdaf.tropomi.eu).

    Filtering on qa_value &lt; 0.5 does not remove all pixels considered bad.
    Some pixels with too low methane concentrations are still present:

     - Single TROPOMI overpasses show stripes of erroneous CH<sub>4</sub> values
       in the flight direction.

     - Not all pixels above inland water are filtered.

     - Uncertainties for the XCH<sub>4</sub> is only based on the single
       sounding precision due to measurement noise. For applications requiring
       an overall uncertainty estimate, we propose to multiply the provided
       error by a factor 2, which reflects the scatter of single sounding errors
       in the TCCON validation.

     - Data prior to November 2021 only provides XCH<sub>4</sub> over land,
       after which glint ocean observations were added.

     - No data are present between 2022-07-26 and 2022-08-31 due to a
       [provider outage](https://scihub.copernicus.eu/news/News01082).

    ### OFFL L3 Product

    To make our OFFL L3 products, we find which areas within the product's
    bounding box contain data by using a command like this:

    ```
    harpconvert --format hdf5 --hdf5-compression 9
    -a 'CH4_column_volume_mixing_ratio_dry_air_validity>50;derive(datetime_stop {time})'
    S5P_OFFL_L2__CH4____20190223T202409_20190223T220540_07072_01_010202_20190301T221106.nc
    grid_info.h5
    ```

    We then merge all the data into one large mosaic (area-averaging values for
    pixels that may have different values for different times).  From the
    mosaic, we create a set of tiles containing orthorectified raster data.

    Example harpconvert invocation for one tile:
    ```
    harpconvert --format hdf5 --hdf5-compression 9
    -a 'CH4_column_volume_mixing_ratio_dry_air_validity>50;
    derive(datetime_stop {time});
    bin_spatial(2001, 50.000000, 0.01, 2001, -120.000000, 0.01);
    keep(CH4_column_volume_mixing_ratio_dry_air, aerosol_height,
    aerosol_optical_depth, sensor_azimuth_angle, sensor_zenith_angle,
    solar_azimuth_angle, solar_zenith_angle)'
    S5P_OFFL_L2__CH4____20190223T202409_20190223T220540_07072_01_010202_20190301T221106.nc
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
    'climate',
    'copernicus',
    'esa',
    'eu',
    'knmi',
    'methane',
    's5p',
    'sentinel',
    'sron',
    'tropomi',
  ],
  providers: [
    ee.producer_provider('European Union/ESA/Copernicus', 'https://sentinel.esa.int/web/sentinel/user-guides/sentinel-5p-tropomi'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2019-02-08T08:13:16Z', null),
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
        name: 'CH4_column_volume_mixing_ratio_dry_air',
        description: |||
          Column-averaged dry air mixing ratio of methane, as parts-per-billion
        |||,
        'gee:units': 'mol/mol',
      },
      {
        name: 'aerosol_height',
        description: 'Aerosol height parameter in the CH<sub>4</sub> retrieval',
        'gee:units': units.meters,
      },
      {
        name: 'aerosol_optical_depth',
        description: 'aerosol optical thickness in the SWIR band',
      },
      {
        name: 'sensor_azimuth_angle',
        description: |||
          Azimuth angle of the satellite at the ground pixel location (WGS84);
          angle measured East-of-North.
        |||,
        'gee:units': 'degrees',
      },
      {
        name: 'sensor_zenith_angle',
        description: |||
          Zenith angle of the satellite at the ground pixel location (WGS84);
          angle measured away from the vertical.
        |||,
        'gee:units': 'degrees',
      },
      {
        name: 'solar_azimuth_angle',
        description: |||
          Azimuth angle of the Sun at the ground pixel location (WGS84); angle
          measured East-of-North.
        |||,
        'gee:units': 'degrees',
      },
      {
        name: 'solar_zenith_angle',
        description: |||
          Zenith angle of the satellite at the ground pixel location (WGS84);
          angle measured away from the vertical.
        |||,
        'gee:units': 'degrees',
      },
      {
        name: 'CH4_column_volume_mixing_ratio_dry_air_bias_corrected',
        description: |||
          Column-averaged dry air mixing ratio of methane, as parts-per-billion,
          corrected for surface albedo
        |||,
        'gee:units': 'mol/mol',
      },
      {
        name: 'CH4_column_volume_mixing_ratio_dry_air_uncertainty',
        description: |||
          Uncertainty of the column averaged dry air mixing ratio of methane
          (1 sigma error)
        |||,
        'gee:units': 'mol/mol',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'RGB',
        lookat: {
          lon: 2.11,
          lat: 30.92,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              1750.0,
            ],
            max: [
              1900.0,
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
              'CH4_column_volume_mixing_ratio_dry_air',
            ],
          },
        },
      },
    ],
    CH4_column_volume_mixing_ratio_dry_air: {
      minimum: 1285.0,
      maximum: 2405.0,
      'gee:estimated_range': true,
    },
    aerosol_height: {
      minimum: 906.0,
      maximum: 11251.0,
      'gee:estimated_range': true,
    },
    aerosol_optical_depth: {
      minimum: 0.00032,
      maximum: 0.2405,
      'gee:estimated_range': true,
    },
    sensor_azimuth_angle: {
      minimum: -180.0,
      maximum: 180.0,
      'gee:estimated_range': true,
    },
    sensor_zenith_angle: {
      minimum: 1.0,
      maximum: 60.0,
      'gee:estimated_range': true,
    },
    solar_azimuth_angle: {
      minimum: -180.0,
      maximum: 180.0,
      'gee:estimated_range': true,
    },
    solar_zenith_angle: {
      minimum: 6.0,
      maximum: 70.0,
      'gee:estimated_range': true,
    },
    CH4_column_volume_mixing_ratio_dry_air_bias_corrected: {
      minimum: 1295.0,
      maximum: 2432.0,
      'gee:estimated_range': true,
    },
    CH4_column_volume_mixing_ratio_dry_air_uncertainty: {
      minimum: 0.0,
      maximum: 10.0,
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
