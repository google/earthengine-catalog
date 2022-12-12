var dataset = ee.ImageCollection('JAXA/GPM_L3/GSMaP/v6/reanalysis')
                  .filter(ee.Filter.date('2014-02-01', '2014-02-02'));
var precipitation = dataset.select('hourlyPrecipRate');
var precipitationVis = {
  min: 0.0,
  max: 30.0,
  palette:
      ['1621a2', 'ffffff', '03ffff', '13ff03', 'efff00', 'ffb103', 'ff2300'],
};
Map.setCenter(-90.7, 26.12, 2);
Map.addLayer(precipitation, precipitationVis, 'Precipitation');
