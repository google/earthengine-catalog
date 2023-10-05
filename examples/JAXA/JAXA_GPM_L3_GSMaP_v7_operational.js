var dataset = ee.ImageCollection('JAXA/GPM_L3/GSMaP/v7/operational')
                  .filter(ee.Filter.date('2023-09-10', '2023-09-11'));
var precipitation = dataset.select('hourlyPrecipRate');
var precipitationVis = {
  min: 0.0,
  max: 10.0,
  palette:
      ['1621a2', 'ffffff', '03ffff', '13ff03', 'efff00', 'ffb103', 'ff2300'],
};
Map.setCenter(-90.7, 26.12, 3);
Map.addLayer(precipitation, precipitationVis, 'Precipitation');