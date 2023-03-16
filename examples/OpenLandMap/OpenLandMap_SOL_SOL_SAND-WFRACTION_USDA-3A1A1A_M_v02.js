var dataset = ee.Image("OpenLandMap/SOL/SOL_SAND-WFRACTION_USDA-3A1A1A_M/v02");

var visualization = {
  bands: ['b0'],
  min: 1.0,
  max: 100.0,
  palette: [
    "FFFF00","F8F806","F1F10C","EBEB13","E4E419","DDDD20",
    "D7D726","D0D02D","CACA33","C3C33A","BCBC41","B6B647",
    "B0B04E","A9A954","A3A35A","9C9C61","959568","8F8F6E",
    "898975","82827B","7B7B82","757589","6E6E8F","686895",
    "61619C","5A5AA3","5454A9","4D4DB0","4747B6","4141BC",
    "3A3AC3","3333CA","2D2DD0","2626D7","2020DD","1919E4",
    "1212EB","0C0CF1","0606F8","0000FF",
  ]
};

Map.centerObject(dataset);

Map.addLayer(dataset, visualization, "Sand content in % (kg / kg)");