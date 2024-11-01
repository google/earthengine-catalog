local id = 'UN/Geodata/BNDA_simplified/current';
local subdir = 'UN';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local license = spdx.proprietary_non_commercial;

local version = '20230210';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_ver,
  ],
  id: id,
  title: 'United Nations Geospatial Data: BNDA_simplified',
  version: version,
  'gee:type': ee_const.gee_type.table,
  description: |||
      The United Nations Geospatial Data, or Geodata, is a worldwide geospatial
      dataset of the United Nations.

      The United Nations Geodata is provided to facilitate the preparation of
      cartographic materials in the United Nations includes geometry, attributes
      and labels to facilitate the adequate depiction and naming of geographic
      features for the preparation of maps in accordance with United Nations
      policies and practices.

      The geospatial dataset include polygons/areas of countries
      (BNDA_simplified). Please refer this [page](https://geoportal.un.org/arcgis/home/item.html?id=e4ee80edac9d4e08b8303522dd4a5fc1)
      for more information.
    |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
  ],
  keywords: [
    'borders',
    'countries',
  ],
  providers: [
    ee.producer_provider(
      'United Nations Geospatial',
      'https://geoportal.un.org/arcgis/home/user.html?user=United_Nations_Geospatial'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2023-02-11T00:00:00Z', '2023-02-12T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'admiso',
        description: 'ISO-3166 alpha-3 code of the area\'s administrator.',
        type: ee_const.var_type.string,
      },
      {
        name: 'geo_cd',
        description: 'UN M49 geographical region code',
        type: ee_const.var_type.int,
      },
      {
        name: 'georeg',
        description: 'UN M49 geographic region',
        type: ee_const.var_type.string,
      },
      {
        name: 'globalid',
        description: 'GlobalID',
        type: ee_const.var_type.string,
      },
      {
        name: 'globalid_1',
        description: 'GlobalID_1',
        type: ee_const.var_type.string,
      },
      {
        name: 'int_cd',
        description: 'UN M49 intermediary region code; 0 if unset',
        type: ee_const.var_type.string,
      },
      {
        name: 'intreg',
        description: 'UN M49 intermediary region; empty if "int_cd" is 0',
        type: ee_const.var_type.string,
      },
      {
        name: 'iso2cd',
        description: 'ISO-3166 alpha-2 code',
        type: ee_const.var_type.string,
      },
      {
        name: 'iso3cd',
        description: 'ISO-3166 alpha-3 code',
        type: ee_const.var_type.string,
      },
      {
        name: 'lbl_en',
        description: 'Cartographic label (English)',
        type: ee_const.var_type.string,
      },
      {
        name: 'lbl_fr',
        description: 'Cartographic label (French)',
        type: ee_const.var_type.string,
      },
      {
        name: 'm49_cd',
        description: 'UN M49 country or area code',
        type: ee_const.var_type.string,
      },
      {
        name: 'nam_en',
        description: 'Name (English)',
        type: ee_const.var_type.string,
      },
      {
        name: 'name_fr',
        description: 'Name (French)',
        type: ee_const.var_type.string,
      },
      {
        name: 'objectid',
        description: 'Internal object ID number',
        type: ee_const.var_type.string,
      },
      {
        name: 'st_area_sh',
        description: 'Total area of the geometry',
        type: ee_const.var_type.double,
      },
      {
        name: 'stscod',
        description: |||
          Sovereignty status code:

          * 0: Antarctica
          * 1: State
          * 2: Occupied Palestinian Territory
          * 3: Non-Self Governing Territory
          * 4: Territory
          * 5: Special Region or Province
          * 99: Undetermined
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'sub_cd',
        description: 'UN M49 sub-region code',
        type: ee_const.var_type.int,
      },
      {
        name: 'subreg',
        description: 'UN M49 sub-region',
        type: ee_const.var_type.string,
      }
  ],
    'gee:visualizations': [
      {
        display_name: 'BNDA simplified',
        table_visualization: {
        color: 'black',
        point_size: 1,
      },
      lookat: {
        lon: -100, lat: 38.5, zoom: 4},
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 250,
      thinning_strategy: 'HIGHER_DENSITY',
      thinning_ranking: ['st_area_sh DESC'],
    },
  },
  'gee:unusual_terms_of_use': true,
  'gee:terms_of_use': |||
    The UN Geodata is a global geospatial database available for use by the UN
    Secretariat and external users. It can be used for various purposes, but
    commercial use is prohibited. The UN retains ownership of the data, and
    users must credit the UN as the source in their creations. The data is
    provided "as is" without warranties, and the UN is not liable for any
    damages or losses arising from its use. Please refer this
    [page](https://drive.google.com/file/d/1ADChwVCVwgaNwIo9OTMwATp9b21iOpI3/view?resourcekey=0-8loAZp_t-wTzafeASPXy4g)
    for more information.

    Note:
    Users of the Data that are not subject to the administrative instruction
    ("Outside Users") may only use the Data for the purpose for which the Data
    is suitable, as identified by the Geospatial Information Section upon
    transmission of or granting access to the Data. Intellectual property over
    the Data shall at all times vest with the United Nations. Intellectual
    property over the products created using the Data shall vest with the
    Outside User. The United Nations shall be recognized as the source of the
    Data in any products created by Outside Users using the Data, unless the
    Outside Users alter the Data or combine the Data with other data sets. In
    case of doubt regarding crediting the United Nations as the Data source,
    please contact: geospatial@un.org. Outside Users acknowledge that any right
    to access and use the Data is revocable and non-transferable. Under no
    circumstances may the Data be used for commercial purposes.
  |||,
}
