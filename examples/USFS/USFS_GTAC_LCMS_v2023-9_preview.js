var dataset = ee.ImageCollection('projects/lcms-292214/assets/Final_Outputs/2023-9/LCMS');

var lcms = dataset.filter(ee.Filter.calendarRange(2022, 2022,'year'))  // range: [1985, 2023]
               .filter('study_area == "CONUS"')  // or "SEAK" ("PRUSVI" and "HAWAII" available late summer 2024)

var landCover = lcms.select('Land_Cover').first()

// Retrieve color palette for Land Cover from deprecated product 
var lcms_v2022 = ee.ImageCollection('USFS/GTAC/LCMS/v2022-8').filter(ee.Filter.eq('study_area', 'CONUS'))
var lcms_v2022_props = lcms_v2022.first().toDictionary()
var landcover_palette = lcms_v2022_props.get('Land_Cover_class_palette')

// Center thumbnail
var lon = -96.5;
var lat = 38;

// Background 
var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'lightgray'];
// var waterLandVis = {palette: backgroundPalette};
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});


// Degrees in EPSG:5070
var delta = 21.5;
// Width and height of the thumbnail image.
var pixels = 512;

var areaOfInterest = ee.Geometry.Rectangle(
[lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
dimensions: [pixels, pixels],
region: areaOfInterest,
crs: 'EPSG:5070',
format: 'png',
};

var image = landCover.visualize({min:1,max:15,palette: landcover_palette});
var imageWithBackground = ee.ImageCollection([
waterLandBackground, image]).mosaic();

Map.addLayer(imageWithBackground, null, 'LCMS Land Cover');

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
