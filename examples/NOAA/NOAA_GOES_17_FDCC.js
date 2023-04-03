// NOAA GOES-17 conterminous fire product for a single time slice.

var image = ee.Image('NOAA/GOES/17/FDCC/2019297090619600000');

var area = image.select('Area');
var temp = image.select('Temp');
var dqf = image.select('DQF');

Map.centerObject(image, 3);
var geometry = image.geometry();

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
  return feature.buffer(ee.Number(feature.get('area')).add(1).pow(1.4));
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
Map.setCenter(-137, 43.0, 5);
Map.addLayer(temp, {color: 'red'}, 'temp');
