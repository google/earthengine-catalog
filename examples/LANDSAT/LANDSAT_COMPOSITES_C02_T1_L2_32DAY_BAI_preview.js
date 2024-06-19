var dataset = ee.ImageCollection('LANDSAT/COMPOSITES/C02/T1_L2_32DAY_BAI')
                  .filterDate('2023-01-01', '2023-03-01');
var burnedArea = dataset.select('BAI').max();

var burnedAreaVis = {
  min: 0.0,
  max: 100.0,
};
Map.setCenter(21.6, -18, 8);
Map.addLayer(burnedArea, burnedAreaVis, 'Burned Area');
var lon = 25.0607;
var lat = -17.394;
var delta = 0.05;


var pixels = 256;
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var backGround = ee.Image.constant(1).visualize({palette:['808080'],min:0,max:1})


var image1 = burnedArea.visualize(burnedAreaVis);

var imageWithBackground = ee.ImageCollection([backGround,image1]).mosaic();
Map.addLayer(image1, null, 'burnedArea');

Map.setCenter(21.6, -18, 8);
print(ui.Thumbnail({image: image1, params: visParams}));