local id = 'OpenLandMap/PNV/PNV_BIOME-TYPE_BIOME00K_C/v01';
local subdir = 'OpenLandMap';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_sa_4_0;

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
  ],
  id: id,
  title: 'OpenLandMap Potential Distribution of Biomes',
  'gee:type': ee_const.gee_type.image,
  description: |||
    Potential Natural Vegetation biomes global predictions of classes
    (based on predictions using the BIOMES 6000 dataset's 'current biomes' category.)

    Potential Natural Vegetation (PNV) is the vegetation cover in equilibrium with climate
    that would exist at a given location non-impacted by human activities. PNV is useful for raising
    public awareness about land degradation and for estimating land potential.
    This dataset contains results of predictions of
    - (1) global distribution of biomes based on the BIOME 6000 data set (8057 modern pollen-based site reconstructions),
    - (2) distribution of forest tree species in Europe based on detailed occurrence records (1,546,435 ground observations), and
    - (3) global monthly Fraction of Absorbed Photosynthetically Active Radiation (FAPAR) values (30,301 randomly-sampled points).

    To report an issue or artifact in data, please use [this link](https://github.com/envirometrix/PNVmaps/issues).

    To access and visualize maps outside of Earth Engine, use [this page](https://landgis.opengeohub.org).

    If you discover a bug, artifact or inconsistency in the LandGIS maps
    or if you have a question please use the following channels:

     *  [Technical issues and questions about the code](https://gitlab.com/openlandmap/global-layers/issues)
     *  [General questions and comments](https://disqus.com/home/forums/landgis/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license('https://opendatacommons.org/licenses/odbl/1-0/'),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7910/DVN/QQHCIK',
    },
  ],
  keywords: [
    'biome',
    'envirometrix',
    'opengeohub',
    'openlandmap',
    'potential',
  ],
  providers: [
    ee.producer_provider('EnvirometriX Ltd', 'https://doi.org/10.7910/DVN/QQHCIK'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2001-01-01T00:00:00Z', '2002-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      1000.0,
    ],
    'eo:bands': [
      {
        name: 'biome_type',
        description: 'Potential distribution of biomes',
        'gee:classes': [
          {
            value: 1,
            color: '1c5510',
            description: 'tropical evergreen broadleaf forest',
          },
          {
            value: 2,
            color: '659208',
            description: 'tropical semi-evergreen broadleaf forest',
          },
          {
            value: 3,
            color: 'ae7d20',
            description: 'tropical deciduous broadleaf forest and woodland',
          },
          {
            value: 4,
            color: '000065',
            description: 'warm-temperate evergreen broadleaf and mixed forest',
          },
          {
            value: 7,
            color: 'bbcb35',
            description: 'cool-temperate rainforest',
          },
          {
            value: 8,
            color: '009a18',
            description: 'cool evergreen needleleaf forest',
          },
          {
            value: 9,
            color: 'caffca',
            description: 'cool mixed forest',
          },
          {
            value: 13,
            color: '55eb49',
            description: 'temperate deciduous broadleaf forest',
          },
          {
            value: 14,
            color: '65b2ff',
            description: 'cold deciduous forest',
          },
          {
            value: 15,
            color: '0020ca',
            description: 'cold evergreen needleleaf forest',
          },
          {
            value: 16,
            color: '8ea228',
            description: 'temperate sclerophyll woodland and shrubland',
          },
          {
            value: 17,
            color: 'ff9adf',
            description: 'temperate evergreen needleleaf open woodland',
          },
          {
            value: 18,
            color: 'baff35',
            description: 'tropical savanna',
          },
          {
            value: 20,
            color: 'ffba9a',
            description: 'xerophytic woods/scrub',
          },
          {
            value: 22,
            color: 'ffba35',
            description: 'steppe',
          },
          {
            value: 27,
            color: 'f7ffca',
            description: 'desert',
          },
          {
            value: 28,
            color: 'e7e718',
            description: 'graminoid and forb tundra',
          },
          {
            value: 30,
            color: '798649',
            description: 'erect dwarf shrub tundra',
          },
          {
            value: 31,
            color: '65ff9a',
            description: 'low and high shrub tundra',
          },
          {
            value: 32,
            color: 'd29e96',
            description: 'prostrate dwarf shrub tundra',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Potential distribution of biomes',
        image_visualization: {
          global_vis: {
            min: [
              1.0,
            ],
            max: [
              32.0,
            ],
            palette: [
              '1c5510',
              '659208',
              'ae7d20',
              '000065',
              'bbcb35',
              '009a18',
              'caffca',
              '55eb49',
              '65b2ff',
              '0020ca',
              '8ea228',
              'ff9adf',
              'baff35',
              'ffba9a',
              'ffba35',
              'f7ffca',
              'e7e718',
              '798649',
              '65ff9a',
              'd29e96',
            ],
            bands: [
              'biome_type',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.7910/DVN/QQHCIK',
  'sci:citation': |||
    Hengl T, Walsh MG, Sanderman J, Wheeler I, Harrison SP, Prentice IC. (2018) Global Mapping of Potential Natural Vegetation: An Assessment of Machine Learning Algorithms for Estimating Land Potential. PeerJ Preprints.
    [10.7287/peerj.preprints.26811v1](https://doi.org/10.7910/DVN/QQHCIK)
  |||,
  'gee:terms_of_use': |||
    This is a human-readable summary of (and not a substitute for) the [license](https://creativecommons.org/licenses/by-sa/4.0/).

    You are free to -
      Share — copy and redistribute the material in any medium or format
      Adapt — remix, transform, and build upon the material for any purpose, even commercially.

    This license is acceptable for Free Cultural Works.
    The licensor cannot revoke these freedoms as long as you follow the license terms.

    Under the following terms -
      Attribution — You must give appropriate credit, provide a link to the license, and indicate if
      changes were made. You may do so in any reasonable manner, but not in any way that suggests the
      licensor endorses you or your use.

      ShareAlike — If you remix, transform, or build upon the material, you must distribute your
      contributions under the same license as the original.

      No additional restrictions — You may not apply legal terms or technological measures that
      legally restrict others from doing anything the license permits.
  |||,
  'gee:unusual_terms_of_use': true,
  'gee:user_uploaded': true,
}
