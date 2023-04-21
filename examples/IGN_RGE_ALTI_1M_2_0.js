var dataset = ee.Image('IGN/RGE_ALTI/1M/2_0/FXX');
var elevation = dataset.select('MNT');

var elevationVis = {
  min: 0,
  max: 1000,
  palette: ['006600', '002200', 'fff700', 'ab7634', 'c4d0ff', 'ffffff']
};

Map.addLayer(elevation, elevationVis, 'Elevation');
Map.setCenter(3, 47, 5);
