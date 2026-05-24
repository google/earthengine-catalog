local id = 'projects/mangrovedatahub2/assets/CGMD-AFCC30';
local subdir = 'mangrovedatahub2';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

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
  title: 'Global Annual Mangrove Fractional Canopy Cover (1984-2023)',
  version: '1.0',
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.image_collection,

  description: |||
    The CGMD-AFCC30 (Continuous Global Mangrove Dynamics-Annual Fractional Canopy Cover at 30-m resolution) dataset provides global annual mangrove fractional canopy cover (FCC) at 30-m spatial resolution from 1984 to 2023. FCC quantifies the proportion of each Landsat pixel occupied by mangrove canopy and is expressed as a percentage ranging from 0% to 100%.

    The dataset was generated using time-series Landsat imagery within the Google Earth Engine platform. FCC maps are produced annually and spatially constrained to the global mangrove extent for each year. For data management and computational efficiency, the global dataset is organized into regional subsets, while temporal information is encoded using the `year` property associated with each image.

    Each image in the collection corresponds to a single year and includes the following key properties:

    * `year`: observation year
    * `version`: data version
    * `resolution`: spatial resolution (30 m)

    To reduce data volume and improve storage efficiency, FCC values are stored as integers representing percentage cover. As a result, a pixel value of 30 corresponds to an FCC of 30%. This representation preserves the original information content while substantially reducing data size.

    This dataset is designed to support large-scale analyses of long-term mangrove dynamics, including canopy change, degradation and recovery, blue carbon assessment, and coastal ecosystem monitoring. For citation, offline analysis, and long-term archiving, a companion version of this dataset is available via [Zenodo](https://zenodo.org/records/17204134). A full description of the data generation, validation, and uncertainty assessment is provided in the [associated scientific paper](https://doi.org/10.1126/science.aec9773).
  |||,

  license: license.id,

  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
  ],

  'gee:categories': [
    'forest-biomass',
    'vegetation-indices',
  ],

  keywords: [
    'mangrove',
    'wetland',
    'coastal',
    'landsat-derived',
    'annual',
    'global',
  ],

  providers: [
    ee.producer_provider('The Mangrove Lab', 'https://www.themangrovelab.com/'),
    ee.producer_provider('Dr. Zhen Zhang', 'https://gis-zhangzhen.github.io/'),
    ee.host_provider(self_ee_catalog_url),
  ],

  extent: ee.extent_global('1984-01-01T00:00:00Z', '2023-12-31T23:59:59Z'),

  summaries: {
    gsd: [30.0],

    'eo:bands': [
      {
        name: 'FCC',
        description: 'Mangrove fractional canopy cover stored as integer percentage cover from 0 to 100',
        'gee:units': '%',
      },
    ],

    'gee:visualizations': [
      {
        display_name: 'Mangrove fractional canopy cover',
        lookat: { lon: 133.55, lat: -2.33, zoom: 10 },
        image_visualization: {
          band_vis: {
            min: [0],
            max: [100],
            palette: [
              'ffffff',
              'e5f5e0',
              'a1d99b',
              '41ab5d',
              '006d2c',
            ],
            bands: ['FCC'],
          },
        },
      },
    ],

    FCC: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': true,
    },
  },

  'sci:citation': |||
    Zhang, Z., Murray, N., Song, X., ... & Friess, D. (2026) Unexpected expansion and regrowth in Earth's mangrove forests over the past four decades. Science. https://doi.org/10.1126/science.aec9773
  |||,

  'sci:publications': [
    {
      citation: |||
        Zhang, Z., Murray, N., Song, X., ... & Friess, D. (2026) Unexpected expansion and regrowth in Earth's mangrove forests over the past four decades. Science. https://doi.org/10.1126/science.aec9773
      |||,
      doi: '10.1126/science.aec9773',
    },
  ],

  'gee:interval': { type: 'cadence', unit: 'year', interval: 1 },

  'gee:terms_of_use': |||
    Acknowledgements

    Users should cite the associated scientific paper and the Zenodo data record when using this dataset in publications or derived products.

    License

    The dataset is licensed under the [CC-BY 4.0 license](https://creativecommons.org/licenses/by/4.0/).
  |||,

  'gee:user_uploaded': true,
}