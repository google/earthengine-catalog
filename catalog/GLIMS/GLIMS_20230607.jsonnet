local versions = import 'versions.libsonnet';
local version_table = import 'templates/glims_versions.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local configs = import 'GLIMS_versions.libsonnet';
local subdir = 'GLIMS';

local license = spdx.proprietary;

local version = '20230607';
local config = configs[version];
local version_config = versions(subdir, version_table, config.id);

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: config.id,
  basename:: std.strReplace(config.id, '/', '_'),

  title: 'GLIMS 2023: Global Land Ice Measurements From Space',
  version: version,
  'gee:type': ee_const.gee_type.table,
  description: |||
    Global Land Ice Measurements from Space (GLIMS) is
    an international initiative with the goal of repeatedly surveying
    the world's estimated 200,000 glaciers.

    The project seeks
    to create a globally comprehensive inventory of land ice, including
    measurements of glacier area, geometry, surface velocity, and
    snow line elevation. To perform these analyses, the GLIMS project
    uses satellite data, primarily from the Advanced Spaceborne Thermal
    Emission and Reflection Radiometer (ASTER) and the Landsat Enhanced
    Thematic Mapper Plus (ETM+), as well as historical information
    derived from maps and aerial photographs.

    Each feature in this dataset is a polygonal boundary of a glacier at the
    time of analysis.  A few glacier IDs have hundreds of distinct rows over
    time.

    This dataset is a snapshot of the inventory of glacier boundaries as of
    June 7, 2023, providing over 1,100,000 rows.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, config.id) + [
    ee.link.example(config.id, subdir, self.basename + '_FeatureView'),
    {
      rel: ee_const.rel.source,
      href: 'https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0272_GLIMS_v1/',
    },
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7265/N5V98602',
    },
  ] + version_config.version_links,
  keywords: [
    'glacier',
    'glims',
    'ice',
    'landcover',
    'nasa',
    'nsidc',
    'snow',
  ],
  providers: [
    ee.producer_provider('National Snow and Ice Data Center (NSDIC)', 'https://www.glims.org'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('1750-01-01T00:00:00Z', '2023-06-07T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'analysts',
        description: 'Name(s) of data contributor(s)',
        type: ee_const.var_type.string,
      },
      {
        name: 'anlys_id',
        description: 'ID of a glacier at a particular time',
        type: ee_const.var_type.double,
      },
      {
        name: 'anlys_time',
        description: 'When the analysis was done',
        type: ee_const.var_type.string,
      },
      {
        name: 'area',
        description: 'Area of the glacier in the plane of the map\nprojection in square kilometers',
        type: ee_const.var_type.double,
      },
      {
        name: 'chief_affl',
        description: 'Affiliation of the chief of the regional center',
        type: ee_const.var_type.string,
      },
      {
        name: 'db_area',
        description: "Same as 'area', but recomputed by the GLIMS project",
        type: ee_const.var_type.double,
      },
      {
        name: 'geog_area',
        description: 'Name of geographic region covered by the regional center',
        type: ee_const.var_type.string,
      },
      {
        name: 'glac_id',
        description: 'The GLIMS glacier ID',
        type: ee_const.var_type.string,
      },
      {
        name: 'glac_name',
        description: "The glacier name. ~80% of the rows equal 'None'",
        type: ee_const.var_type.string,
      },
      {
        name: 'glac_stat',
        description: "Glacier status, either 'exists' or 'None'",
        type: ee_const.var_type.string,
      },
      {
        name: 'length',
        description: 'Length of the glacier perimeter in meters',
        type: ee_const.var_type.double,
      },
      {
        name: 'line_type',
        description: |||
          Glacier record type, e.g. 'glac_bound' for glaciers,
          or other values for internal rocks, snowlines, water features,
          etc.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'local_id',
        description: 'ID assigned by the contributing institution or regional center',
        type: ee_const.var_type.string,
      },
      {
        name: 'max_elev',
        description: 'Highest part of the glacier, in meters above sea level',
        type: ee_const.var_type.double,
      },
      {
        name: 'mean_elev',
        description: 'Mean elevation of the glacier, in meters above sea level',
        type: ee_const.var_type.double,
      },
      {
        name: 'min_elev',
        description: 'Lowest part of the glacier, in meters above sea level',
        type: ee_const.var_type.double,
      },
      {
        name: 'parent_id',
        description: 'ID of the glacier that is the parent of this glacier',
        type: ee_const.var_type.string,
      },
      {
        name: 'primeclass',
        description: 'WGMS glacier classification number',
        type: ee_const.var_type.double,
      },
      {
        name: 'proc_desc',
        description: 'Description of processing done on this record',
        type: ee_const.var_type.string,
      },
      {
        name: 'rc_id',
        description: 'ID used by the regional center',
        type: ee_const.var_type.double,
      },
      {
        name: 'rec_status',
        description: 'Record status',
        type: ee_const.var_type.string,
      },
      {
        name: 'release_dt',
        description: 'Date data was released, in YYYY-MM-ddTHH:mm:ss format',
        type: ee_const.var_type.string,
      },
      {
        name: 'src_date',
        description: 'Date of source imagery used to create the outline',
        type: ee_const.var_type.string,
      },
      {
        name: 'subm_id',
        description: 'The submission ID assigned by GLIMS',
        type: ee_const.var_type.double,
      },
      {
        name: 'submitters',
        description: 'Name(s) of data submitter(s)',
        type: ee_const.var_type.string,
      },
      {
        name: 'wgms_id',
        description: 'World Glacier Monitoring Service ID',
        type: ee_const.var_type.string,
      },
      {
        name: 'width',
        description: 'Width of the glacier in meters',
        type: ee_const.var_type.double,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Glacier Area',
        lookat: {
          lat: 73.214,
          lon: -26.763,
          zoom: 6,
        },
        polygon_visualization: {
          property_name: 'area',
          property_vis: {
            min: [
              0.0,
            ],
            max: [
              10.0,
            ],
            palette: [
              'gray',
              'cyan',
              'blue',
            ],
          },
        },
      },
      {
        display_name: 'Glacier Area',
        visualize_as: 'FeatureView',
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 12000,
      thinning_strategy: 'HIGHER_DENSITY',
      thinning_ranking: ['area DESC'],
      z_order_ranking: ['area DESC'],
      prerender_tiles: true,
    },
  },
  'sci:doi': '10.7265/N5V98602',
  'gee:terms_of_use': |||
    For the creation of any reports, publications, new
    data sets, derived products, or services resulting from the data
    set, users should cite: GLIMS and NSIDC (2005, updated 2013): Global
    Land Ice Measurements from Space glacier database.  Compiled and
    made available by the international GLIMS community and the National
    Snow and Ice Data Center, Boulder CO, U.S.A.,
    [doi:10.7265/N5V98602](https://doi.org/10.7265/N5V98602)
  |||,
}
