var dataset = ee.ImageCollection('JRC/GHSL/P2016/POP_GPW_GLOBE_V1')
                  .filter(ee.Filter.date('2015-01-01', '2015-12-31'));
var populationCount = dataset.select('population_count');
var populationCountVis = {
  min: 0.0,
  max: 200.0,
  palette: ['060606', '337663', '337663', 'ffffff'],
};
Map.setCenter(78.22, 22.59, 3);
Map.addLayer(populationCount, populationCountVis, 'Population Count');
