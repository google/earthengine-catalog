Map.setCenter(-88.84, 14.57, 12);

var collection = ee.ImageCollection(
    'projects/forestdatapartnership/assets/coffee/model_2025b');

var coffee2020 = collection.filterDate('2020-01-01', '2020-12-31').mosaic().gt(0.95);
Map.addLayer(
  coffee2020.selfMask(), {min: 0.5, max: 1, palette: 'white,brown'}, 'coffee 2020');

var coffee2024 =
    collection.filterDate('2024-01-01', '2024-12-31').mosaic().gt(0.95);
Map.addLayer(
    coffee2024.selfMask(), {min: 0.5, max: 1, palette: 'white,green'},
    'coffee 2024');