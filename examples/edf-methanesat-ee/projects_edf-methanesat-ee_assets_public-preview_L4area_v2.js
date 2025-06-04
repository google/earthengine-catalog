// Request access to this data by filling out the form at: https://forms.gle/jqw4Mvr63dsV1fUF8
var dataset = ee.ImageCollection("projects/edf-methanesat-ee/assets/public-preview/L4area_v2")
  .filterDate('2024-06-01', '2025-06-07');

var colorRange = [
  "#F9ED3B", "#F7E33A", "#F5D838", "#F1C335", "#EEB934", "#ECAE32","#EB9E2F",
  "#EA8D2C", "#EC8129", "#F16823", "#D85627", "#BF442C", "#983623", "#70281A"
];

var fluxVisParams = {
  min: 0,
  max: 625,
  palette: colorRange,
};

Map.setCenter(-98.72, 36.49, 4);
Map.addLayer(dataset, fluxVisParams, 'Methane area sources flux');