local id = 'TALLO/TALLO_V1';
local subdir = 'TALLO';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Tallo: A Global Tree Allometry and Crown Architecture Database V1',
  version: '1.0.0',
  'gee:type': ee_const.gee_type.bigquery_table,
  'gee:bq_table_name': 'earth-engine-public-data.tallo.tallo_v1',
  description: |||
    The Tallo database is a global collection of 498,838 georeferenced and
    taxonomically standardized individual-tree records compiled across 61,856
    sampling sites globally. Spanning 5,163 tree species, 1,453 genera, and 187
    plant families, Tallo provides individual-tree measurements of stem
    diameter (DBH), total tree height, and mean crown radius across all major
    terrestrial biomes.

    The database was created to support research in forest ecology, remote
    sensing, and global vegetation carbon modeling. It is described in detail in
    [Jucker et al. (2022)](https://doi.org/10.1111/gcb.16302).

    This dataset is available through BigQuery at
    `earth-engine-public-data.tallo.tallo_v1`.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://doi.org/10.5281/zenodo.6637599',
    },
  ],
  'gee:categories': ['forest-biomass', 'ecosystems'],
  keywords: [
    'bigquery',
    'biodiversity',
    'biomass',
    'canopy',
    'forest',
    'height',
    'species',
  ],
  providers: [
    ee.producer_provider('Tommaso Jucker / Selva Lab (University of Bristol)', 'https://github.com/selva-lab-repo/TALLO'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2022-06-08T00:00:00Z', '2022-06-09T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'tree_id',
        description: 'Unique identifier for each individual tree record in the Tallo database',
        type: ee_const.var_type.string,
      },
      {
        name: 'division',
        description: 'Major taxonomic division (Angiosperm or Gymnosperm)',
        type: ee_const.var_type.string,
      },
      {
        name: 'family',
        description: 'Taxonomic family of the tree (e.g. Rubiaceae, Pinaceae, Fabaceae)',
        type: ee_const.var_type.string,
      },
      {
        name: 'genus',
        description: 'Taxonomic genus of the tree (e.g. Coprosma, Pinus, Quercus)',
        type: ee_const.var_type.string,
      },
      {
        name: 'species',
        description: 'Binomial scientific name of the tree species (e.g. Coprosma ochracea)',
        type: ee_const.var_type.string,
      },
      {
        name: 'latitude',
        description: 'Latitude of the sampling location in decimal degrees (WGS84)',
        type: ee_const.var_type.double,
      },
      {
        name: 'longitude',
        description: 'Longitude of the sampling location in decimal degrees (WGS84)',
        type: ee_const.var_type.double,
      },
      {
        name: 'geo_point',
        description: 'Geographic point geometry (WGS84)',
        type: ee_const.var_type.geometry,
      },
      {
        name: 'stem_diameter_cm',
        description: 'Stem diameter at breast height (DBH) in centimeters',
        type: ee_const.var_type.double,
        units: units.centimeter,
      },
      {
        name: 'height_m',
        description: 'Total tree height in meters',
        type: ee_const.var_type.double,
        units: units.meter,
      },
      {
        name: 'crown_radius_m',
        description: 'Mean crown radius of the tree in meters',
        type: ee_const.var_type.double,
        units: units.meter,
      },
      {
        name: 'height_outlier',
        description: "Outlier flag for tree height measurement (Y = outlier, N = valid)",
        type: ee_const.var_type.string,
      },
      {
        name: 'crown_radius_outlier',
        description: "Outlier flag for crown radius measurement (Y = outlier, N = valid)",
        type: ee_const.var_type.string,
      },
      {
        name: 'reference_id',
        description: 'Numerical identifier linking record to contributing data source citation',
        type: ee_const.var_type.int,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Tallo Tree Sampling Locations',
        lookat: {
          lat: 38.0,
          lon: -100.5,
          zoom: 4,
        },
        table_visualization: {
          color: '228b22',
          point_size: 2,
        },
      },
    ],
  },
  'sci:doi': '10.1111/gcb.16302',
  'sci:citation': |||
    Jucker, T., Fischer, F. J., Chave, J., Coomes, D. A., Caspersen, J., Ali, A.,
    ... & Zavala, M. A. (2022). Tallo: A global tree allometry and crown
    architecture database. Global Change Biology, 28(17), 5254-5268.
    [doi:10.1111/gcb.16302](https://doi.org/10.1111/gcb.16302)
  |||,
  'sci:publications': [
    {
      citation: |||
        Jucker, T., Fischer, F. J., Chave, J., Coomes, D. A., Caspersen, J., Ali, A.,
        ... & Zavala, M. A. (2022). Tallo: a global tree allometry and crown
        architecture database (Version 1.0.0) [Data set]. Zenodo.
        [doi:10.5281/zenodo.6637599](https://doi.org/10.5281/zenodo.6637599)
      |||,
      doi: '10.5281/zenodo.6637599',
    },
  ],
  'gee:skip_featureview_generation': true,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
