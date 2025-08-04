// Load collection.
var dataset = ee.ImageCollection("GOOGLE/SATELLITE_EMBEDDING/V1/ANNUAL");

// Year of interest.
var year = 2024;

// Region of interest.
var roi = ee.Geometry.Rectangle([-74.3, 40.5, -73.7, 41], null, false);

var image = dataset
          .filterDate(year + "-01-01", (year + 1) + "-01-01")
          .filterBounds(roi)
          .first();

var pixels = 256;

var imageParams = {
  dimensions: [pixels, pixels],
  region: roi,
  crs: 'EPSG:4326',
  format: 'png',
};

var thumbnailImage = image.visualize({
  min: -0.25,
  max: 0.25,
  bands: ['A03', 'A02', 'A04']
});

print(ui.Thumbnail({
  image: thumbnailImage,
  params: imageParams,
}));