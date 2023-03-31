// Import the NALCMS collection.
var image = ee.Image('USGS/NLCD_RELEASES/2019_REL/NALCMS');
print(image);

  Map.addLayer(image, {
  palette: [
    '033e00',  // 1
    '939b71',  // 2
    '196d12',  // 3
    '1fab01',  // 4
    '5b725c',  // 5
    '6b7d2c',  // 6
    'b29d29',  // 7
    'b48833',  // 8
    'e9da5d',  // 9
    'e0cd88',  // 10
    'a07451',  // 11
    'bad292',  // 12
    '3f8970',  // 13
    '6ca289',  // 14
    'e6ad6a',  // 15
    'a9abae',  // 16
    'db2126',  // 17
    '4c73a1',  // 18
    'fff7fe',  // 19
    ],
  min:1, max:19});

// Display the image on the map.
Map.setCenter(-114, 38, 6);
