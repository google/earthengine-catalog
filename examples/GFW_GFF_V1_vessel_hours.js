var dataset = ee.ImageCollection('GFW/GFF/V1/vessel_hours')
                  .filter(ee.Filter.date('2016-12-01', '2017-01-01'));
var trawlers = dataset.select('trawlers');
var trawlersVis = {
  min: 0.0,
  max: 5.0,
};
Map.setCenter(130.61, 34.287, 8);
Map.addLayer(trawlers.max(), trawlersVis, 'Trawlers');
