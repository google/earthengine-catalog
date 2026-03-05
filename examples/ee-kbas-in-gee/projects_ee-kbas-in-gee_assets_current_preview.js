//Area of interest (Americas)
var lon = -65
var lat = -20
var delta = 40

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

//Load the KBA polygons
var kbas = ee.FeatureCollection("projects/ee-kbas-in-gee/assets/current");

//Set visualization parameters
var kbaStyled = kbas.style ({
  color: '006400', //dark green outline
  width: 0.5, 
  fillColor: '00640080' //green with 50% transparency (last two chars = alpha)
});

var land = ee.FeatureCollection("USDOS/LSIB_SIMPLE/2017");

var ocean = ee.Image.constant(0).visualize({palette: ['#bfe7ff']}); // pale blue

var landMask = ee.Image().byte().paint(land, 1).selfMask();
var landVis = landMask.visualize({palette: ['#fffdd0']}); // cream

//Create a global white image
var globalWhiteImage = ee.Image(1).paint(ee.Geometry.Polygon(
    [[[-180, -90], [180, -90], [180, 90], [-180, 90]]]), 0)
    .visualize({palette: ['ffffff'], min: 0, max: 1});
    
var clippedWhiteImage = globalWhiteImage.clip(areaOfInterest);    

// Define parameters for the thumbnail image
var pixels = 256;
var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

// Blend the clipped white image with the clipped MODIS land cover image
var blendedLayer = ocean.blend(landVis).blend(kbaStyled);

// Display the thumbnail of the blended layer
print(ui.Thumbnail({image: blendedLayer, params: visParams}));