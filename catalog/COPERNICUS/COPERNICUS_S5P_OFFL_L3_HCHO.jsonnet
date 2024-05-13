local id = 'COPERNICUS/S5P/OFFL/L3_HCHO';
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
  title: 'Sentinel-5P OFFL HCHO: Offline Formaldehyde',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    ### OFFL/L3_HCHO

    This dataset provides offline high-resolution imagery of atmospheric
    formaldehyde (HCHO) concentrations.

    Formaldehyde is an intermediate gas in almost all oxidation chains of non-methane
    volatile organic compounds (NMVOC), leading eventually to CO<sub>2</sub>. Non-Methane Volatile
    Organic Compounds (NMVOCs) are, together with NO<sub>x</sub>, CO and CH<sub>4</sub>, among the
    most important precursors of tropospheric O<sub>3</sub>. The major HCHO source in the remote
    atmosphere is CH<sub>4</sub> oxidation. Over the continents, the oxidation of higher NMVOCs
    emitted from vegetation, fires, traffic and industrial sources results in important
    and localized enhancements of the HCHO levels. The seasonal and inter-annual
    variations of the formaldehyde distribution are principally related to temperature
    changes and fire events, but also to changes in anthropogenic activities. HCHO concentrations
    in the boundary layer can be directly related to the release of short-lived hydrocarbons, which
    mostly cannot be observed directly from space.
    [More information.](http://www.tropomi.eu/data-products/formaldehyde)

    ### OFFL L3 Product

    To make our OFFL L3 products, we find areas within the product's bounding
    box with data using a command like this:

    ```
    harpconvert --format hdf5 --hdf5-compression 9
    -a 'tropospheric_HCHO_column_number_density_validity>50;derive(datetime_stop {time})'
    S5P_OFFL_L2__HCHO___20190116T171037_20190116T185207_06531_01_010105_20190123T104749.nc
    grid_info.h5
    ```

    We then merge all the data into one large mosaic (area-averaging values for
    pixels that may have different values for different times).  From the
    mosaic, we create a set of tiles containing orthorectified raster data.

    Example harpconvert invocation for one tile:

    ```
    harpconvert --format hdf5 --hdf5-compression 9
    -a 'tropospheric_HCHO_column_number_density_validity>50;derive(datetime_stop {time});
    bin_spatial(2001, 50.000000, 0.01, 2001, -120.000000, 0.01);
    keep(tropospheric_HCHO_column_number_density,
         tropospheric_HCHO_column_number_density_amf,
         HCHO_slant_column_number_density,cloud_fraction,sensor_altitude,
         sensor_azimuth_angle, sensor_zenith_angle,solar_azimuth_angle,
         solar_zenith_angle)'
    S5P_OFFL_L2__HCHO___20190116T171037_20190116T185207_06531_01_010105_20190123T104749.nc
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
    'formaldehyde',
    'hcho',
    'pollution',
    's5p',
    'sentinel',
    'tropomi',
  ],
  providers: COPERNICUS_S5P.providers(self_ee_catalog_url),
  extent: ee.extent_global('2018-12-05T12:14:36Z', null),
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
        name: 'tropospheric_HCHO_column_number_density',
        description: 'Tropospheric HCHO column number density.',
        'gee:units': 'mol/m^2',
      },
      {
        name: 'tropospheric_HCHO_column_number_density_amf',
        description: 'Tropospheric air mass factor.',
        'gee:units': 'mol/m^2',
      },
      {
        name: 'HCHO_slant_column_number_density',
        description: 'HCHO slant column number density.',
        'gee:units': 'mol/m^2',
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
          lon: 2.11,
          lat: 16.83,
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
              'tropospheric_HCHO_column_number_density',
            ],
          },
        },
      },
    ],
    tropospheric_HCHO_column_number_density: {
      minimum: -0.0172,
      maximum: 0.0074,
      'gee:estimated_range': true,
    },
    tropospheric_HCHO_column_number_density_amf: {
      minimum: 0.177,
      maximum: 4.058,
      'gee:estimated_range': true,
    },
    HCHO_slant_column_number_density: {
      minimum: -0.01425,
      maximum: 0.00735,
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
      minimum: 8.76,
      maximum: 101.17,
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
