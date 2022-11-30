var dataset = ee.ImageCollection('JAXA/GPM_L3/GSMaP/v6/operational')
                  .filter(ee.Filter.date('2018-08-06', '2018-08-07'));
var precipitation = dataset.select('hourlyPrecipRate');
var precipitationVis = {
  min: 0.0,
  max: 30.0,
  palette:
      ['1621a2', 'ffffff', '03ffff', '13ff03', 'efff00', 'ffb103', 'ff2300'],
};
Map.setCenter(-90.7, 26.12, 2);
Map.addLayer(precipitation, precipitationVis, 'Precipitation');
