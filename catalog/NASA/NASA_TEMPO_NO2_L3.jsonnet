local id = 'NASA/TEMPO/NO2_L3';
local subdir = 'NASA';

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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'TEMPO gridded NO2 tropospheric and stratospheric columns V03',
  version: 'V03',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Nitrogen dioxide Level 3 files provide trace gas information on a regular
    grid covering the TEMPO field of regard for nominal TEMPO observations.
    Level 3 files are derived by combining information from all Level 2 files
    constituting a TEMPO East-West scan cycle. The rasters contain information
    on tropospheric, stratospheric and total nitrogen dioxide vertical columns,
    ancillary data used in air mass factor and stratospheric/tropospheric
    separation calculations, and retrieval quality flags. The re-gridding
    algorithm uses an area-weighted approach.

    * [General Documentation](https://asdc.larc.nasa.gov/documents/tempo/guide/TEMPO_Level-2-3_trace_gas_clouds_user_guide_V1.2.pdf)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/IS-40e/TEMPO/NO2_L3.003',
    },
  ],
  'gee:categories': ['satellite-imagery'],
  keywords: [
    'air_quality',
    'nasa',
    'nitrogen_dioxide',
    'pollution',
    'tropomi',
  ],
  providers: [
    ee.producer_provider('NASA ASDC', 'https://asdc.larc.nasa.gov/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2930763263-LARC_CLOUD',
  ],
  extent: ee.extent_global('2023-08-01T00:00:00Z', null),
  summaries: {
    gsd: [
      2226,
    ],
    instruments: [
      'TEMPO',
    ],
    'eo:bands': [
      {
        name: 'weight',
        description: |||
          Sum of Level 2 pixel overlap areas. Represents the weighting factor
          for each grid cell, indicating the fraction of the grid cell area
          with valid data.
        |||,
        'gee:units': units.square_km,
      },
      {
        name: 'vertical_column_troposphere',
        description: 'NO2 troposphere vertical column',
        'gee:units': units.molecules_per_cm2,
      },
      {
        name: 'vertical_column_troposphere_uncertainty',
        description: 'NO2 troposphere vertical column uncertainty',
        'gee:units': units.molecules_per_cm2,
      },
      {
        name: 'vertical_column_stratosphere',
        description: 'NO2 stratosphere vertical column uncertainty',
        'gee:units': units.molecules_per_cm2,
      },
      {
        name: 'main_data_quality_flag',
        description: |||
          Main data quality flag.  Provides an overall assessment of the data
          quality.
        |||,
        'gee:units': units.dimensionless,

        'gee:classes': [
          {
            value: 0,
            description: 'good'
          },
          {
            value: 1,
            description: 'suspect',
          },
          {
            value: 2,
            description: 'bad',
          },
        ]
      },
      {
        name: 'num_vertical_column_troposphere_samples',
        description: |||
          Number of Level 2 pixel values contributing to Level 3 grid for the
          tropospheric vertical column.
        |||,
        'gee:units': units.dimensionless,
      },
      {
        name: 'min_vertical_column_troposphere_sample',
        description: |||
          Smallest Level 2 pixel value contributing to Level 3 grid for the
          tropospheric vertical column.
        |||,
        'gee:units': units.molecules_per_cm2,
      },
      {
        name: 'max_vertical_column_troposphere_sample',
        description: |||
          Largest Level 2 pixel value contributing to Level 3 grid for the
          tropospheric vertical column.
        |||,
        'gee:units': units.molecules_per_cm2,
      },
      {
        name: 'num_vertical_column_troposphere_uncertainty_samples',
        description: |||
          Number of Level 2 pixel values contributing to Level 3 grid for the
          tropospheric vertical column uncertainty.
        |||,
        'gee:units': units.dimensionless,
      },
      {
        name: 'min_vertical_column_troposphere_uncertainty_sample',
        description: |||
          Smallest Level 2 pixel value contributing to Level 3 grid for the
          tropospheric vertical column uncertainty.
        |||,
        'gee:units': units.molecules_per_cm2,
      },
      {
        name: 'max_vertical_column_troposphere_uncertainty_sample',
        description: |||
            Largest Level 2 pixel value contributing to Level 3 grid for the
            tropospheric vertical column uncertainty.
        |||,
        'gee:units': units.molecules_per_cm2,
      },
      {
        name: 'num_vertical_column_stratosphere_samples',
        description: |||
          Number of Level 2 pixel values contributing to Level 3 grid for the
          stratospheric vertical column.
        |||,
        'gee:units': units.dimensionless,
      },
      {
        name: 'min_vertical_column_stratosphere_sample',
        description: |||
          Smallest Level 2 pixel value contributing to Level 3 grid for the
          stratospheric vertical column.
        |||,
        'gee:units': units.molecules_per_cm2,
      },
      {
        name: 'max_vertical_column_stratosphere_sample',
        description: |||
          Largest Level 2 pixel value contributing to Level 3 grid for the
          stratospheric vertical column.
        |||,
        'gee:units': units.molecules_per_cm2,
      },
      {
        name: 'num_vertical_column_total_samples',
        description: |||
          Number of Level 2 pixel values contributing to Level 3 grid for the
          total vertical column.
        |||,
        'gee:units': units.dimensionless,
      },
      {
        name: 'min_vertical_column_total_sample',
        description: |||
          Smallest Level 2 pixel value contributing to Level 3 grid for the
          total vertical column.
        |||,
        'gee:units': units.molecules_per_cm2,
      },
      {
        name: 'max_vertical_column_total_sample',
        description: |||
          Largest Level 2 pixel value contributing to Level 3 grid for the
          total vertical column.
        |||,
        'gee:units': units.molecules_per_cm2,
      },
      {
        name: 'solar_zenith_angle',
        description: 'Solar zenith angle at pixel center',
        'gee:units': units.degree,
      },
      {
        name: 'viewing_zenith_angle',
        description: 'Viewing zenith angle at pixel center',
        'gee:units': units.degree,
      },
      {
        name: 'relative_azimuth_angle',
        description: 'Relative azimuth angle at pixel center',
        'gee:units': units.degree,
      },
      {
        name: 'vertical_column_total',
        description: 'NO2 vertical column',
        'gee:units': units.molecules_per_cm2,
      },
      {
        name: 'vertical_column_total_uncertainty',
        description: 'NO2 vertical column uncertainty',
        'gee:units': units.molecules_per_cm2,
      },
      {
        name: 'surface_pressure',
        description: 'Surface pressure',
        'gee:units': units.hectopascal,
      },
      {
        name: 'terrain_height',
        description: 'Terrain height',
        'gee:units': units.meter,
      },
      {
        name: 'snow_ice_fraction',
        description: 'Fraction of pixel area covered by snow and/or ice',
        'gee:units': units.dimensionless,
      },
      {
        name: 'fitted_slant_column',
        description: 'NO2 fitted slant column',
        'gee:units': units.molecules_per_cm2,
      },
      {
        name: 'fitted_slant_column_uncertainty',
        description: 'NO2 fitted slant column uncertainty',
        'gee:units': units.molecules_per_cm2,
      },
      {
        name: 'albedo',
        description: 'Surface albedo',
        'gee:units': units.dimensionless,
      },
      {
        name: 'tropopause_pressure',
        description: 'Tropopause pressure',
        'gee:units': units.hectopascal,
      },
      {
        name: 'amf_total',
        description: 'NO2 air mass factor',
        'gee:units': units.dimensionless,
      },
      {
        name: 'eff_cloud_fraction',
        description: 'Effective cloud fraction',
        'gee:units': units.dimensionless,
      },
      {
        name: 'amf_cloud_fraction',
        description: 'Cloud radiance fraction for AMF calculation',
        'gee:units': units.dimensionless,
      },
      {
        name: 'amf_cloud_pressure',
        description: 'Cloud pressure for AMF calculation',
        'gee:units': units.hectopascal,
      },
      {
        name: 'amf_troposphere',
        description: 'NO2 troposphere air mass factor',
        'gee:units': units.dimensionless,
      },
      {
        name: 'amf_stratosphere',
        description: 'NO2 stratosphere air mass factor',
        'gee:units': units.dimensionless,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Tropospheric NO2',
        lookat: {
          lat: 35,
          lon: -95,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [0],
            max: [1.5e16],
            bands: ['vertical_column_troposphere'],
            palette: [
              '000080',
              '0000D9',
              '4000FF',
              '8000FF',
              '0080FF',
              '00D9FF',
              '80FFFF',
              'FF8080',
              'D90000',
              '800000',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    NASA/LARC/SD/ASDC. (n.d.). TEMPO gridded NO2 tropospheric and stratospheric
    columns V03 (PROVISIONAL) [Data set]. NASA Langley Atmospheric Science Data
    Center DAAC. Retrieved from https://doi.org/10.5067/IS-40e/TEMPO/NO2_L3.003
  |||,
  'gee:terms_of_use': |||
    This dataset is in the public domain and is available
    without restriction on use and distribution. See [NASA's
    Earth Science Data & Information Policy](https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
}
