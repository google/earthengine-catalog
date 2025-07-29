// Request access to this data by filling out the form at: https://forms.gle/jqw4Mvr63dsV1fUF8
var dataset = ee.ImageCollection("projects/edf-methanesat-ee/assets/public-preview/L4area_v2")
  .filterDate('2024-11-01', '2025-05-01');

// Visualization
var colorRange = [
  "#F9ED3B", "#F7E33A", "#F5D838", "#F1C335", "#EEB934", "#ECAE32","#EB9E2F",
  "#EA8D2C", "#EC8129", "#F16823", "#D85627", "#BF442C", "#983623", "#70281A"
];

var fluxVisParams = {
  bands: ['mean_flux'],
  min: 0,
  max: 13,
  palette: colorRange,
};

// By default, Earth Engine will use the colors provided in the 'palette' param above
// to define a "color ramp" or gradient. Each color in the 'palette' is mapped to a value evenly
// distributed between 'min' and 'max'. For intermediate values, Earth Engine maps the values
// linearly to a color in between, creating a gradient effect.
// This function forces pixel colors to be one of the 14 colors listed above in colorRange rather
// than using additional in between colors when a gradient is applied.
var prepColorPalette = function(image) {
  var img0000 = image.gte(0);
  var img0025 = image.gte(4);
  var img0050 = image.gte(8);
  var img0090 = image.gte(14.4);
  var img0150 = image.gte(24);
  var img0225 = image.gte(26);
  var img0325 = image.gte(52);
  var img0450 = image.gte(72);
  var img0600 = image.gte(96);
  var img0775 = image.gte(124);
  var img0975 = image.gte(156);
  var img1200 = image.gte(192);
  var img1450 = image.gte(232);
  var img1700 = image.gte(272);
  
  return img0000
    .add(img0025)
    .add(img0050)
    .add(img0090)
    .add(img0150)
    .add(img0225)
    .add(img0325)
    .add(img0450)
    .add(img0600)
    .add(img0775)
    .add(img0975)
    .add(img1200)
    .add(img1450)
    .add(img1700);
}
var images = dataset.map(prepColorPalette);

Map.setCenter(-98.72, 36.49, 4);
Map.addLayer(images, fluxVisParams, 'Methane area sources flux');