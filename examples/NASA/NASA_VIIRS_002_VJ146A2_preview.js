var dataset = ee.ImageCollection('NASA/VIIRS/002/VJ146A2')
                  .filter(ee.Filter.date('2024-11-20', '2024-11-22'));

var gap_filled_band =
    dataset.select('Gap_Filled_DNB_BRDF_Corrected_NTL').first();

var visParams = {
  min: 0.2,
  max: 4.0,
  palette: ['000839', '005082', '00a8cc', 'ffa41b', 'ffe867', 'ffffff'],
};

var image = gap_filled_band.visualize(visParams);

var lon = -95.0;
var lat = 38.0;

var geometry = ee.Geometry.Polygon(
    [[
      [-130, 55],
      [-130, 15],
      [-60, 15],
      [-60, 55],
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
Map.addLayer(image, {}, 'Nighttime Lights Preview');

print(ui.Thumbnail({image: image, params: imageParams}));
