local id = 'NASA/ECOSTRESS/L2T_STARS/V2';
local subdir = 'NASA';
local version = 'V002';

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
  title: 'ECOSTRESS Tiled Ancillary NDVI and Albedo L2 Global 70 m V002',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The ECOSTRESS Tiled Ancillary NDVI and Albedo (ECO_L2T_STARS) V002 dataset
    provides Normalized Difference Vegetation Index (NDVI) and albedo data at a
    70m spatial resolution. This ancillary product, essential for understanding
    plant water needs and stress, is created through a data fusion process that
    combines Visible Infrared Imaging Radiometer Suite (VIIRS) and Harmonized
    Landsat Sentinel (HLS) data. The fusion is performed using the STARS
    algorithm, a Bayesian timeseries methodology, to align the data with
    daytime ECOSTRESS overpasses. This product is only generated for
    corresponding ECOSTRESS Land Surface Temperature and Emissivity tiles.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/1655/ECO_L1C-4_Grid_Tile_User_Guide_V2.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/1869/ECOSTRESSL3JET_ATBD_V1.pdf)

    * [General Documentation](https://github.com/nasa/ECOSTRESS-Data-Resources)

    * [Land Processes Distributed Active Archive Center](https://www.earthdata.nasa.gov/centers/lp-daac)

  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/ECOSTRESS/ECO_L2T_STARS.002',
    },
  ],
  'gee:categories': ['plant-productivity'],
  keywords: [
    'land',
    'ecostress',
    'ndvi',
    'albedo',
  ],
  providers: [
    ee.producer_provider('Land Processes Distributed Active Archive Center', 'https://www.earthdata.nasa.gov/data/catalog/lpcloud-eco-l2t-stars-002'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2090073749-LPCLOUD',
  ],
  extent: ee.extent_global('2018-07-09T00:00:00Z', null),
  summaries: {
    gsd: [
      70.0,
    ],
    'eo:bands': [
      {
        name: 'NDVI',
        description: 'Normalized Difference Vegetation Index (NDVI)',
      },
      {
        name: 'NDVI-UQ',
        description: |||
          Normalized Difference Vegetation Index (NDVI) uncertainty.
        |||,
      },
      {
        name: 'albedo',
        description: 'Albedo',
      },
      {
        name: 'albedo-UQ',
        description: |||
          Albedo uncertainty.
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'NDVI',
        lookat: {
          lat: 38.8904,
          lon: -77.1056,
          zoom: 10,
        },
        image_visualization: {
          band_vis: {
            min: [
              -1.0,
            ],
            max: [
              1.0,
            ],
            palette: [
              '00008B',
              'A9A9A9',
              'CD853F',
              'FFFF00',
              '90EE90',
              '006400',
            ],
            bands: [
              'NDVI',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5067/ECOSTRESS/ECO_L2T_STARS.002',
  'sci:citation': |||
    Hook, Simon, et al. ECOSTRESS Tiled Ancillary NDVI and Albedo L2 Global 70 m
    v002. NASA Land Processes Distributed Active Archive Center, 2023,
    doi:[10.5067/ECOSTRESS/ECO_L2T_STARS.002](https://doi.org/10.5067/ECOSTRESS/ECO_L2T_STARS.002)
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
