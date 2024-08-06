local id = 'NASA/VIIRS/002/VNP15A2H';
local subdir = 'NASA';
local version = 'v002';
local predecessor_id = 'NOAA/VIIRS/001/VNP15A2H';
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
  title: 'VNP15A2H: LAI/FPAR 8-Day L4 Global 500m SIN Grid',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Visible Infrared Imaging Radiometer Suite (VIIRS) Leaf Area Index (LAI)
    and Fraction of Photosynthetically Active Radiation (FPAR) Version 1 data
    product provides information about the vegetative canopy layer at 500 meter
    resolution (VNP15A2H). The VIIRS sensor is located onboard the NOAA/NASA
    joint Suomi National Polar-Orbiting Partnership (Suomi NPP) satellite. LAI
    is an index that quantifies the one-sided leaf area of a canopy, while FPAR
    is the fraction of incoming solar energy absorbed through photosynthesis at
    400 to 700 nanometers. This product is intentionally designed after the
    Terra and Aqua Moderate Resolution Imaging Spectroradiometer (MODIS)
    LAI/FPAR operational algorithm to promote the continuity of the Earth
    Observation System (EOS) mission.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/126/VNP15_User_Guide.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/125/VNP15_ATBD.pdf)

    * [General Documentation](https://lpdaac.usgs.gov/products/vnp15a2hv002/)

    * [Land Product Quality Assessment website](https://landweb.modaps.eosdis.nasa.gov/browse?sensor=VIIRS&sat=SNPP)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/VIIRS/VNP15A2H.002',
    },
    ee.link.latest(latest_id, catalog_subdir_url + latest_basename + '.json'),
    ee.link.predecessor(
      predecessor_id,
      ee_const.catalog_base + 'NOAA/' + predecessor_basename + '.json'),
  ],
  keywords: [
    'land',
    'nasa',
    'noaa',
    'surface',
    'viirs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/VIIRS/VNP15A2H.002'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1407099490-LPDAAC_ECS',
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
        name: 'Fpar',
        description: |||
          Fraction of Photosynthetically Active Radiation.
        |||,
      },
      {
        name: 'FparExtra_QC',
        description: 'Pass-through Quality Control (QC) for FPAR',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Cloud detection and confidence',
              bit_count: 2,
              values: [
                {
                  description: 'Confident clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Probably clear',
                },
                {
                  value: 2,
                  description: 'Probably cloudy',
                },
                                {
                  value: 3,
                  description: 'Confident cloudy',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Cloud shadow',
              bit_count: 1,
              values: [
                {
                  description: 'No cloud shadow',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Shadow',
                },
              ],
              first_bit: 2,
            },
            {
              description: 'Thin cirrus',
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
              first_bit: 3,
            },
            {
              description: 'Aerosol quantity',
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
              first_bit: 4,
            },
            {
              description: 'Snow/Ice',
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
              first_bit: 6,
            },
          ],
          total_bit_count: 7,
        },
      },
      {
        name: 'FparLai_QC',
        description: 'Quality for LAI and FPAR',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'SCF_QC',
              bit_count: 3,
              values: [
                {
                  description: |||
                    Main (RT) method used, best result possible (no saturation)
                  |||,
                  value: 0,
                },
                {
                  description: |||
                    Main (RT) method used with saturation. Good, very usable.
                  |||,
                  value: 1,
                },
                {
                  description: |||
                    Main (RT) method failed due to bad geometry, empirical
                    algorithm used
                  |||,
                  value: 2,
                },
                {
                  description: |||
                    Main (RT) method failed due to problems other than geometry,
                    empirical algorithm used
                  |||,
                  value: 3,
                },
                {
                  description: |||
                    Pixel not produced at all, value couldn't be retrieved 
                  |||,
                  value: 4,
                },
              ],
              first_bit: 0,
            },
            {
              description: 'DeadDetector',
              bit_count: 1,
              values: [
                {
                  description: 'Both red and NIR detectors are fine',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'At least one band has dead detector',
                },
              ],
              first_bit: 3,
            },
            {
              description: 'BiomeType',
              bit_count: 4,
              values: [
                {
                  description: 'Water',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Grasses/cereal crops',
                },
                {
                  value: 2,
                  description: 'Shrubs',
                },
                {
                  value: 3,
                  description: 'Broadleaf crops',
                },
                {
                  value: 4,
                  description: 'Savanna',
                },
                {
                  value: 5,
                  description: 'Evergreen broadleaf forest',
                },
                {
                  value: 6,
                  description: 'Deciduous broadleaf forest',
                },
                {
                  value: 7,
                  description: 'Evergreen needleleaf forest',
                },
                {
                  value: 8,
                  description: 'Deciduous needleleaf forest',
                },
                {
                  value: 9,
                  description: 'Non-vegetated',
                },
                {
                  value: 10,
                  description: 'Urban',
                },
                {
                  value: 11,
                  description: 'Unclassified',
                },
                {
                  value: 12,
                  description: 'Filled Value',
                },
              ],
              first_bit: 4,
            },
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'FparStdDev',
        description: 'Standard deviation of FPAR',
      },
      {
        name: 'Lai',
        description: 'Leaf Area Index',
        'gee:units': units.area_fraction,
      },
      {
        name: 'LaiStdDev',
        description: 'Standard deviation for LAI',
        'gee:units': units.area_fraction,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Leaf Area Index (LAI)',
        lookat: {
          lat: 41.2,
          lon: 38.8,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              4,
            ],
            palette: [
              'a50026',
              'd73027',
              'f46d43',
              'fdae61',
              'fee08b',
              'ffffbf',
              'd9ef8b',
              'a6d96a',
              '66bd63',
              '1a9850',
              '006837',
            ],
            bands: [
              'Lai',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5067/VIIRS/VNP15A2H.002',
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
