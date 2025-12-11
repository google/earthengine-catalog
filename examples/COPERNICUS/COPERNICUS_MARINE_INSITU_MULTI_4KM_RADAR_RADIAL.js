// This script loads a large BigQuery table and performs per-feature operations,
// which can make it take longer to load than typical Earth Engine scripts.
var dataset = ee.FeatureCollection.loadBigQueryTable("earth-engine-public-data.insitu_nrt_currents.radar_radial_latest")
                  .filter(ee.Filter.date('2025-04-01', '2025-04-02'));

dataset = dataset.map(function(f) {
  var val = ee.Number(f.get('RDVA')).float();
  return f.buffer(3000) // 3km radius circles
          .set('RDVA', val);
});


var image = dataset.reduceToImage({
  properties: ['RDVA'],
  reducer: ee.Reducer.first()
});

var visParams = {
  min: -0.5,
  max: 0.5,
  palette: ['a50026', 'd73027', '333333', '4575b4', '313695'],
};

Map.setCenter(-9.46, 42.76, 7);
Map.addLayer(image, visParams, 'Global INSITU Radar Radial RDVA');
