var dataset = ee.FeatureCollection.loadBigQueryTable("earth-engine-public-data.insitu_nrt_currents.argo_latest")
                  .filter(ee.Filter.date('2025-04-01', '2025-05-01'));

dataset = dataset.map(function(f) {
  var val = ee.Number(f.get('EWCT')).float();
  return f.buffer(8000) // 8km radius circles
          .set('EWCT', val);
});


var image = dataset.reduceToImage({
  properties: ['EWCT'],
  reducer: ee.Reducer.first()
});

var visParams = {
  min: -0.5,
  max: 0.5,
  palette: ['a50026', 'd73027', '333333', '4575b4', '313695'],
};


image = image.updateMask(image.neq(0));
// ***************************************************************

var lon = -100.5;
var lat = 30.2;

var geometry = ee.Geometry.Polygon(
    [[[-130, 40],
      [-130, -20],
      [-55, -10],
      [-55, 55]]],
    null, false);

var pixels = 256;

var areaOfInterest = geometry;

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'gray'];
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

var imageWithBackground =
    ee.ImageCollection([waterLandBackground, image.visualize(visParams)]).mosaic();

Map.setCenter(lon, lat, 3);
Map.addLayer(imageWithBackground, {}, 'Argo EWCT (with background)');

print('Thumbnail of EWCT data with background:');
print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
