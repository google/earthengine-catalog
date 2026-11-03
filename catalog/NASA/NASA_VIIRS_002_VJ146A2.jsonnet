local id = 'NASA/VIIRS/002/VJ146A2';
local subdir = 'NASA';
local version = '002';

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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title:
    'VJ146A2: VIIRS Lunar Gap-Filled BRDF Nighttime Lights Daily L3 ' +
    'Global 500m',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The NOAA-20 (JPSS-1) Visible Infrared Imaging Radiometer Suite (VIIRS)
    supports a Day-Night Band (DNB) sensor that provides global daily
    measurements of nocturnal visible and near-infrared (NIR) light that are
    suitable for Earth system science and applications. The VIIRS DNB's
    ultra-sensitivity in lowlight conditions generates science-quality nighttime
    products that manifest substantial improvements in sensor resolution and
    calibration when compared to previous eras (such as DMSP/OLS). Such
    improvements allow the VIIRS DNB products to better monitor both the
    magnitude and signature of nighttime phenomena, and anthropogenic sources
    of light emissions.

    VJ146A2 is the short-name for the daily moonlight- and atmosphere-corrected
    Nighttime Lights (NTL) product called VIIRS/NOAA-20 Gap-Filled Lunar
    BRDF-Adjusted Nighttime Lights Daily L3 Global 500m Linear Lat Lon Grid.

    Documentation:

    * [User's Guide](https://ladsweb.modaps.eosdis.nasa.gov/api/v2/content/archives/Document%20Archive/Science%20Data%20Product%20Documentation/VIIRS_Black_Marble_UG_v1.3_Sep_2022.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://ladsweb.modaps.eosdis.nasa.gov/api/v2/content/archives/Document%20Archive/Science%20Data%20Product%20Documentation/Product%20Generation%20Algorithms/VIIRS_Black_Marble_ATBD_v1.1_July_2020.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/missions-and-measurements/products/VJ146A2/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/VIIRS/VJ146A2.002',
    },
  ],
  'gee:categories': ['population'],
  keywords: [
    'brdf',
    'daily',
    'nasa',
    'noaa',
    'viirs',
    'nighttime',
  ],
  providers: [
    ee.producer_provider('NASA LAADS DAAC', 'https://doi.org/10.5067/VIIRS/VJ146A2.002'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C3370789118-LAADS',
  ],
  extent: ee.extent_global('2018-01-19T00:00:00Z', null),
  summaries: {
    gsd: [
      500.0,
    ],
    'gee:schema': [
      {
        name: 'num_tiles',
        description: |||
          The number of source tiles that were mosaicked to create this image.
        |||,
        type: ee_const.var_type.int,
      },
    ],
    platform: [
      'NOAA-20',
    ],
    instruments: [
      'VIIRS',
    ],
    'eo:bands': [
      {
        name: 'DNB_BRDF_Corrected_NTL',
        description: 'BRDF corrected DNB NTL',
      },
      {
        name: 'Gap_Filled_DNB_BRDF_Corrected_NTL',
        description: 'Gap Filled BRDF corrected DNB NTL',
      },
      {
        name: 'DNB_Lunar_Irradiance',
        description: 'DNB Lunar Irradiance',
      },
      {
        name: 'Latest_High_Quality_Retrieval',
        description: 'Latest high quality BRDF corrected DNB radiance retrieval',
      },
      {
        name: 'Mandatory_Quality_Flag',
        description: 'Mandatory quality flag',
        'gee:classes': [
          {
            value: 0,
            description: 'High-quality, Persistent nighttime lights',
          },
          {
            value: 1,
            description: 'High-quality, Ephemeral nighttime Lights',
          },
          {
            value: 2,
            description: |||
              Poor-quality, Outlier, potential cloud contamination,
              or other issues
            |||,
          },
          {
            value: 255,
            description: 'No retrieval, Fill value (masked out on ingestion)',
          },
        ],
      },
      {
        name: 'Snow_Flag',
        description: 'Flag for snow cover',
        'gee:classes': [
          {
            value: 0,
            description: 'No Snow/Ice',
          },
          {
            value: 1,
            description: 'Snow/Ice',
          },
        ],
      },
      {
        name: 'QF_Cloud_Mask',
        description: 'Quality flag for cloud mask',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Day/Night',
              bit_count: 1,
              values: [
                {
                  description: 'Night',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Day',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Land/Water Background',
              first_bit: 1,
              bit_count: 3,
              values: [
                {
                  value: 0,
                  description: 'Land & Desert',
                },
                {
                  value: 1,
                  description: 'Land no Desert',
                },
                {
                  value: 2,
                  description: 'Inland Water',
                },
                {
                  value: 3,
                  description: 'Sea Water',
                },
                {
                  value: 5,
                  description: 'Coastal',
                },
              ],
            },
            {
              description: 'Cloud Mask Quality',
              first_bit: 4,
              bit_count: 2,
              values: [
                {
                  description: 'Poor',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Low',
                },
                {
                  value: 2,
                  description: 'Medium',
                },
                {
                  value: 3,
                  description: 'High',
                },
              ],
            },
            {
              description: 'Cloud Detection Results & Confidence Indicator',
              first_bit: 6,
              bit_count: 2,
              values: [
                {
                  description: 'Confident Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Probably Clear',
                },
                {
                  value: 2,
                  description: 'Probably Cloudy',
                },
                {
                  value: 3,
                  description: 'Confident Cloudy',
                },
              ],
            },
            {
              description: 'Shadow Detected',
              first_bit: 8,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Cirrus Detection (IR) (BTM15 - BTM16)',
              first_bit: 9,
              bit_count: 1,
              values: [
                {
                  description: 'No cloud',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Cloud',
                },
              ],
            },
            {
              description: 'Snow/Ice Surface',
              first_bit: 10,
              bit_count: 1,
              values: [
                {
                  description: 'No Snow/Ice',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Snow/Ice',
                },
              ],
            },
          ],
          total_bit_count: 11,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'brdf',
        lookat: {
          lat: 7.71,
          lon: 17.93,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              100.0,
            ],
            bands: [
              'DNB_BRDF_Corrected_NTL',
            ],
          },
        },
      },
    ],
    DNB_BRDF_Corrected_NTL: {
      minimum: 0.0,
      maximum: 6553.4,
      'gee:estimated_range': false,
    },
    Gap_Filled_DNB_BRDF_Corrected_NTL: {
      minimum: 0.0,
      maximum: 6553.4,
      'gee:estimated_range': false,
    },
    DNB_Lunar_Irradiance: {
      minimum: 0.0,
      maximum: 6553.4,
      'gee:estimated_range': false,
    },
    Mandatory_Quality_Flag: {
      minimum: 0,
      maximum: 3,
      'gee:estimated_range': false,
    },
    Snow_Flag: {
      minimum: 0,
      maximum: 1,
      'gee:estimated_range': false,
    },
    QF_Cloud_Mask: {
      minimum: 0,
      maximum: 65534,
      'gee:estimated_range': false,
    },
  },
  'sci:doi': '10.5067/VIIRS/VJ146A2.002',
  'sci:citation': |||
    Rom&aacute;n, M.O., Wang, Z., Sun, Q., Kalb, V., Miller, S.D., Molthan, A.,
    Schultz, L., Bell, J., Stokes, E.C., Pandey, B. and Seto, K.C., et al.
    (2018). NASA's Black Marble nighttime lights product suite.
    Remote Sensing of Environment 210, 113-143.
    [10.1016/j.rse.2018.03.017](https://doi.org/10.1016/j.rse.2018.03.017)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    LP DAAC NASA data are freely accessible; however, when an author
    publishes these data or works based on the data, it is requested that the
    author cite the datasets within the text of the publication and include a
    reference to them in the reference list.
  |||,
}
