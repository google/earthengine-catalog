var dataset=ee.ImageCollection('NASA/FLDAS/NOAH01/C/GL/M/V001')
              .filter(ee.Filter.date('2018-11-01', '2018-12-01'));
var layer = dataset.select('Evap_tavg');

var band_viz = {
  min: 0.0,
  max: 0.00005,
  opacity: 1.0,
  palette: ["black", "blue", "purple", "cyan", "green", "yellow", "red"]
};

Map.setCenter(30.0, 30.0, 2);
Map.addLayer(layer, band_viz, 'Average Evapotranspiration');

