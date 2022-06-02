local id = 'WRI/GPPD/power_plants';
local subdir = 'WRI';

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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Global Power Plant Database',
  version: '1.1.0',
  'gee:type': ee_const.gee_type.table,
  description: |||
    The Global Power Plant Database is a comprehensive, open source
    database of power plants around the world. It centralizes
    power plant data to make it easier to navigate, compare and draw
    insights. Each power plant is geolocated and entries contain
    information on plant capacity, generation, ownership, and fuel type.
    As of June 2018, the database includes around 28,500 power plants
    from 164 countries.
    It will be continuously updated as data becomes available.

    The methodology for the dataset creation is given in the World Resources
    Institute publication
    ["A Global Database of Power Plants"](https://www.wri.org/publication/global-power-plant-database).

    Associated code for the creation of the dataset can be found on
    [GitHub](https://github.com/wri/global-power-plant-database).
    The bleeding-edge version of the database (which may contain substantial
    differences from the release in Earth Engine) is available on GitHub as well.

    If you use this dataset, the provider (WRI) has requested that you
    [register your use](https://goo.gl/ivTvkd) and (optionally)
    sign up to receive update notifications.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'climate',
    'energy',
    'infrastructure',
    'power',
    'power_plants',
    'wri',
  ],
  providers: [
    ee.producer_provider('World Resources Institute', 'https://datasets.wri.org/dataset/globalpowerplantdatabase'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2018-06-11T00:00:00Z', '2018-06-11T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'country',
        description: '3-character country code corresponding to the ISO 3166-1 alpha-3 specs',
        type: ee_const.var_type.string,
      },
      {
        name: 'country_lg',
        description: 'Longer form of the country designation',
        type: ee_const.var_type.string,
      },
      {
        name: 'name',
        description: 'Name or title of the power plant, generally in Romanized form',
        type: ee_const.var_type.string,
      },
      {
        name: 'gppd_idnr',
        description: '10- or 12-character identifier for the power plant',
        type: ee_const.var_type.string,
      },
      {
        name: 'capacitymw',
        description: 'Electrical generating capacity in megawatts',
        type: ee_const.var_type.double,
      },
      {
        name: 'latitude',
        description: 'Geolocation in decimal degrees',
        type: ee_const.var_type.double,
      },
      {
        name: 'longitude',
        description: 'Geolocation in decimal degrees',
        type: ee_const.var_type.double,
      },
      {
        name: 'fuel1',
        description: 'Energy source used in electricity generation or export',
        type: ee_const.var_type.string,
      },
      {
        name: 'fuel2',
        description: 'Energy source used in electricity generation or export',
        type: ee_const.var_type.string,
      },
      {
        name: 'fuel3',
        description: 'Energy source used in electricity generation or export',
        type: ee_const.var_type.string,
      },
      {
        name: 'fuel4',
        description: 'Energy source used in electricity generation or export',
        type: ee_const.var_type.string,
      },
      {
        name: 'comm_year',
        description: 'Year of plant operation, weighted by unit-capacity when data is available',
        type: ee_const.var_type.string,
      },
      {
        name: 'owner',
        description: 'Majority shareholder of the power plant, generally in Romanized form',
        type: ee_const.var_type.string,
      },
      {
        name: 'source',
        description: 'Entity reporting the data; could be an organization, report, or document,\ngenerally in Romanized form',
        type: ee_const.var_type.string,
      },
      {
        name: 'url',
        description: 'Web document corresponding to the "source" field',
        type: ee_const.var_type.string,
      },
      {
        name: 'src_latlon',
        description: 'Attribution for geolocation information',
        type: ee_const.var_type.string,
      },
      {
        name: 'cap_year',
        description: 'Year the capacity information was reported',
        type: ee_const.var_type.double,
      },
      {
        name: 'gwh_2013',
        description: 'Electricity generation in gigawatt-hours reported for the year 2013',
        type: ee_const.var_type.double,
      },
      {
        name: 'gwh_2014',
        description: 'Electricity generation in gigawatt-hours reported for the year 2014',
        type: ee_const.var_type.double,
      },
      {
        name: 'gwh_2015',
        description: 'Electricity generation in gigawatt-hours reported for the year 2015',
        type: ee_const.var_type.double,
      },
      {
        name: 'gwh_2016',
        description: 'Electricity generation in gigawatt-hours reported for the year 2016',
        type: ee_const.var_type.double,
      },
      {
        name: 'gwh_estimt',
        description: 'Estimated annual electricity generation in gigawatt-hours for the year\n2015',
        type: ee_const.var_type.double,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Power Plant capacity',
        polygon_visualization: {
          property_name: 'capacitymw',
          property_vis: {
            min: [
              0.0,
            ],
            max: [
              10.0,
            ],
          },
        },
      },
      {
        display_name: 'Power Plant capacity',
        visualize_as: 'FeatureView',
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 10000,
      thinning_strategy: 'HIGHER_DENSITY',
      thinning_ranking: 'capacitymw DESC',
      z_order_ranking: 'capacitymw DESC',
      prerender_tiles: true,
    },
  },
  'sci:citation': |||
    Global Energy Observatory, Google, KTH Royal Institute of Technology in
    Stockholm, University of Groningen, World Resources Institute. 2018. Global
    Power Plant Database. Published on Resource Watch and Google Earth Engine;
    [https://resourcewatch.org/](https://resourcewatch.org/)
    [https://earthengine.google.com/](https://earthengine.google.com/)
  |||,
  'gee:terms_of_use': 'This dataset is licensed under\n[CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/).',
}
