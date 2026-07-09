var collection = ee.ImageCollection('COPERNICUS/DEM/GLO30_2024_1');
var nativeProj = collection.first().projection();
var dataset = collection.mosaic().setDefaultProjection(nativeProj);

var dsm = dataset.select('DEM');
var dsmVis = {
  min: 0.0,
  max: 3000.0,
  palette: ['333399', '00a2e5', '55dd77', 'ffff99', 'aa926b', 'aa928d', 'ffffff'],
};

var image = dsm.visualize(dsmVis);

var lon = 8.5;
var lat = 46.5;

var geometry = ee.Geometry.Polygon(
    [[[5, 48],
      [5, 44],
      [12, 44],
      [12, 48]]],
    null, false);
var pixels = 256;

var areaOfInterest = geometry;

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

Map.setCenter(lon, lat, 6);
Map.addLayer(imageWithBackground);

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
