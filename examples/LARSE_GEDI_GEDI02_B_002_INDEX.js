var rectangle = ee.Geometry.Rectangle([
    -111.22, 24.06, -6.54, 51.9
]);
// Filter index by date and location
var filter_index = ee.FeatureCollection(
    'LARSE/GEDI/GEDI02_B_002_INDEX').filter(
    "time_start > '2020-10-10T15:57:18Z' && time_end < '2020-10-11T01:20:45Z'")
    .filterBounds(rectangle);

Map.addLayer(filter_index);
