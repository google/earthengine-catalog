// Load the LHScat ImageCollection and filter it to a specific time window.
var LHScat = ee.ImageCollection("projects/ee-pkurelab/assets/LHScat")
               .filterDate("2020-03-01", "2020-04-01");

// Reduce the collection to a single representative image.
var signals = LHScat.mean();

// Visualization parameters for the radar singles signal.
var visParams_signals = {
  min: -2000,
  max: 500,
  palette: ['green', 'yellow', 'red', 'firebrick']
};

// Center the map on the image footprint.
Map.centerObject(signals, 4);

// Add the layer to the map for interactive preview.
Map.addLayer(signals, visParams_signals, 'LHScat radar singles (2020-03)');


// Preview script: generate a thumbnail for the catalog
var chinaRegion = ee.Geometry.Rectangle({
  coords: [73.0, 18.0, 135.0, 54.0],   
  geodesic: false
});

// Print a ui.Thumbnail widget in the console (for visual preview).
var thumb = ui.Thumbnail({
  image: signals,
  params: {
    min: -2000,
    max: 500,
    palette: ['green', 'yellow', 'red', 'firebrick'],
    region: chinaRegion,
    dimensions: 512,
    format: 'png'
  },
  style: {width: '256px', height: '256px', position: 'bottom-left'}
});

print('Thumbnail preview:', thumb);