var dataset = ee.ImageCollection('NRCan/CDEM');
var elevation = dataset.select('elevation');
var elevationVis = {
  min: -50.0,
  max: 1500.0,
  palette: ['0905ff', 'ffefc4', 'ffffff'],
};
Map.setCenter(-139.3643, 63.3213, 9);
Map.addLayer(elevation, elevationVis, 'Elevation');