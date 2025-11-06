var dataset = ee.Image(
    'projects/nature-trace/assets/species_distribution_models/australia_mammals/v0');
var species = dataset.select('GreaterGlider');

var occurenceVis = {
  min: 0,
  max: 250,
  palette: [
    '0000FF', '004FFF', '009DFF', '00ECFF', '00FFC4', '00FF75', '00FF27',
    '28FF00', '76FF00', 'C5FF00', 'FFEB00', 'FF9C00', 'FF4E00', 'FF0000'
  ]
};

// Center of Australia
var lon_center = 133.4;
var lat_center = -26.6;

// To correct the aspect ratio in EPSG:4326 at mid-latitudes,
// the degrees of longitude should span a wider range than degrees of latitude
// for a visually square area.
var aspectRatioCorrection = 1.0 / Math.cos(lat_center * Math.PI / 180);

var lat_half_span = 18;  // Degrees of latitude from the center
var lon_half_span =
    lat_half_span * aspectRatioCorrection;  // Adjusted degrees of longitude

var lon_min = lon_center - lon_half_span;
var lon_max = lon_center + lon_half_span;
var lat_min = lat_center - lat_half_span;
var lat_max = lat_center + lat_half_span;

var areaOfInterest =
    ee.Geometry.Rectangle([lon_min, lat_min, lon_max, lat_max], null, false);

var pixels = 256;
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

// Background layers
var backGround =
    ee.Image(1).visualize({palette: ['white']});  // Changed to white
var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground = waterLand.visualize(
    {palette: ['#E0E0E0', '#B0B0B0']});  // Ocean, Land in shades of gray

// Visualize the species layer
var speciesImage = species.visualize(occurenceVis);

// Composite the image: background -> land masses -> species data
// Mask the waterLandBackground so only land is opaque
var landMasK = waterLand.eq(1);
var imageWithBg =
    backGround.blend(waterLandBackground.mask(landMasK)).blend(speciesImage);

// Print the thumbnail to the console
print(ui.Thumbnail({image: imageWithBg, params: imageParams}));