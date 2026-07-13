local id = 'NASA/TEMPO/O3PROF_L3_V4';
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local layers = std.range(0, 23);

local ozone_profile_bands = [
  {
    name: 'ozone_profile_' + layer,
    description: 'Ozone profile partial column for layer ' + layer + ' (0 is top of atmosphere, 23 is near surface)',
    'gee:units': units.dobson,
  }
  for layer in layers
];

local ozone_profile_error_bands = [
  {
    name: 'ozone_profile_error_' + layer,
    description: 'Ozone profile partial column error for layer ' + layer,
    'gee:units': units.dobson,
  }
  for layer in layers
];

local ozone_profile_precision_bands = [
  {
    name: 'ozone_profile_precision_' + layer,
    description: 'Ozone profile partial column precision for layer ' + layer,
    'gee:units': units.dobson,
  }
  for layer in layers
];

local ozone_apriori_profile_bands = [
  {
    name: 'ozone_apriori_profile_' + layer,
    description: 'Ozone apriori profile partial column for layer ' + layer,
    'gee:units': units.dobson,
  }
  for layer in layers
];

local ozone_apriori_profile_error_bands = [
  {
    name: 'ozone_apriori_profile_error_' + layer,
    description: 'Ozone apriori profile partial column error for layer ' + layer,
    'gee:units': units.dobson,
  }
  for layer in layers
];

local ozone_profile_altitude_bands = [
  {
    name: 'ozone_profile_altitude_' + layer,
    description: 'Ozone profile altitude for layer ' + layer,
    'gee:units': units.kilometer,
  }
  for layer in layers
];

local ozone_profile_altitude_bounds_bands = std.flattenArrays([
  [
    {
      name: 'ozone_profile_altitude_bounds_' + layer + '_top',
      description: 'Ozone profile altitude top bound for layer ' + layer + '. Note: Physically, top altitude >= bottom altitude.',
      'gee:units': units.kilometer,
    },
    {
      name: 'ozone_profile_altitude_bounds_' + layer + '_bottom',
      description: 'Ozone profile altitude bottom bound for layer ' + layer + '. Note: Physically, top altitude >= bottom altitude.',
      'gee:units': units.kilometer,
    },
  ]
  for layer in layers
]);

local ozone_profile_pressure_bands = [
  {
    name: 'ozone_profile_pressure_' + layer,
    description: 'Ozone profile pressure for layer ' + layer,
    'gee:units': units.hectopascal,
  }
  for layer in layers
];

local ozone_profile_pressure_bounds_bands = std.flattenArrays([
  [
    {
      name: 'ozone_profile_pressure_bounds_' + layer + '_top',
      description: 'Ozone profile pressure top bound for layer ' + layer + '. Note: Physically, top pressure <= bottom pressure (pressure decreases with height).',
      'gee:units': units.hectopascal,
    },
    {
      name: 'ozone_profile_pressure_bounds_' + layer + '_bottom',
      description: 'Ozone profile pressure bottom bound for layer ' + layer + '. Note: Physically, top pressure <= bottom pressure (pressure decreases with height).',
      'gee:units': units.hectopascal,
    },
  ]
  for layer in layers
]);

local base_bands = [
  {
    name: 'weight',
    description: 'Sum of Level 2 pixel overlap areas',
    'gee:units': units.square_km,
  },
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
    name: 'stratosphere_ozone_column',
    description: 'Stratospheric ozone column',
    'gee:units': units.dobson,
  },
  {
    name: 'stratosphere_ozone_error',
    description: 'Stratospheric ozone column error',
    'gee:units': units.dobson,
  },
  {
    name: 'stratosphere_ozone_precision',
    description: 'Stratospheric ozone column precision',
    'gee:units': units.dobson,
  },
  {
    name: 'total_ozone_column',
    description: 'Total ozone column',
    'gee:units': units.dobson,
  },
  {
    name: 'total_ozone_error',
    description: 'Total ozone column error',
    'gee:units': units.dobson,
  },
  {
    name: 'total_ozone_precision',
    description: 'Total ozone column precision',
    'gee:units': units.dobson,
  },
  {
    name: 'troposphere_ozone_column',
    description: 'Tropospheric ozone column',
    'gee:units': units.dobson,
  },
  {
    name: 'troposphere_ozone_error',
    description: 'Tropospheric ozone column error',
    'gee:units': units.dobson,
  },
  {
    name: 'troposphere_ozone_precision',
    description: 'Tropospheric ozone column precision',
    'gee:units': units.dobson,
  },
  {
    name: 'eff_cloud_fraction',
    description: 'Effective cloud fraction',
    'gee:units': units.dimensionless,
  },
  {
    name: 'eff_cloud_pressure',
    description: 'Effective cloud pressure',
    'gee:units': units.hectopascal,
  },
  {
    name: 'tropopause_index',
    description: 'Tropopause layer index',
    'gee:units': units.dimensionless,
  },
];

