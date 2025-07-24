var farmscapes =
    ee.ImageCollection('projects/nature-trace/assets/farmscapes/england_v1_0')
        .mosaic();

var hedgerow = farmscapes.select('B0')
var woodland = farmscapes.select('B2')
var stone_wall = farmscapes.select('B1')

var R = hedgerow;
var G = woodland.add(stone_wall);
var B = hedgerow.add(stone_wall);
var rgb = ee.Image.cat([R, G, B]);

var mask = rgb.reduce(ee.Reducer.sum()).gt(250 / 4);
rgb = rgb.updateMask(mask);

var lon = -1.43;
var lat = 52.973;
Map.setCenter(lon, lat, 15);

// Degrees in EPSG:4326
var lon_delta = 3.45;
var lat_delta = 3.45;
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

var imageWithBg = backGround.blend(waterLandBackground.blend(rgb.visualize()));
print(ui.Thumbnail({image: imageWithBg, params: imageParams}));
