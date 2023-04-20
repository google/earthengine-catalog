// NOAA GOES-17 full disk fire product for a single time slice.

var image = ee.Image('NOAA/GOES/17/FDCF/2019275191034100000');
var area = image.select('Area');
var temp = image.select('Temp');
var dqf = image.select('DQF');

var xmin = -205;  // On station as GOES-W
var xmax = xmin + 135;
Map.setCenter((xmin+xmax)/2, 15, 3);
var geometry = ee.Geometry.Rectangle([xmin, -65, xmax, 65], null, true);

var DQFVis = {
  min: 0,
  max: 5,
  palette: [
    'blanchedalmond',  // Good quality fire pixel
    'olive',           // Good quality fire free land
    'teal',            // Opaque cloud
                       // Bad surface type, sunglint, LZA threshold exceeded,
    'darkslateblue',   // off earth, or missing input data
    'lemonchiffon',    // Bad input data
    'burlywood'        // Algorithm failure
  ]};
Map.addLayer(dqf, DQFVis, 'DQF');

// Fires are small enough that they are difficult to see at the scale of
// an entire GOES image.  Buffer fires based on area to make them stand out.
var area = area.reduceToVectors({
  geometry: geometry,
  scale: 2000,
  geometryType: 'centroid',
  labelProperty: 'area',
  maxPixels: 1e10,
}).map(function(feature){
  return feature.buffer(ee.Number(feature.get('area')).add(1).pow(1.5));
});
Map.addLayer(area, {color: 'orange'}, 'area');

// Buffer fires based on temperature to make them stand out.
var temp = temp.reduceToVectors({
  geometry: geometry,
  scale: 2000,
  geometryType: 'centroid',
  labelProperty: 'temp',
  maxPixels: 1e10,
}).map(function(feature){
  return feature.buffer(ee.Number(feature.get('temp')).add(2).pow(1.2));
});
Map.addLayer(temp, {color: 'red'}, 'temp');
