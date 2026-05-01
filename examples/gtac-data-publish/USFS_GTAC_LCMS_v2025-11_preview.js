// Load the LCMS image collection.
var dataset = ee.ImageCollection('projects/gtac-data-publish/assets/LCMS/Product_Version/2025-11');

// Filter to the 2024 CONUS image and convert to a single image.
var lcms = dataset.filter(ee.Filter.calendarRange(2024, 2024,'year'))  // range: [1985, 2025]
               .filter('study_area == "CONUS"').first()  // "AK"

// Select the land cover band and apply default visualization.
var landCover = lcms.select('Land_Cover');
var image = landCover.visualize();

// Center point used for map display and preview AOI.
var lon = -112;
var lat = 41;

// Center the interactive map for quick inspection.
Map.setCenter(lon, lat, 10);

// Create a simple land/water background from ETOPO bedrock elevation.
var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0);
var backgroundPalette = ['cadetblue', 'lightgray'];
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

// Rectangle half-width/half-height in degrees around the center point.
var lonDelta = 2;
var latDelta = 1.5;
// Width and height of the thumbnail image.
var pixels = 512;

// Build the export/thumbnail region.
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - lonDelta, lat - latDelta, lon + lonDelta, lat + latDelta],
    null,
    false);

// Thumbnail rendering parameters.
var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

// Mosaic the background under the LCMS land cover visualization.
var imageWithBackground =
    ee.ImageCollection([waterLandBackground, image]).mosaic();

// Add composed layer to the map.
Map.addLayer(imageWithBackground, null, 'Land Cover with background');

// Print a thumbnail preview to the console.
print(ui.Thumbnail({image: imageWithBackground, params: visParams}));
