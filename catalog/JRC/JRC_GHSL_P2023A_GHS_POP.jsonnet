local id = 'JRC/GHSL/P2023A/GHS_POP';
local predecessor_id = 'JRC/GHSL/P2016/POP_GPW_GLOBE_V1';
local subdir = 'JRC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local predecessor_basename = std.strReplace(predecessor_id, '/', '_');
local predecessor_filename = predecessor_basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local predecessor_url = catalog_subdir_url + predecessor_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'GHS-POP R2023A - GHS population grid multitemporal (1975-2030)',
  version: 'v1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The GHS-POP R2023A dataset depicts the distribution of residential
    population, expressed as the number of people per cell.
    Residential population estimates between 1975 and 2020 in 5-year intervals
    and projections to 2025 and 2030 derived from CIESIN GPWv4.11 were
    disaggregated from census or administrative units to grid cells, informed by
    the distribution, volume and classification of built-up as mapped in the
    Global Human Settlement Layer (GHSL) global layer per corresponding epoch.


    The Global Human Settlement Layer (GHSL) project is supported by the
    European Commission, Joint Research Center, and Directorate-General for
    Regional and Urban Policy.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.predecessor(predecessor_id, predecessor_url)
  ],
  keywords: [
    'ciesin_derived',
    'jrc',
    'population',
  ],
  providers: [
    ee.producer_provider('EC JRC', 'https://ghsl.jrc.ec.europa.eu/ghs_pop2023.php'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1975-01-01T00:00:00Z', '2030-12-31T00:00:00Z'),
  summaries: {
    gsd: [
      250.0,
    ],
    'eo:bands': [
      {
        name: 'population_count',
        description: 'Number of people per cell',
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
    population_count: {
      minimum: 0.0,
      maximum: 1344190.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Schiavina M., Freire S., Carioli A., MacManus K. (2023):
    GHS-POP R2023A - GHS population grid multitemporal (1975-2030).
    European Commission, Joint Research Centre (JRC)
    PID: http://data.europa.eu/89h/2ff68a52-5b5b-4a22-8f40-c41da8332cfe,
    [doi:10.2905/2FF68A52-5B5B-4A22-8F40-C41DA8332CFE](https://doi.org/10.2905/2FF68A52-5B5B-4A22-8F40-C41DA8332CFE)
  |||,
  'sci:doi': '10.2905/2FF68A52-5B5B-4A22-8F40-C41DA8332CFE',
  'gee:terms_of_use': |||
    The GHSL has been produced by the EC JRC as open and free data. Reuse is
    authorised, provided the source is acknowledged. For more information,
    please read the use conditions ([European Commission Reuse and Copyright
    Notice](https://ec.europa.eu/info/legal-notice_en)).
  |||,
}
