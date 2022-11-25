local id = 'MODIS/NTSG/MOD16A2/105';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
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
  title: 'MOD16A2: MODIS Global Terrestrial Evapotranspiration 8-Day Global 1km',
  version: 'V105',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MOD16A2 V105 product provides information about
    8-day global terrestrial evapotranspiration at 1km pixel resolution.
    Evapotranspiration (ET) is the sum of evaporation and plant transpiration
    from the Earth's surface to the atmosphere. With long-term ET
    data, the effects of changes in climate, land use, and ecosystems
    disturbances can be quantified.

    The MOD16A2 product is produced by the Numerical Terradynamic Simulation
    Group [NTSG](https://www.ntsg.umt.edu/),
    University of Montana (UMT) in conjunction with NASA Earth Observing
    System. For more details about the algorithm used see the [algorithm
    theoretical basis document](https://scholarworks.umt.edu/cgi/viewcontent.cgi?article=1267&context=ntsg_pubs).

    * The period of coverage is 8 days with the exception of
    the last period at the end of the year which is either 5 or 6 days.
    ET/PET units are 0.1mm/5-day for December 27-31 of 2001, 2002,
    2003, 2005, 2006, 2007, 2009, 2010, and 0.1mm/6-day for December
    26-31 of 2000, 2004, 2008 (leap years).

    ** For some pixels in African
    rainforest, the MODIS albedo data from MCD43B2/MCD43B3 have no
    cloud-free data throughout an entire year. As a result, pixels
    for that year in all data bands are masked out.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.source,
      href: 'http://files.ntsg.umt.edu/data/MOD16_TP/',
    },
  ],
  keywords: [
    '8_day',
    'evapotranspiration',
    'global',
    'mod16a2',
    'modis',
  ],
  providers: [
    ee.producer_provider('Numerical Terradynamic Simulation Group, The University of Montana', 'https://www.ntsg.umt.edu/project/modis/mod16.php'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2014-12-27T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'days_of_coverage',
        description: |||
          Number of days covered by each image since the period
          of coverage for the last asset of the year can be of varying
          length
        |||,
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      1000.0,
    ],
    platform: [
      'Aqua',
      'Terra',
    ],
    instruments: [
      'MODIS',
    ],
    'eo:bands': [
      {
        name: 'ET',
        description: 'Evapotranspiration, aggregated for period of coverage.',
        'gee:units': 'kg/m^2',
        'gee:scale': 0.1,
      },
      {
        name: 'LE',
        description: 'Latent heat flux, averaged daily over the period of coverage.',
        'gee:units': 'J/m^2/day',
        'gee:scale': 0.0001,
      },
      {
        name: 'PET',
        description: 'Potential evapotranspiration, aggregated for period of coverage.',
        'gee:units': 'kg/m^2',
        'gee:scale': 0.1,
      },
      {
        name: 'PLE',
        description: 'Potential Latent Heat Flux, averaged daily over the period ofcoverage.',
        'gee:units': 'J/m^2/day',
        'gee:scale': 0.0001,
      },
      {
        name: 'ET_QC',
        description: 'ET quality control.',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'MODLAND_QC bits',
              bit_count: 1,
              values: [
                {
                  description: 'Good quality (main algorithm with or without saturation)',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Other quality (back-up algorithm or fill values)',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Sensor',
              first_bit: 1,
              bit_count: 1,
              values: [
                {
                  description: 'Terra',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Aqua',
                },
              ],
            },
            {
              description: 'Dead detector',
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  description: 'Detectors fine for up to 50% of channels 1, 2',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Dead detectors caused >50% adjacent detector retrieval',
                },
              ],
            },
            {
              description: 'Cloud state',
              first_bit: 3,
              bit_count: 2,
              values: [
                {
                  description: 'Significant clouds NOT present (clear)',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Significant clouds WERE present',
                },
                {
                  value: 2,
                  description: 'Mixed cloud present on pixel',
                },
                {
                  value: 3,
                  description: 'Cloud state not defined, assumed clear',
                },
              ],
            },
            {
              description: 'SCF_QC (five level confidence score)',
              first_bit: 5,
              bit_count: 3,
              values: [
                {
                  description: 'Main method used, best result possible (no saturation)',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Main method used, good and very usable (with saturation)',
                },
                {
                  value: 2,
                  description: 'Main method failed due to bad geometry, empirical algorithm used',
                },
                {
                  value: 3,
                  description: 'Main method failed due to problems other than geometry, empirical algorithm used',
                },
                {
                  value: 4,
                  description: "Pixel not produced at all, value couldn't be retrieved",
                },
              ],
            },
          ],
          total_bit_count: 8,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Evapotranspiration',
        lookat: {
          lon: 0,
          lat: 0,
          zoom: 0,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              300.0,
            ],
            palette: [
              'a50000',
              'ff4f1a',
              'f1e342',
              'c7ef1f',
              '05fff3',
              '1707ff',
              'd90bff',
            ],
            bands: [
              'ET',
            ],
          },
        },
      },
    ],
    ET: {
      minimum: -5.0,
      maximum: 453.0,
      'gee:estimated_range': true,
    },
    LE: {
      minimum: -20.0,
      maximum: 1671.0,
      'gee:estimated_range': true,
    },
    PET: {
      minimum: -8.0,
      maximum: 793.0,
      'gee:estimated_range': true,
    },
    PLE: {
      minimum: -40.0,
      maximum: 3174.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Qiaozhen Mu, Maosheng Zhao, Steven W. Running and Numerical Terradynamic
    Simulation Group (2014): MODIS Global Terrestrial Evapotranspiration
    (ET) Product MOD16A2 Collection 5.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 8,
  },
  'gee:terms_of_use': |||
    All NTSG data distributed through this [site](http://files.ntsg.umt.edu/)
    has no restrictions on subsequent use, sale, or redistribution.
  |||,
}
