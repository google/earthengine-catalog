local id = 'NASA/TEMPO/O3_L3_QA';
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
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'TEMPO gridded ozone total column V03 (PROVISIONAL)',
  version: 'V03',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The TEMPO gridded ozone total column V03 (PROVISIONAL) is a Level 3 dataset
    providing essential total column ozone information on a regular grid across
    North America. Generated from the TEMPO instrument on the IS-40e platform,
    the data is created by combining and re-gridding Level 2 files from single
    East-West scan cycles using an area-weighted methodology. These measurements
    are critical for monitoring continental air quality and atmospheric
    chemistry and are distributed by the NASA Langley Research Center (LaRC)
    ASDC.

    This Level 3 product serves as a quality-controlled version of the Level 2
    data, pre-filtered to include only the highest-quality retrievals.
    Specifically, it includes pixels with a quality flag of 0, solar and
    viewing zenith angles (SZA/VZA) below 80°, and an effective cloud fraction
    under 0.5.

    This dataset includes auxiliary measurements such as effective and radiative
    cloud properties, sulfur dioxide index, and terrain pressure. These
    parameters support a wide range of research applications while ensuring
    that users have access to research-ready data that has already been
    screened for common retrieval anomalies and extreme geometries.

    Documentation:

    * [User's Guide](https://asdc.larc.nasa.gov/documents/tempo/guide/TEMPO_Level-2-3_O3TOT_user_guide_V2.0.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://asdc.larc.nasa.gov/documents/tempo/TEMPO_O3TOT_Algorithm_description_V2.0.pdf)

    * [General Documentation](https://asdc.larc.nasa.gov/project/TEMPO)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/IS-40e/TEMPO/O3TOT_L3.003',
    },
  ],
  'gee:categories': ['satellite-imagery'],
  keywords: [
    'air_quality',
    'nasa',
    'ozone',
    'pollution',
    'tempo',
    'tropomi',
  ],
  providers: [
    ee.producer_provider('NASA ASDC', 'https://asdc.larc.nasa.gov/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2930764281-LARC_CLOUD',
  ],
  extent: ee.extent(-170.0, 10.0, -10.0, 80.0, '2023-08-02T00:00:00Z', '2025-09-16T00:00:00Z'),
  summaries: {
    gsd: [
      2226,
    ],
    instruments: [
      'TEMPO',
    ],
    'eo:bands': [
      {
        name: 'relative_azimuth_angle',
        description: 'Relative azimuth angle',
        'gee:units': units.degree,
      },
      {
        name: 'solar_zenith_angle',
        description: 'Solar zenith angle',
        'gee:units': units.degree,
      },
      {
        name: 'viewing_zenith_angle',
        description: 'Viewing zenith angle',
        'gee:units': units.degree,
      },
      {
        name: 'column_amount_o3',
        description: 'Total column ozone',
        'gee:units': units.dobson,
      },
      {
        name: 'fc',
        description: 'Effective cloud fraction (mixed LER model)',
        'gee:units': units.dimensionless,
      },
      {
        name: 'o3_below_cloud',
        description: 'Ozone concentration below cloud',
        'gee:units': units.dobson,
      },
      {
        name: 'radiative_cloud_frac',
        description: 'Radiative cloud fraction',
        'gee:units': units.dimensionless,
      },
      {
        name: 'so2_index',
        description: 'Sulfur dioxide index',
        'gee:units': units.dimensionless,
      },
      {
        name: 'uv_aerosol_index',
        description: 'UV aerosol index',
        'gee:units': units.dimensionless,
      },
      {
        name: 'max_column_sample',
        description: 'Maximum column sample',
        'gee:units': units.molecules_per_cm2,
      },
      {
        name: 'min_column_sample',
        description: 'Minimum column sample',
        'gee:units': units.molecules_per_cm2,
      },
      {
        name: 'num_column_samples',
        description: 'Number of column samples',
        'gee:units': units.dimensionless,
      },
      {
        name: 'cloud_pressure',
        description: 'Cloud pressure',
        'gee:units': units.hectopascal,
      },
      {
        name: 'terrain_height',
        description: 'Terrain height',
        'gee:units': units.meter,
      },
      {
        name: 'terrain_pressure',
        description: 'Terrain pressure',
        'gee:units': units.hectopascal,
      },
      {
        name: 'weight',
        description: |||
          Sum of Level 2 pixel overlap areas, representing the total spatial
          coverage of valid data within each grid cell. It serves as the
          weighting factor for calculating the gridded average, where lower
          values indicate partial coverage or data removed due to quality
          filtering.
        |||,
        'gee:units': units.square_km,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Total Column Ozone',
        lookat: {
          lat: 35,
          lon: -95,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [0],
            max: [500],
            bands: ['column_amount_o3'],
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
  'sci:doi': '10.5067/IS-40e/TEMPO/O3TOT_L3.003',
  'sci:citation': |||
    NASA/LARC/SD/ASDC.(2024). TEMPO gridded ozone total column V03 (PROVISIONAL)
    [Data set]. NASA Langley Atmospheric Science Data Center DAAC.
    Retrieved from [10.5067/IS-40e/TEMPO/O3TOT_L3.003](https://doi.org/10.5067/IS-40e/TEMPO/O3TOT_L3.003)
  |||,
  'gee:terms_of_use': |||
    This dataset is in the public domain and is available
    without restriction on use and distribution.
    See [NASA's Earth Science Data & Information Policy](https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
}
