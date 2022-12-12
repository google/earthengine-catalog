var dataset = ee.ImageCollection('NOAA/CDR/AVHRR/SR/V5')
                  .filter(ee.Filter.date('2018-05-01', '2018-06-01'));
var surfaceReflectance = dataset.select('SREFL_CH1');
var surfaceReflectanceVis = {
  min: -1000.0,
  max: 9000.0,
  palette: ['003b02', '006a03', '008d05', '01be07', '01ff09', 'ffffff'],
};
Map.setCenter(52.48, 71.72, 1);
Map.addLayer(surfaceReflectance, surfaceReflectanceVis, 'Surface Reflectance');
