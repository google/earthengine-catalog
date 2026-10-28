local id = 'NASA/VIIRS/002/VJ213A1';
local subdir = 'NASA';
local version = 'V002';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

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
  title: 'VJ213A1: VIIRS Vegetation Indices 16-Day 500m',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Joint Polar Satellite System (JPSS-2) / NOAA-21 NASA Visible
    Infrared Imaging Radiometer Suite (VIIRS) Vegetation Indices (VJ213A1)
    Version 2 data product provides vegetation indices by a process of
    selecting the best available pixel over a 16-day acquisition period
    at 500 meter resolution. The VJ213 data products are designed
    after the Moderate Resolution Imaging Spectroradiometer (MODIS)
    Terra and Aqua Vegetation Indices product suite to promote the
    continuity of the Earth Observation System (EOS) mission.

    The VJ213 algorithm process produces three vegetation indices: (1)
    Normalized Difference Vegetation Index (NDVI), (2) the Enhanced
    Vegetation Index (EVI), and (3) Enhanced Vegetation Index-2 (EVI2).
    (1) NDVI is one of the longest continual remotely sensed time series
    observations, using both the red and near-infrared (NIR) bands.
    (2) EVI is a slightly different vegetation index that is more sensitive
    to canopy cover, while NDVI is more sensitive to chlorophyll. (3) EVI2
    is a reformation of the standard 3-band EVI, using the red band and
    NIR band. This reformation addresses arising issues when comparing
    VIIRS EVI to other EVI models that do not include a blue band. EVI2
    will eventually become the standard EVI.

    Along with the three Vegetation Indices layers, this product also
    includes layers for near-infrared (NIR) reflectance; three shortwave
    infrared (SWIR) reflectance; red, blue, and green reflectance; composite
    day of year; pixel reliability; relative azimuth, view, and sun angles;
    and a quality layer.

    The band scale factors are already applied.

    For additional information, visit the VIIRS [Land Product Quality
    Assessment website](https://landweb.modaps.eosdis.nasa.gov/browse?sensor=VIIRS&sat=NOAA-21).

    Documentation:

    * [User's Guide and ATBD](https://lpdaac.usgs.gov/documents/1372/VNP13_User_Guide_ATBD_V2.1.2.pdf)

    * [General Documentation](https://lpdaac.usgs.gov/products/vj213a1v002/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/VIIRS/VJ213A1.002',
    },
  ],
  'gee:categories': ['vegetation-indices'],
  keywords: [
    '16_day',
    'evi',
    'nasa',
    'ndvi',
    'noaa',
    'noaa21',
    'vegetation',
    'viirs',
    'vj213a1',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/VIIRS/VJ213A1.002'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2817367150-LPCLOUD',
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
        name: 'EVI',
        description: '3 band Enhanced Vegetation Index',
      },
      {
        name: 'EVI2',
        description: '2 band Enhanced Vegetation Index',
      },
      {
        name: 'NDVI',
        description: 'Normalized Difference Vegetation Index',
      },
      {
        name: 'NIR_reflectance',
        description: 'Near-infrared Radiation reflectance',
        center_wavelength: 0.866,
        'gee:wavelength': '846-885nm',
      },
      {
        name: 'SWIR1_reflectance',
        description: 'Shortwave Infrared Radiation reflectance',
        center_wavelength: 1.24,
        'gee:wavelength': '1230-1250nm',
      },
      {
        name: 'SWIR2_reflectance',
        description: 'Shortwave Infrared Radiation reflectance',
        center_wavelength: 1.61,
        'gee:wavelength': '1580-1640nm',
      },
      {
        name: 'SWIR3_reflectance',
        description: 'Shortwave Infrared Radiation reflectance',
        center_wavelength: 2.25,
        'gee:wavelength': '2225-2275nm',
      },
      {
        name: 'VI_Quality',
        description: 'Quality Assessment (QA) bit-field',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'MODLAND_QA',
              bit_count: 2,
              values: [
                {
                  description: 'VI produced, good quality',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'VI produced, but check other QA',
                },
                {
                  value: 2,
                  description: 'Pixel produced, but probably cloudy',
                },
                {
                  value: 3,
                  description: 'Pixel not produced due to other reason than clouds',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'VI usefulness, higher values are worse',
              first_bit: 2,
              bit_count: 4,
              values: [
                {
                  description: 'Highest Quality',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Lower quality',
                },
                {
                  value: 2,
                  description: 'Decreasing quality',
                },
                {
                  value: 3,
                  description: 'Decreasing quality',
                },
                {
                  value: 4,
                  description: 'Decreasing quality',
                },
                {
                  value: 5,
                  description: 'Decreasing quality',
                },
                {
                  value: 6,
                  description: 'Decreasing quality',
                },
                {
                  value: 7,
                  description: 'Decreasing quality',
                },
                {
                  value: 8,
                  description: 'Decreasing quality',
                },
                {
                  value: 9,
                  description: 'Decreasing quality',
                },
                {
                  value: 10,
                  description: 'Decreasing quality',
                },
                {
                  value: 11,
                  description: 'Decreasing quality',
                },
                {
                  value: 12,
                  description: 'Worst quality',
                },
                {
                  value: 13,
                  description: 'Quality so low that it is not useful',
                },
                {
                  value: 14,
                  description: 'L1B data faulty',
                },
                {
                  value: 15,
                  description: 'Not useful for any reason/not processed',
                },
              ],
            },
            {
              description: 'Aerosol quantity',
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
              description: 'Adjacent cloud detected',
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
              description: 'Atmosphere BRDF correction performed',
              first_bit: 9,
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
              description: 'Mixed clouds',
              first_bit: 10,
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
              description: 'Land/Water Flag',
              first_bit: 11,
              bit_count: 3,
              values: [
                {
                  description: 'Land & desert',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Land no desert',
                },
                {
                  value: 2,
                  description: 'Inland water',
                },
                {
                  value: 3,
                  description: 'Sea water',
                },
                {
                  value: 5,
                  description: 'Coastal',
                },
              ],
            },
            {
              description: 'Possible snow/ice',
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
            {
              description: 'Possible shadow',
              first_bit: 15,
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
          total_bit_count: 16,
        },
      },
      {
        name: 'red_reflectance',
        description: 'Red band reflectance',
        center_wavelength: 0.64,
        'gee:wavelength': '600-680nm',
      },
      {
        name: 'green_reflectance',
        description: 'Green band reflectance',
        center_wavelength: 0.555,
        'gee:wavelength': '545-565nm',
      },
      {
        name: 'blue_reflectance',
        description: 'Blue band reflectance',
        center_wavelength: 0.488,
        'gee:wavelength': '478-498nm',
      },
      {
        name: 'composite_day_of_the_year',
        description: 'Julian day of year',
        'gee:units': units.day,
      },
      {
        name: 'pixel_reliability',
        description: 'Pixel usefulness using a simple rank class',
        'gee:classes': [
          {
            description: 'Excellent',
            value: 0,
          },
          {
            value: 1,
            description: 'Good',
          },
          {
            value: 2,
            description: 'Acceptable',
          },
          {
            value: 3,
            description: 'Marginal',
          },
          {
            value: 4,
            description: 'Pass',
          },
          {
            value: 5,
            description: 'Questionable',
          },
          {
            value: 6,
            description: 'Poor',
          },
          {
            value: 7,
            description: 'Cloud Shadow',
          },
          {
            value: 8,
            description: 'Snow/Ice',
          },
          {
            value: 9,
            description: 'Cloud',
          },
          {
            value: 10,
            description: 'Estimated',
          },
          {
            value: 11,
            description: 'LTAVG (taken from database)',
          },
        ],
      },
      {
        name: 'relative_azimuth_angle',
        description: 'Relative azimuth angle for each pixel',
        'gee:units': units.degree,
      },
      {
        name: 'sun_zenith_angle',
        description: 'Sun zenith angle for each pixel',
        'gee:units': units.degree,
      },
      {
        name: 'view_zenith_angle',
        description: 'View zenith angle for each pixel',
        'gee:units': units.degree,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'NDVI',
        lookat: {
          lat: 17.6,
          lon: -98.0,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              0.9,
            ],
            palette: [
              'FFFFFF',
              'CE7E45',
              'DF923D',
              'F1B555',
              'FCD163',
              '99B718',
              '74A901',
              '66A000',
              '529400',
              '3E8601',
              '207401',
              '056201',
              '004C00',
              '023B01',
              '012E01',
              '011D01',
              '011301',
            ],
            bands: [
              'NDVI',
            ],
          },
        },
      },
      {
        display_name: 'True Color (RGB)',
        lookat: {
          lat: 17.6,
          lon: -98.0,
          zoom: 6,
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
              'red_reflectance',
              'green_reflectance',
              'blue_reflectance',
            ],
          },
        },
      },
    ],
    EVI: {
      minimum: -1.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    EVI2: {
      minimum: -1.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    NDVI: {
      minimum: -1.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    NIR_reflectance: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    SWIR1_reflectance: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    SWIR2_reflectance: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    SWIR3_reflectance: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    red_reflectance: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    green_reflectance: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    blue_reflectance: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    composite_day_of_the_year: {
      minimum: 1.0,
      maximum: 366.0,
      'gee:estimated_range': false,
    },
    relative_azimuth_angle: {
      minimum: -180.0,
      maximum: 180.0,
      'gee:estimated_range': false,
    },
    sun_zenith_angle: {
      minimum: 0.0,
      maximum: 180.0,
      'gee:estimated_range': false,
    },
    view_zenith_angle: {
      minimum: 0.0,
      maximum: 180.0,
      'gee:estimated_range': false,
    },
  },
  'sci:doi': '10.5067/VIIRS/VJ213A1.002',
  'sci:citation': |||
    Vermote, E. (2026). VIIRS/JPSS2 Vegetation Indices 16-Day L3 Global 500m SIN Grid V002 [Data set]. NASA EOSDIS Land Processes Distributed Active Archive Center.
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
