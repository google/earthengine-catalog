var dataset = ee.ImageCollection(
    'projects/climate-and-sustainability/assets/gem-15_v1');
var dsm = dataset.select('dsm').mosaic();

var visParams = {
  min: 20.0,
  max: 100.0,
  palette: [
    'fadd67', 'b8b257', '7ca88f', '4aa4ca', '3869d1',
    '6f5bc8', 'b862b0', 'bc3a6b', 'cb3438', 'f08429', 'fbd227'
  ]
};

var lon = 2.165;
var lat = 41.395;
var region = ee.Geometry.Point([lon, lat]).buffer(1500).bounds();

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
var visualizedImage = dsm.visualize(visParams);
var imageWithBackground = ee.ImageCollection(
    [background, visualizedImage]).mosaic();

Map.setCenter(lon, lat, 14);
Map.addLayer(imageWithBackground);

var imageParams = {
  dimensions: [256, 256],
  region: region,
  crs: 'EPSG:3857',
  format: 'png'
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
