var dataset = ee.Image('ACA/reef_habitat/v1_0');

// Teti'aroa, an atoll in French Polynesia.
Map.setCenter(-149.56194, -17.00872, 13);
Map.setOptions('SATELLITE');

// The visualizations are baked into the image properties.

// Example mask application.
var reefExtent = dataset.select('reef_mask').selfMask();
Map.addLayer(reefExtent, {}, 'Global reef extent');

// Geomorphic zonation classification.
var geomorphicZonation = dataset.select('geomorphic').selfMask();
Map.addLayer(geomorphicZonation, {}, 'Geomorphic zonation');

// Benthic habitat classification.
var benthicHabitat = dataset.select('benthic').selfMask();
Map.addLayer(benthicHabitat, {}, 'Benthic habitat');
