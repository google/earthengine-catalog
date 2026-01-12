var visParams = {
  min: 0,
  max: 500,
  bands: ['column_amount_o3'],
  palette: [
    '000080', '0000D9', '4000FF', '8000FF', '0080FF',
    '00D9FF', '80FFFF', 'FF8080', 'D90000', '800000'
  ]
};
// thumbnail location
var lon = -60;
var lat = 35;

//Background
var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'lightgray'];
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});


var deltalong = 30;
var deltalat = 25;
var pixels = 256;
var collection = ee.ImageCollection('NASA/TEMPO/O3_L3_QA')
    .filterDate('2024-04-01', '2024-04-05');
var image = collection.mosaic().visualize(visParams);
var imageWithBackground = ee.ImageCollection([waterLandBackground, image]).mosaic();
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - deltalong, lat - deltalat, lon + deltalong, lat + deltalat], null, false);
// Specify the thumbnail parameters.
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};
print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
Map.setCenter(lon, lat, 3)
Map.addLayer(imageWithBackground, {}, 'Total Column Ozone')