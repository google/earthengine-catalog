local id = 'IBGE/UF/V2025';
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
  title: 'IBGE: Brazil State Boundaries 2025 (Federation Units)',
  version: '2025',
  'gee:type': ee_const.gee_type.table,
  description: |||
    The Instituto Brasileiro de Geografia e Estat&iacute;stica (IBGE) provides official
    cartographic representations of the Brazilian territorial structure. This
    dataset contains the boundaries of the 27 Federation Units (26 States and
    1 Federal District) of Brazil for the reference year 2025 (Malha Territorial
    2025).

    Federation Units are the primary subnational administrative divisions of
    Brazil, grouped into five macro regions (Norte, Nordeste, Sudeste, Sul, and
    Centro-Oeste).

    For more information on the methodology and technical specifications, visit
    the [IBGE Municipal Mesh Documentation](https://www.ibge.gov.br/en/geosciences/territorial-organization/territorial-meshes/2786-np-municipal-mesh/18890-municipal-mesh.html).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
    {
      rel: ee_const.rel.source,
      href: 'https://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2025/Brasil/BR_UF_2025.zip',
    },
  ],
  'gee:categories': ['infrastructure-boundaries'],
  keywords: [
    'borders',
    'boundaries',
    'brazil',
    'ibge',
    'states',
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
        name: 'CD_UF',
        description: '2-digit State / Federation Unit Code (e.g., 11=RO, 35=SP, 53=DF)',
        type: ee_const.var_type.string,
      },
      {
        name: 'NM_UF',
        description: 'State / Federation Unit Name',
        type: ee_const.var_type.string,
      },
      {
        name: 'SIGLA_UF',
        description: '2-letter State Abbreviation (e.g., SP, RJ, MG, DF)',
        type: ee_const.var_type.string,
      },
      {
        name: 'CD_REGIAO',
        description: '1-digit Macro Region Code (1=Norte, 2=Nordeste, 3=Sudeste, 4=Sul, 5=Centro-Oeste)',
        type: ee_const.var_type.string,
      },
      {
        name: 'NM_REGIAO',
        description: 'Macro Region Name',
        type: ee_const.var_type.string,
      },
      {
        name: 'SIGLA_RG',
        description: 'Macro Region Abbreviation (N, NE, SE, S, CO)',
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
        display_name: 'State Boundaries',
        lookat: { lon: -51.9253, lat: -14.235, zoom: 4 },
        table_visualization: {
          color: '2ca02c',
          width: 1.5,
          fill_color: 'b5ffb4',
        },
      },
      {
        display_name: 'State Boundaries',
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
    Estat&iacute;stica (IBGE) as open public data in accordance with Brazilian
    Federal Law No. 12.527/2011 (Access to Information Law). Users are free to
    use, modify, and distribute the data for personal, educational, research,
    and commercial applications, with appropriate attribution to IBGE.
  |||,
}
