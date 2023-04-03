var mosaic = ee.Image('UMN/PGC/REMA/V1_1/8m');

Map.setCenter(-61, -75, 3);

var elevationVis = {
  bands: ['elevation'],
  min: -50.0,
  max: 1000.0,
  palette: ['0d13d8', '60e1ff', 'ffffff'],
};

Map.addLayer(mosaic, elevationVis, 'REMA_DEM_mosaic_8m');
