Map.setCenter(106.48584, 11.17099, 11);

var collection = ee.ImageCollection(
    'projects/forestdatapartnership/assets/rubber/model_2024a');

var r2020 = collection.filterDate('2020-01-01', '2020-12-31').mosaic();
Map.addLayer(
    r2020.selfMask(), {min: 0.5, max: 1, palette: 'white,blue'}, 'rubber 2020');

var r2023 = collection.filterDate('2023-01-01', '2023-12-31').mosaic();
Map.addLayer(
    r2023.selfMask(), {min: 0.5, max: 1, palette: 'white,green'},
    'rubber 2023');