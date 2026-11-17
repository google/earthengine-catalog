var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/coastal/tidal_composites/v1');
// Low-tide composites 2023-2025; tile order reversed so the cleaner tile is on top where
// neighboring tiles overlap.
var image = dataset
    .filter(ee.Filter.eq('period', '2023-2025'))
    .filter(ee.Filter.eq('tide_state', 'low'))
    .sort('system:index', false)
    .mosaic();

// Stretch fixed for this site.
var visParams = {
  bands: ['B4', 'B3', 'B2'],
  min: [520, 779, 984],
  max: [1287, 1546, 1751],
  gamma: 1.1,
};

// Bijagos Archipelago, Guinea-Bissau.
var lon = -15.75;
var lat = 11.35;
Map.setCenter(lon, lat, 10);

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
var imageWithBackground =
    ee.ImageCollection([background, image.visualize(visParams)]).mosaic();
Map.addLayer(imageWithBackground, {}, 'Low-tide composite (2023-2025)');

var parameters = {
  dimensions: [256, 256],
  region: ee.Geometry.Rectangle([-16.05, 11.0557, -15.45, 11.644], null, false),
  crs: 'EPSG:3857',
  format: 'png'
};
print(ui.Thumbnail({image: imageWithBackground, params: parameters}));
