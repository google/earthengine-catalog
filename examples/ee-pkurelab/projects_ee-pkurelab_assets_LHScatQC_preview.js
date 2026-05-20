var LHScat_QC = ee.Image("projects/ee-pkurelab/assets/LHScatQC");

// Select the RMSE band and scale it (original values are 0-1)
// We convert the result to an int band to make sure the visualization is RGB
var RMSE = LHScat_QC.select('RMSE').multiply(100).toInt();

var visParams_RMSE = {
  min: 0,
  max: 100,
  palette: ['green', 'yellow', 'red', 'firebrick']
};

var region = ee.Geometry.Rectangle([73, 8, 150, 54], null, false);

// Create a background to avoid transparency issues.
var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var background = waterLand.visualize({palette: ['cadetblue', 'lightgray']});

var rgbImage = RMSE.visualize(visParams_RMSE);
var imageWithBackground = ee.ImageCollection([background, rgbImage]).mosaic();

print(ui.Thumbnail({
  image: imageWithBackground,
  params: {
    dimensions: 256,
    format: 'png',
    region: region,
    crs: 'EPSG:3857',
  }
}));
