local id = 'Tsinghua/DESS/ChinaTerraceMap/v1';
local subdir = 'Tsinghua';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'DESS China Terrace Map v1',
  version: 'v1',
  'gee:type': ee_const.gee_type.image,
  description: |||
    This dataset is a China terrace map at 30 m resolution in 2018. It was
    developed through supervised pixel-based classification using multisource and
    multi-temporal data based on the Google Earth Engine platform. The overall
    accuracy and kappa coefficient achieved 94% and 0.72, respectively. This first
    30 m China terrace map can be used for studies on soil erosion, food
    security, biogeochemical cycle, biodiversity, and ecosystem service
    assessments.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5194/essd-13-2437-2021',
    },
  ],
  keywords: [
    'agriculture',
    'china',
    'dess',
    'landcover',
    'landuse',
    'terrace',
    'tsinghua',
  ],
  providers: [
    ee.producer_provider('Department of Earth System Science, Tsinghua University (DESS, THU)', 'https://essd.copernicus.org/articles/13/2437/2021/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(70.0, 0.0, 140.0, 60.0,
                    '2018-01-01T00:00:00Z', '2019-01-01T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'terrace',
        description: '1 when a terrace is present, 0 when it is not.',
        gsd: 30.0,
        'gee:classes': [
          {
            color: 'ffffff',
            description: 'No terraces',
            value: 0,
          },
          {
            value: 1,
            color: 'a3ff74',
            description: 'Terraces present',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Terraces',
        lookat: {
          lat: 30.4,
          lon: 106.6,
          zoom: 10,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              1.0,
            ],
            palette: [
              'ffffff',
              'a3ff74',
            ],
            bands: [
              'terrace',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5194/essd-13-2437-2021',
  'sci:citation': |||
    Cao, B., Yu, L., Naipal, V., Ciais, P., Li, W., Zhao, Y., Wei, W.,
    Chen, D., Liu, Z., and Gong, P.: A 30 m terrace mapping in China using
    Landsat 8 imagery and digital elevation model based on the Google Earth
    Engine, Earth Syst. Sci. Data, 13, 2437-2456,
    [doi:10.5194/essd-13-2437-2021](https://doi.org/10.5194/essd-13-2437-2021), 2021.
  |||,
  'gee:terms_of_use': 'This work is licensed under a Creative Commons Attribution 4.0 International License.',
  'gee:user_uploaded': true,
}
