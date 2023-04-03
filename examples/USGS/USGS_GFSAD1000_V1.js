var dataset = ee.Image('USGS/GFSAD1000_V1');
var cropMask = dataset.select('landcover');
var cropMaskVis = {
  min: 0.0,
  max: 5.0,
  palette: ['black', 'orange', 'brown', '02a50f', 'green', 'yellow'],
};
Map.setCenter(-17.22, 13.72, 2);
Map.addLayer(cropMask, cropMaskVis, 'Crop Mask');
