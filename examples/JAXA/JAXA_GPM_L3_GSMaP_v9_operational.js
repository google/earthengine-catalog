var dataset = ee.ImageCollection('JAXA/GPM_L3/GSMaP/v9/operational')
                  .filter(ee.Filter.date('2026-10-18', '2026-10-19'));
var precipitation = dataset.select('hourlyPrecipRate');
var precipitationVis = {
  min: 0.0,
  max: 10.0,
  palette:
      ['1621a2', 'ffffff', '03ffff', '13ff03', 'efff00', 'ffb103', 'ff2300'],
};
Map.setCenter(-90.7, 26.12, 3);
Map.addLayer(precipitation, precipitationVis, 'Precipitation');
