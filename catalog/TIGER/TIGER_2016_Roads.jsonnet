local id = 'TIGER/2016/Roads';
local subdir = 'TIGER';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'TIGER: US Census Roads',
  version: '2016',
  'gee:type': ee_const.gee_type.table,
  description: |||
    This United States Census Bureau TIGER dataset contains all road segments
    from the 2016 release, containing more than 19 million individual
    line features covering the United States, the District of Columbia,
    Puerto Rico, and the [Island Areas](https://www.census.gov/newsroom/releases/archives/2010_census/press-kits/island-areas.html).
    Each feature represents a road segment geometry (a single navigable
    linear path connected to at least one intersection).

    For full technical details on all TIGER 2016 products, see the [TIGER
    technical documentation](https://www2.census.gov/geo/pdfs/maps-data/data/tiger/tgrshp2016/TGRSHP2016_TechDoc.pdf).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, basename + '_FeatureView'),
    {
      rel: ee_const.rel.source,
      href: 'ftp://ftp2.census.gov/geo/tiger/TIGER2016/ROADS/',
    },
  ],
  keywords: [
    'census',
    'roads',
    'tiger',
    'us',
  ],
  providers: [
    ee.producer_provider('United States Census Bureau', 'https://www.census.gov/programs-surveys/geography/guidance/tiger-data-products-guide.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -14.69, -64.435, 71.567,
                    '2016-01-01T00:00:00Z', '2017-01-02T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'fullname',
        description: 'A human-readable road name',
        type: ee_const.var_type.string,
      },
      {
        name: 'linearid',
        description: 'The primary identifier used to refer to this row in other TIGER products',
        type: ee_const.var_type.string,
      },
      {
        name: 'mtfcc',
        description: |||
          The road [priority code](https://www.census.gov/library/reference/code-lists/mt-feature-class-codes.html),
          representing, e.g., primary, second, local, etc.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'rttyp',
        description: 'The route [type code](https://www.census.gov/library/reference/code-lists/route-type-codes.html),',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Roads',
        lookat: {
          lat: 40.74101,
          lon: -73.99172,
          zoom: 12,
        },
        table_visualization: {
          color: 'B2B2B3',
          width: 1.0,
        },
      },
      {
        display_name: 'Roads',
        visualize_as: 'FeatureView',
        lookat: {
          lat: 40.74101,
          lon: -73.99172,
          zoom: 12,
        },
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 16000,
      thinning_strategy: 'GLOBALLY_CONSISTENT',
      thinning_ranking: ['rttyp ASC'],
      z_order_ranking: ['rttyp ASC'],
      prerender_tiles: true,
    },
  },
  'sci:citation': |||
    For the creation of any reports, publications, new data sets, derived
    products, or services resulting from the data set, users should
    [cite the US Census Bureau](https://www.census.gov/about/policies/citation.html).
  |||,
  'gee:terms_of_use': |||
    The U.S. Census Bureau offers some of its public data
    in machine-readable format via an Application Programming Interface
    (API). All of the content, documentation, code and related materials
    made available through the API are subject to [these terms and
    conditions](https://www.census.gov/data/developers/about/terms-of-service.html).
  |||,
}
