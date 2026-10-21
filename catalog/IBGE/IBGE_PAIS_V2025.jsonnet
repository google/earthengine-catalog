local id = 'IBGE/PAIS/V2025';
local subdir = 'IBGE';

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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'IBGE: Brazil Country Boundary 2025',
  version: '2025',
  'gee:type': ee_const.gee_type.table,
  description: |||
    The Instituto Brasileiro de Geografia e Estat&iacute;stica (IBGE) provides official
    cartographic representations of the Brazilian territorial structure. This
    dataset represents the official national country boundary of the Federative
    Republic of Brazil for the reference year 2025 (Malha Territorial 2025).

    The dataset includes the whole territory of Brazil along with the official
    calculated land area.

    For more information on the methodology and technical specifications, visit
    the [IBGE Municipal Mesh Documentation](https://www.ibge.gov.br/en/geosciences/territorial-organization/territorial-meshes/2786-np-municipal-mesh/18890-municipal-mesh.html).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
    {
      rel: ee_const.rel.source,
      href: 'https://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2025/Brasil/BR_Pais_2025.zip',
    },
  ],
  'gee:categories': ['infrastructure-boundaries'],
  keywords: [
    'borders',
    'boundaries',
    'brazil',
    'countries',
    'ibge',
  ],
  providers: [
    ee.producer_provider('IBGE', 'https://www.ibge.gov.br/en/home-eng.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-73.99,
                    -33.75,
                    -28.85,
                    5.27,
                    '2025-01-01T00:00:00Z',
                    '2026-01-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'Pais',
        description: 'Country name',
        type: ee_const.var_type.string,
      },
      {
        name: 'AREA_KM2',
        description: 'Area in square kilometers',
        type: ee_const.var_type.double,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Country Boundary',
        lookat: { lon: -51.9253, lat: -14.235, zoom: 4 },
        table_visualization: {
          color: '004d40',
          width: 2,
          fill_color: '00796b',
        },
      },
      {
        display_name: 'Country Boundary',
        visualize_as: 'FeatureView',
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 250,
      thinning_strategy: 'HIGHER_DENSITY',
      thinning_ranking: ['AREA_KM2 DESC'],
    },
  },
  'gee:terms_of_use': |||
    This dataset is made available by the Instituto Brasileiro de Geografia e
    Estat&iacute;stica (IBGE) as open public data in accordance with Brazilian Federal
    Law No. 12.527/2011 (Access to Information Law). Users are free to use,
    modify, and distribute the data for personal, educational, research, and
    commercial applications, with appropriate attribution to IBGE.
  |||,
}
