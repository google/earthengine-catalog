// Define the area of interest (AOI) around the new center
var lon = 13.80;
var lat = 5.0;
var delta = 40;
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

// Create a global waterLand image
var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground =
    waterLand.visualize({palette: ['cadetblue', 'lightgray']});

// Load the dataset
var image =
    ee.Image('ISRIC/SoilGrids250m/v2_0/wv0010').select('val_0_5cm_Q0_95');

var imageVis = {
  min: -0.061,
  max: 0.636,
  palette: [
    '#440154', '#482878', '#3E4A89', '#31688E', '#26828E', '#1F9E89', '#35B779',
    '#6DCD59', '#B4DE2C', '#FDE725'
  ]
};

var clippedImage = image.visualize(imageVis).clip(areaOfInterest);

// Blend the clipped image with the waterLandBackground
var blendedLayer = waterLandBackground.blend(clippedImage);

Map.setCenter(lon, lat, 3);
Map.addLayer(blendedLayer, {}, 'SoilGrids250m 10kPa Q0.95 0-5cm');

// Define parameters for the thumbnail image
var pixels = 256;
var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

// Display the thumbnail of the blended layer at zoom level 7
print(ui.Thumbnail({
  image: blendedLayer,
  params: visParams,
}));