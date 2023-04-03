var dataset = ee.ImageCollection('NOAA/CDR/GRIDSAT-B1/V2')
                  .filter(ee.Filter.date('2017-05-01', '2017-05-14'));
var brightnessTemp = dataset.select(['irwin_cdr', 'vschn', 'irwvp']);
var brightnessTempVis = {
  min: 500.0,
  max: 10000.0,
};
Map.setCenter(7.71, 17.93, 2);
Map.addLayer(brightnessTemp, brightnessTempVis, 'Brightness Temperature');
