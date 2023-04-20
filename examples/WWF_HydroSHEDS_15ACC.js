var dataset = ee.Image('WWF/HydroSHEDS/15ACC');
var flowAccumulation = dataset.select('b1');
var flowAccumulationVis = {
  min: 0.0,
  max: 500.0,
  palette: [
    '000000', '023858', '006837', '1a9850', '66bd63', 'a6d96a', 'd9ef8b',
    'ffffbf', 'fee08b', 'fdae61', 'f46d43', 'd73027'
  ],
};
Map.setCenter(-121.652, 38.022, 8);
Map.addLayer(flowAccumulation, flowAccumulationVis, 'Flow Accumulation');