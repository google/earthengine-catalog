local template = import 'templates/copernicus_marine_bgc.libsonnet';
local units = import 'units.libsonnet';

local id = 'COPERNICUS/MARINE/GLOBAL_ANALYSISFORECAST_BGC_001_028/CO2';

{
  stac_version: template.stac_version,
  type: template.type,
  stac_extensions: template.stac_extensions,
  id: id,
  title: 'Copernicus Global Ocean Bio-Geo-Chemical Forecast - CO2',
  'gee:type': 'image_collection',
  description: template.description + |||
                    <br><br> This dataset consists of surface partial pressure
                    of carbon dioxide.
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
    'eo:bands': [
      {
        name: 'spco2_depth1',
        description: 'Surface Partial Pressure of Carbon Dioxide',
        'gee:units': units.pascal,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Global BGC CO2 Forecast',
        lookat: {
          lat: 73.63,
          lon: -140.5,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              20.0,
            ],
            max: [
              40.0,
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
              'spco2_depth1',
            ],
          },
        },
      },
    ],
    'spco2_depth1': {
      minimum: -14,
      maximum: 1460,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': template.citation,
  'gee:interval': template.interval,
  'gee:terms_of_use': template.terms_of_use,
}
