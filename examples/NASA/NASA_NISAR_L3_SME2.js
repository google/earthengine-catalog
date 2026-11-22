// Assets for all granule versions are kept; select among them explicitly.
// Keep a single maturity track.
var collection = ee.ImageCollection('NASA/NISAR/L3_SME2')
    .filterDate('2025-11-24', '2025-11-30')
    .filter(ee.Filter.eq('status', 'provisional'));

// Sort by granule version (crid, then counter) so that the most recent
// version is drawn on top where granules overlap. Assumes all crid values
// share the same environment letter (e.g., 'P').
collection = collection.map(function(image) {
  var crid = ee.Number.parse(ee.String(image.get('crid')).slice(1));
  return image.set('version', crid.multiply(1000).add(image.get('counter')));
}).sort('version');

// Keep recommended retrievals only (qualityFlag bit 0 == 0).
var soilMoisture = collection.map(function(image) {
  var notRecommended = image.select('qualityFlag').toInt().bitwiseAnd(1);
  return image.select('soilMoisture').updateMask(notRecommended.eq(0));
});

var visParams = {
  min: 0.0,
  max: 0.5,
  palette: ['0300ff', '418504', 'efff07', 'ff0303']
};

Map.setCenter(140.0, 35.5, 6);
Map.addLayer(soilMoisture, visParams, 'NISAR Soil Moisture V1');
