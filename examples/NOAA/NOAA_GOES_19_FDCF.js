// NOAA GOES-19 full disk fire product for a single time slice.

var image = ee.Image('NOAA/GOES/19/FDCF/2025097022020500000');
var fireAreaImage = image.select('Area');
var temperatureImage = image.select('Temp');
var dataQualityFlagsImage = image.select('DQF');

var xMin = -142;  // On station as GOES-E
var xMax = xMin + 135;
Map.setCenter((xMin + xMax) / 2, 15, 3);
var geometry = ee.Geometry.Rectangle([xMin, -65, xMax, 65], null, true);

var dataQualityFlagsVis = {
  min: 0,
  max: 5,
  palette: [
    'blanchedalmond',  // Good quality fire pixel
    'olive',           // Good quality fire free land
    'teal',            // Opaque cloud
    'darkslateblue',   // Bad surface type, sunglint, LZA threshold exceeded,
                       // off Earth, or missing input data
    'lemonchiffon',    // Bad input data
    'burlywood'        // Algorithm failure
  ]
};
Map.addLayer(
    dataQualityFlagsImage, dataQualityFlagsVis, 'Data Quality Flags (DQF)');

var fireAreaVectors = fireAreaImage.reduceToVectors({
  geometry: geometry,
  scale: 2000,
  geometryType: 'centroid',
  labelProperty: 'area',
  maxPixels: 1e10,
});
// Fires are small enough that they are difficult to see at the scale of
// an entire GOES image.  Buffer fires based on area to make them stand out.
var fireAreaFeatureCollection = fireAreaVectors.map(function(feature) {
  return feature.buffer(feature.getNumber('area').add(1).pow(1.76));
});
Map.addLayer(fireAreaFeatureCollection, {color: 'orange'}, 'Fire area (orange)');

var temperatureVector = temperatureImage.reduceToVectors({
  geometry: geometry,
  scale: 2000,
  geometryType: 'centroid',
  labelProperty: 'temp',
  maxPixels: 1e10,
});
// Buffer fires based on temperature to make them stand out.
var temperature = temperatureVector.map(function(feature) {
  return feature.buffer(feature.getNumber('temp').add(2).pow(1.3));
});
Map.addLayer(temperature, {color: 'red'}, 'Temperature (red)');
