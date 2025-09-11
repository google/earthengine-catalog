var farmscapes =
    ee.ImageCollection('projects/nature-trace/assets/farmscapes/england_v1_0')
        .mosaic();
Map.addLayer(farmscapes, {}, 'Raw probs', false);

var stone_wall = farmscapes.select(['B1']);
stone_wall = stone_wall.updateMask(stone_wall.gt(250 / 4));
Map.addLayer(
    stone_wall, {palette: ['FFFFFF', '00FFFF'], min: 0, max: 250},
    'Stone wall');

var hedgerow = farmscapes.select(['B0']);
hedgerow = hedgerow.updateMask(hedgerow.gt(250 / 4));
Map.addLayer(
    hedgerow, {palette: ['FFFFFF', 'c71585'], min: 0, max: 250}, 'Hedgerow');

var woodland = farmscapes.select(['B2']);
woodland = woodland.updateMask(woodland.gt(250 / 4));
Map.addLayer(
    woodland, {palette: ['FFFFFF', '06402B'], min: 0, max: 250}, 'Woodland');

var lon = -1.43;
var lat = 52.973;
Map.setCenter(lon, lat, 15);