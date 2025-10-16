var probabilities =
    ee.ImageCollection(
          'projects/nature-trace/assets/forest_typology/natural_forest_2020_v1_0_collection')
        .mosaic()
        .select('B0');
var image = probabilities.mask(probabilities.neq(0));
var vis = {min: 0, max: 250, palette: ['white', 'green']}

          Map.addLayer(image, vis, 'Natural forests 2020')

var lon = -30
var lat = 10;
Map.setCenter(lon, lat, 3);

// Degrees in EPSG:4326
var lon_delta = 64;
var lat_delta = 64;
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - lon_delta, lat - lat_delta, lon + lon_delta, lat + lat_delta], null,
    false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

var backGround = ee.Image(1).visualize({palette: ['lightgray']})
var waterLand = ee.Image('NOAA/NGDC/ETOPO1')
                    .select('bedrock')
                    .gt(0.0)
                    .clip(ee.Geometry.BBox(-180, -55, 180, 75));
var waterLandBackground =
    waterLand.visualize({palette: ['white', 'lightgray']});

var imageWithBg =
    backGround.blend(waterLandBackground.blend(image.visualize(vis)));
print(ui.Thumbnail({image: imageWithBg, params: imageParams}));