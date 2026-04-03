// Load the LHScat ImageCollection and filter it to a specific time window.
var LHScat = ee.ImageCollection("projects/ee-pkurelab/assets/LHScat")
               .filterDate("2020-03-01", "2020-04-01");

// Reduce the collection to a single representative image.
var signals = LHScat.mean();

var region = ee.Geometry.Rectangle([73, 8, 150, 54]);

// Visualization parameters for the radar singles signal.
var visParams_signals = {
  min: -2000,
  max: 500,
  palette: ['green', 'yellow', 'red', 'firebrick']
};

// Center the map on the image footprint.
Map.centerObject(region, 4);

// Add the layer to the map for interactive preview.
Map.addLayer(signals, visParams_signals, 'LHScat radar singles (2020-03)');

