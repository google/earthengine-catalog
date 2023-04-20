var collection = ee.ImageCollection('UMN/PGC/REMA/V1/2m');

Map.setCenter(-60, -75, 3);

var elevationVis = {
  bands: ['elevation'],
  min: -50.0,
  max: 1000.0,
  palette: ['0d13d8', '60e1ff', 'ffffff'],
};

Map.addLayer(collection, elevationVis, 'REMA_DEM_strips_2m');
