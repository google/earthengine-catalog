var dataset = ee.Image("OpenLandMap/SOL/SOL_ORGANIC-CARBON_USDA-6A1C_M/v02");

var visualization = {
  bands: ['b0'],
  min: 0.0,
  max: 120.0,
  palette: [
    "ffffa0","f7fcb9","d9f0a3","addd8e","78c679","41ab5d",
    "238443","005b29","004b29","012b13","00120b",
  ]
};

Map.centerObject(dataset);

Map.addLayer(dataset, visualization, "Soil organic carbon content in x 5 g / kg");