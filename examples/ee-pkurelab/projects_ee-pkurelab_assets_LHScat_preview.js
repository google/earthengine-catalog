// Load the LHScat ImageCollection and filter it to a specific time window.
var LHScat = ee.ImageCollection("projects/ee-pkurelab/assets/LHScat")
               .filterDate("2020-03-01", "2020-04-01");

// Reduce the collection to a single representative image.
var signals = LHScat.mean();

var region = ee.Geometry.Rectangle([73, 8, 150, 54]);

// Print a ui.Thumbnail widget in the console (for visual preview).
var thumb = ui.Thumbnail({
  image: signals,
  params: {
    min: -2000,
    max: 500,
    palette: ['green', 'yellow', 'red', 'firebrick'],
    dimensions: 512,
    format: 'png',
    region: region,
  },
  style: {width: '256px', height: '256px', position: 'bottom-left'}
});

print('Thumbnail preview:', thumb);