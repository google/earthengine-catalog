var landscan_global = ee.Image(
    'projects/sat-io/open-datasets/ORNL/LANDSCAN_GLOBAL/landscan-global-2022');
var popcount_intervals = '<RasterSymbolizer>' +
    ' <ColorMap type="intervals" extended="false" >' +
    '<ColorMapEntry color="#CCCCCC" quantity="0" label="No Data"/>' +
    '<ColorMapEntry color="#FFFFBE" quantity="5" label="Population Count (Estimate)"/>' +
    '<ColorMapEntry color="#FEFF73" quantity="25" label="Population Count (Estimate)"/>' +
    '<ColorMapEntry color="#FEFF2C" quantity="50" label="Population Count (Estimate)"/>' +
    '<ColorMapEntry color="#FFAA27" quantity="100" label="Population Count (Estimate)"/>' +
    '<ColorMapEntry color="#FF6625" quantity="500" label="Population Count (Estimate)"/>' +
    '<ColorMapEntry color="#FF0023" quantity="2500" label="Population Count (Estimate)"/>' +
    '<ColorMapEntry color="#CC001A" quantity="5000" label="Population Count (Estimate)"/>' +
    '<ColorMapEntry color="#730009" quantity="185000" label="Population Count (Estimate)"/>' +
    '</ColorMap>' +
    '</RasterSymbolizer>';

var lon = 26
var lat = 40;

Map.setCenter(lon, lat, 5);

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

// Degrees in EPSG:3857.
var delta = 10;
// Width and height of the thumbnail image.
var pixels = 256;

var image = landscan_global.sldStyle(popcount_intervals);
Map.addLayer(
    image, {}, 'National Intertidal Digital Elevation Model (NIDEM; m)', false);

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

Map.addLayer(imageWithBackground, {}, 'Population Count Estimate 2022');

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
