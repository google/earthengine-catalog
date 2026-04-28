Map.setCenter(110, 0, 11);

var collection = ee.ImageCollection(
    'projects/forestdatapartnership/assets/palm/model_2025b');

var p2020 = collection.filterDate('2020-01-01', '2020-12-31').mosaic();
Map.addLayer(
    p2020.selfMask(), {min: 0.5, max: 1, palette: 'white,blue'}, 'palm 2020');

var p2024 = collection.filterDate('2024-01-01', '2024-12-31').mosaic();
Map.addLayer(
    p2024.selfMask(), {min: 0.5, max: 1, palette: 'white,green'}, 'palm 2024');