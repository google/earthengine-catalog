var drivers = ee.Image('projects/landandcarbon/assets/wri_gdm_drivers_forest_loss_1km/v1_2001_2022');

var drivers_class = drivers.select(['classification'])

var vis = {
  "min":1, 
  "max": 7,
  "palette": ['E39D29','E58074','e9d700','51a44e','895128','a354a0','3a209a']
};

Map.addLayer(drivers_class, vis, 'Drivers of Forest Loss, 2001-2022')

var lon = -30
var lat = 10

Map.setCenter(lon, lat, 3);

// Degrees in EPSG:4326
var delta = 64;
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);
  
var parameters = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png'
};

var backGround = ee.Image(1).visualize({palette: ['lightgray']})
var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0).clip(
  ee.Geometry.BBox(-180, -55, 180, 75));
var waterLandBackground =
    waterLand.visualize({palette: ['white', 'lightgray']});
    
var imageWithBg = backGround.blend(waterLandBackground.blend(drivers_class.visualize(vis)));

print(ui.Thumbnail({image: imageWithBg, params: parameters}));