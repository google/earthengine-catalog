var dataset = ee.ImageCollection('NASA/ECOSTRESS/L2T_LSTE/V2')
                  .filter(ee.Filter.date('2025-03-01', '2025-05-01'));

var LST = dataset.select('LST').mean();

var vis = {
  min: 294.8999938964844,
  max: 298.4200134277344,
  palette: ['00008B', 'A9A9A9', 'CD853F', 'FFFF00', '90EE90', '006400'],
};
Map.addLayer(LST, vis, 'LST');

var image = LST.visualize(vis);

var pixels = 256;

var geometry = ee.Geometry.Polygon(
    [[
      [-116.93146777343752,33.13894857146559],
      [-115.84382128906252,33.13894857146559],
      [-115.84382128906252,34.08134449438152],
      [-116.93146777343752,34.08134449438152],
      [-116.93146777343752,33.13894857146559]
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

Map.setCenter(-116.102, 33.634, 10);
Map.addLayer(imageWithBackground)

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));