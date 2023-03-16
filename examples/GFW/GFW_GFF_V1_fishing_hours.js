var dataset = ee.ImageCollection('GFW/GFF/V1/fishing_hours')
                  .filter(ee.Filter.date('2016-12-01', '2017-01-01'));
var trawlers = dataset.select('trawlers');
var trawlersVis = {
  min: 0.0,
  max: 5.0,
};
Map.setCenter(16.201, 36.316, 7);
Map.addLayer(trawlers.max(), trawlersVis, 'Trawlers');
