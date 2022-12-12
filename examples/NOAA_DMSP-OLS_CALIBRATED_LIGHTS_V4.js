var dataset = ee.ImageCollection('NOAA/DMSP-OLS/CALIBRATED_LIGHTS_V4')
                  .filter(ee.Filter.date('2010-01-01', '2010-12-31'));
var nighttimeLights = dataset.select('avg_vis');
var nighttimeLightsVis = {
  min: 3.0,
  max: 60.0,
};
Map.setCenter(7.82, 49.1, 4);
Map.addLayer(nighttimeLights, nighttimeLightsVis, 'Nighttime Lights');
