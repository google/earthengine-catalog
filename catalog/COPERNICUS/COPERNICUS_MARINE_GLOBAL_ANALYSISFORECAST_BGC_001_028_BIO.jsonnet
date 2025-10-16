local id = 'COPERNICUS/MARINE/GLOBAL_ANALYSISFORECAST_BGC_001_028/BIO';
local template = import 'templates/copernicus_marine_bgc.libsonnet';
local units = import 'units.libsonnet';


{
  stac_version: template.stac_version,
  type: template.type,
  stac_extensions: template.stac_extensions,
  id: id,
  title: 'Copernicus Global Ocean Bio-Geo-Chemical Forecast - BIO',
  'gee:type': 'image_collection',
  description: template.description + |||
                    These products are provided on 50 vertical levels with
                    depths ranging from 0.49m to 5727.92m.
                    <br><br> This dataset mainly consists of total primary
                    production of phytos, and dissolved oxygen.
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
        template.gen_bands('nppv',
                           'Total Primary Production of Phyto',
                           units.mg_per_cubic_meter_per_day,
                           template.ALL_DEPTHS) +
        template.gen_bands('o2',
                           'Dissolved Oxygen',
                           units.mmol_per_cubic_meter,
                           template.ALL_DEPTHS),
    'gee:visualizations': [
      {
        display_name: 'Global BGC BIO Forecast',
        lookat: {
          lat: 73.63,
          lon: -140.5,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              50.0,
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
              'nppv_depth1',
            ],
          },
        },
      },
    ],
  } +
  template.gen_summaries('nppv', 0, 2729.2, template.ALL_DEPTHS) +
  template.gen_summaries('o2', 0.1, 516.16, template.ALL_DEPTHS),
  'sci:citation': template.citation,
  'gee:interval': template.interval,
  'gee:terms_of_use': template.terms_of_use,
}
