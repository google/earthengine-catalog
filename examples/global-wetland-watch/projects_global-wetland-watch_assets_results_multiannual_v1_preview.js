var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/results/multiannual/v1');
var image = dataset.filter(ee.Filter.eq('period', '2023-2025')).mosaic();

var visParams = {
  bands: ['mode_class'],
  min: 1,
  max: 31,
  palette: [
    'f2d27c', 'c06b3e', '6f6f6f', 'e6d8a8', '7fa65a',  // 1-5
    'ffffff', 'ffffff', 'ffffff', 'ffffff',            // 6-9
    '1f5f3a', 'b5cf4a', '4e7a55', 'f1a6a6', '7a5b2e',  // 10-14
    'b89a5a', 'f0d35c',                                // 15-16
    'ffffff', 'ffffff', 'ffffff', 'ffffff',            // 17-20
    '3fa9a6', '7fe3e6', '8f63a8', 'e8ddf0', '5fa8d3',  // 21-25
    '4f66b2', '1f3f7a', '6a8fd9', 'c7dbf2', '3b86b3',  // 26-30
    'bdbdbd',                                          // 31
  ],
};

var lon = 89.2;
var lat = 21.9;
Map.setCenter(lon, lat, 10);

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
var imageWithBackground =
    ee.ImageCollection([background, image.visualize(visParams)]).mosaic();
Map.addLayer(imageWithBackground, {}, 'Dominant wetland type (2023-2025)');

var delta = 0.35;
var parameters = {
  dimensions: [256, 256],
  region: ee.Geometry.Rectangle(
      [lon - delta, lat - delta, lon + delta, lat + delta], null, false),
  crs: 'EPSG:3857',
  format: 'png'
};
print(ui.Thumbnail({image: imageWithBackground, params: parameters}));
