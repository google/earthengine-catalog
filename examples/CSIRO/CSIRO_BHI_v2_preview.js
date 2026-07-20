var dataset = ee.ImageCollection('CSIRO/BHI/v2');
var image = dataset.first();

var visParams = {
  bands: ['proportion_habitat'],
  min: 0.0,
  max: 1.0,
  palette: ['red', 'yellow', 'green'],
};

var pixels = 256;
var areaOfInterest = ee.Geometry.Rectangle([112.0, -44.0, 154.0, -10.0], null, false);

var imageVis = image.visualize(visParams);

var thumbnailParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

Map.setCenter(133.0, -25.0, 4);
Map.addLayer(imageVis, {}, 'Proportion of Habitat Retained');

print(ui.Thumbnail({image: imageVis, params: thumbnailParams}));
