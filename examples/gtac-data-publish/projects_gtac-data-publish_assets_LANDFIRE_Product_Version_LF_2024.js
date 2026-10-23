var dataset = ee.ImageCollection('projects/gtac-data-publish/assets/LANDFIRE/Product_Version/LF2024');

var image = dataset
    .filterDate('2023-10-01', '2024-10-01')
    .filter(ee.Filter.eq('study_area', 'CONUS'))
    .first();

// Remap sparse fuel-model codes to sequential indexes for visualization only.
var fuelModelValues = [
  91,
  92,
  93,
  98,
  99,
  101,
  102,
  103,
  104,
  105,
  106,
  107,
  108,
  109,
  121,
  122,
  123,
  124,
  141,
  142,
  143,
  144,
  145,
  146,
  147,
  148,
  149,
  161,
  162,
  163,
  164,
  165,
  181,
  182,
  183,
  184,
  185,
  186,
  187,
  188,
  189,
  201,
  202,
  203,
  204
];
var fuelModelIndexes = fuelModelValues.map(function(value, index) {
  return index;
});
var fuelModelPalette = [
  "686868",
  "e1e1e1",
  "ffeded",
  "000ed6",
  "4d6e70",
  "ffebbe",
  "ffd373",
  "ffec8b",
  "ffff73",
  "f5de29",
  "e6e640",
  "cdc673",
  "8b864e",
  "a87000",
  "ffaa00",
  "ffa77f",
  "ff6300",
  "cd6600",
  "d7c29e",
  "d7b09e",
  "cd8966",
  "895a44",
  "cdaa66",
  "ed7044",
  "cd7d39",
  "a83800",
  "731a00",
  "e9ffbe",
  "aaff00",
  "b4d79e",
  "70a800",
  "267300",
  "beffe8",
  "00ffc5",
  "bed2ff",
  "7b68ee",
  "bee8ff",
  "00c5ff",
  "0084a8",
  "005ce6",
  "4d6e91",
  "e8beff",
  "c500ff",
  "ffbee8",
  "ff7f7f"
];
var fuelModel = image.select('FBFM40').remap(
    fuelModelValues, fuelModelIndexes);

Map.setOptions('TERRAIN');
Map.setCenter(-105.6, 39.2, 7);
Map.addLayer(fuelModel, {
  min: 0,
  max: fuelModelValues.length - 1,
  palette: fuelModelPalette
}, 'Scott and Burgan fire behavior fuel model');
Map.addLayer(image.select('VDep'), {
  min: 0,
  max: 100,
  palette: ['006837', 'ffffbf', 'a50026']
}, 'Vegetation departure (%)', false);

print('LANDFIRE 2024 CONUS image', image);
