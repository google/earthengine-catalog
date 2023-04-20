var dataset =
    ee.ImageCollection('CIESIN/GPWv4/unwpp-adjusted-population-count');
var populationCount = dataset.select('population-count')
  .filter(ee.Filter.date('2010-01-01', '2010-12-31'));
var populationCountVis = {
  min: 200.0,
  max: 1000.0,
  palette: ['ffffff', 'ffcdc6', 'ff0000', '950000'],
};
Map.setCenter(79.1, 19.81, 3);
Map.addLayer(populationCount, populationCountVis, 'Population Count');
