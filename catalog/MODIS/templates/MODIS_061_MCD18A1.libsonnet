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
        name: 'DSR',
        description: 'Instantaneous total DSR at MODIS overpass',
        'gee:units': units.watt_per_meter_squared
      },
      {
        name: 'Direct',
        description: 'Instantaneous direct DSR at MODIS overpass',
        'gee:units': units.watt_per_meter_squared
      },
      {
        name: 'Diffuse',
        description: 'Instantaneous diffuse DSR at MODIS overpass',
        'gee:units': units.watt_per_meter_squared
      },
      {
        name: 'GMT_0000_DSR',
        description: 'Total DSR at GMT 00:00',
        'gee:units': units.watt_per_meter_squared
      },
      {
        name: 'GMT_0300_DSR',
        description: 'Total DSR at GMT 03:00',
        'gee:units': units.watt_per_meter_squared
      },
      {
        name: 'GMT_0600_DSR',
        description: 'Total DSR at GMT 06:00',
        'gee:units': units.watt_per_meter_squared
      },
      {
        name: 'GMT_0900_DSR',
        description: 'Total DSR at GMT 09:00',
        'gee:units': units.watt_per_meter_squared
      },
      {
        name: 'GMT_1200_DSR',
        description: 'Total DSR at GMT 12:00',
        'gee:units': units.watt_per_meter_squared
      },
      {
        name: 'GMT_1500_DSR',
        description: 'Total DSR at GMT 15:00',
        'gee:units': units.watt_per_meter_squared
      },
      {
        name: 'GMT_1800_DSR',
        description: 'Total DSR at GMT 18:00',
        'gee:units': units.watt_per_meter_squared
      },
      {
        name: 'GMT_2100_DSR',
        description: 'Total DSR at GMT 21:00',
        'gee:units': units.watt_per_meter_squared
      },
      {
        name: 'DSR_Quality',
        description: 'Quality flag',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Input source of surface reflectance data',
              bit_count: 2,
              values: [
                {
                  description: 'no valid surface reflectance data',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'from the MCD43 product',
                },
                {
                  value: 2,
                  description: 'from the climatology data',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 2,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Total DSR at GMT 12:00',
        lookat: {lon: 6.746, lat: 46.529, zoom: 2},
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              350,
            ],
            palette: [
              '0f17ff',
              'b11406',
              'f1ff23',
            ],
            bands: [
              'GMT_1200_DSR',
            ],
          },
        },
      },
    ],
    DSR: {
      minimum: 0,
      maximum: 1400,
      'gee:estimated_range': false,
    },
    Direct: {
      minimum: 0,
      maximum: 1400,
      'gee:estimated_range': false,
    },
    Diffuse: {
      minimum: 0,
      maximum: 1400,
      'gee:estimated_range': false,
    },
    GMT_0000_DSR: {
      minimum: 0,
      maximum: 1400,
      'gee:estimated_range': false,
    },
    GMT_0300_DSR: {
      minimum: 0,
      maximum: 1400,
      'gee:estimated_range': false,
    },
    GMT_0600_DSR: {
      minimum: 0,
      maximum: 1400,
      'gee:estimated_range': false,
    },
    GMT_0900_DSR: {
      minimum: 0,
      maximum: 1400,
      'gee:estimated_range': false,
    },
    GMT_1200_DSR: {
      minimum: 0,
      maximum: 1400,
      'gee:estimated_range': false,
    },
    GMT_1500_DSR: {
      minimum: 0,
      maximum: 1400,
      'gee:estimated_range': false,
    },
    GMT_1800_DSR: {
      minimum: 0,
      maximum: 1400,
      'gee:estimated_range': false,
    },
    GMT_2100_DSR: {
      minimum: 0,
      maximum: 1400,
      'gee:estimated_range': false,
    },
  },
}
