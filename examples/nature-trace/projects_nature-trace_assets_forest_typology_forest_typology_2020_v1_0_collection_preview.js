var dataset =
    ee.ImageCollection(
          'projects/nature-trace/assets/forest_typology/forest_typology_2020_v1_0_collection')
        .mosaic();

// Compute argmax class with masking for non-forest areas.
var classified = dataset.toArray().arrayArgmax().arrayGet(0).add(1);
var maxProb = dataset.reduce(ee.Reducer.max());
classified = classified.where(maxProb.eq(0), 6);
classified = classified.mask(classified.lte(5));

var colors = ['1b7837', '7fbf7b', '1d91c0', 'e7298a', 'd95f02', 'ffff00'];
var vis = {min: 1, max: 6, palette: colors};

// Regional view: Africa/Europe showing forest type diversity.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle([-20, -15, 55, 60], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

var backGround = ee.Image(1).visualize({palette: ['lightgray']});
var waterLand =
    ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0).clip(areaOfInterest);
var waterLandBackground =
    waterLand.visualize({palette: ['white', 'lightgray']});

var imageWithBg =
    backGround.blend(waterLandBackground.blend(classified.visualize(vis)));
print(ui.Thumbnail({image: imageWithBg, params: imageParams}));
