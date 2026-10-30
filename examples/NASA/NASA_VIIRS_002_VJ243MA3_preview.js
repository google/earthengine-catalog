var dataset = ee.ImageCollection('NASA/VIIRS/002/VJ243MA3')
                  .filter(ee.Filter.date('2023-06-01', '2023-06-10'));

var blackSkyAlbedo = dataset.select('Albedo_BSA_Shortwave').mosaic();

var visParams = {
  min: 0.0,
  max: 0.3,
  palette: [
    '440154',
    '414487',
    '2a788e',
    '22a884',
    '7ad151',
    'fde725',
  ],
};

var image = blackSkyAlbedo.visualize(visParams);

var lon = -98.0;
var lat = 38.0;

var geometry = ee.Geometry.Polygon(
    [[
      [-125, 50],
      [-125, 24],
      [-66, 24],
      [-66, 50],
    ]],
    null, false);

var pixels = 256;

var imageParams = {
  dimensions: [pixels, pixels],
  region: geometry,
  crs: 'EPSG:3857',
  format: 'png',
};

Map.setCenter(lon, lat, 4);
Map.addLayer(image, {}, 'Black-Sky Albedo Shortwave Preview');

// Create a background image
var backgroundImage = ee.Image.constant(1).visualize({palette: ['#000000']});

// Combine images
var combinedImage = backgroundImage.blend(image);

print(ui.Thumbnail({image: combinedImage, params: imageParams}));
