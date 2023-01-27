var dataset = ee.Image("ACA/reef_habitat/v2_0");

// Teti'aroa, an atoll in French Polynesia
Map.setCenter(-149.56194, -17.00872, 13);
Map.setOptions('SATELLITE');

// Mitch: The visualisations are baked into the image properties

// Benthic habitat classification
var benthic_habitat = dataset.select('benthic').selfMask();
Map.addLayer(benthic_habitat, {}, "Benthic habitat map");

// Geomorphic zonation classification
var geomorphic_zonation = dataset.select('geomorphic').selfMask();
Map.addLayer(geomorphic_zonation, {}, "Geomorphic zonation map");

// Example mask application
var reef_extent = dataset.select('reef_mask').selfMask();
Map.addLayer(reef_extent, {}, "Global reef extent");
