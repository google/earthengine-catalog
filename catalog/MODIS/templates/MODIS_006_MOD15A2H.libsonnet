local units = import 'units.libsonnet';

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
        name: 'Fpar_500m',
        description: 'Fraction of Photosynthetically Active Radiation',
        'gee:units': units.percent,
        'gee:scale': 0.01,
      },
      {
        name: 'Lai_500m',
        description: 'Leaf Area Index',
        'gee:units': units.area_fraction,
        'gee:scale': 0.1,
      },
      {
        name: 'FparLai_QC',
        description: 'Quality for LAI and FPAR',
      },
      {
        name: 'FparExtra_QC',
        description: 'Extra detail Quality for LAI and FPAR',
      },
      {
        name: 'FparStdDev_500m',
        description: 'Standard deviation of FPAR',
        'gee:units': units.percent,
        'gee:scale': 0.01,
      },
      {
        name: 'LaiStdDev_500m',
        description: 'Standard deviation of LAI',
        'gee:units': units.area_fraction,
        'gee:scale': 0.1,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Fpar',
        lookat: {
          lat: 40.94,
          lon: -10.88,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'Fpar_500m',
            ],
            min: [
              0.0,
            ],
            max: [
              100.0,
            ],
            palette: [
              'FFFFFF',
              'CE7E45',
              'DF923D',
              'F1B555',
              'FCD163',
              '99B718',
              '74A901',
              '66A000',
              '529400',
              '3E8601',
              '207401',
              '056201',
              '004C00',
              '023B01',
              '012E01',
              '011D01',
              '011301',
            ],
          },
        },
      },
    ],
    Fpar_500m: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Lai_500m: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    FparLai_QC: {
      minimum: 0.0,
      maximum: 254.0,
      'gee:estimated_range': false,
    },
    FparExtra_QC: {
      minimum: 0.0,
      maximum: 254.0,
      'gee:estimated_range': false,
    },
    FparStdDev_500m: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    LaiStdDev_500m: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
  },
}
