var collection = ee.ImageCollection("NASA/HLS/HLSS30/v002")
                    .filter(ee.Filter.date('2024-04-25', '2024-04-26'))
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

Map.setCenter(-109.53, 29.19, 12)
Map.addLayer(rgbCollection, {}, 'HLS S30 RGB bands');