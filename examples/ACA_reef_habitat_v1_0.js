var dataset = ee.Image("ACA/reef_habitat/v1_0");

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
var global_mask = dataset.select('reef_mask').selfMask();
Map.addLayer(global_mask, {}, "Global reporting reef mask");
Map.addLayer(
    geomorphic_zonation.updateMask(global_mask), {},
    "Geomorphic map (global mask applied)");
