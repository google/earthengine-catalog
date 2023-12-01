local id = 'NOAA/CDR/PATMOSX/V53';
local subdir = 'NOAA';

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
  title: 'NOAA CDR PATMOSX: Cloud Properties, Reflectance, and Brightness Temperatures, Version 5.3',
  version: 'V5.3',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset provides high quality Climate Data Record (CDR) of multiple
    cloud properties along with Advanced Very High Resolution Radiometer (AVHRR)
    Pathfinder Atmospheres Extended (PATMOS-x) brightness temperatures and
    reflectances. These data have been fitted to a 0.1 x 0.1 equal angle-grid
    with both ascending and descending assets generated daily from two to ten
    NOAA and MetOp satellite passes per day.

    This dataset includes 48 bands, 11 of which are deemed CDR quality
    (marked with "CDR variable" in the band list).
    The cloud products are derived using the ABI (Advanced Baseline Imager)
    Cloud Height Algorithm (ACHA), and the Daytime Cloud Optical Properties
    (DCOMP) algorithm. For more detail on the processing see the
    [Climate Algorithm Theoretical Basis Document (C-ATBD)](
    https://www.ncei.noaa.gov/pub/data/sds/cdr/CDRs/AVHRR-HIRS_Reflectance_PATMOS-x/AlgorithmDescription%20_01B-1c.pdf).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7289/V5348HCK',
    },
  ],
  keywords: [
    'atmospheric',
    'avhrr',
    'brightness',
    'cdr',
    'cloud',
    'metop',
    'noaa',
    'optical',
    'poes',
    'reflectance',
    'temperature',
  ],
  providers: [
    ee.producer_provider('NOAA', 'https://www.ncei.noaa.gov/products/climate-data-records/avhrr-hirs-cloud-properties-patmos'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1979-01-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'orbit_node',
        description: "'ascending' or 'descending'",
        type: ee_const.var_type.string,
      },
      {
        name: 'platform',
        description: 'Name of platform',
        type: ee_const.var_type.string,
      },
      {
        name: 'status',
        description: "'provisional' or 'permanent'",
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      11132.0,
    ],
    platform: [
      'MetOP',
      'NOAA',
    ],
    instruments: [
      'AVHRR',
    ],
    'eo:bands': [
      {
        name: 'cld_emiss_acha',
        description: 'Cloud emissivity at 11&micro;m, determined from ACHA (CDR variable)',
        center_wavelength: 11.0,
        'gee:scale': 0.003937008,
        'gee:offset': 0.5,
        'gee:wavelength': '11&micro;m',
      },
      {
        name: 'cld_height_acha',
        description: 'Cloud height computed using ACHA',
        'gee:units': units.kilometer,
        'gee:scale': 0.0003051851,
        'gee:offset': 10.0,
      },
      {
        name: 'cld_height_uncer_acha',
        description: 'Cloud height uncertainty computed using ACHA',
        'gee:units': units.kilometer,
        'gee:scale': 0.03937008,
        'gee:offset': 5.0,
      },
      {
        name: 'cld_opd_acha',
        description: 'Cloud optical depth at 0.65&micro;m, determined from ACHA',
        center_wavelength: 0.65,
        'gee:scale': 0.03228346,
        'gee:offset': 3.9,
        'gee:wavelength': '0.65&micro;m',
      },
      {
        name: 'cld_opd_dcomp',
        description: 'Cloud optical depth at 0.65&micro;m, determined from DCOMP (CDR variable)',
        center_wavelength: 0.65,
        'gee:scale': 0.002444532,
        'gee:offset': 79.9,
        'gee:wavelength': '0.65&micro;m',
      },
      {
        name: 'cld_opd_dcomp_unc',
        description: 'Uncertainty in the cloud optical depth at 0.65&micro;m, determined from DCOMP',
        'gee:scale': 0.002444532,
        'gee:offset': 79.9,
      },
      {
        name: 'cld_press_acha',
        description: 'Cloud-top pressure computed using ACHA',
        'gee:units': units.hectopascal,
        'gee:scale': 0.01678518,
        'gee:offset': 550.0,
      },
      {
        name: 'cld_reff_acha',
        description: 'Effective radius of cloud particles determined from ACHA',
        'gee:units': units.micrometer,
        'gee:scale': 0.6299213,
        'gee:offset': 80.0,
      },
      {
        name: 'cld_reff_dcomp',
        description: 'Effective radius of cloud particles determined from DCOMP (CDR variable)',
        'gee:units': units.micrometer,
        'gee:scale': 0.002441481,
        'gee:offset': 80.0,
      },
      {
        name: 'cld_reff_dcomp_unc',
        description: 'Uncertainty in the effective radius of cloud particle determined from DCOMP',
        'gee:units': units.micrometer,
        'gee:scale': 0.002441481,
        'gee:offset': 80.0,
      },
      {
        name: 'cld_temp_acha',
        description: 'Cloud-top temperature computed using ACHA (CDR variable)',
        'gee:units': units.kelvin,
        'gee:scale': 0.002441481,
        'gee:offset': 240.0,
      },
      {
        name: 'cloud_fraction',
        description: 'Cloud fraction computed over a 3x3 pixel array at the native resolution centered on this pixel',
        'gee:scale': 0.003937008,
        'gee:offset': 0.5,
      },
      {
        name: 'cloud_fraction_uncertainty',
        description: 'Cloud fraction uncertainty computed over a 3x3 array',
        'gee:scale': 0.003937008,
        'gee:offset': 0.5,
      },
      {
        name: 'cloud_probability',
        description: 'Probability of a pixel being cloudy from the Bayesian cloud mask',
        'gee:scale': 0.003937008,
        'gee:offset': 0.5,
      },
      {
        name: 'cloud_transmission_0_65um',
        description: 'Cloud transmission at 0.65&micro;m from DCOMP',
        center_wavelength: 0.65,
        'gee:scale': 0.003937008,
        'gee:offset': 0.5,
        'gee:wavelength': '0.65&micro;m',
      },
      {
        name: 'cloud_type',
        description: 'Integer classification of the cloud type including clear and aerosol type',
        'gee:classes': [
          {
            color: '73d8ff',
            description: 'Clear',
            value: 0,
          },
          {
            value: 1,
            color: '73d8ff',
            description: 'Probably clear',
          },
          {
            value: 2,
            color: 'b1d8dc',
            description: 'Fog',
          },
          {
            value: 3,
            color: '030bff',
            description: 'Water',
          },
          {
            value: 4,
            color: '0013a1',
            description: 'Supercooled water',
          },
          {
            value: 5,
            color: '05ffa3',
            description: 'Mixed',
          },
          {
            value: 6,
            color: 'd5fff9',
            description: 'Opaque ice',
          },
          {
            value: 7,
            color: 'ffffff',
            description: 'Cirrus',
          },
          {
            value: 8,
            color: 'b2b8ff',
            description: 'Overlapping',
          },
          {
            value: 9,
            color: 'b2b8ff',
            description: 'Overshooting',
          },
          {
            value: 10,
            color: 'f8c4ff',
            description: 'Unknown',
          },
          {
            value: 11,
            color: 'd7e9a1',
            description: 'Dust',
          },
          {
            value: 12,
            color: 'adadad',
            description: 'Smoke',
          },
        ],
      },
      {
        name: 'cloud_water_path',
        description: 'Integrated total cloud water over whole column',
        'gee:units': 'g/m^2',
        'gee:scale': 4.72441,
        'gee:offset': 600.0,
      },
      {
        name: 'land_class',
        description: 'Land classes',
        'gee:classes': [
          {
            color: '46ffba',
            description: 'Shallow ocean',
            value: 0,
          },
          {
            value: 1,
            color: 'c09968',
            description: 'Land',
          },
          {
            value: 2,
            color: 'eddc66',
            description: 'Coastline',
          },
          {
            value: 3,
            color: '32bc76',
            description: 'Shallow inland water',
          },
          {
            value: 4,
            color: '00b5c8',
            description: 'Ephemeral water',
          },
          {
            value: 5,
            color: '338c91',
            description: 'Deep inland water',
          },
          {
            value: 6,
            color: '0109ff',
            description: 'Moderate ocean',
          },
          {
            value: 7,
            color: '010583',
            description: 'Deep ocean',
          },
        ],
      },
      {
        name: 'refl_0_65um',
        description: 'Top of atmosphere reflectance 0.65&micro;m (CDR variable)',
        center_wavelength: 0.65,
        'gee:scale': 0.001861629,
        'gee:offset': 59.0,
        'gee:wavelength': '0.65&micro;m',
      },
      {
        name: 'refl_0_65um_counts',
        description: 'Instrument counts for the 0.65&micro;m channel',
      },
      {
        name: 'refl_0_65um_stddev_3x3',
        description: 'Standard deviation of the 0.63&micro;m reflectance computed over\na 3x3 pixel array',
        'gee:scale': 0.07874016,
        'gee:offset': 10.0,
      },
      {
        name: 'refl_0_86um',
        description: 'Top of atmosphere reflectance at 0.86&micro;m (CDR variable)',
        center_wavelength: 0.86,
        'gee:scale': 0.001861629,
        'gee:offset': 59.0,
        'gee:wavelength': '0.86&micro;m',
      },
      {
        name: 'refl_0_86um_counts',
        description: 'Instrument counts for the 0.86&micro;m channel',
      },
      {
        name: 'refl_1_60um',
        description: 'Top of atmosphere reflectance at 1.60&micro;m (CDR variable)',
        center_wavelength: 1.6,
        'gee:scale': 0.001861629,
        'gee:offset': 59.0,
        'gee:wavelength': '1.60&micro;m',
      },
      {
        name: 'refl_1_60um_counts',
        description: 'Instrument counts for the 1.60&micro;m channel',
      },
      {
        name: 'refl_3_75um',
        description: 'Top of atmosphere reflectance at 3.75&micro;m (CDR variable)',
        center_wavelength: 3.75,
        'gee:scale': 0.001525925,
        'gee:offset': 30.0,
        'gee:wavelength': '3.75&micro;m',
      },
      {
        name: 'relative_azimuth_angle',
        description: 'Sun-sensor relative azimuth angle; 0 is the principal plane looking towards sun',
        'gee:units': units.degree,
        'gee:scale': 0.7086614,
        'gee:offset': 90.0,
      },
      {
        name: 'scan_element_number',
        description: 'Scan element index of the pixel chosen for inclusion in level-2b',
      },
      {
        name: 'scan_line_number',
        description: 'Scan line number',
      },
      {
        name: 'scan_line_time',
        description: 'Scan line time',
        'gee:units': units.hour,
      },
      {
        name: 'sensor_zenith_angle',
        description: 'Sensor zenith for each pixel measured in degrees from nadir',
        'gee:units': units.degree,
        'gee:scale': 0.3543307,
        'gee:offset': 45.0,
      },
      {
        name: 'snow_class',
        description: 'Snow classes and values',
        'gee:classes': [
          {
            value: 1,
            color: '000000',
            description: 'No snow/ice',
          },
          {
            value: 2,
            color: '17b0c0',
            description: 'Sea-ice',
          },
          {
            value: 3,
            color: 'ffffff',
            description: 'Snow',
          },
        ],
      },
      {
        name: 'solar_azimuth_angle',
        description: 'Solar azimuth angle in degrees from north, pixel to sun,\npositive values are clockwise from north',
        'gee:units': units.degree,
        'gee:scale': 1.417323,
      },
      {
        name: 'solar_zenith_angle',
        description: 'Solar zenith for each pixel measured in degrees away from the\nsun (0=looking at sun)',
        'gee:units': units.degree,
        'gee:scale': 0.7086614,
        'gee:offset': 90.0,
      },
      {
        name: 'surface_temperature_retrieved',
        description: 'Surface temperature retrieved using atmospherically corrected 11&micro;m radiance',
        'gee:units': units.kelvin,
        'gee:scale': 0.472441,
        'gee:offset': 280.0,
      },
      {
        name: 'surface_type',
        description: 'UMD surface type',
        'gee:classes': [
          {
            color: '0d00d4',
            description: 'Water',
            value: 0,
          },
          {
            value: 1,
            color: '096619',
            description: 'Evergreen needle',
          },
          {
            value: 2,
            color: '096619',
            description: 'Evergreen broad',
          },
          {
            value: 3,
            color: '2ac027',
            description: 'Deciduous needle',
          },
          {
            value: 4,
            color: '2ac027',
            description: 'Deciduous broad',
          },
          {
            value: 5,
            color: 'a0c800',
            description: 'Mixed forest',
          },
          {
            value: 6,
            color: '7c6e48',
            description: 'Woodlands',
          },
          {
            value: 7,
            color: 'dcca76',
            description: 'Wooded grass',
          },
          {
            value: 8,
            color: 'c7ff42',
            description: 'Closed shrubs',
          },
          {
            value: 9,
            color: 'c7ff42',
            description: 'Open shrubs',
          },
          {
            value: 10,
            color: '00ff5a',
            description: 'Grasses',
          },
          {
            value: 11,
            color: 'fff700',
            description: 'Croplands',
          },
          {
            value: 12,
            color: 'ffdb77',
            description: 'Bare',
          },
          {
            value: 13,
            color: '9f9f9f',
            description: 'Urban',
          },
        ],
      },
      {
        name: 'temp_11_0um',
        description: 'Top of atmosphere brightness temperature at 11.0&micro;m (CDR variable)',
        'gee:units': units.kelvin,
        center_wavelength: 11.0,
        'gee:scale': 0.002441481,
        'gee:offset': 260.0,
        'gee:wavelength': '11.0&micro;m',
      },
      {
        name: 'temp_11_0um_clear_sky',
        description: 'Top of atmosphere brightness temperature modeled assuming clear skies at 11.0&micro;m',
        'gee:units': units.kelvin,
        'gee:scale': 0.002441481,
        'gee:offset': 260.0,
      },
      {
        name: 'temp_11_0um_stddev_3x3',
        description: 'Standard deviation of the 11.0&micro;m brightness temperature computed over a 3x3 pixel array',
        'gee:units': units.kelvin,
        'gee:scale': 0.07874016,
        'gee:offset': 10.9,
      },
      {
        name: 'temp_12_0um',
        description: 'Top of atmosphere brightness temperature 12.0&micro;m (CDR variable)',
        'gee:units': units.kelvin,
        center_wavelength: 12.0,
        'gee:scale': 0.002441481,
        'gee:offset': 260.0,
        'gee:wavelength': '12.0&micro;m',
      },
      {
        name: 'temp_3_75um',
        description: 'Top of atmosphere brightness temperature 3.75&micro;m (CDR variable)',
        'gee:units': units.kelvin,
        center_wavelength: 3.75,
        'gee:scale': 0.002441481,
        'gee:offset': 260.0,
        'gee:wavelength': '3.75&micro;m',
      },
      {
        name: 'acha_info',
        description: 'ACHA processing information bit flags',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Cloud height attempted',
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
              first_bit: 0,
            },
            {
              description: 'Bias correction employed',
              first_bit: 1,
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
              description: 'Ice cloud retrieval',
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
              description: 'Local radiative center processing used',
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
              description: 'Multi-layer retrieval',
              first_bit: 4,
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
              description: 'Lower cloud interpolation used',
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
              description: 'Boundary layer inversion assumed',
              first_bit: 6,
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
          total_bit_count: 7,
        },
      },
      {
        name: 'acha_quality',
        description: 'ACHA quality flags',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'ACHA products processed',
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
              first_bit: 0,
            },
            {
              description: 'Valid Tc retrieval',
              first_bit: 1,
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
              description: 'Valid ec retrieval',
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
              description: 'Valid beta retrieval',
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
              description: 'Degraded Tc retrieval',
              first_bit: 4,
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
              description: 'Degraded ec retrieval',
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
              description: 'Degraded beta retrieval',
              first_bit: 6,
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
          total_bit_count: 7,
        },
      },
      {
        name: 'bad_pixel_mask',
        description: 'Mask that distinguishes good from bad pixels',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Bad pixel mask',
              bit_count: 1,
              values: [
                {
                  description: 'Good',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Bad',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
      {
        name: 'cloud_mask',
        description: 'Integer classification of the cloud mask',
        'gee:classes': [
          {
            color: '73d8ff',
            description: 'Clear',
            value: 0,
          },
          {
            value: 1,
            color: 'b1d8dc',
            description: 'Probably clear',
          },
          {
            value: 2,
            color: 'd0d0d0',
            description: 'Probably cloudy',
          },
          {
            value: 3,
            color: '9d9d9d',
            description: 'Cloudy',
          },
        ],
      },
      {
        name: 'dcomp_info',
        description: 'Processing flags for DCOMP',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Info flag set',
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
              first_bit: 0,
            },
            {
              description: 'Land/sea mask',
              first_bit: 1,
              bit_count: 1,
              values: [
                {
                  description: 'Land',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Sea',
                },
              ],
            },
            {
              description: 'Day/night mask',
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  description: 'Day',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Night',
                },
              ],
            },
            {
              description: 'Twilight (65-82 solar zenith)',
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
              description: 'Snow',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Snow',
                },
              ],
            },
            {
              description: 'Sea-ice',
              first_bit: 5,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Sea-ice',
                },
              ],
            },
            {
              description: 'Phase',
              first_bit: 6,
              bit_count: 1,
              values: [
                {
                  description: 'Liquid',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Ice',
                },
              ],
            },
            {
              description: 'Thick cloud',
              first_bit: 7,
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
              description: 'Thin cloud',
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
          ],
          total_bit_count: 9,
        },
      },
      {
        name: 'dcomp_quality',
        description: 'DCOMP processing information bit flags',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'DCOMP products processed',
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
              first_bit: 0,
            },
            {
              description: 'Valid COD retrieval',
              first_bit: 1,
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
              description: 'Valid REF retrieval',
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
              description: 'Degraded COD retrieval',
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
              description: 'Degraded REF retrieval',
              first_bit: 4,
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
              description: 'Convergency',
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
              description: 'Glint',
              first_bit: 6,
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
          total_bit_count: 7,
        },
      },
      {
        name: 'glint_mask',
        description: 'Glint mask',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Glint mask',
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
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Cloud Emissivity and Height',
        lookat: {
          lat: 71.72,
          lon: 52.48,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'cld_emiss_acha',
              'cld_height_acha',
              'cld_height_uncer_acha',
            ],
          },
        },
      },
    ],
    cld_emiss_acha: {
      minimum: -127.0,
      maximum: 127.0,
      'gee:estimated_range': true,
    },
    cld_height_acha: {
      minimum: -32767.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    cld_height_uncer_acha: {
      minimum: -127.0,
      maximum: 127.0,
      'gee:estimated_range': true,
    },
    cld_opd_acha: {
      minimum: -127.0,
      maximum: 127.0,
      'gee:estimated_range': true,
    },
    cld_opd_dcomp: {
      minimum: -32685.0,
      maximum: 32149.0,
      'gee:estimated_range': true,
    },
    cld_opd_dcomp_unc: {
      minimum: -32685.0,
      maximum: -32276.0,
      'gee:estimated_range': true,
    },
    cld_press_acha: {
      minimum: -32767.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    cld_reff_acha: {
      minimum: -127.0,
      maximum: 127.0,
      'gee:estimated_range': true,
    },
    cld_reff_dcomp: {
      minimum: -32767.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    cld_reff_dcomp_unc: {
      minimum: -32767.0,
      maximum: -32357.0,
      'gee:estimated_range': true,
    },
    cld_temp_acha: {
      minimum: -32767.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    cloud_fraction: {
      minimum: -127.0,
      maximum: 127.0,
      'gee:estimated_range': true,
    },
    cloud_fraction_uncertainty: {
      minimum: -127.0,
      maximum: 0.0,
      'gee:estimated_range': true,
    },
    cloud_probability: {
      minimum: -127.0,
      maximum: 127.0,
      'gee:estimated_range': true,
    },
    cloud_transmission_0_65um: {
      minimum: -127.0,
      maximum: 127.0,
      'gee:estimated_range': true,
    },
    cloud_water_path: {
      minimum: -127.0,
      maximum: 127.0,
      'gee:estimated_range': true,
    },
    refl_0_65um: {
      minimum: -32767.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    refl_0_65um_counts: {
      minimum: -21.0,
      maximum: 1017.0,
      'gee:estimated_range': true,
    },
    refl_0_65um_stddev_3x3: {
      minimum: -127.0,
      maximum: 127.0,
      'gee:estimated_range': true,
    },
    refl_0_86um: {
      minimum: -32767.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    refl_0_86um_counts: {
      minimum: -21.0,
      maximum: 1016.0,
      'gee:estimated_range': true,
    },
    refl_1_60um: {
      minimum: -32767.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    refl_1_60um_counts: {
      minimum: -12.0,
      maximum: 1629.0,
      'gee:estimated_range': true,
    },
    refl_3_75um: {
      minimum: -32767.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    relative_azimuth_angle: {
      minimum: -127.0,
      maximum: 127.0,
      'gee:estimated_range': true,
    },
    scan_element_number: {
      minimum: -999.0,
      maximum: 409.0,
      'gee:estimated_range': true,
    },
    scan_line_number: {
      minimum: -999.0,
      maximum: 13835.0,
      'gee:estimated_range': true,
    },
    scan_line_time: {
      minimum: 0.0,
      maximum: 23.99,
      'gee:estimated_range': true,
    },
    sensor_zenith_angle: {
      minimum: -127.0,
      maximum: 68.0,
      'gee:estimated_range': true,
    },
    solar_azimuth_angle: {
      minimum: -127.0,
      maximum: 127.0,
      'gee:estimated_range': true,
    },
    solar_zenith_angle: {
      minimum: -101.0,
      maximum: 101.0,
      'gee:estimated_range': true,
    },
    surface_temperature_retrieved: {
      minimum: -127.0,
      maximum: 127.0,
      'gee:estimated_range': true,
    },
    temp_11_0um: {
      minimum: -32767.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    temp_11_0um_clear_sky: {
      minimum: -30853.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    temp_11_0um_stddev_3x3: {
      minimum: -127.0,
      maximum: 127.0,
      'gee:estimated_range': true,
    },
    temp_12_0um: {
      minimum: -32767.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    temp_3_75um: {
      minimum: -32767.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.7289/V5348HCK',
  'sci:citation': |||
    For the TOA Reflectances and Brightness Temperatures users must cite:
    Andrew K. Heidinger, Michael J. Foster, Andi Walther, Xuepeng Zhao, and
    NOAA CDR Program (2014): NOAA Climate Data Record (CDR) of Reflectance
    and Brightness Temperatures from AVHRR Pathfinder Atmospheres - Extended
    (PATMOS-x), Version 5.3. [indicate subset used]. NOAA National Centers for
    Environmental Information.
    [doi:10.7289/V56W982J](https://doi.org/10.7289/V56W982J)
    [access date].
  |||,
  'sci:publications': [
    {
      citation: |||
        For the cloud properties users must cite: Andrew K. Heidinger, Michael J.
        Foster, Andi Walther, Xuepeng Zhao, and NOAA CDR Program (2014): NOAA
        Climate Data Record (CDR) of Cloud Properties from AVHRR Pathfinder
        Atmospheres - Extended (PATMOS-x), Version 5.3. [indicate subset used].
        NOAA National Centers for Environmental Information.
        [doi:10.7289/V5348HCK](https://doi.org/10.7289/V5348HCK)
        [access date].
      |||,
      doi: '10.7289/V5348HCK',
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    The NOAA CDR Program's official distribution point for CDRs is NOAA's
    National Climatic Data Center which provides sustained, open access and
    active data management of the CDR packages and related information in
    keeping with the United States' open data policies and practices as
    described in the President's Memorandum on \"Open Data Policy\" and pursuant
    to the Executive Order of May 9, 2013, \"Making Open and Machine Readable
    the New Default for Government Information\". In line with these policies,
    the CDR data sets are nonproprietary, publicly available, and no
    restrictions are placed upon their use. For more information, see the
    [Fair Use of NOAA's CDR Data Sets, Algorithms and Documentation](https://www1.ncdc.noaa.gov/pub/data/sds/cdr/CDRs/Aerosol_Optical_Thickness/UseAgreement_01B-04.pdf)
    pdf.
  |||,
}
