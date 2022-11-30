var dataset = ee.Image("YALE/YCEO/UHI/UHI_all_averaged/v4");

var visualization = {
  bands: ['all_daytime_UHI'],
  min: -1.5,
  max: 7.5,
  palette: [
    "#313695","#74add1","#fed976","#feb24c","#fd8d3c","#fc4e2a",
    "#e31a1c","#b10026",
  ]
};

Map.setCenter(-74.7, 40.6, 7);

Map.addLayer(dataset, visualization, "All Daytime UHI");