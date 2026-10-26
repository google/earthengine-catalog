local id = 'NASA/VIIRS/002/VJ209H1';
local subdir = 'NASA';
local version = 'V002';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
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
  title: 'VJ209H1: VIIRS Surface Reflectance 8-Day L3 Global 500m',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The 8-day Visible Infrared Imaging Radiometer Suite (VIIRS) Surface
    Reflectance (VJ209H1) Version 2 composite product provides an estimate of
    land surface reflectance from the Joint Polar Satellite System (JPSS-2) /
    NOAA-21 VIIRS sensor for three imagery bands (I1, I2, I3) at nominal
    500 meter resolution (approximately 463 meter). The 500 meter dataset is
    derived through resampling the native 375 meter VIIRS resolution in the L2
    input product. The data are corrected for atmospheric conditions such as the
    effects of molecular gases, including ozone and water vapor, and for the
    effects of atmospheric aerosols. Each pixel represents the best possible
    Level 2G observation during an 8-day period, which is selected on the basis
    of high observation coverage, low sensor angle, the absence of clouds or
    cloud shadow, and aerosol loading. Along with the three reflectance bands,
    this product includes a state quality assurance (QA) layer and a reflectance
    band quality layer.

    The band scale factors are already applied.

    For additional information, visit the VIIRS [Land Product Quality
    Assessment website](https://landweb.modaps.eosdis.nasa.gov/browse?sensor=VIIRS&sat=NOAA-21).

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/1657/VNP09_User_Guide_V2.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/122/VNP09_ATBD.pdf)

    * [General Documentation](https://lpdaac.usgs.gov/products/vj209h1v002/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/VIIRS/VJ209H1.002',
    },
  ],
  'gee:categories': ['satellite-imagery'],
  keywords: [
    '8_day',
    'nasa',
    'noaa',
    'noaa21',
    'reflectance',
    'sr',
    'viirs',
    'vj209h1',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/VIIRS/VJ209H1.002'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2817366221-LPCLOUD',
  ],
  extent: ee.extent_global('2023-02-10T00:00:00Z', null),
  summaries: {
    gsd: [
      500.0,
    ],
    platform: [
      'NOAA-21',
    ],
    instruments: [
      'VIIRS',
    ],
    'eo:bands': [
      {
        name: 'SurfReflect_I1',
        description: '500m surface reflectance band I1',
        center_wavelength: 0.64,
        'gee:wavelength': '0.600 - 0.680&micro;m',
      },
      {
        name: 'SurfReflect_I2',
        description: '500m surface reflectance band I2',
        center_wavelength: 0.865,
        'gee:wavelength': '0.850 - 0.880&micro;m',
      },
      {
        name: 'SurfReflect_I3',
        description: '500m surface reflectance band I3',
        center_wavelength: 1.61,
        'gee:wavelength': '1.580 - 1.640&micro;m',
      },
      {
        name: 'SurfReflect_QC_500m',
        description: 'Surface Reflectance Band Quality Control (QC)',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'MODLAND QA bits',
              bit_count: 2,
              values: [
                {
                  description: |||
                    Corrected product produced at ideal quality all bands
                  |||,
                  value: 0,
                },
                {
                  value: 1,
                  description: |||
                    Corrected product produced at less than ideal quality some
                    or all bands
                  |||,
                },
                {
                  value: 2,
                  description: |||
                    Corrected product not produced due to cloud effects all
                    bands
                  |||,
                },
                {
                  value: 3,
                  description: |||
                    Corrected product not produced due to other reasons some or
                    all bands may be fill value [Note that a value of (11)
                    overrides a value of (01)].
                  |||,
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Cloud state',
              first_bit: 2,
              bit_count: 2,
              values: [
                {
                  description: |||
                    Always set at 11. Users should use Cloud state of
                    SurfReflect_State_500m.
                  |||,
                  value: 3,
                },
              ],
            },
            {
              description: 'Band 1 data quality four bit range',
              first_bit: 4,
              bit_count: 4,
              values: [
                {
                  description: 'Highest quality',
                  value: 0,
                },
                {
                  value: 7,
                  description: 'Noisy detector',
                },
                {
                  value: 8,
                  description: 'Dead detector, data interpolated in L1B',
                },
                {
                  value: 9,
                  description: 'Solar zenith >= 86 degrees',
                },
                {
                  value: 10,
                  description: 'Solar zenith >= 85 and < 86 degrees',
                },
                {
                  value: 11,
                  description: 'Missing input',
                },
                {
                  value: 12,
                  description: |||
                    Internal constant used in place of climatological data for
                    at least one atmospheric constant
                  |||,
                },
                {
                  value: 13,
                  description: |||
                    Correction out of bounds, pixel constrained to extreme
                    allowable value
                  |||,
                },
                {
                  value: 14,
                  description: 'L1B data faulty',
                },
                {
                  value: 15,
                  description: 'Not processed due to deep ocean or clouds',
                },
              ],
            },
            {
              description: 'Band 2 data quality four bit range',
              first_bit: 8,
              bit_count: 4,
              values: [
                {
                  description: 'Highest quality',
                  value: 0,
                },
                {
                  value: 7,
                  description: 'Noisy detector',
                },
                {
                  value: 8,
                  description: 'Dead detector, data interpolated in L1B',
                },
                {
                  value: 9,
                  description: 'Solar zenith >= 86 degrees',
                },
                {
                  value: 10,
                  description: 'Solar zenith >= 85 and < 86 degrees',
                },
                {
                  value: 11,
                  description: 'Missing input',
                },
                {
                  value: 12,
                  description: |||
                    Internal constant used in place of climatological data for
                    at least one atmospheric constant
                  |||,
                },
                {
                  value: 13,
                  description: |||
                    Correction out of bounds, pixel constrained to extreme
                    allowable value
                  |||,
                },
                {
                  value: 14,
                  description: 'L1B data faulty',
                },
                {
                  value: 15,
                  description: 'Not processed due to deep ocean or clouds',
                },
              ],
            },
            {
              description: 'Atmospheric correction performed',
              first_bit: 12,
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
              description: 'Adjacency correction performed',
              first_bit: 13,
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
              description: 'Different orbit from 500m',
              first_bit: 14,
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
          ],
          total_bit_count: 15,
        },
      },
      {
        name: 'SurfReflect_State_500m',
        description: 'Surface Reflectance State Quality Assurance (QA)',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Cloud state',
              bit_count: 2,
              values: [
                {
                  description: 'Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Cloudy',
                },
                {
                  value: 2,
                  description: 'Mixed',
                },
                {
                  value: 3,
                  description: 'Not set, assumed clear',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Cloud shadow',
              first_bit: 2,
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
              description: 'Land/water flag',
              first_bit: 3,
              bit_count: 3,
              values: [
                {
                  description: 'Shallow ocean',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Land',
                },
                {
                  value: 2,
                  description: 'Ocean coastlines and lake shorelines',
                },
                {
                  value: 3,
                  description: 'Shallow inland water',
                },
                {
                  value: 4,
                  description: 'Ephemeral water',
                },
                {
                  value: 5,
                  description: 'Deep inland water',
                },
                {
                  value: 6,
                  description: 'Continental/moderate ocean',
                },
                {
                  value: 7,
                  description: 'Deep ocean',
                },
              ],
            },
            {
              description: 'Aerosol quantity: level of uncertainty in aerosol correction',
              first_bit: 6,
              bit_count: 2,
              values: [
                {
                  description: 'Climatology',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Low',
                },
                {
                  value: 2,
                  description: 'Average',
                },
                {
                  value: 3,
                  description: 'High',
                },
              ],
            },
            {
              description: 'Cirrus detected',
              first_bit: 8,
              bit_count: 2,
              values: [
                {
                  description: 'None',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Small',
                },
                {
                  value: 2,
                  description: 'Average',
                },
                {
                  value: 3,
                  description: 'High',
                },
              ],
            },
            {
              description: 'Spare (unused)',
              first_bit: 10,
              bit_count: 2,
            },
            {
              description: 'Snow/ice flag',
              first_bit: 12,
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
              description: 'Pixel is adjacent to cloud',
              first_bit: 13,
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
          ],
          total_bit_count: 14,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'False Color (I3, I2, I1)',
        lookat: {
          lat: -0.26,
          lon: -162.64,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              0.3,
            ],
            gamma: [
              1.4,
            ],
            bands: [
              'SurfReflect_I3',
              'SurfReflect_I2',
              'SurfReflect_I1',
            ],
          },
        },
      },
    ],
    SurfReflect_I1: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    SurfReflect_I2: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    SurfReflect_I3: {
      minimum: -0.01,
      maximum: 1.6,
      'gee:estimated_range': false,
    },
    SurfReflect_State_500m: {
      minimum: 0.0,
      maximum: 13311.0,
      'gee:estimated_range': false,
    },
    SurfReflect_QC_500m: {
      minimum: 0.0,
      maximum: 32767.0,
      'gee:estimated_range': false,
    },
  },
  'sci:doi': '10.5067/VIIRS/VJ209H1.002',
  'sci:citation': |||
    Vermote, E., Franch, B., Claverie, M. (2023). VIIRS/JPSS2 Surface Reflectance 8-Day L3 Global 500m SIN Grid V002 [Data set]. NASA EOSDIS Land Processes Distributed Active Archive Center.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 8,
  },
  'gee:terms_of_use': |||
    LP DAAC NASA data are freely accessible; however, when an author
    publishes these data or works based on the data, it is requested that the
    author cite the datasets within the text of the publication and include a
    reference to them in the reference list.
  |||,
}
