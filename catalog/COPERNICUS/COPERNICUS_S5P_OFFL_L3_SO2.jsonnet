local id = 'COPERNICUS/S5P/OFFL/L3_SO2';
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
  title: 'Sentinel-5P OFFL SO2: Offline Sulfur Dioxide',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    ### OFFL/L3_SO2

    This dataset provides offline high-resolution imagery of atmospheric sulfur
    dioxide (SO<sub>2</sub>) concentrations.

    Sulfur dioxide (SO<sub>2</sub>) enters the Earth's atmosphere through both natural and
    anthropogenic processes. It plays a role in chemistry on a local and global
    scale and its impact ranges from short-term pollution to effects on climate.
    Only about 30% of the emitted SO<sub>2</sub> comes from natural sources; the majority
    is of anthropogenic origin. SO<sub>2</sub> emissions adversely affect human health and
    air quality. SO<sub>2</sub> has an effect on climate through radiative forcing, via
    the formation of sulfate aerosols. Volcanic SO<sub>2</sub> emissions can also pose a
    threat to aviation, along with volcanic ash. S5P/TROPOMI samples the Earth's
    surface with a revisit time of one day with unprecedented spatial resolution
    of 3.5 x 7 km which allows the resolution of fine details including the
    detection of much smaller SO<sub>2</sub> plumes.
    [More information.](https://www.tropomi.eu/data-products/sulfur-dioxide)

    For this L3 SO<sub>2</sub> product, the absorbing_aerosol_index is calculated with a
    pair of measurements at the 340 nm and 380 wavelengths.  The
    [COPERNICUS/S5P/OFFL/L3_AER_AI](https://developers.google.com/earth-engine/datasets/catalog/COPERNICUS_S5P_OFFL_L3_AER_AI)
    product has the absorbing_aerosol_index calculated using the 354 nm and 388
    nm wavelengths.

    ### OFFL L3 Product

    To make our OFFL L3 products, we find areas within the product's bounding
    box with data using a command like this:

    ```
    harpconvert --format hdf5 --hdf5-compression 9
    -a 'SO2_column_number_density_validity>50;derive(datetime_stop {time})'
    S5P_OFFL_L2__SO2____20181228T231131_20181229T005301_06265_01_010105_20190104T083244.nc
    grid_info.h5
    ```

    We then merge all the data into one large mosaic (area-averaging values for
    pixels that may have different values for different times).  From the
    mosaic, we create a set of tiles containing orthorectified raster data.

    The qa value is adjusted before running harpconvert to satisfy all of the
    following criteria:

    * snow_ice < 0.5
    * sulfurdioxide_total_air_mass_factor_polluted > 0.1
    * sulfurdioxide_total_vertical_column > -0.001
    * qa_value > 0.5
    * cloud_fraction_crb < 0.3
    * solar_zenith_angle < 60

    The 15km SO2 band is ingested only when solar_zenith_angle < 70.

    Example harpconvert invocation for one tile:
    ```
    harpconvert --format hdf5 --hdf5-compression 9
    -a 'SO2_column_number_density_validity>50;derive(datetime_stop {time});
    bin_spatial(2001, 50.000000, 0.01, 2001, -120.000000, 0.01);
    keep(SO2_column_number_density,SO2_column_number_density_amf,
         SO2_slant_column_number_density,absorbing_aerosol_index,cloud_fraction, sensor_altitude,
         sensor_azimuth_angle, sensor_zenith_angle,solar_azimuth_angle,
         solar_zenith_angle)'
    S5P_OFFL_L2__SO2____20181228T231131_20181229T005301_06265_01_010105_20190104T083244.nc
    output.h5
    ```

  ||| + s5p_desc,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'air_quality',
    'bira',
    'copernicus',
    'dlr',
    'esa',
    'eu',
    'pollution',
    's5p',
    'sentinel',
    'so2',
    'sulfur_dioxide',
    'tropomi',
  ],
  providers: COPERNICUS_S5P.providers(self_ee_catalog_url),
  extent: ee.extent_global('2018-12-05T11:53:01Z', null),
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
        name: 'SO2_column_number_density',
        description: 'SO<sub>2</sub> vertical column density at ground level,\ncalculated using the DOAS technique.',
        'gee:units': 'mol/m^2',
      },
      {
        name: 'SO2_column_number_density_amf',
        description: 'Weighted mean of cloudy and clear air mass factor (amf) weighted by\nintensity-weighted cloud fraction.',
        'gee:units': 'mol/m^2',
      },
      {
        name: 'SO2_slant_column_number_density',
        description: 'SO<sub>2</sub> ring corrected slant column number density',
        'gee:units': 'mol/m^2',
      },
      {
        name: 'absorbing_aerosol_index',
        description: |||
          A measure of the prevalence of aerosols in the atmosphere, calculated by
          [this equation](https://sentinel.esa.int/web/sentinel/data-products/-/asset_publisher/fp37fc19FN8F/content/sentinel-5-precursor-level-2-ultraviolet-aerosol-index) using the 340/380 wavelength pair.
        |||,
      },
      {
        name: 'cloud_fraction',
        description: |||
          Effective cloud fraction.  See the [Sentinel 5P L2 Input/Output Data Definition Spec](https://sentinels.copernicus.eu/documents/247904/3119978/Sentinel-5P-Level-2-Input-Output-Data-Definition),
          p.220.
        |||,
        'gee:units': units.unspecified_fraction,
      },
    ] + COPERNICUS_S5P.bands_common +
    [
      {
        name: 'SO2_column_number_density_15km',
        description: 'SO<sub>2</sub> vertical column density at 15km,\ncalculated using the DOAS technique.',
        'gee:units': 'mol/m^2',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'RGB',
        lookat: {
          lon: 5.27,
          lat: 27.86,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              0.0005,
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
              'SO2_column_number_density',
            ],
          },
        },
      },
    ],
    SO2_column_number_density: {
      minimum: -0.4051,
      maximum: 0.2079,
      'gee:estimated_range': true,
    },
    SO2_column_number_density_amf: {
      minimum: 0.1,
      maximum: 3.387,
      'gee:estimated_range': true,
    },
    SO2_slant_column_number_density: {
      minimum: -0.14746,
      maximum: 0.16159,
      'gee:estimated_range': true,
    },
    absorbing_aerosol_index: {
      minimum: -11.733,
      maximum: 18.657,
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
