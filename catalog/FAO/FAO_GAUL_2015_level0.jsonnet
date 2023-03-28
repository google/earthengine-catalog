local id = 'FAO/GAUL/2015/level0';
local subdir = 'FAO';

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
  id: id,
  title: 'FAO GAUL: Global Administrative Unit Layers 2015, Country Boundaries',
  'gee:type': ee_const.gee_type.table,
  description: |||
    The Global Administrative Unit Layers (GAUL) compiles and disseminates the
    best available information on administrative units for all the countries in
    the world, providing a contribution to the standardization of the spatial
    dataset representing administrative units. The GAUL always maintains global
    layers with a unified coding system at country, first (e.g. departments),
    and second administrative levels (e.g. districts). Where data is available,
    it provides layers on a country by country basis down to third, fourth, and
    lowers levels. The overall methodology consists in a) collecting the best
    available data from most reliable sources, b) establishing validation
    periods of the geographic features (when possible), c) adding selected data
    to the global layer based on the last country boundaries map provided by
    the UN Cartographic Unit (UNCS), d) generating codes using GAUL Coding
    System, and e) distribute data to the users
    (see [Technical Aspects of the GAUL Distribution Set](https://data.apps.fao.org:/map/catalog/srv/api/records/9c35ba10-5649-41c8-bdfc-eb78e9e65654/attachments/GAUL2015_Documentation.zip).
    Note that some administrative units are multipolygon features.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
  ],
  keywords: [
    'borders',
    'countries',
    'fao',
    'gaul',
    'un',
  ],
  providers: [
    ee.producer_provider('FAO UN', 'https://www.fao.org/geonetwork/srv/en/metadata.show?id=12691'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2014-12-19T16:45:00Z', '2014-12-19T16:45:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'ADM0_CODE',
        description: 'GAUL country code',
        type: ee_const.var_type.int,
      },
      {
        name: 'ADM0_NAME',
        description: 'UN country name',
        type: ee_const.var_type.string,
      },
      {
        name: 'DISP_AREA',
        description: "Unsettled territory: 'Yes' or 'No'",
        type: ee_const.var_type.string,
      },
      {
        name: 'STATUS',
        description: 'Status of the country',
        type: ee_const.var_type.string,
      },
      {
        name: 'Shape_Area',
        description: 'Shape area',
        type: ee_const.var_type.double,
      },
      {
        name: 'Shape_Leng',
        description: 'Shape length',
        type: ee_const.var_type.double,
      },
      {
        name: 'EXP0_YEAR',
        description: 'Expiry year of the administrative unit',
        type: ee_const.var_type.int,
      },
      {
        name: 'STR0_YEAR',
        description: 'Creation year of the administrative unit',
        type: ee_const.var_type.int,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Country Boundaries',
        lookat: {
          lat: 49.1,
          lon: 7.82,
          zoom: 4,
        },
        polygon_visualization: {
          property_name: 'ADM0_CODE',
          property_vis: {
            min: [
              1.0,
            ],
            max: [
              250.0,
            ],
            palette: [
              '00FF97',
              'DDFF6B',
              'F0FF6B',
              'FFE96B',
              '7277FF',
              'FFFFB3',
              'DAFFFF',
              'B0FFFF',
              '72FFFF',
              'A9FF6B',
              '72D6FF',
              '00FF72',
            ],
          },
        },
      },
      {
        display_name: 'Country Boundaries',
        visualize_as: 'FeatureView',
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 250,
      thinning_strategy: 'HIGHER_DENSITY',
      thinning_ranking: ['Shape_Area DESC'],
    },
  },
  'gee:terms_of_use': |||
    The GAUL dataset is distributed to the United Nations and other authorized
    international and national institutions/agencies. FAO grants a license to
    use, download and print the materials contained in the GAUL dataset solely
    for non-commercial purposes and in accordance with the conditions specified
    in the data license.
    [The full GAUL Data License document](https://developers.google.com/earth-engine/datasets/catalog/DataLicenseGAUL2015.pdf)
    is available for downloading. See also
    [the disclaimer](https://developers.google.com/earth-engine/datasets/catalog/DisclaimerGAUL2015.pdf).
  |||,
  'gee:unusual_terms_of_use': true,
}
