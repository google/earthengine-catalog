local id = 'NOAA/VIIRS/001/VNP46A2';
local subdir = 'NOAA';

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
    'VNP46A2: VIIRS Lunar Gap-Filled BRDF Nighttime Lights Daily L3 ' +
    'Global 500m',
  version: '1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Suomi National Polar-orbiting Partnership (SNPP) Visible Infrared
    Imaging Radiometer Suite (VIIRS) supports a Day-Night Band (DNB) sensor
    that provides global daily measurements of nocturnal visible and
    near-infrared (NIR) light that are suitable for Earth system science and
    applications. The VIIRS DNB's ultra-sensitivity in lowlight conditions
    enables us to generate a new set of science-quality nighttime products that
    manifest substantial improvements in sensor resolution and calibration when
    compared to the previous era of Defense Meteorological Satellite
    Program/Operational Linescan System's (DMSP/OLS) nighttime lights image
    products.

    VNP46A2 dataset is a daily moonlight- and atmosphere-corrected Nighttime
    Lights (NTL) product using the Bidirectional Reflectance Distribution
    Function (BRDF).

    Documentation:

    * [User's Guide](https://ladsweb.modaps.eosdis.nasa.gov/api/v2/content/archives/Document%20Archive/Science%20Data%20Product%20Documentation/VIIRS_Black_Marble_UG_v1.3_Sep_2022.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://ladsweb.modaps.eosdis.nasa.gov/api/v2/content/archives/Document%20Archive/Science%20Data%20Product%20Documentation/Product%20Generation%20Algorithms/VIIRS_Black_Marble_ATBD_v1.1_July_2020.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/missions-and-measurements/products/VNP46A2/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/VIIRS/VNP46A2.001',
    },
  ],
  keywords: [
    'brdf',
    'daily',
    // TODO(simonf): Explain why lunar applies to this dataset.
    // 'lunar',
    'nasa',
    'noaa',
    'viirs',
  ],
  providers: [
    ee.producer_provider('NASA LAADS DAAC', 'https://doi.org/10.5067/VIIRS/VNP46A2.001'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1373412048-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2012-01-19T00:00:00Z', null),
  summaries: {
    gsd: [
      500.0,
    ],
    platform: [
      'Suomi NPP',
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
        description: 'Latest high quality BRDF corrected DNB radiance retrieval'
      },
      {
        name: 'Mandatory_Quality_Flag',
        description: 'Mandatory quality flag',
        'gee:classes': [
          {
            value: 0,
            description: 'High-quality, Persistent nighttime lights'
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
        ]
      },
      {
        name: 'Snow_Flag',
        description: 'Flag for snow cover',
        'gee:classes': [
          {
            value: 0,
            description: 'No Snow/Ice'
          },
          {
            value: 1,
            description: 'Snow/Ice',
          }
        ]
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
                  description: ' Confident Clear',
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
  'sci:doi': '10.5067/VIIRS/VNP46A2.001',
  'sci:citation': "Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)",
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
