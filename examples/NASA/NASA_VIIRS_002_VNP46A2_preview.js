var dataset = ee.ImageCollection('NASA/VIIRS/002/VNP46A2')
                  .filter(ee.Filter.date('2013-01-01', '2013-03-01'));

var gap_filled_band =
    dataset.select('Gap_Filled_DNB_BRDF_Corrected_NTL').first();

var visParams = {
  min: 0.0,
  max: 1.0,
};

var image = gap_filled_band.visualize(visParams);

var lon = -77.1056;
var lat = 38.8904;

var geometry = ee.Geometry.Polygon(
    [[
      [-130, 55],
      [-130, -10],
      [-55, -10],
      [-55, 55],
    ]],
    null, false);
var pixels = 256;

var areaOfInterest = geometry;

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

Map.setCenter(lon, lat, 3);
Map.addLayer(image)

print(ui.Thumbnail({image: image, params: imageParams}));