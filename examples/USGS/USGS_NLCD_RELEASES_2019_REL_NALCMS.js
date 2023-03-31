// Import the NALCMS collection.
var image = ee.Image('USGS/NLCD_RELEASES/2019_REL/NALCMS');
print(image);

  Map.addLayer(image, {
  palette: [
    '1a200e',  // 1
    '4b5320',  // 2
    '222b13',  // 3
    '68ab5f',  // 4
    'b5c58f',  // 5
    '1c5f2c',  // 6
    '556b2f',  // 7
    'dec5c5',  // 8
    'dcd939',  // 9
    'ccb879',  // 10
    'af963c',  // 11
    'd1d182',  // 12
    '82ba9e',  // 13
    'a3cc51',  // 14
    'ab6c28',  // 15
    'b8d9eb',  // 16
    'ab0000',  // 17
    '466b9f',  // 18
    'd1def8',  // 19
    ],
  min:1, max:19});

// Display the image on the map.
Map.setCenter(-114, 38, 6);
