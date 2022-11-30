// NOTE: This ImageCollection is deprecated.

var dataset = ee.ImageCollection("LANDSAT/LT4_L1T_ANNUAL_GREENEST_TOA");

Map.setCenter( -119.0446, 35.1195, 12);
Map.addLayer(dataset.select("greenness"), null, "greenness");
