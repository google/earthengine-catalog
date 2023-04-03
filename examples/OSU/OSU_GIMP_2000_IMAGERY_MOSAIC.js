var dataset = ee.Image('OSU/GIMP/2000_IMAGERY_MOSAIC');
var greenlandImage = dataset.select(['B3', 'B2', 'B1']);
var visParams = {
  min: 0.0,
  max: 255.0,
};
Map.setCenter(-29.1605, 70.4, 9);
Map.addLayer(greenlandImage, visParams, 'Greenland Pansharpened Image');
