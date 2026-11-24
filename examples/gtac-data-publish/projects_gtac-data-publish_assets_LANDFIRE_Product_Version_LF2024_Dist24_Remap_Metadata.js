var metadata = ee.FeatureCollection('projects/gtac-data-publish/assets/LANDFIRE/Product_Version/LF2024_Dist24_Remap_Metadata');
var dataset = ee.ImageCollection('projects/gtac-data-publish/assets/LANDFIRE/Product_Version/LF2024');

// Exclude the NoData lookup and order both aggregate arrays identically.
var lookup = metadata
    .filter(ee.Filter.neq('VALUE', -9999))
    .sort('VALUE');
var sourceValues = lookup.aggregate_array('VALUE');
var level1Values = lookup.aggregate_array('Dist_type_L1');

var image = dataset
    .filterDate('2023-10-01', '2024-10-01')
    .filter(ee.Filter.eq('study_area', 'CONUS'))
    .first();
var disturbanceType = image.select('Dist_raw').remap(
    sourceValues, level1Values, 255);

Map.setOptions('TERRAIN');
Map.setCenter(-112.0, 43.5, 5);
Map.addLayer(disturbanceType, {
  min: 0,
  max: 10,
  palette: [
    'e8e8e8', 'd6604d', 'f4a582', 'b88712', 'd1e5f0', '6eaac8',
    '6a3d9a', '9c27b0', '003300', 'ffff00', '6f6f6f'
  ]
}, 'Disturbance type (level 1)');

print('Dist24 remap metadata', metadata);
print('Example source class', metadata.filter(ee.Filter.eq('VALUE', 2483)).first());
