var dataset = ee.ImageCollection("YALE/YCEO/UHI/Winter_UHI_yearly_pixel/v4");

var visualization = {
  bands: ['Daytime'],
  min: -1.5,
  max: 7.5,
  palette: [
    "#313695","#74add1","#fed976","#feb24c","#fd8d3c","#fc4e2a",
    "#e31a1c","#b10026",
  ]
};

Map.setCenter(-74.7, 40.6, 7);

Map.addLayer(dataset, visualization, "Daytime UHI");