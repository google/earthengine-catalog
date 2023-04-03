var dataset = ee.FeatureCollection(
    'JRC/LUCAS_HARMO/COPERNICUS_POLYGONS/V1/2018');

var visParams = {
  min: 35,
  max: 60,
};

// plotting the GPS latitude per polygon
var dataset2 = dataset.map(function (f) {
  return ee.Feature(f.buffer(5000));
});

var image = ee.Image().float().paint(dataset2, 'gps_lat').randomVisualizer();

Map.addLayer(ee.Image(1), {min:0, max:1}, 'background');
Map.addLayer(image, visParams, 'LUCAS Polygons');
Map.addLayer(dataset, null, 'for Inspector', false);

Map.setCenter(19.514, 51.82, 8);
