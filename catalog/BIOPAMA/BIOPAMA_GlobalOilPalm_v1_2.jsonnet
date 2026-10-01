local id = 'BIOPAMA/GlobalOilPalm/v1_2';
local subdir = 'BIOPAMA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;
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
  title: 'Global Oil Palm Extent and Planting Year (1990-2021)',
  version: 'v1.2',
  'gee:type': ee_const.gee_type.image_collection,
  'gee:status': 'beta',
  description: |||
    This dataset provides a global map of oil palm plantations, including
    both industrial and smallholder plantations, along with estimated planting
    years.

    The dataset consists of two paired layers:
    1. **Plantation type classification (OP-extent)**: 10-meter spatial
       resolution raster classification derived from Sentinel-1 data (2016-2021)
       using a convolutional neural network (CNN), distinguishing industrial and
       smallholder oil palm plantations from other land cover.
    2. **Planting year (YoP)**: 30-meter spatial resolution raster depicting
       the estimated year of oil palm plantation establishment (1990-2021),
       derived from Landsat-5, -7, and -8 time series detecting early growth
       stages.

    Each asset in the collection represents a 100x100 km tile covering regions
    where oil palm plantations were detected.

    See [Descals et al. (2024)](https://doi.org/10.5194/essd-16-5111-2024) for
    methodology and additional information.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5281/zenodo.13379129',
    },
    ee.link.predecessor(
      'BIOPAMA/GlobalOilPalm/v1',
      ee_const.catalog_base + 'BIOPAMA/BIOPAMA_GlobalOilPalm_v1.json'
    ),
  ],
  'gee:categories': [
    'agriculture',
    'landuse-landcover',
  ],
  keywords: [
    'agriculture',
    'biodiversity',
    'conservation',
    'crop',
    'global',
    'landcover',
    'landuse',
    'palm',
    'plantation',
  ],
  providers: [
    ee.producer_provider('Descals et al. (2024) / Zenodo', 'https://doi.org/10.5281/zenodo.13379129'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1990-01-01T00:00:00Z', '2021-12-31T23:59:59Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'classification',
        description: 'Oil palm plantation type classification (10 m resolution)',
        gsd: 10,
        'gee:classes': [
          {
            value: 0,
            color: '696969',
            description: 'Other land covers that are not oil palm',
          },
          {
            value: 1,
            color: 'ff0000',
            description: 'Industrial closed-canopy oil palm plantations',
          },
          {
            value: 2,
            color: 'ef00ff',
            description: 'Smallholder closed-canopy oil palm plantations',
          },
        ],
      },
      {
        name: 'planting_year',
        description: 'Estimated year of plantation establishment (30 m resolution)',
        gsd: 30,
      },
    ],
    planting_year: {
      minimum: 1990,
      maximum: 2021,
      'gee:estimated_range': false,
    },
    'gee:visualizations': [
      {
        display_name: 'Plantation Classification',
        lookat: {
          lon: 101.7,
          lat: 3.1,
          zoom: 10,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              2.0,
            ],
            palette: [
              '696969',
              'ff0000',
              'ef00ff',
            ],
            bands: [
              'classification',
            ],
          },
        },
      },
      {
        display_name: 'Planting Year (1990-2021)',
        lookat: {
          lon: 101.7,
          lat: 3.1,
          zoom: 10,
        },
        image_visualization: {
          band_vis: {
            min: [
              1990.0,
            ],
            max: [
              2021.0,
            ],
            palette: [
              'ffffb2',
              'fecc5c',
              'fd8d3c',
              'f03b20',
              'bd0026',
            ],
            bands: [
              'planting_year',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Descals, A., Gaveau, D. L., Wich, S., Szantoi, Z., and Meijaard, E. (2024).
    Global mapping of oil palm planting year from 1990 to 2021.
    Earth System Science Data, 16(11), 5111-5129.
    [doi:10.5194/essd-16-5111-2024](https://doi.org/10.5194/essd-16-5111-2024)
  |||,
  'sci:doi': '10.5194/essd-16-5111-2024',
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
