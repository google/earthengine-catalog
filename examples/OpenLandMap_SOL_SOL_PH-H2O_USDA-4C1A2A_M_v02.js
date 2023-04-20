var dataset = ee.Image("OpenLandMap/SOL/SOL_PH-H2O_USDA-4C1A2A_M/v02");

var visualization = {
  bands: ['b0'],
  min: 42.0,
  max: 110.0,
  palette: [
    "FF0000","FF1C00","FF3900","FF5500","FF7100","FF8E00",
    "FFAA00","FFC600","FFE200","FFFF00","E3FF00","C7FF00",
    "AAFF00","8EFF00","72FF00","55FF00","39FF00","1DFF00",
    "01FF00","00FF1C","00FF38","00FF54","00FF71","00FF8D",
    "00FFA9","00FFC6","00FFE2","00FFFE","00E3FF","00C7FF",
    "00ABFF","008FFF","0072FF","0056FF","003AFF","001DFF",
    "0001FF","1B00FF","3800FF","5400FF",
  ]
};

Map.centerObject(dataset);

Map.addLayer(dataset, visualization, "Soil pH x 10 in H2O");