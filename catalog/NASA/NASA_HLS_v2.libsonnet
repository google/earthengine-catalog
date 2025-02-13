local units = import 'units.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';

{
  common_description: |||
    The HLS project uses a set of algorithms
    to obtain seamless products from OLI and MSI that include atmospheric
    correction, cloud and cloud-shadow masking, spatial co-registration and
    common gridding, illumination and view angle normalization, and spectral
    bandpass adjustment.

    The HLS project distributes data as two separate products: HLSL30
    (Landsat 8/9) and HLSS30 (Sentinel-2 A/B). They both provide 30m Nadir
    Bidirectional Reflectance Distribution Function (BRDF), Adjusted Reflectance
    (NBAR).

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/1698/HLS_User_Guide_V2.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/769/HLS_ATBD_V15_provisional.pdf)
  |||,
  citation: |||
    Masek, J., Ju, J., Roger, J., Skakun, S., Vermote, E., Claverie, M., Dungan,
    J., Yin, Z., Freitag, B., Justice, C. (2021). HLS Operational Land Imager
    Surface Reflectance and TOA Brightness Daily Global 30m v2.0 [Data set].
    NASA EOSDIS Land Processes Distributed Active Archive Center.
    Accessed 2023-09-12 from https://doi.org/10.5067/HLS/HLSL30.002
  |||,
  terms_of_use: |||
    NASA promotes the full and open sharing of all data with research and
    applications communities, private industry, academia, and the general
    public.
  |||,
  version: 'v002',
  keywords: [
    'landsat',
    'nasa',
    'sentinel',
    'usgs',
  ],
  gsd: [
      30.0,
    ],
  instruments: [
      'OLI',
      'TIRS',
    ],
  qa_bands: [
      {
        name: 'Fmask',
        description: 'Quality Bits',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Cirrus',
              bit_count: 1,
              values: [
                {
                  description: 'Reserved but not used',
                  value: 0,
                },
                {
                  description: 'Reserved but not used',
                  value: 1,
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Cloud',
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
              first_bit: 1,
            },
            {
              description: 'Adjacent to cloud/shadow',
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  value: 0,
                  description: 'No',
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Cloud shadow',
              first_bit: 3,
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
              description: 'Snow/ice',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: ' No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Water',
              first_bit: 5,
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
              description: 'Aerosol level',
              first_bit: 6,
              bit_count: 2,
              values: [
                {
                  description: 'Climatology aerosol',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Low aerosol',
                },
                {
                  value: 2,
                  description: 'Moderate aerosol',
                },
                {
                  value: 3,
                  description: 'High aerosol',
                },
              ],
            },
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'SZA',
        description: 'Sun Zenith Angle',
        'gee:units': units.degree,
      },
      {
        name: 'SAA',
        description: 'Sun Azimuth Angle',
        'gee:units': units.degree,
      },
      {
        name: 'VZA',
        description: 'View Zenith Angle',
        'gee:units': units.degree,
      },
      {
        name: 'VAA',
        description: 'View Azimuth Angle',
        'gee:units': units.degree,
      },
  ],
  rgb_bands: [
      {
        name: 'B1',
        description: 'Coastal Aerosol',
      },
      {
        name: 'B2',
        description: 'Blue',
      },
      {
        name: 'B3',
        description: 'Green',
      },
      {
        name: 'B4',
        description: 'Red',
      },
  ],
  common_properties: [
     {
        name: 'CLOUD_COVERAGE',
        description: |||
          The percentage of cloud and cloud shadow in observation based on
          Fmask
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'HLS_PROCESSING_TIME',
        description: |||
          The date and time of HLS processing for this observation
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'MEAN_SUN_AZIMUTH_ANGLE',
        description: |||
          Mean Sun Azimuth Angle in degree of the input data for HLS L30
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'MEAN_SUN_ZENITH_ANGLE',
        description: |||
          Mean Sun Zenith Angle in degree of the input data for HLS L30
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'MEAN_VIEW_AZIMUTH_ANGLE',
        description: 'Mean View Azimuth Angle in degree of the input data',
        type: ee_const.var_type.double,
      },
      {
        name: 'MEAN_VIEW_ZENITH_ANGLE',
        description: 'Mean View Zenith Angle in degree of the input data',
        type: ee_const.var_type.double,
      },
      {
        name: 'NBAR_SOLAR_ZENITH',
        description: |||
          The solar zenith angle used in NBAR derivation
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SPATIAL_COVERAGE',
        description: 'The percentage of the tile with data',
        type: ee_const.var_type.double,
      },
  ],
}