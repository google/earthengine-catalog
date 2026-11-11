var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/coastal/tidal_composites/v1');
var image = dataset
    .filter(ee.Filter.eq('period', '2023-2025'))
    .filter(ee.Filter.eq('tide_state', 'low'))
    .mosaic();

var visParams = {
  bands: ['B4', 'B3', 'B2'],
  min: 0,
  max: 2500,
};

var lon = 8.6;
var lat = 53.7;
Map.setCenter(lon, lat, 11);

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
var imageWithBackground =
    ee.ImageCollection([background, image.visualize(visParams)]).mosaic();
Map.addLayer(imageWithBackground, {}, 'Low-tide composite (2023-2025)');

var delta = 0.2;
var parameters = {
  dimensions: [256, 256],
  region: ee.Geometry.Rectangle(
      [lon - delta, lat - delta, lon + delta, lat + delta], null, false),
  crs: 'EPSG:3857',
  format: 'png'
};
print(ui.Thumbnail({image: imageWithBackground, params: parameters}));
