local id = 'iNaturalist/MULTI_SPECIES/LATEST';
local subdir = 'iNaturalist';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_ver,
  ],
  id: id,
  title: 'INaturalist Multispecies Open Range Maps',
  version: '2.23',
  'gee:type': ee_const.gee_type.bigquery_table,
  'gee:bq_table_name': 'earth-engine-public-data.inaturalist_open_range_map.multispecies_latest',
  description: |||
    The iNaturalist Multispecies Range Dataset provides modeled geographic
    ranges for thousands of species. Dataset contains species polygons, with
    attributes such as taxon_id, name, scientific_name, and geomodel_version.
    Ranges are estimated from iNaturalist community observations and updated on
    a monthly basis. These datasets enable large-scale biodiversity analyses,
    ecological modeling, and integration with other spatial data.
    This dataset contains the latest available range maps for multiple species
    from iNaturalist. The dataset is available through BigQuery.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://www.inaturalist.org/pages/range_maps',
    },
  ],
  'gee:categories': ['ecosystems'],
  keywords: [
    'bigquery',
    'biodiversity',
    'range',
    'species'
  ],
  providers: [
    ee.producer_provider('iNaturalist', 'https://www.inaturalist.org'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2025-02-25T00:00:00Z', '2025-03-25T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'taxon_id',
        description: 'Unique identifier for a species in iNaturalist',
        type: ee_const.var_type.string,
      },
      {
        name: 'parent_taxon_id',
        description: |||
          Identifier for the immediate higher-level taxon
          (e.g., genus or family), giving taxonomic context.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'name',
        description: 'The scientific name of the species.',
        type: ee_const.var_type.string,
      },
      {
        name: 'rank',
        description: |||
          Taxonomic rank of the taxon (e.g., species, genus, family, order).
          Useful for filtering or grouping taxa by level.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'iconic_taxon_id',
        description: |||
          Internal identifier for one of iNaturalist's "iconic taxa" - broad,
          recognizable groups such as Mammalia, Aves, Reptilia, Plantae.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'iconic_taxon_name',
        description: |||
          The iconic taxon name of the species (e.g., Mammalia, Aves).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'geomodel_version',
        description: 'The version of the geomodel used.',
        type: ee_const.var_type.string,
      },
      {
        name: 'geometry',
        description: |||
          Polygon or multipolygon in WGS84 (EPSG:4326) representing the
          modeled distribution.
        |||,
        type: ee_const.var_type.geometry,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'iNaturalist Multispecies Latest',
        lookat: {
          lat: 0,
          lon: 25,
          zoom: 3,
        },
        polygon_visualization: {
          property_name: 'name',
          property_vis: {
            palette: ['E4004B', 'ED775A', 'FAD691', 'C9CDCF'],
          },
        },
      },
    ],
  },
  'gee:skip_featureview_generation': true,
  'gee:status': 'beta',
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
