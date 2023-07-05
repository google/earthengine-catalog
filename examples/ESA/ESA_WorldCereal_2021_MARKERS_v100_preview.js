var dataset = ee.ImageCollection('ESA/WorldCereal/2021/MARKERS/v100')

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'lightgray'];
var waterLandVis = {palette: backgroundPalette};
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

Map.addLayer(waterLandBackground)

// Width and height of the thumbnail image.
var pixels = 256;

// Filter on AEZ
var aez_46173 = dataset.filter('aez_id == 46173');

// Get the active cropland marker for the summer season
var activemarker_summerseason = aez_46173.filter('season == "tc-maize-main"');

// Visualization specifics
var imageVisParam = {
  'bands': ['classification'],
  'min': 0,
  'max': 100,
  'palette': ['eb0000', '37e622']
};

// For the preview
var preview_image = activemarker_summerseason.mosaic(
    ).visualize(imageVisParam);

var image_with_background = ee.ImageCollection(
  [waterLandBackground, preview_image]).mosaic();
Map.addLayer(image_with_background, {}, 'WorldCereal active')

var areaOfInterest = ee.Geometry.Rectangle(
  [-98, 36.5, -97.5, 37]);

print(preview_image)
var imageParams = {
    dimensions: [pixels, pixels],
    region: areaOfInterest,
    crs: 'EPSG:3857',
    format: 'png',
  };


print(ui.Thumbnail({image: image_with_background, params: imageParams}));
