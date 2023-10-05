var dataset = ee.ImageCollection('GOOGLE/CLOUD_SCORE_PLUS/V1/S2_HARMONIZED');

var region = ee.Geometry.Point(31.2196,-16.1377).buffer(10000).bounds();

var image = dataset
    .filterDate('2023-05-01', '2023-05-02')
    .filterBounds(region)
    .mosaic();

var visParams = {
  bands: ['cs_cdf'],
  min: 0,
  max: 1,
  palette: ['white', 'black']
};

var imageParams = {
  crs: 'EPSG:32736',
  region: region,
  dimensions: 256, // Width and height in pixels
  format: 'png'
};

print(ui.Thumbnail({image: image.visualize(visParams), params: imageParams}));

Map.addLayer(image, visParams, 'Cloud Score+');
Map.addLayer(region, {color: 'red'}, 'Region Of Interest');
Map.centerObject(region, 11);