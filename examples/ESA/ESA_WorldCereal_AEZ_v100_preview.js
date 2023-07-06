var aez = ee.FeatureCollection('ESA/WorldCereal/AEZ/v100');

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground =
    waterLand.visualize({palette: ['cadetblue', 'lightgray']});
Map.addLayer(waterLandBackground);

var aezImage = ee.Image().byte();
var aezOutlines =
    aezImage.paint({featureCollection: aez, color: '000000', width: 3});
Map.addLayer(aezOutlines);

var pixels = 256;
var areaOfInterest = ee.Geometry.Rectangle([-10, 30, 30, 60]);
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};
var imageWithBg = waterLandBackground.blend(aezOutlines);
print(ui.Thumbnail({image: imageWithBg, params: imageParams}));