local all_bands = base_bands +
  ozone_profile_bands +
  ozone_profile_error_bands +
  ozone_profile_precision_bands +
  ozone_apriori_profile_bands +
  ozone_apriori_profile_error_bands +
  ozone_profile_altitude_bands +
  ozone_profile_altitude_bounds_bands +
  ozone_profile_pressure_bands +
  ozone_profile_pressure_bounds_bands;

{
  stac_version: ee_const.stac_version,
  'gee:status': 'beta',
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'TEMPO gridded ozone profile V04 (PROVISIONAL)',
  version: 'V04',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The TEMPO gridded ozone profile V04 (PROVISIONAL) is a Level 3 dataset
    providing vertical ozone profile information on a regular grid across
    North America. Generated from the TEMPO instrument on the IS-40e platform,
    the data is created by combining and re-gridding Level 2 files from single
    East-West scan cycles using an area-weighted methodology. These measurements
    are critical for monitoring atmospheric ozone structure, stratospheric-tropospheric
    exchange, and continental air quality.

    ### Multi-dimensional Band Flattening
    To conform to Earth Engine's 2D image band model, multi-dimensional variables
    in the source NetCDF files are flattened during ingestion:

    *   **Flat Layer Bands:** Variables containing a vertical layer dimension (24 layers,
        from layer `0` at the top of the atmosphere to layer `23` near the surface)
        are split into 24 individual bands suffixed with `_0` to `_23`. These include
        `ozone_profile`, `ozone_profile_error`, `ozone_profile_precision`,
        `ozone_apriori_profile`, `ozone_apriori_profile_error`, `ozone_profile_altitude`,
        and `ozone_profile_pressure`.

    *   **Layer Bounds (Top/Bottom) Bands:** Variables defining the layer boundaries are
        split by both layer index (`0` to `23`) and boundary index (top and bottom bounds),
        resulting in 48 bands suffixed with `_top` and `_bottom` (e.g., `_0_top`, `_0_bottom`
        ... `_23_top`, `_23_bottom`). These include `ozone_profile_altitude_bounds` and
        `ozone_profile_pressure_bounds`.

    ### Spatial Reference for "Top" and "Bottom" Bounds
    `_top` and `_bottom` refer to spatial elevation relative to the Earth's
    surface:
    *   **Altitude**: Value increases with height (`_top` > `_bottom`).
    *   **Pressure**: Value decreases with height (`_top` < `_bottom`).

    Documentation:

    * [User's Guide](https://asdc.larc.nasa.gov/documents/tempo/guide/TEMPO_Level-2-3_O3PROF_user_guide_V1.1.pdf)

    * [General Documentation](https://asdc.larc.nasa.gov/project/TEMPO)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/IS-40E/TEMPO/O3PROF_L3.004',
    },
  ],
  'gee:categories': ['satellite-imagery'],
  keywords: [
    'air_quality',
    'nasa',
    'ozone',
    'pollution',
    'tempo',
  ],
  providers: [
    ee.producer_provider('NASA ASDC', 'https://doi.org/10.5067/IS-40E/TEMPO/O3PROF_L3.004'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C3685896402-LARC_CLOUD',
  ],
  extent: ee.extent(-170.0, 10.0, -10.0, 80.0, '2023-08-02T00:00:00Z', null),
  summaries: {
    gsd: [
      2226,
    ],
    instruments: [
      'TEMPO',
    ],
    'eo:bands': all_bands,
    'gee:visualizations': [
      {
        display_name: 'Total Ozone Column',
        lookat: {
          lat: 35,
          lon: -95,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [0],
            max: [500],
            bands: ['total_ozone_column'],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5067/IS-40E/TEMPO/O3PROF_L3.004',
  'sci:citation': |||
    NASA/LARC/SD/ASDC.(2025). TEMPO gridded ozone profile V04 (PROVISIONAL)
    [Data set]. NASA Langley Atmospheric Science Data Center DAAC.
    Retrieved from [10.5067/IS-40E/TEMPO/O3PROF_L3.004](https://doi.org/10.5067/IS-40E/TEMPO/O3PROF_L3.004)
  |||,
  'gee:terms_of_use': |||
    This dataset is in the public domain and is available
    without restriction on use and distribution.
    See [NASA's Earth Science Data & Information Policy](https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
}
