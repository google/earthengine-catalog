/**
  MapBiomas Antarctica - LULC Preview Thumbnail
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

// King George Island - ice cap, ice-free areas and vegetation
var region = ee.Geometry.Point([-58.9, -62.2]).buffer(20000).bounds();

Map.centerObject(region, 9);
Map.addLayer(collection, visParams, 'MapBiomas Antarctica LULC ' + year);

print(ui.Thumbnail({
  image: collection.mosaic().visualize(visParams),
  params: {
    region: region,
    dimensions: 256,
    format: 'png',
  },
  style: {height: '256px', width: '256px'},
}));
