Map.setCenter(-7.67, 6.71, 11);

var collection = ee.ImageCollection(
  'projects/forestdatapartnership/assets/cocoa/model_2025a');

var cocoa2020 = collection.filterDate('2020-01-01', '2020-12-31').mosaic();
Map.addLayer(
  cocoa2020.selfMask(), {min: 0.5, max: 1, palette: 'white,blue'}, 'cocoa 2020');

var cocoa2023 = collection.filterDate('2023-01-01', '2023-12-31').mosaic();
Map.addLayer(
  cocoa2023.selfMask(), {min: 0.5, max: 1, palette: 'white,green'}, 'cocoa 2023');