var dataset = ee.ImageCollection('ESA/WorldCereal/2021/MODELS/v100')

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'lightgray'];
var waterLandVis = {palette: backgroundPalette};
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

Map.addLayer(waterLandBackground)

// Width and height of the thumbnail image.
var pixels = 256;

function mask_other(img) {
  return img.updateMask(img.neq(0))
}

// Apply the mask_other function to the collection
dataset = dataset.map(mask_other).select('classification');

// Get a global mosaic for all AEZ of temporary crops
var temporarycrops = dataset.filter(
  ee.Filter.eq('product', 'temporarycrops')
  ).mosaic();

// Get a global mosaic for all AEZ and seasons of maize and remap to unique value
var maize = dataset.filter(
  ee.Filter.eq('product', 'maize')
  ).mosaic().remap([100], [150]).select('remapped').rename('classification').cast({'classification': 'uint8'});

// Get a global mosaic for all AEZ and seasons of wintercereals and remap to unique value
var wintercereals = dataset.filter(
  ee.Filter.eq('product', 'wintercereals')
  ).mosaic().remap([100], [200]).select('remapped').rename('classification').cast({'classification': 'uint8'});

// Visualization specifics
var imageVisParam = {
  "bands": ["classification"],
  "min":100,
  "max":200,
  "palette":["ff0000","fff80c","dc981c"]
};

// For the preview, create a collection of all these and mosaic
var preview_image = ee.ImageCollection(
  [wintercereals, maize, temporarycrops]).mosaic(
    ).visualize(imageVisParam);

var image_with_background = ee.ImageCollection(
  [waterLandBackground, preview_image]).mosaic();
Map.addLayer(image_with_background, {}, 'WorldCereal products')

var areaOfInterest = ee.Geometry.Rectangle(
  [-10, 30, 30, 60]);

print(preview_image)
var imageParams = {
    dimensions: [pixels, pixels],
    region: areaOfInterest,
    crs: 'EPSG:3857',
    format: 'png',
  };


print(ui.Thumbnail({image: image_with_background, params: imageParams}));
