var dataset = ee.ImageCollection('TRMM/3B42')
                  .filter(ee.Filter.date('2018-04-01', '2018-04-10'));
var precipitation =
    dataset.select(['precipitation', 'HQprecipitation', 'IRprecipitation']);
var precipitationVis = {
  min: 0.0,
  max: 12.0,
  gamma: 5.0,
};
Map.setCenter(-79.98, 23.32, 4);
Map.addLayer(precipitation, precipitationVis, 'Precipitation');
