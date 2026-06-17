var dataset = ee.ImageCollection('NASA/ECOSTRESS/L2T_LSTE/V2')
                  .filter(ee.Filter.date('2025-03-01', '2025-05-01'));

var LST = dataset.select('LST').mean();

var vis = {
  min: 285,
  max: 305,
  palette: ['blue', 'yellow', 'red'],
};

Map.addLayer(LST, vis, 'LST');

var image = LST.visualize(vis);

var pixels = 256;

var geometry = ee.Geometry.Polygon(
    [[
      [-120.14496874999998,35.095210464598324],
      [-116.03608203124998,35.1311584928128],
      [-115.97016406249998,32.55840702390209],
      [-120.10102343749998,32.5398856072293],
      [-120.14496874999998,35.095210464598324]
    ]],
    null, false);

var areaOfInterest = geometry;

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'gray'];
var waterLandVis = {palette: backgroundPalette};
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});
var imageWithBackground =
    ee.ImageCollection([waterLandBackground, image]).mosaic();

Map.setCenter(-116.102, 33.634, 8);
Map.addLayer(imageWithBackground)

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));