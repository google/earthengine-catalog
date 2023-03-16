var dataset = ee.ImageCollection('VITO/PROBAV/C1/S1_TOC_100M')
                  .filter(ee.Filter.date('2018-03-01', '2018-04-01'));
var falseColor = dataset.select(['RED', 'NIR', 'BLUE']);
var falseColorVis = {
  min: 20.0,
  max: 2000.0,
};
Map.setCenter(17.93, 7.71, 2);
Map.addLayer(falseColor, falseColorVis, 'False Color');
