var dataset = ee.FeatureCollection.loadBigQueryTable("earth-engine-public-data.insitu_nrt_currents.argo_latest")
                  .filter(ee.Filter.date('2025-04-01', '2025-05-01'));

dataset = dataset.map(function(f) {
  var val = ee.Number(f.get('EWCT')).float();
  return f.buffer(8000) // 8km radius circles
          .set('EWCT', val);
});


var image = dataset.reduceToImage({
  properties: ['EWCT'],
  reducer: ee.Reducer.first()
});

var visParams = {
  min: -0.5,
  max: 0.5,
  palette: ['a50026', 'd73027', '333333', '4575b4', '313695'],
};

Map.setCenter(-100.5, 30.2, 3);
Map.addLayer(image, visParams, 'Global INSITU Argo EWCT');
