var dataset = ee.ImageCollection('CIESIN/GPWv4/population-density');
var populationDensity = dataset.select('population-density')
  .filter(ee.Filter.date('2010-01-01', '2010-12-31'));
var populationDensityVis = {
  min: 200.0,
  max: 1500.0,
  palette: ['ffffff', 'ffcdc6', 'ff0000', '950000'],
};
Map.setCenter(79.1, 19.81, 3);
Map.addLayer(populationDensity, populationDensityVis, 'Population Density');
