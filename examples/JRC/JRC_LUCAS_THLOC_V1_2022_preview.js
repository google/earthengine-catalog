var dataset = ee.FeatureCollection('JRC/LUCAS/THLOC/V1/2022');
var areaOfInterest = ee.Geometry.Rectangle([
  -9.5517, // minLon
  38.4402, // minLat
  -8.806,  // maxLon
  38.8509  // maxLat
]);

Map.centerObject(areaOfInterest, 10);
var styledPoints = dataset.style({
  color: 'FF0000',
  pointSize: 3,
});

Map.addLayer(styledPoints, {}, 'LUCAS 2022 Points');

// Add a blue outline of the area of interest to the map for clarity.
Map.addLayer(areaOfInterest, {color: '0000FF'}, 'Area of Interest');


// THUMBNAIL GENERATION
var satelliteBackground = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED')
    .filterBounds(areaOfInterest)
    .filterDate('2022-01-01', '2022-12-31')
    .median() // Creates a single, clear composite image
    .visualize({bands: ['B4', 'B3', 'B2'], min: 0, max: 3000}); // True-color visualization

// Combine the satellite background with the styled LUCAS points.
var compositeImage = ee.ImageCollection([satelliteBackground, styledPoints]).mosaic();

var pixels = 256;
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  format: 'png',
};

var thumbnail = ui.Thumbnail({
  image: compositeImage,
  params: imageParams
});

print('Thumbnail of LUCAS 2022 Points near Lisbon, Portugal:', thumbnail);
