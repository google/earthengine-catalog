// Import the Tree Canopy Cover image collection.
var dataset = ee.ImageCollection('USGS/NLCD_RELEASES/2021_REL/CANOPY/YEAR');

Map.addLayer(
  dataset,
  {
    palette: [
      'ffffe0',  // light yellow - percent shrub
      '66cdaa',  // medium green - percent shrub
    ],
    min: 0,
    max: 254,
    },
    'NALCMS Land Cover');
      
Map.setCenter(-130, 48, 10);