var dataset = ee.ImageCollection('NOAA/PERSIANN-CDR')
                  .filter(ee.Filter.date('2017-05-01', '2017-05-02'));
var precipitation = dataset.select('precipitation');
var precipitationVis = {
  min: 0.0,
  max: 50.0,
  palette: ['3907ff', '03fff3', '28ff25', 'fbff09', 'ff1105'],
};
Map.setCenter(113.03, 3.34, 3);
Map.addLayer(precipitation, precipitationVis, 'Precipitation');
