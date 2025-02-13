{
  description: |||
    is a Moderate Resolution Imaging Spectroradiometer
    (MODIS) Terra and Aqua combined Photosynthetically Active Radiation (PAR)
    gridded Level 3 product produced daily at 0.05 degree (5,600 meters at the
    equator) resolution with estimates of PAR every 3 hours. PAR is incident
    solar radiation in the visible spectrum (400-700 nanometers) and is an
    important variable in land-surface models that address a variety of
    scientific and application issues. The MCD18 products are based on a
    prototyping algorithm that uses multi-temporal signatures of MODIS data to
    derive surface reflectance and then calculate incident PAR using the look-up
    table (LUT) approach. The LUTs consider different types of loadings of
    aerosols and clouds at a variety of illumination/viewing geometry. Global
    PAR products are generated from MODIS and geostationary satellite data.
    Additional details regarding the methodology used to create the data are
    available in the
    [Algorithm Theoretical Basis Document](https://lpdaac.usgs.gov/documents/106/MCD18_ATBD.pdf)
  |||,
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
          lon: 6.746,
          lat: 46.529,
          zoom: 2,
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
