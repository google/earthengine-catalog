local id = 'COPERNICUS/S5P/OFFL/L3_NO2';
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
  title: 'Sentinel-5P OFFL NO2: Offline Nitrogen Dioxide',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    ### OFFL/L3_NO2

    This dataset provides offline high-resolution imagery of NO<sub>2</sub> concentrations.

    Nitrogen oxides (NO<sub>2</sub> and NO) are important trace gases in the Earth's atmosphere,
    present in both the troposphere and the stratosphere. They enter the atmosphere
    as a result of anthropogenic activities (notably fossil fuel combustion and
    biomass burning) and natural processes (wildfires, lightning, and microbiological processes in
    soils). Here, NO<sub>2</sub> is used to represent concentrations
    of collective nitrogen oxides because during daytime, i.e. in the presence of
    sunlight, a photochemical cycle involving ozone (O<sub>3</sub>) converts NO into NO<sub>2</sub>
    and vice versa on a timescale of minutes. The TROPOMI NO<sub>2</sub> processing system is based
    on the algorithm developments for the DOMINO-2 product and for the EU QA4ECV NO<sub>2</sub>
    reprocessed dataset for OMI, and has been adapted for TROPOMI. This
    retrieval-assimilation-modelling system uses the 3-dimensional global TM5-MP
    chemistry transport model at a resolution of 1x1 degree as an essential element.
    [[More information](http://www.tropomi.eu/data-products/nitrogen-dioxide)]

    ### OFFL L3 Product

    To make our OFFL L3 products, we find areas within the product's bounding
    box with data using a command like this:

    ```
    harpconvert --format hdf5 --hdf5-compression 9
    -a 'tropospheric_NO2_column_number_density_validity>50;derive(datetime_stop {time})'
    S5P_OFFL_L2__NO2____20181010T074409_20181010T092539_05135_01_010100_20181016T092316.nc
    grid_info.h5
    ```

    We then merge all the data into one large mosaic (area-averaging values for
    pixels that may have different values for different times).  From the
    mosaic, we create a set of tiles containing orthorectified raster data.

    Example harpconvert invocation for one tile:
    ```
    harpconvert --format hdf5 --hdf5-compression 9
    -a 'tropospheric_NO2_column_number_density_validity>50;derive(datetime_stop {time});
    bin_spatial(2001, 50.000000, 0.01, 2001, -120.000000, 0.01);
    keep(NO2_column_number_density,tropospheric_NO2_column_number_density,
         stratospheric_NO2_column_number_density,NO2_slant_column_number_density,
         tropopause_pressure,absorbing_aerosol_index,cloud_fraction,
         sensor_altitude,sensor_azimuth_angle,
         sensor_zenith_angle,solar_azimuth_angle,solar_zenith_angle)'
    S5P_OFFL_L2__NO2____20181010T074409_20181010T092539_05135_01_010100_20181016T092316.nc
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
    'knmi',
    'nitrogen_dioxide',
    'no2',
    'pollution',
    's5p',
    'sentinel',
    'tropomi',
  ],
  providers: COPERNICUS_S5P.providers(self_ee_catalog_url),
  extent: ee.extent_global('2018-06-28T10:24:07Z', null),
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
        name: 'NO2_column_number_density',
        description: |||
          Total vertical column of NO<sub>2</sub> (ratio of the slant column density of NO<sub>2</sub>
          and the total air mass factor).
        |||,
        'gee:units': 'mol/m^2',
      },
      {
        name: 'tropospheric_NO2_column_number_density',
        description: 'tropospheric vertical column of NO<sub>2</sub>',
        'gee:units': 'mol/m^2',
      },
      {
        name: 'stratospheric_NO2_column_number_density',
        description: 'stratospheric vertical column of NO<sub>2</sub>',
        'gee:units': 'mol/m^2',
      },
      {
        name: 'NO2_slant_column_number_density',
        description: 'NO<sub>2</sub> slant column density',
        'gee:units': 'mol/m^2',
      },
      {
        name: 'tropopause_pressure',
        description: 'topopause pressure',
        'gee:units': 'Pa',
      },
      {
        name: 'absorbing_aerosol_index',
        description: |||
          Aerosol index (at wavelengths 354/388, i.e. the OMI pair) from the AER_AI
          level 2 product.  See [Level 2 Algorithms - Aerosol Index](https://earth.esa.int/web/sentinel/technical-guides/sentinel-5p/level-2/aerosol-index).
        |||,
        'gee:units': units.dimensionless,
      },
      {
        name: 'cloud_fraction',
        description: |||
          Effective cloud fraction.
          See the [Sentinel 5P L2 Input/Output Data Definition Spec](https://sentinels.copernicus.eu/documents/247904/3119978/Sentinel-5P-Level-2-Input-Output-Data-Definition), p.220.
        |||,
        'gee:units': 'fraction',
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
              0.0002,
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
              'tropospheric_NO2_column_number_density',
            ],
          },
        },
      },
    ],
    NO2_column_number_density: {
      minimum: -0.00051,
      maximum: 0.0192,
      'gee:estimated_range': true,
    },
    tropospheric_NO2_column_number_density: {
      minimum: -0.0005375,
      maximum: 0.0192044,
      'gee:estimated_range': true,
    },
    stratospheric_NO2_column_number_density: {
      minimum: 8.6e-06,
      maximum: 0.000107,
      'gee:estimated_range': true,
    },
    NO2_slant_column_number_density: {
      minimum: 1.48e-05,
      maximum: 0.003908,
      'gee:estimated_range': true,
    },
    tropopause_pressure: {
      minimum: 6156.0,
      maximum: 37345.0,
      'gee:estimated_range': true,
    },
    absorbing_aerosol_index: {
      minimum: -14.43,
      maximum: 10.67,
      'gee:estimated_range': true,
    },
    cloud_fraction: {
      minimum: 0.0,
      maximum: 1.0,
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
      maximum: 82.0,
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
