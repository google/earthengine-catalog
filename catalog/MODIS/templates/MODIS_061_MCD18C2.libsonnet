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
        name: 'GMT_0000_PAR',
        description: 'Total PAR at GMT 00:00',
      },
      {
        name: 'GMT_0300_PAR',
        description: 'Total PAR at GMT 03:00',
      },
      {
        name: 'GMT_0600_PAR',
        description: 'Total PAR at GMT 06:00',
      },
      {
        name: 'GMT_0900_PAR',
        description: 'Total PAR at GMT 09:00',
      },
      {
        name: 'GMT_1200_PAR',
        description: 'Total PAR at GMT 12:00',
      },
      {
        name: 'GMT_1500_PAR',
        description: 'Total PAR at GMT 15:00',
      },
      {
        name: 'GMT_1800_PAR',
        description: 'Total PAR at GMT 18:00',
      },
      {
        name: 'GMT_2100_PAR',
        description: 'Total PAR at GMT 21:00',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Total PAR at GMT 12:00',
        lookat: {
          lon: 0,
          lat: 0,
          zoom: 0,
        },
        image_visualization: {
          band_vis: {
            min: [
              -236,
            ],
            max: [
              316,
            ],
            palette: [
              '0f17ff',
              'b11406',
              'f1ff23',
            ],
            bands: [
              'GMT_1200_PAR',
            ],
          },
        },
      },
    ],
  },
}
