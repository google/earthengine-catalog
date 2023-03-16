var dataset = ee.ImageCollection('LANDSAT/MANGROVE_FORESTS');
var mangrovesVis = {
  min: 0,
  max: 1.0,
  palette: ['d40115'],
};
Map.setCenter(-44.5626, -2.0164, 9);
Map.addLayer(dataset, mangrovesVis, 'Mangroves');
