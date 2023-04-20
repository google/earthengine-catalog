var dataset = ee.Image("UMD/hansen/global_forest_change_2018_v1_6");

var visualization = {
  bands: ['treecover2000'],
  min: 0.0,
  max: 100.0,
  palette: [
    "3d3d3d","080a02","080a02","080a02","106e12","37a930",
    "03ff17",
  ]
};

Map.setCenter(-60.5, -20.0, 2);

Map.addLayer(dataset, visualization, "Tree Canopy Cover");