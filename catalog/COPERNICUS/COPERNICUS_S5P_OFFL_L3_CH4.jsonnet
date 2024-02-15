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

local s5p_desc = importstr 'COPERNICUS_S5P_description.md';
local COPERNICUS_S5P = import 'COPERNICUS_S5P.libsonnet';

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
    [More information.](http://www.tropomi.eu/data-products/methane)

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

  ||| + s5p_desc,
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
  providers: COPERNICUS_S5P.providers(self_ee_catalog_url),
  extent: ee.extent_global('2019-02-08T08:13:16Z', null),
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
        name: 'CH4_column_volume_mixing_ratio_dry_air',
        description: |||
          Column-averaged dry air mixing ratio of methane, as parts-per-billion
        |||,
        'gee:units': units.mole_fraction,
      },
      {
        name: 'aerosol_height',
        description: 'Aerosol height parameter in the CH<sub>4</sub> retrieval',
        'gee:units': units.meter,
      },
      {
        name: 'aerosol_optical_depth',
        description: 'aerosol optical thickness in the SWIR band',
      },
    ] + COPERNICUS_S5P.bands_common +
    [
      {
        name: 'CH4_column_volume_mixing_ratio_dry_air_bias_corrected',
        description: |||
          Column-averaged dry air mixing ratio of methane, as parts-per-billion,
          corrected for surface albedo
        |||,
        'gee:units': units.mole_fraction,
      },
      {
        name: 'CH4_column_volume_mixing_ratio_dry_air_uncertainty',
        description: |||
          Uncertainty of the column averaged dry air mixing ratio of methane
          (1 sigma error)
        |||,
        'gee:units': units.mole_fraction,
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
  'gee:terms_of_use': COPERNICUS_S5P.terms_of_use,
}
