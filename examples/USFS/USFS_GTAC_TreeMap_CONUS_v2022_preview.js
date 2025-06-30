var year = '2022';

var datasetPath = 'USFS/GTAC/TreeMap/v2022';

var dataset = ee.ImageCollection(datasetPath);
var image = dataset.filter(ee.Filter.eq('year', year))
                    .filter('study_area == "CONUS"') 
                    .select('FLDTYPCD')
                    .first();

var image = image.randomVisualizer();

var RGBimage = ee.Image.cat(
  image.select('viz-red').rename('vis-red'),
  image.select('viz-green').rename('vis-green'),
  image.select('viz-blue').rename('vis-blue')
  );

var RGBimage = RGBimage.toByte();


var waterLand = ee.Image('NOAA/NGDC/ETOPO1')
  .select('bedrock')
  .gt(0);

var backgroundPalette = ['87adca', 'e8e2d5'];
var waterLandBackground = waterLand.visualize({
  palette: backgroundPalette});
var waterLandBackground = waterLandBackground.toByte();

var imageWithBackground = ee.ImageCollection([
  waterLandBackground, 
  RGBimage
]).mosaic();


var lon = -115;
var lat = 40;
Map.setCenter(lon, lat, 4);

// Degrees in EPSG:3857
var lonDelta = 10;
var latDelta = 10;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - lonDelta, lat - latDelta, lon + lonDelta, lat + latDelta],
    null,
    false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

Map.addLayer(imageWithBackground, null, 'TreeMap' + year + ' (FLDTYPCD) with background');

print(ui.Thumbnail({
  image: imageWithBackground, 
  params: visParams
}));