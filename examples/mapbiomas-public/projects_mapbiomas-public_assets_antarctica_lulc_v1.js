/**
  MapBiomas Antarctica - Land Use and Land Cover V1
*/

var assetPath = 'projects/mapbiomas-public/assets/antarctica/lulc/v1';

var year = 2025;
var version = 'v1';
var collectionId = 1;

var collection = ee.ImageCollection(assetPath)
  .filter(ee.Filter.eq('collection_id', collectionId))
  .filter(ee.Filter.eq('version', version))
  .filter(ee.Filter.eq('year', year));

var visParams = {
  min: 0,
  max: 10,
  palette: [
    '000000',  // [0] --
    '2c7bb6',  // [1] Ocean
    'e5f2ff',  // [2] Ice and snow
    '542609',  // [3] Ice-free area
    '003200',  // [4] Vegetation
    '000000',  // [5] --
    '000000',  // [6] --
    '000000',  // [7] --
    '000000',  // [8] --
    '000000',  // [9] --
    'cccccc',  // [10] No data
  ],
};

Map.addLayer(collection, visParams, 'MapBiomas Antarctica LULC ' + year);
Map.setCenter(-58.9, -62.2, 9);
