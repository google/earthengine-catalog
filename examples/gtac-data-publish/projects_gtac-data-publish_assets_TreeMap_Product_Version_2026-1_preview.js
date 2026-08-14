// Load the TreeMap image collection.
var dataset = ee.ImageCollection('projects/gtac-data-publish/assets/TreeMap/Product_Version/2026-1');

// Filter to the 2023 CONUS image and convert to a single image.
var treemap = dataset.filter(ee.Filter.calendarRange(2023, 2023, 'year'))
               .filter('study_area == "CONUS"').first();

// Select the FORTYPCD band and apply categorical visualization.
var fortypcdValues = [
  101, 102, 103, 104, 105, 121, 122, 123, 124, 125, 126, 127, 141, 142, 161, 162, 163, 164, 165, 166, 
  167, 171, 182, 184, 185, 201, 202, 221, 222, 224, 225, 226, 241, 261, 262, 263, 264, 265, 266, 267, 
  268, 269, 270, 271, 281, 301, 304, 305, 321, 341, 361, 362, 365, 366, 367, 368, 369, 371, 381, 383, 
  384, 385, 401, 402, 403, 404, 405, 406, 407, 409, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 
  511, 512, 513, 514, 515, 516, 517, 519, 520, 601, 602, 605, 606, 607, 608, 609, 701, 702, 703, 704, 
  705, 706, 707, 708, 709, 722, 801, 802, 805, 809, 901, 902, 903, 904, 905, 911, 912, 921, 922, 923, 
  924, 931, 933, 934, 935, 941, 942, 943, 961, 962, 971, 972, 973, 974, 975, 976, 982, 983, 991, 992, 
  995, 999
];

var fortypcdPalette = [
  '6e26ec', 'c765ec', 'efdbcc', 'a8a9f2', 'd0ce83', '47d0b6', '9d86a6', 'a5f77a', 'dcf4d9', '64e1f7', 
  'afa9b0', 'f2c531', '84d7eb', 'ef4677', '97f2ad', 'd45549', '63f3ac', 'f58de4', 'e9c991', 'ddbef2', 
  'bba847', '95eacd', 'a6827b', 'bca28a', 'cff3f4', 'c1ded5', '948ee9', 'd0ef5b', 'e29af0', 'c34bc3', 
  'e6acb8', 'ea3b34', '724353', 'f2c7a0', '6ab27f', 'f1f3d3', 'ea5aba', 'edc7e1', '4965e2', 'a0f4c4', 
  '5697de', '5defc4', 'e8f384', 'cc63bd', 'e16f3d', 'f5da68', 'a63bcf', '51d0dd', '6bc5b6', 'f2f4a5', 
  '576abe', 'b56f7c', 'dca5ca', '67eff4', 'ca5483', 'a8bf86', 'aff6e9', 'a53394', 'e9e2eb', 'd0cfad', 
  'eee1b3', 'e4db79', 'ec42f6', '7e9f81', '4a7196', '5cd76e', '37999a', 'ed54dd', '6792f0', '82eb3e', 
  'b8db98', 'bccc4b', 'f22ab1', 'f6e095', '77989d', '718640', '9d4f8d', 'c376e4', '7cb133', '5fa7cc', 
  '9ae6e8', 'def3b1', 'b88bf2', 'a5f031', 'eeafa3', '9bd763', 'b838ee', 'e88fbb', 'cce5b9', 'ed8a9c', 
  'c8ed2d', 'f0bd53', '60dad1', 'c790c1', '54c7ef', '8e6a31', 'cecceb', 'b1bef2', 'f077ef', '969aca', 
  'c4ec84', 'efadec', 'da23cf', 'e4c3c0', 'bf90e1', '52f3eb', 'a2c9eb', '3ff451', '6ab7f2', 'b3714c', 
  'd28f25', 'f59550', 'dd82c7', 'c5f2a0', 'e3f2e7', 'b2c2b1', '4ff389', '8772e8', 'bb24a1', 'c7f7cd', 
  '8fc3c6', 'f13896', 'efe92f', '6c48ae', 'b3e8cd', 'e8a882', 'b3e0f0', '6a48de', 'c3ab6e', 'f5f169', 
  'f3c66f', '4ecb89', '60b0c2', '76e45f', 'b3c5ce', 'ee73af', '9473b4', '80d9a8', 'e6a25e', 'f8f3b7', 
  'e67774', 'd5cc36'
];

var fortypcd = treemap.select('FORTYPCD');
var image = fortypcd.remap(fortypcdValues, ee.List.sequence(0, fortypcdValues.length - 1))
  .visualize({
    min: 0,
    max: fortypcdValues.length - 1,
    palette: fortypcdPalette
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

// Mosaic the background under the TreeMap FORTYPCD visualization.
var imageWithBackground =
    ee.ImageCollection([waterLandBackground, image]).mosaic();

// Add composed layer to the map.
Map.addLayer(imageWithBackground, null, 'TreeMap 2023 (FORTYPCD) with background');

// Print a thumbnail preview to the console.
print(ui.Thumbnail({image: imageWithBackground, params: visParams}));