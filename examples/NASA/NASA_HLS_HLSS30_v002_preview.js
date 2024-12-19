var collection = ee.ImageCollection("NASA/HLS/HLSS30/v002")
                    .filter(ee.Filter.date('2024-04-25', '2024-04-26'))
                    .filter(ee.Filter.lt('CLOUD_COVERAGE', 20));

// Visualization parameters
var visParams = {
  bands: ['B4', 'B3', 'B2'],
  min: 0.01,
  max: 0.18
};

// Create a mosaic from the ImageCollection
var mosaicImage = collection.mosaic().visualize(visParams);

// Define the area of interest for the thumbnail
var x = -120.97;
var y = 37.02;
var step = 0.2;
var areaOfInterest = ee.Geometry.Rectangle(
  [x, y, x + step, y + step], null, false
);

// Define parameters for the thumbnail
var thumbnailParams = {
  dimensions: 256,
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png'
};

Map.setCenter(-120.97, 37.02, 12);
Map.addLayer(mosaicImage, {}, 'HLS S30 Mosaic');

// Generate the thumbnail
print(ui.Thumbnail({
  image: mosaicImage,
  params: thumbnailParams,
  style: {width: '256px'}
}));
