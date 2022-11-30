var dataset = ee.FeatureCollection('USDOS/LSIB/2017');
var styleParams = {
  fillColor: 'b5ffb4',
  color: '00909F',
  width: 3.0,
};
var countries = dataset.style(styleParams);
Map.setCenter(16.35, 48.83, 4);
Map.addLayer(countries, {}, 'USDOS/LSIB/2017');
