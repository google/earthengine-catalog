var dataset = ee.FeatureCollection("EDF/OGIM/current");

// Prepare visualization
var datasetVis = dataset.style({
  color: "black",
  width: 0.5,
  pointSize: 2,
  fillColor: "FEE135FF"
});

// Background
var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground =
    waterLand.visualize({palette: ['cadetblue', 'lightgray']});
var imageWithBackground = waterLandBackground.blend(datasetVis);

// Visualizing
var region = ee.Geometry.Rectangle([-130, -60, 60, 80], ee.Projection('EPSG:4326'), false);
var pixels = 256;
var imageParams = {
  dimensions: [pixels, pixels],
  region: region,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));