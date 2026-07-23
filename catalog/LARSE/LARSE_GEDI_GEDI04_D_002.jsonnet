local id = 'LARSE/GEDI/GEDI04_D_002';
local subdir = 'LARSE';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local gedi = importstr 'gedi.md';

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
  title: 'GEDI L4D Imputed Waveforms, Version 2',
  version: '2',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The GEDI Level 4D (L4D) product provides a 30-m spatial elaboration of the mission's sample of footprint-level L2A V002, L2B V002, and L4A Version 2.1 products globally between latitudes -51.6 and 51.6 degrees.

    A k-nearest neighbors (k-NN) algorithm was used with Landsat time series data to impute high-quality GEDI shots to every 30-m pixel. A different nearest neighbor model was developed for every 10 x 10-km tile, with potential imputed shots drawn from a support area of at least 30 x 30 km centered on the tile. The imputation assigns the single nearest neighbor using Landsat time series imagery centered on the target year 2023.

    The most basic 30-m output is the shot number of the imputed pixel (relayed in fragments across five fields), from which any shot-level quantity may be retrieved. Predictions for commonly used waveform attributes are also included, such as relative height (RH) metrics from the L2A product, canopy cover from L2B, and aboveground biomass density (AGBD) from L4A.

    See [User Guide](https://daac.ornl.gov/GEDI/guides/GEDI_L4D_Imputed_Waveforms.html) for more information.
  ||| + gedi,
  license: spdx.proprietary.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.3334/ORNLDAAC/2455',
    },
  ],
  'gee:categories': ['forest-biomass'],
  keywords: [
    'biomass',
    'canopy',
    'elevation',
    'forest',
    'gedi',
    'larse',
    'nasa',
    'tree_cover',
  ],
  providers: [
    ee.producer_provider('ORNL DAAC', 'https://daac.ornl.gov/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2019-04-18T00:00:00Z', '2023-03-16T00:00:00Z'),
  summaries: {
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'rh10',
        description: 'Relative Height metric (rh10)',
        type:: ee_const.var_type.int,
      },
      {
        name: 'rh20',
        description: 'Relative Height metric (rh20)',
        type:: ee_const.var_type.int,
      },
      {
        name: 'rh30',
        description: 'Relative Height metric (rh30)',
        type:: ee_const.var_type.int,
      },
      {
        name: 'rh40',
        description: 'Relative Height metric (rh40)',
        type:: ee_const.var_type.int,
      },
      {
        name: 'rh50',
        description: 'Relative Height metric (rh50)',
        type:: ee_const.var_type.int,
      },
      {
        name: 'rh60',
        description: 'Relative Height metric (rh60)',
        type:: ee_const.var_type.int,
      },
      {
        name: 'rh70',
        description: 'Relative Height metric (rh70)',
        type:: ee_const.var_type.int,
      },
      {
        name: 'rh80',
        description: 'Relative Height metric (rh80)',
        type:: ee_const.var_type.int,
      },
      {
        name: 'rh90',
        description: 'Relative Height metric (rh90)',
        type:: ee_const.var_type.int,
      },
      {
        name: 'rh95',
        description: 'Relative Height metric (rh95)',
        type:: ee_const.var_type.int,
      },
      {
        name: 'rh98',
        description: 'Relative Height metric (rh98)',
        type:: ee_const.var_type.int,
      },
      {
        name: 'cover_z_000',
        description: 'Canopy Cover',
        type:: ee_const.var_type.int,
      },
      {
        name: 'agbd',
        description: 'Aboveground Biomass Density',
        type:: ee_const.var_type.int,
      },
      {
        name: 'sensitivity_a2',
        description: 'Sensitivity',
        type:: ee_const.var_type.int,
      },
      {
        name: 'shot_orbit',
        description: 'Orbit component of shot number',
        type:: ee_const.var_type.int,
      },
      {
        name: 'shot_beam',
        description: 'Beam component of shot number',
        type:: ee_const.var_type.int,
      },
      {
        name: 'shot_future',
        description: 'Future component of shot number',
        type:: ee_const.var_type.int,
      },
      {
        name: 'shot_granule',
        description: 'Granule component of shot number',
        type:: ee_const.var_type.int,
      },
      {
        name: 'shot_index',
        description: 'Shot Index component of shot number',
        type:: ee_const.var_type.int,
      },
      {
        name: 'QA',
        description: 'Quality Assessment mask',
        type:: ee_const.var_type.int,
        'gee:classes': [
          {
            value: 0,
            description: 'No data (pixel outside zone boundary)',
          },
          {
            value: 1,
            description: 'Valid data',
          },
          {
            value: 2,
            description: 'No data (unavailability of cloud-free CCDC input features)',
          },
          {
            value: 3,
            description: 'No data (nearest shot number truncated in GEE L2A product)',
          },
          {
            value: 4,
            description: 'Masked out (pixels corresponding to permanent water bodies)',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Aboveground Biomass Density',
        lookat: {
          lat: 0.0,
          lon: 0.0,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              60.0,
            ],
            palette: [
              'darkred',
              'red',
              'orange',
              'green',
              'darkgreen',
            ],
            bands: [
              'agbd',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.3334/ORNLDAAC/2455',
  'sci:citation': |||
    Seo, E., Healey, S. P., Yang, Z., Dubayah, R. O., De Conto, T., & Armston, J. (2025). GEDI L4D Imputed Waveforms, Version 2 (Version 2). ORNL Distributed Active Archive Center. https://doi.org/10.3334/ORNLDAAC/2455
  |||,
  'gee:terms_of_use': |||
    This dataset is in the public domain and is available
    without restriction on use and distribution. See [NASA's
    Earth Science Data & Information Policy]
    (https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
}
