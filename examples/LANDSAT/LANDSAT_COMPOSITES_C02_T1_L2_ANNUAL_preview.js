var dataset = ee.ImageCollection('LANDSAT/COMPOSITES/C02/T1_L2_32DAY')
                  .filterDate('2023-01-01', '2024-01-01');
var rgb = dataset.select(['red', 'green', 'blue']).mean();
var rgbVis = {
  min: 0.0,
  max: 0.3,
};
Map.setCenter(-3.57, 40.351, 6);
Map.addLayer(rgb, rgbVis, 'RGB');
var lon = -3.57;
var lat = 40.351;
var delta = 2;
var pixels = 256;
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);
var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};
var image = ee.Image(0).blend(rgb).visualize(rgbVis);
print(ui.Thumbnail({image: image, params: visParams}));
