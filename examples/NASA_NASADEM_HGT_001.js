// Import the dataset and select the elevation band.
var dataset = ee.Image('NASA/NASADEM_HGT/001');
var elevation = dataset.select('elevation');

// Add a white background image to the map.
var background = ee.Image(1);
Map.addLayer(background, {min: 0, max: 1});

// Set elevation visualization properties.
var elevationVis = {
  min: 0,
  max: 2000,
};

// Set elevation <= 0 as transparent and add to the map.
Map.addLayer(elevation.updateMask(elevation.gt(0)), elevationVis, 'Elevation');
Map.setCenter(17.93, 7.71, 2);
