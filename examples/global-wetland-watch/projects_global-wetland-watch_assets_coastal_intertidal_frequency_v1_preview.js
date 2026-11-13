var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/coastal/intertidal_frequency/v1');
var image = dataset
    .filter(ee.Filter.eq('tide_state', 'all-tide'))
    .filter(ee.Filter.eq('period', '2023-2025'))
    .mosaic()
    .selfMask();

var visParams = {
  bands: ['inundationFrequency'],
  min: 0,
  max: 100,
  palette: ['f7fcb9', 'addd8e', '41ab5d', '1d91c0', '253494'],
};

var lon = 8.6;
var lat = 53.7;
Map.setCenter(lon, lat, 11);

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
var imageWithBackground =
    ee.ImageCollection([background, image.visualize(visParams)]).mosaic();
Map.addLayer(imageWithBackground, {}, 'Inundation frequency, all tides (%)');

var delta = 0.2;
var parameters = {
  dimensions: [256, 256],
  region: ee.Geometry.Rectangle(
      [lon - delta, lat - delta, lon + delta, lat + delta], null, false),
  crs: 'EPSG:3857',
  format: 'png'
};
print(ui.Thumbnail({image: imageWithBackground, params: parameters}));
