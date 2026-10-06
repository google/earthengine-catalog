// RADD Forest Disturbance Alerts preview.

// Representative area in the Peruvian Amazon.
var region = ee.Geometry.Rectangle([
  -75.65, -6.65,
  -75.35, -6.35,
]);

var radd = ee.ImageCollection('projects/radar-wur/raddalert/v1');

// Select the latest South America alert image.
var raddAlert = ee.Image(
  radd
    .filterMetadata('layer', 'contains', 'alert')
    .filterMetadata('geography', 'equals', 'sa')
    .sort('system:time_end', false)
    .first()
);

// Visualize alert confidence:
// 2 = unconfirmed (low confidence)
// 3 = confirmed (high confidence)
var visualizedAlert = raddAlert.select('Alert').visualize({
  min: 2,
  max: 3,
  palette: ['0000FF', 'FF7F50'],
});

// Simple cloud/shadow mask for Sentinel-2 SR.
function maskS2(image) {
  var scl = image.select('SCL');
  var mask = scl.neq(3)   // cloud shadow
    .and(scl.neq(8))      // cloud medium probability
    .and(scl.neq(9))      // cloud high probability
    .and(scl.neq(10))     // thin cirrus
    .and(scl.neq(11));    // snow/ice
  return image.updateMask(mask);
}

// Build a dark Sentinel-2 background composite.
var s2 = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED')
  .filterBounds(region)
  .filterDate('2023-01-01', '2024-12-31')
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 40))
  .map(maskS2)
  .median()
  .clip(region);

// Dark RGB rendering.
var background = s2.visualize({
  bands: ['B4', 'B3', 'B2'],
  min: 200,
  max: 3000,
  gamma: 1.3,
});

// Combine Sentinel-2 background and RADD alerts.
var imageWithBackground = ee.ImageCollection([
  background,
  visualizedAlert,
]).mosaic();

var imageParams = {
  region: region,
  dimensions: '256x256',
  format: 'png',
};

print(ui.Thumbnail({
  image: imageWithBackground,
  params: imageParams,
}));