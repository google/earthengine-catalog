// Import the NLCD Tree Canopy Cover image collection.
var dataset = ee.ImageCollection('USGS/NLCD_RELEASES/2021_REL/CANOPY/NLCD/TCC/YEAR');
var canopy = dataset.filter(ee.Filter.eq('system:year', '2021')).first();

var vis = {
  // Map colors
    'palette': [
      'ffffe0',  // light yellow - percent shrub
      '66cdaa',  // medium green - percent shrub
  ],  
};

// Display the image on the map.
Map.setCenter(-130, 48, 10);
Map.addLayer(canopy, vis, 'year_2021 %');