var dataset = ee.ImageCollection('BIOPAMA/GlobalOilPalm/v1_2');
var classification = dataset.select('classification');

var classificationVis = {
  min: 0.0,
  max: 2.0,
  palette: ['696969', 'ff0000', 'ef00ff'],
};

var lon = 101.7;
var lat = 3.1;

Map.setCenter(lon, lat, 10);
Map.addLayer(classification, classificationVis, 'Oil Palm Classification');

var point = ee.Geometry.Point(lon, lat);
var delta = 0.2;
var rect = ee.Geometry.Rectangle([lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var thumbnail = ui.Thumbnail({
  image: classification.mosaic().visualize(classificationVis),
  params: {
    dimensions: '256',
    region: rect,
    format: 'png',
  },
  style: {height: '256px', width: '256px'},
});

print(thumbnail);
