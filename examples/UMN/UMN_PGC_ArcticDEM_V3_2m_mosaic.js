var dataset = ee.Image('UMN/PGC/ArcticDEM/V3/2m_mosaic');
var elevation = dataset.select('elevation');
var elevationVis = {
  min: -50.0,
  max: 1000.0,
  palette: ['0d13d8', '60e1ff', 'ffffff'],
};
Map.setCenter(-63.402, 66.368, 7);
Map.addLayer(elevation, elevationVis, 'Elevation');
