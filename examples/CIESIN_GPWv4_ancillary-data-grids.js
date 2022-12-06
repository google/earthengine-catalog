var dataset = ee.Image('CIESIN/GPWv4/ancillary-data-grids');
var zeroPopulationAreas = dataset.select('data-context');
var zeroPopulationAreasVis = {
  min: 201.0,
  max: 205.0,
  palette: ['099506', 'ff0b00', '060606', 'a5a5a5', 'ffe152'],
};
Map.setCenter(-3.3, 36.03, 1);
Map.addLayer(
    zeroPopulationAreas, zeroPopulationAreasVis, 'Zero Population Areas');
