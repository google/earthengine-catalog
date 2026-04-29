var Collection = ee.ImageCollection('projects/ee-potapovpeter/assets/LATAM_WVSC/latam_v1')
   .filter(ee.Filter.eq('year', 2024));

var Year_2024 = Collection.first();

var TCH2024 = Year_2024.select(['TCH']);

var TCH2024masked = TCH2024.updateMask(TCH2024.gte(20));

var vis = {
  "min":20, 
  "max": 300,
  "palette": ['8a35ac','466be3','28bceb','32f298','a4fc3c','eecf3a','fb7e21','d02f05','7a0403']
};

Map.addLayer(TCH2024masked, vis, 'WVCH 2024', 1, 1)

var lat=-59.6837;
var lon=-7.164;

Map.setCenter(lat, lon, 12);

// Width and height of the thumbnail image.
var pixels = 256;
var areaOfInterest =
    ee.Geometry.Rectangle([-55.6389, -4.4034, -55.5489, -4.3134], null, false);
  
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
    
var imageWithBg = backGround.blend(waterLandBackground.blend(TCH2024masked.visualize(vis)));

print(ui.Thumbnail({image: imageWithBg, params: parameters}));