local template = import 'templates/copernicus_marine_bgc.libsonnet';
local units = import 'units.libsonnet';

local id = 'COPERNICUS/MARINE/GLOBAL_ANALYSISFORECAST_BGC_001_028/CAR';

{
  stac_version: template.stac_version,
  type: template.type,
  stac_extensions: template.stac_extensions,
  id: id,
  title: 'Copernicus Global Ocean Bio-Geo-Chemical Forecast - CAR',
  'gee:type': 'image_collection',
  description: template.description + |||
                  These products are provided on 50 vertical levels with
                  depths ranging from 0.49m to 5727.92m.
                  <br><br> This dataset consists of pH and dissolved
                  inorganic carbon.
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
        template.gen_bands('ph',
                           'Ocean pH',
                           units.dimensionless, template.ALL_DEPTHS) +
        template.gen_bands('dissic',
                           'Dissolved Inorganic Carbon',
                           units.mol_per_cubic_meter, template.ALL_DEPTHS),
    'gee:visualizations': [
      {
        display_name: 'Global BGC CAR Forecast',
        lookat: {
          lat: 73.63,
          lon: -140.5,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              8.0,
            ],
            max: [
              8.2,
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
              'ph_depth1',
            ],
          },
        },
      },
    ],
  } +
  template.gen_summaries('ph', 6.1, 8.6, template.ALL_DEPTHS) +
  template.gen_summaries('dissic', 0.1, 10.358, template.ALL_DEPTHS),
  'sci:citation': template.citation,
  'gee:interval': template.interval,
  'gee:terms_of_use': template.terms_of_use,
}
