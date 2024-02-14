var collection = ee.ImageCollection("NASA/HLS/HLSL30/v002")
                    .filter(ee.Filter.date('2013-04-25', '2013-04-28'))
                    .filter(ee.Filter.lt('CLOUD_COVERAGE', 30));
var visParams = {
  bands: ['B4', 'B3', 'B2'],
  min:0.01,
  max:0.18,
};

var visualizeImage = function(image) {
  var imageRGB = image.visualize(visParams);
  return imageRGB;
};

var rgbCollection = collection.map(visualizeImage);

Map.setCenter(-60.1765, -22.5318, 11)
Map.addLayer(rgbCollection, {}, 'HLS RGB bands');
