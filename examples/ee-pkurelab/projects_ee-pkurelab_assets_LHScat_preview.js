// Load the LHScat ImageCollection and filter it to a specific time window.
var LHScat = ee.ImageCollection("projects/ee-pkurelab/assets/LHScat")
               .filterDate("2020-03-01", "2020-04-01");

// Reduce the collection to a single representative image.
var signals = LHScat.select('radar_signals').mean();

var visParams = {
  min: -2000,
  max: 500,
  palette: ['green', 'yellow', 'red', 'firebrick']
};

var region = ee.Geometry.Rectangle([73, 8, 150, 54], null, false);

// Create a background to avoid transparency issues.
var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var background = waterLand.visualize({palette: ['cadetblue', 'lightgray']});

var rgbImage = signals.visualize(visParams);
var imageWithBackground = ee.ImageCollection([background, rgbImage]).mosaic().toInt();

print(ui.Thumbnail({
  image: imageWithBackground,
  params: {
    dimensions: 256,
    format: 'png',
    region: region,
    crs: 'EPSG:3857',
  }
}));
