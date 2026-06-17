// This script loads a large BigQuery table and performs per-feature operations,
// which can make it take longer to load than typical Earth Engine scripts.
var dataset = ee.FeatureCollection.loadBigQueryTable("earth-engine-public-data.insitu_nrt_currents.radar_total_latest")
                  .filter(ee.Filter.date('2025-04-01', '2025-04-02'))
                  .filter(ee.Filter.notNull(['EWCT']));

dataset = dataset.map(function(f) {
  var val = ee.Number(f.get('EWCT')).float();
  return f.buffer(3000) // 3km radius circles
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

Map.setCenter(25.5, 71.5, 6);
Map.addLayer(image, visParams, 'Radar Total EWCT');