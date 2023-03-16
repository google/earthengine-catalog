var dataset = ee.Image("OpenLandMap/SOL/SOL_WATERCONTENT-33KPA_USDA-4B1C_M/v01");

var visualization = {
  bands: ['b0'],
  min: 0.0,
  max: 52.9740182135385,
  palette: [
    "d29642","eec764","b4ee87","32eeeb","0c78ee","2601b7",
    "083371",
  ]
};

Map.centerObject(dataset);

Map.addLayer(dataset, visualization, "Soil water content at 33kPa (field capacity)");