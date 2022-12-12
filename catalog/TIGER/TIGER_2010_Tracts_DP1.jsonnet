local id = 'TIGER/2010/Tracts_DP1';
local subdir = 'TIGER';

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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'TIGER: US Census Tracts Demographic - Profile 1',
  version: '2010',
  'gee:type': ee_const.gee_type.table,
  description: |||
    The United States Census Bureau regularly releases
    a geodatabase named TIGER. This table contains the 2010 census
    Demographic Profile 1 values aggregated by census tract. Tract
    areas vary tremendously, but in urban areas are roughly equivalent
    to a neighborhood. There are about 74,000 polygon features covering
    the United States, the District of Columbia, Puerto Rico, and
    the [Island areas](https://www.census.gov/data/tables/2010/dec/2010-island-areas.html).

    For full technical details on all TIGER 2010 products, see
    the [TIGER technical documentation](https://www2.census.gov/geo/pdfs/maps-data/data/tiger/tgrshp2010/TGRSHP10SF1.pdf).

    Each tract also includes attributes with sums of the DP1
    population measurements that intersect the boundary. The columns
    have the same name as the shortname column in the [DP1 lookup
    table](https://developers.google.com/earth-engine/tiger_2010_tract_dp1_metadata).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'census',
    'demographic',
    'human',
    'social',
    'tiger',
    'us',
  ],
  providers: [
    ee.producer_provider('United States Census Bureau', 'https://www.census.gov/programs-surveys/geography/guidance/tiger-data-products-guide.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -14.69, -64.435, 71.567,
                    '2010-01-01T00:00:00Z', '2010-01-02T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'aland10',
        description: 'Land area',
        type: ee_const.var_type.double,
        units: 'm^2',
      },
      {
        name: 'awater10',
        description: 'Water area',
        type: ee_const.var_type.double,
        units: 'm^2',
      },
      {
        name: 'geoid10',
        description: 'Census tract identifier: a concatenation of state FIPS code, county FIPS code, and census tract code',
        type: ee_const.var_type.string,
      },
      {
        name: 'intptlat10',
        description: 'Latitude of the internal point',
        type: ee_const.var_type.string,
      },
      {
        name: 'intptlon10',
        description: 'Longitude of the internal point',
        type: ee_const.var_type.string,
      },
      {
        name: 'namelsad10',
        description: 'Legal/statistical area description and the census tract name',
        type: ee_const.var_type.string,
      },
      {
        name: 'shape_area',
        description: 'Area in square degrees',
        type: ee_const.var_type.double,
      },
      {
        name: 'shape_leng',
        description: 'Perimeter in degrees',
        type: ee_const.var_type.double,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Tract Area',
        lookat: {
          lat: 40.74101,
          lon: -73.99172,
          zoom: 11,
        },
        polygon_visualization: {
          property_name: 'shape_area',
          property_vis: {
            min: [
              0.0,
            ],
            max: [
              53.0,
            ],
            gamma: [
              7.0,
            ],
          },
        },
      },
      {
        display_name: 'Tract Area',
        visualize_as: 'FeatureView',
        lookat: {
          lat: 40.74101,
          lon: -73.99172,
          zoom: 11,
        },
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 16000,
      thinning_strategy: 'HIGHER_DENSITY',
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
    made available to you through the API are subject to [these terms and
    conditions](https://www.census.gov/data/developers/about/terms-of-service.html).
  |||,
}
