// Load the TreeMap image collection.
var dataset = ee.ImageCollection('projects/gtac-data-publish/assets/TreeMap/Product_Version/2026-1');

// Filter to the 2023 CONUS image and convert to a single image.
var treemap = dataset.filter(ee.Filter.calendarRange(2023, 2023, 'year'))
               .filter('study_area == "CONUS"').first();

// Select the TPA_LIVE band and apply the defined visualization.
var palette_bamako = ['00404d','134b42','265737','3a652a','52741c','71870b','969206','c5ae32','e7cd68','ffe599'];
var bamako_r = palette_bamako.slice().reverse();
var tpaLive = treemap.select('TPA_LIVE');
var image = tpaLive.visualize({
  min: 252,
  max: 1666,
  palette: bamako_r
});

// Center point used for map display and preview AOI.
var lon = -110.4;
var lat = 40.8;

// Center the interactive map for quick inspection.
Map.setCenter(lon, lat, 11);

// Create a simple land/water background from ETOPO bedrock elevation.
var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0);
var backgroundPalette = ['cadetblue', 'whitesmoke'];
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

// Rectangle half-width/half-height in degrees around the center point.
// Decrease these values to zoom in farther for the thumbnail export.
var lonDelta = 1;
var latDelta = 0.75;
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

// Mosaic the background under the TreeMap TPA_LIVE visualization.
var imageWithBackground =
    ee.ImageCollection([waterLandBackground, image]).mosaic();

// Add composed layer to the map.
Map.addLayer(imageWithBackground, null, 'TreeMap 2023 (TPA_LIVE) with background');

// Print a thumbnail preview to the console.
print(ui.Thumbnail({image: imageWithBackground, params: visParams}));