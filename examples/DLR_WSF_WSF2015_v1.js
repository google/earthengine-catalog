var dataset = ee.Image("DLR/WSF/WSF2015/v1");

var opacity = 0.75;
var blackBackground = ee.Image(0);
Map.addLayer(blackBackground, null, "Black background", true, opacity);

var visualization = {
  min: 0,
  max: 255,
};
Map.addLayer(dataset, visualization, "Human settlement areas");

Map.setCenter(90.45, 23.7, 7);
