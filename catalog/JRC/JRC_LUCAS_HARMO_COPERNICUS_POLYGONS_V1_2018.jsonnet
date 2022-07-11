local id = 'JRC/LUCAS_HARMO/COPERNICUS_POLYGONS/V1/2018';
local subdir = 'JRC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local properties = import 'LUCAS_properties.libsonnet';
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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'LUCAS Copernicus (Polygons with attributes, 2018) V1',
  version: 'V1',
  'gee:type': ee_const.gee_type.table,
  description: |||
    The
    [Land Use/Cover Area frame Survey (LUCAS)](https://ec.europa.eu/eurostat/web/lucas)
    in the European Union (EU) was set up to provide statistical information.
    It represents a triennial in-situ landcover and land-use data-collection
    exercise that extends over the whole of the EU's territory.  LUCAS collects
    information on land cover and land use, agro-environmental variables, soil,
    and grassland. The surveys also provide spatial information to analyse the
    mutual influences between agriculture, environment, and countryside, such as
    irrigation and land management.

    The dataset presented here is the LUCAS Copernicus module. It was set set up
    in 2018 to provide Earth Observation relevant data for the first time in
    LUCAS history. The dataset consist of 63,287 polygons of various sizes and
    shapes with consistent land cover, making the ideal tool for polygon-based
    extraction from remote sensing data. The harmonization process has improved
    the land cover legend to LUCAS Level-3, and has joined, wherever deemed
    appropriate, the attribute data from the 2018 LUCAS survey, augmenting the
    possibilities for data extraction to the fullest potential of the LUCAS
    collected variables.

    The text "C1 (Instructions)" in the table schema descriptions refers to
    [this document](https://ec.europa.eu/eurostat/documents/205002/8072634/LUCAS2018-C1-Instructions.pdf).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: 'source',
      href: 'https://www.dropbox.com/s/f467ffmvh6nl5au/l2018_poly_attr_geomCC.csv?dl=0',
    },
  ],
  keywords: [
    'copernicus',
    'EU',
    'JRC',
    'landcover',
    'landuse',
  ],
  providers: [
    ee.producer_provider(
        'Joint Research Center, Unit D5',
        'https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/LUCAS/LUCAS_2018_Copernicus/'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-13.359375, 34.307144, 34.804688, 71.187754,
                    '2006-02-05T00:00:00Z', '2019-03-14T00:00:00Z'),
  summaries: {
    'gee:schema': properties.schema + [
      {
        name: 'copernicus_cleaned',
        description: |||
          Whether 'cprn_lc_same_lc1' and 'lucas_core_intersect' are both TRUE.

          Values:

          * TRUE
          * FALSE

          Source: Added by harmonization process

        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'cprn_lc_same_lc1',
        description: |||
          Whether the reported Copernicus level-2 land cover observed is the same as the one reported for the LUCAS theoretical point.

          Values:

          * TRUE
          * FALSE

          Source: Added by harmonization process

        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lucas_core_intersect',
        description: |||
          Whether the LUCAS theoretical point location falls within the LUCAS polygon.

          Values:

          * TRUE
          * FALSE

          Source: Added by harmonization process

        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'th_lat',
        description: |||
          Theoretical point latitude.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'th_lon',
        description: |||
          Theoretical point latitude.
        |||,
        type: ee_const.var_type.double,
      }
    ],
    'gee:visualizations': [
      {
        display_name: 'LUCAS Polygons',
        lookat: {
          lat: 37.0,
          lon: -6.0,
          zoom: 10,
        },
        table_visualization: {
          color: '489734',
          point_size: 3,
        },
      },
      {
        display_name: 'LUCAS Polygons',
        visualize_as: 'FeatureView',
        lookat: {
          lat: 37.0,
          lon: -6.0,
          zoom: 10,
        },
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 150,
      thinning_strategy: 'HIGHER_DENSITY',
    },
  },
  'sci:citation': |||
    d'Andrimont, R., Verhegghen, A., Meroni, M., Lemoine, G., Strobl, P.,
    Eiselt, B., Yordanov, M., Martinez-Sanchez, L. and van der Velde, M., 2020.
    LUCAS Copernicus 2018: Earth Observation relevant in-situ data on land cover
    throughout the European Union. Earth System Science Data Discussions, 2020,
    pp.1-19.
    [doi:10.5194/essd-13-1119-2021](https://doi.org/10.5194/essd-13-1119-2021)
  |||,
  'gee:terms_of_use': |||
    Licensed under the Creative Commons Attribution 4.0 International License.
  |||,
  'gee:user_uploaded': true,
}
