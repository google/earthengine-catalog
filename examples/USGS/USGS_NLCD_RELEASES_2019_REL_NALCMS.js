// Import the NALCMS collection.
var image = ee.Image('projects/ee-nalcms/assets/nalcms/2020');
print(image);

var vis = {
  Map.addLayer(image, {
  palette: [
    'tomato',  // 1
    'orange',  // 2
    'red',  // 3
    'purple',  // 4
    'maroon',  // 5
    'silver',  // 6
    'blue',  // 7
    'coral',  // 8
    'cyan',  // 9
    'bisque',  // 10
    'darkviolet',  // 11
    'goldenrod',  // 12
    'lightsalmon',  // 13
    'fuchsia',  // 14
    'seagreen',  // 15
    'whitesmoke',  // 16
    'thistle',  // 17
    'sandybrown',  // 18
    'seashell',  // 19
    ],
  min:1, max:19});

// Display the image on the map.
Map.setCenter(-114, 38, 6);
