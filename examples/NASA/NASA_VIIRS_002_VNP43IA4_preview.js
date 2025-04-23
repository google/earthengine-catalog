var dataset = ee.ImageCollection('NASA/VIIRS/002/VNP43IA4')
                  .filter(ee.Filter.date('2021-06-01', '2021-06-03'));

var nadir_reflectance_I1 = dataset.select('Nadir_Reflectance_I1').first();
var palette = [
  '000080',
  '0000d9',
  '4000ff',
  '8000ff',
  '0080ff',
  '00ffff',
  '00ff80',
  '80ff00',
  'daff00',
  'ffff00',
  'fff500',
  'ffda00',
  'ffb000',
  'ffa400',
  'ff4f00',
  'ff2500',
  'ff0a00',
  'ff00ff',
];
var visParams = {
  min: 0,
  max: 10000,
  palette: palette,
};

// cadetblue
var background = ee.Image.rgb(95, 158, 160).visualize({min: 0, max: 255});
var image = nadir_reflectance_I1.visualize(visParams);

var lon = -8;
var lat = 60;

var geometry = ee.Geometry.Polygon(
    [[
      [-114, 83],
      [-114, 60],
      [-8, 60],
      [-8, 83],
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

Map.addLayer(background, {}, 'background');
Map.addLayer(image, {}, 'Nadir BRDF/Albedo Reflectance I1');
Map.setCenter(lon, lat, 3);
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));