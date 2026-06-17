var dataset = ee.FeatureCollection.loadBigQueryTable("earth-engine-public-data.insitu_nrt_currents.drifter_latest")
                  .filter(ee.Filter.date('2025-04-01', '2025-05-01'));

var temps = dataset.select('TEMP');

var tempVis = {
  min: 18,
  max: 25,
  palette: ['d7191c', 'fdae61', 'ffffbf', 'abd9e9', '2c7bb6'],
};

// Create an empty image and paint the features onto it, coloring by 'TEMP'.
var image = ee.Image().float().paint({
  featureCollection: temps,
  color: 'TEMP',
  width: 8 // Point size
});

Map.setCenter(-100.5, 30.2, 3);
Map.addLayer(image, tempVis, 'Global INSITU Drifter TEMP');
