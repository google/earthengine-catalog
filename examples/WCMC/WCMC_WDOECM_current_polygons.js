var table = ee.FeatureCollection('WCMC/WDOECM/current/polygons');

var image = table.reduceToImage({
  properties: ['REP_AREA'],
  reducer: ee.Reducer.first()
});

var visParams = {
  min: 50000.0,
  max: 800000.0,
  palette: ['2ed033', '5aff05', '67b9ff', '5844ff', '0a7618', '2c05ff'],
  opacity: 0.8
};

Map.setCenter(-4.14, 27.33, 5);

Map.addLayer(image, visParams, 'Total OECMs extent');
