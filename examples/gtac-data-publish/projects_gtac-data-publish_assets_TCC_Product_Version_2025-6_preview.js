// Load NLCD Tree Canopy Cover (TCC) image collection.
var dataset = ee.ImageCollection('projects/gtac-data-publish/assets/TCC/Product_Version/2025-6');

// Keep only the 2024 CONUS image and convert to a single image.
var tcc = dataset.filter(ee.Filter.calendarRange(2024, 2024,'year'))  // range: [1985, 2025]
               .filter(ee.Filter.inList('study_area', ['AK', 'CONUS']))  // CONUS and AK
               .mosaic();
               
// Color ramp for canopy cover visualization (low to high cover).
var tcc_palette = [
    'CDA066',
    'D7C29E',
    'C2D096',
    'B7D692',
    'ADDD8E',
    '78C679',
    '5CB86B',
    '41AB5D',
    '39A156',
    '329750',
    '238443',
    '11763D',
    '006837',
    '004529'
  ]
  
// Select the NLCD canopy cover band.
var nlcd_tcc = tcc.select('NLCD_Percent_Tree_Canopy_Cover')

// Boundary of study areas to mask TCC data from waterLandBackground mask
var studyAreasBoundary = nlcd_tcc.mask().neq(1)

// Mask out zero values so only mapped canopy cover is shown.
var msk = nlcd_tcc.neq(0)
nlcd_tcc = nlcd_tcc.updateMask(msk)

// Build a land/water background layer used behind the canopy image.
var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var groundPalette = ['CDA066'];
var landBackground = waterLand.visualize({palette: groundPalette});

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'lightgrey'];
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});
waterLandBackground = waterLandBackground.updateMask(studyAreasBoundary)

// Load LCMS to derive a water mask from the land cover class.
var dataset = ee.ImageCollection("projects/gtac-data-publish/assets/LCMS/Product_Version/2025-11")
var lcms = dataset.filterDate('2024', '2025')  // range: [1985, 2025]
               .filter(ee.Filter.inList('study_area', ['AK', 'CONUS']))  // CONUS and AK
               .mosaic();

// Class 14 is water in the LCMS Land_Cover band.
var waterMsk = lcms.select('Land_Cover').eq(14).selfMask()
var waterMskBackground = waterMsk.visualize({palette: ['cadetblue']});

// Map center used to define a rectangular preview area.
var lon = -112;
var lat = 41;

// Rectangle half-width/half-height in degrees around the center point.
var lonDelta = 2;
var latDelta = 1.5;
// Initial pixel size (overridden below by the final export size).
var pixels = 512;

// Build area of interest from the center point and deltas.
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - lonDelta, lat - latDelta, lon + lonDelta, lat + latDelta],
    null,
    false);

// Final thumbnail dimensions.
var pixels = 1024;
    
// Thumbnail/export parameters.
var imageParams = {
dimensions: [pixels, pixels],
region: areaOfInterest,
crs: 'EPSG:5070',
format: 'png',
};

// Visualize canopy cover and mosaic it over custom land/water backgrounds.
var image = nlcd_tcc.visualize({min:0,max:60,palette: tcc_palette});
var imageWithBackground = ee.ImageCollection([landBackground,waterLandBackground,waterMskBackground,image]).mosaic();

// Add the final composed image to the map.
Map.addLayer(imageWithBackground, null, 'NLCD Percent Tree Canopy Cover');

Map.setCenter(-98.58, 38.14, 4);

// Print a thumbnail preview in the console.
print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));

