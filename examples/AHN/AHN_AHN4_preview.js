var image = ee.Image('AHN/AHN4/AHN4_20200101');

var greyBackground = ee.Image.constant([128, 128, 128])
  .rename(['red', 'green', 'blue'])
  .visualize({
    min: 0,
    max: 255,
    bands: ['red', 'green', 'blue']
  });

var combinedImage = image.visualize({
  bands: ['dsm', 'dtm', 'dsm'],
  min: 0,
  max: 30
});

// Merge the grey background with the combined image
var finalImage = ee.ImageCollection([
  greyBackground, 
  combinedImage
]).mosaic();

// Define the area of interest for the thumbnail
var pixels = 256;
var centerLon = 6.21;
var centerLat = 52.13;
var areaOfInterest = ee.Geometry.Rectangle(
  [centerLon - 0.02, centerLat - 0.02, centerLon + 0.02, centerLat + 0.02]
);

// Define thumbnail parameters
var thumbnailParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png'
};

// Display the map
Map.setCenter(centerLon, centerLat, 13);
Map.addLayer(finalImage, {}, 'Combined DSM and DTM with Grey Background');

// Generate and display the thumbnail
print('Combined DSM and DTM Thumbnail with Grey Background:');
print(ui.Thumbnail({
  image: finalImage,
  params: thumbnailParams,
}));
