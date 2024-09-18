var geometry = ee.Geometry.Point(
    [31.549876545106667, 30.011531513347673]);  // New Cairo, Egypt

var col = ee.ImageCollection('GOOGLE/Research/open-buildings-temporal/v1');

/**
 * Adds building presence and height layers for a given timestamp.
 * @param {number} millis Timestamp in milliseconds.
 */
function addLayers(millis) {
  // Create a mosaic of tiles with the same timestamp.
  var mosaic = col.filter(ee.Filter.eq('system:time_start', millis)).mosaic();
  var year = new Date(millis).getFullYear();
  Map.addLayer(
      mosaic.select('building_presence'), {max: 1},
      'building_presence_conf_' + year);
  Map.addLayer(
      mosaic.select('building_height'), {max: 100}, 'building_height_m_' + year,
      /*shown=*/ false);
};

// Get latest 2 years
var ts = col.filterBounds(geometry)
             .aggregate_array('system:time_start')
             .distinct()
             .sort()
             .getInfo()
             .slice(-2);


ts.forEach(addLayers);


Map.centerObject(geometry, 14);