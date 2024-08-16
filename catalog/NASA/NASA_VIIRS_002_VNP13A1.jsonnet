local id = 'NASA/VIIRS/002/VNP13A1';
local subdir = 'NASA';
local version = '2';
local predecessor_id = 'NOAA/VIIRS/001/VNP13A1';
local latest_id = id;

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local predecessor_basename = std.strReplace(predecessor_id, '/', '_');
local latest_basename = std.strReplace(latest_id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'VNP13A1.002: VIIRS Vegetation Indices 16-Day 500m',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Suomi National Polar-Orbiting Partnership (S-NPP) NASA Visible
    Infrared Imaging Radiometer Suite (VIIRS) Vegetation Indices (VNP13A1)
    data product provides vegetation indices by a process of
    selecting the best available pixel over a 16-day acquisition period
    at 500 meter resolution. The VNP13 data products are designed
    after the Moderate Resolution Imaging Spectroradiometer (MODIS)
    Terra and Aqua Vegetation Indices product suite to promote the
    continuity of the Earth Observation System (EOS) mission.

    The VNP13 algorithm process produces three vegetation indices: (1)
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
    infrared (SWIR) reflectance-red, blue, and green reflectance; composite
    day of year; pixel reliability; view and sun angles, and a quality layer.

    For additional information, visit the VIIRS [Land Product Quality
    Assessment website](https://landweb.modaps.eosdis.nasa.gov/browse?sensor=VIIRS&sat=SNPP) and see
    the [User Guide](https://lpdaac.usgs.gov/documents/1372/VNP13_User_Guide_ATBD_V2.1.2.pdf).

    Documentation:

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/VIIRS/1/VNP13A1)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/VIIRS/VNP13A1.002',
    },
      ee.link.latest(latest_id, catalog_subdir_url + latest_basename + '.json'),
      ee.link.predecessor(predecessor_id,ee_const.catalog_base + 'NOAA/' +
        predecessor_basename + '.json'),
  ],
  keywords: [
    '16_day',
    'evi',
    'nasa',
    'ndvi',
    'noaa',
    'npp',
    'vegetation',
    'viirs',
    'vnp13a1',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/VIIRS/VNP13A1.002'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1392010616-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2012-01-17T00:00:00Z', null),
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
        description: 'Quality Assessment (QA) bit-field.',
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
              description: 'VI Usefulness, higher values are worse.',
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
              description: 'Adjacent BRDF correction performed',
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
                  description: 'land & desert',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'land no desert',
                },
                {
                  value: 2,
                  description: 'inland water',
                },
                {
                  value: 3,
                  description: 'sea_water',
                },
                {
                  value: 5,
                  description: 'coastal',
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
        center_wavelength: 0.601,
        'gee:wavelength': '545-656nm',
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
        display_name: 'Default visualization',
        lookat: {
          lat: 27.808,
          lon: 95.571,
          zoom: 8,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              10000.0,
            ],
            palette: [
              '000000',
              '004400',
              '008800',
              '00bb00',
              '00ff00',
            ],
            bands: [
              'EVI',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5067/VIIRS/VNP13A1.002',
  'sci:citation': |||
    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
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
