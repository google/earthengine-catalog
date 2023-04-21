var dataset = ee.Image("OpenLandMap/SOL/SOL_TEXTURE-CLASS_USDA-TT_M/v02");

var visualization = {
  bands: ['b0'],
  min: 1.0,
  max: 12.0,
  palette: [
    "d5c36b","b96947","9d3706","ae868f","f86714","46d143",
    "368f20","3e5a14","ffd557","fff72e","ff5a9d","ff005b",
  ]
};

Map.centerObject(dataset);

Map.addLayer(dataset, visualization, "Soil texture class (USDA system)");