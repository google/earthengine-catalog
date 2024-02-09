// Import the tree canopy cover collection
var dataset = ee.ImageCollection('USGS/NLCD_RELEASES/2021_REL/TCC/v2021-4');

//Filter collection to 2021 and CONUS study area 
var tcc = dataset.filter(ee.Filter.calendarRange(2021, 2021,'year'))  // range: [2008, 2021]
               .filter('study_area == "CONUS"')  // or "AK", "PRUSVI", "HAWAII" 
               .first();
               
// TCC palette
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

// SE palette 
var se_palette = [
    '000000',
    'FFFFFF',
    ]

// Select nlcd tcc band 
var nlcd_tcc = tcc.select('NLCD_Percent_Tree_Canopy_Cover')

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

var image = nlcd_tcc.visualize({min:0,max:60,palette: tcc_palette});
var imageWithBackground = ee.ImageCollection([
waterLandBackground, image]).mosaic();

Map.addLayer(imageWithBackground, null, 'NLCD Percent Tree Canopy Cover');

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
