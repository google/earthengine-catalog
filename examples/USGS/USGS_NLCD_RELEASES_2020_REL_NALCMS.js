// Import the NALCMS image.
var image = ee.Image('USGS/NLCD_RELEASES/2020_REL/NALCMS');

Map.addLayer(
  image,
  {
    palette: [
      '033e00',  // 1  Temperate or sub-polar needleleaf forest
      '939b71',  // 2  Sub-polar taiga needleleaf forest
      '196d12',  // 3  Tropical or sub-tropical broadleaf evergreen forest
      '1fab01',  // 4  Tropical or sub-tropical broadleaf deciduous forest
      '5b725c',  // 5  Temperate or sub-polar broadleaf deciduous forest
      '6b7d2c',  // 6  Mixed forest
      'b29d29',  // 7  Tropical or sub-tropical shrubland
      'b48833',  // 8  Temperate or sub-polar shrubland
      'e9da5d',  // 9  Tropical or sub-tropical grassland
      'e0cd88',  // 10  Temperate or sub-polar grassland
      'a07451',  // 11  Sub-polar or polar shrubland-lichen-moss
      'bad292',  // 12  Sub-polar or polar grassland-lichen-moss
      '3f8970',  // 13  Sub-polar or polar barren-lichen-moss
      '6ca289',  // 14  Wetland
      'e6ad6a',  // 15  Cropland
      'a9abae',  // 16  Barren land
      'db2126',  // 17  Urban and built-up
      '4c73a1',  // 18  Water
      'fff7fe',  // 19  Snow and ice
    ],
   min: 1,
   max: 19,
  },
  'NALCMS Land Cover');

Map.setCenter(-114, 38, 6);
