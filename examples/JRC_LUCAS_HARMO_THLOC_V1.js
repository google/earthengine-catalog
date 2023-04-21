var dataset = ee.FeatureCollection("JRC/LUCAS_HARMO/THLOC/V1");

// For the Inspector
Map.addLayer(dataset, {}, "LUCAS Points (data)", false);

dataset = dataset.style({
  color: "489734",
  pointSize: 3,
});

Map.setCenter(-3.8233, 40.609, 10);

Map.addLayer(dataset, {}, "LUCAS Points (styled green)");
