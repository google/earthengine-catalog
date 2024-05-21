local id = 'JRC/GHSL/P2023A/GHS_POP';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/jrc_pop_versions.libsonnet';

local subdir = 'JRC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'GHSL: Global population surfaces 1975-2030 (P2023A)',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This raster dataset depicts the spatial distribution of residential
    population, expressed as the absolute number of inhabitants of the cell.
    Residential population estimates between 1975 and 2020 in 5-year intervals
    and projections to 2025 and 2030 derived from CIESIN GPWv4.11 were
    disaggregated from census or administrative units to grid cells, informed by
    the distribution, volume, and classification of built-up area as mapped in
    the [global GHSL built-up surface layers](https://developers.google.com/earth-engine/datasets/catalog/JRC_GHSL_P2023A_GHS_BUILT_S)
    per epoch.

    More information about the GHSL main products can be found in the
    [GHSL Data Package 2023 report]
    (https://ghsl.jrc.ec.europa.eu/documents/GHSL_Data_Package_2023.pdf?t=1683540422)

    The Global Human Settlement Layer (GHSL) project is supported by the
    European Commission, Joint Research Center, and Directorate-General for
    Regional and Urban Policy.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'ghsl',
    'jrc',
    'population',
    'ciesin_derived',
    'sdg',
  ],
  providers: [
    ee.producer_provider('EC JRC', 'https://ghsl.jrc.ec.europa.eu/ghs_pop2023.php'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('1975-01-01T00:00:00Z', '2030-12-31T00:00:00Z'),
  summaries: {
    gsd: [
      100.0,
    ],
    'eo:bands': [
      {
        name: 'population_count',
        description: 'Population count by epoch'
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Population Count',
        lookat: {
          lat: 22.59,
          lon: 78.22,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              200.0,
            ],
            palette: [
              '060606',
              '337663',
              '337663',
              'ffffff',
            ],
            bands: [
              'population_count',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
   Schiavina, Marcello; Freire, Sergio; Alessandra Carioli; MacManus, Kytt (2023):
   GHS-POP R2023A - GHS population grid multitemporal (1975-2030). European
   Commission, Joint Research Centre (JRC)
   [PID: http://data.europa.eu/89h/2ff68a52-5b5b-4a22-8f40-c41da8332cfe](http://data.europa.eu/89h/2ff68a52-5b5b-4a22-8f40-c41da8332cfe)
   [doi:10.2905/2FF68A52-5B5B-4A22-8F40-C41DA8332CFE](https://doi.org/10.2905/2FF68A52-5B5B-4A22-8F40-C41DA8332CFE)
  |||,
  'sci:doi': '10.2905/2FF68A52-5B5B-4A22-8F40-C41DA8332CFE',
  'gee:terms_of_use': |||
    The GHSL has been produced by the European Commission Joint Research Centre
    as open and free data. Reuse is authorised, provided the source is
    acknowledged. For more information, please read the use conditions ([European
    Commission Reuse and Copyright Notice](https://ec.europa.eu/info/legal-notice_en)).
  |||,
}
