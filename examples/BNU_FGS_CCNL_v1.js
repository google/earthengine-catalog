var dataset = ee.ImageCollection('BNU/FGS/CCNL/v1')
                  .filter(ee.Filter.date('2010-01-01', '2010-12-31'));
var nighttimeLights = dataset.select('b1');
var nighttimeLightsVis = {
  min: 3.0,
  max: 60.0,
};
Map.setCenter(31.4, 30, 6);
Map.addLayer(nighttimeLights, nighttimeLightsVis, 'Nighttime Lights');
