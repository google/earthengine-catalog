local id = 'LANDSAT/MANGROVE_FORESTS';
local subdir = 'LANDSAT';

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
  title: 'Global Mangrove Forests Distribution, v1 (2000)',
  version: 'v1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The database was prepared using Landsat satellite data from the year 2000.
    More than 1,000 Landsat scenes obtained from the USGS Earth Resources
    Observation and Science Center (EROS) were classified using hybrid
    supervised and unsupervised digital image classification techniques. This
    database is the first, most comprehensive mangrove assessment of the world
    ([Giri et al., 2011](https://onlinelibrary.wiley.com/doi/abs/10.1111/j.1466-8238.2010.00584.x)).
    Partial funding of this research was provided by NASA.

    The mangrove database is being used for identifying priority areas
    for mangrove conservation, studying the role of mangrove forests in
    saving lives and properties from natural disasters (e.g. tsunami),
    carbon accounting, and biodiversity conservation. The USGS EROS has
    been using the data to study the impact of sea level rise on mangrove
    ecosystems. The database serves as a baseline for mangrove
    monitoring.

    [General Documentation](https://sedac.ciesin.columbia.edu/data/set/lulc-global-mangrove-forests-distribution-2000/docs)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7927/H4J67DW8',
    },
  ],
  keywords: [
    'annual',
    'ciesin',
    'global',
    'landsat_derived',
    'mangrove',
    'nasa',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA SEDAC at the Center for International Earth Science Information Network', 'https://doi.org/10.7927/H4J67DW8'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1000000440-SEDAC',
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2001-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      30.0,
    ],
    platform: [
      'Landsat',
    ],
    instruments: [
      'TM',
    ],
    'eo:bands': [
      {
        name: '1',
        description: 'Mangroves',
        'gee:classes': [
          {
            value: 1,
            color: 'd40115',
            description: 'Mangroves',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Mangroves',
        lookat: {
          lat: -81.5034,
          lon: 24.6882,
          zoom: 10,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              1.0,
            ],
            palette: [
              'd40115',
            ],
            bands: [
              '1',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.7927/H4J67DW8',
  'sci:citation': |||
    Giri, C., E. Ochieng, L.L.Tieszen, Z. Zhu, A. Singh, T. Loveland, J. Masek, and N. Duke. 2013. Global Mangrove Forests Distribution, 2000. Palisades, NY: NASA Socioeconomic Data and Applications Center (SEDAC). [https://doi.org/10.7927/H4J67DW8](https://doi.org/10.7927/H4J67DW8). Accessed DAY MONTH YEAR
  |||,
  'sci:publications': [
    {
      citation: |||
        Giri, C., E. Ochieng, L. L. Tieszen, Z. Zhu, A. Singh, T. Loveland, J. Masek, and N. Duke. 2010. Status and Distribution of Mangrove Forests of the World Using Earth Observation Satellite Data. Global Ecology and Biogeography: A Journal of Macroecology 20(1): 154-159. [https://doi.org/10.1111/j.1466-8238.2010.00584.x](https://doi.org/10.1111/j.1466-8238.2010.00584.x).
      |||,
      doi: '10.1111/j.1466-8238.2010.00584.x',
    },
  ],
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
