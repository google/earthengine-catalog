local id = 'JRC/LUCAS_HARMO/THLOC/V1';
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
  title: 'LUCAS Harmonized (Theoretical Location, 2006-2018) V1',
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

    The dataset presented here is the harmonized version of all yearly LUCAS
    surveys with a total of 106 attributes. Each point's location is using
    the fields 'th_lat' and 'th_lon', that is, the LUCAS theoretical location
    (THLOC), as prescribed by the LUCAS grid.  For more information please
    see Citations. Note that not every field is present for every year - see
    the \"Years\" section in property descriptions.

    The text \"C1 (Instructions)\" in the table schema descriptions refers to
    [this document](https://ec.europa.eu/eurostat/documents/205002/8072634/LUCAS2018-C1-Instructions.pdf).

    See also
    [the 2018 LUCAS polygons dataset](JRC_LUCAS_HARMO_COPERNICUS_POLYGONS_V1_2018).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://www.dropbox.com/s/6fist8jby0uwwgo/lucas_harmo_pack_uf_final_th_gee_noNAs_noQuo.csv',
    },
  ],
  keywords: [
    'EU',
    'JRC',
    'landcover',
    'landuse',
    'lucas'
  ],
  providers: [
    ee.producer_provider('Joint Research Center, Unit D5', 'https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/LUCAS/LUCAS_harmonised/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-13.359375, 34.307144, 34.804688, 71.187754,
                    '2006-02-05T00:00:00Z', '2019-03-14T00:00:00Z'),
  summaries: {
    'gee:schema': properties.schema + [{
      name: 'obs_radius',
      description: |||
        The radius of observation - whether the near or the extended window
        of observation is applied.

        Values:

        * 1.5
        * 20
        * null if not relevant

        Source: C1(Instructions)

        Years: 2006, 2009, 2012, 2015
      |||,
      type: ee_const.var_type.double,
      units: 'meters',
    }],
    'gee:visualizations': [
      {
        display_name: 'LUCAS Points',
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
        display_name: 'LUCAS Points',
        visualize_as: 'FeatureView',
        lookat: {
          lat: 37.0,
          lon: -6.0,
          zoom: 10,
        },
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 1500,
      thinning_strategy: 'HIGHER_DENSITY',
    },
  },
  'sci:citation': |||
    d'Andrimont, R., Yordanov, M., Martinez-Sanchez, L. et al. Harmonised LUCAS
    in-situ land cover and use database for field surveys from 2006 to 2018
    in the European Union. Sci Data 7, 352 (2020).
    [doi:10.1038/s41597-020-00675-z](https://doi.org/10.1038/s41597-020-00675-z)
  |||,
  'gee:terms_of_use': 'Licensed under the Creative Commons Attribution 4.0 International License.',
  'gee:user_uploaded': true,
}
