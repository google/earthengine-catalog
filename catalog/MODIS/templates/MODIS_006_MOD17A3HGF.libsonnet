{
  summaries: {
    gsd: [
      500.0,
    ],
    instruments: [
      'MODIS',
    ],
    'eo:bands': [
      {
        name: 'Npp',
        description: 'Net primary productivity',
        'gee:units': 'kg*C/m^2',
        'gee:scale': 0.0001,
      },
      {
        name: 'Npp_QC',
        description: 'Quality control percentage',
        'gee:units': '%',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'NPP',
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              19000.0,
            ],
            palette: [
              'bbe029',
              '0a9501',
              '074b03',
            ],
            bands: [
              'Npp',
            ],
          },
        },
      },
    ],
    Npp: {
      minimum: -30000.0,
      maximum: 32700.0,
      'gee:estimated_range': false,
    },
    Npp_QC: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
  },
}
