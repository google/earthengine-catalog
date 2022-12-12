var collection = ee.ImageCollection('UTOKYO/WTLAB/KBDI/v1')
  .select('KBDI')
  .filterDate('2019-01-01', '2019-01-10');
var bandViz = {
  min: 0,
  max: 800,
  palette: [
    '001a4d', '003cb3', '80aaff', '336600', 'cccc00', 'cc9900', 'cc6600',
    '660033'
  ]
};
Map.addLayer(collection.mean(), bandViz, 'Keetch-Byram Drought Index');
Map.setCenter(120, 3, 3);
