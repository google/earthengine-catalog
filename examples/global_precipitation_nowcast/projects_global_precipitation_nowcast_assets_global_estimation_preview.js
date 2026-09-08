var imageCollection = ee.ImageCollection(
  "projects/global-precipitation-nowcast/assets/global_estimation"
);

// Select a single estimate.
var single_estimate = imageCollection.filterDate('2022-12-30T12-00').first(); 
// mask to remove 0 values
var masked = single_estimate.selfMask();

var lon = 8;
var lat = 2;
Map.setCenter(lon, lat, 2);

// Degrees in EPSG:4326
var lon_delta = 50;
var lat_delta = 50;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - lon_delta, lat - lat_delta, lon + lon_delta, lat + lat_delta], null,
    false);


// Display on map.
var visParams = {
  min: 0,
  max: 15,
  palette: [
    '000096','0064ff', '00b4ff', '33db80', '9beb4a',
    'ffeb00', 'ffb300', 'ff6400', 'eb1e00', 'af0000'
  ]
};

var imageVisualized = masked.visualize(visParams);

var countryOutlines = ee.FeatureCollection('USDOS/LSIB_SIMPLE/2017');
var outlinesStyle = {
  fillColor: 'FFFFFF',
  color: '000000',
  width: 2,
};
var countries = countryOutlines.style(outlinesStyle);
var landWaterBackground = countries.visualize();

// Combine the precipitation visualization with the country outlines.
var combinedVisual = landWaterBackground.blend(imageVisualized);

Map.addLayer(combinedVisual, {}, 'Precipitation with country boundaries');

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: combinedVisual, params: imageParams}));