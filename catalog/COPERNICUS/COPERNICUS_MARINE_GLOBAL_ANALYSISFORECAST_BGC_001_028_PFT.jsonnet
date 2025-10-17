local template = import 'templates/copernicus_marine_bgc.libsonnet';
local units = import 'units.libsonnet';

local id = 'COPERNICUS/MARINE/GLOBAL_ANALYSISFORECAST_BGC_001_028/PFT';

{
  stac_version: template.stac_version,
  type: template.type,
  stac_extensions: template.stac_extensions,
  id: id,
  title: 'Copernicus Global Ocean Bio-Geo-Chemical Forecast - PFT',
  'gee:type': 'image_collection',
  description: template.description + |||
                    These products are provided on 50 vertical levels with
                    depths ranging from 0.49m to 5727.92m.
                    <br><br> This dataset consists of total chlorophyll and
                    total phytoplankton concentrations.
                  |||,
  license: template.license,
  links: template.links(id),
  'gee:categories': ['oceans'],
  keywords: template.keywords + [
    'daily',
    'forecast',
  ],
  providers: template.providers(id),
  extent: template.extent,
  summaries: {
    gsd: [
      27750.0, // Approximately 0.25 degrees at the equator
    ],
    'eo:bands':
        template.gen_bands('chl',
                           'Total Chlorophyll',
                           units.density_mg_per_m_cubed,
                           template.ALL_DEPTHS) +
        template.gen_bands('phyc',
                           'Total Phytoplankton',
                           units.mmol_per_cubic_meter,
                           template.ALL_DEPTHS),
    'gee:visualizations': [
      {
        display_name: 'Global BGC PFT Forecast - Chlorophyll',
        lookat: {
          lat: 73.63,
          lon: -140.5,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              1.0,
            ],
            palette: [
              'black',
              'blue',
              'cyan',
              'green',
              'yellow',
              'red',
              'white'
            ],
            bands: [
              'chl_depth1',
            ],
          },
        },
      },
    ],
  } +
  template.gen_summaries('chl', 0, 27, template.ALL_DEPTHS) +
  template.gen_summaries('phyc', 0, 117, template.ALL_DEPTHS),
  'sci:citation': template.citation,
  'gee:interval': template.interval,
  'gee:terms_of_use': template.terms_of_use,
}
