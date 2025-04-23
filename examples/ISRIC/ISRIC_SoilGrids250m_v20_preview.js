// Define the area of interest (AOI) around the new center
var lon = 13.80;
var lat = 5.0;
var delta = 40;
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

// Create a global white image
var globalWhiteImage =
    ee.Image(1)
        .paint(
            ee.Geometry.Polygon(
                [[[-180, -90], [180, -90], [180, 90], [-180, 90]]]),
            0)
        .visualize({palette: ['ffffff'], min: 0, max: 1});

var clippedWhiteImage = globalWhiteImage.clip(areaOfInterest);

// Load the land cover dataset
var landCover =
    ee.Image('ISRIC/SoilGrids250m/v20/Q0_95').select('wv0010_0-5cm');

var landCoverVis = {
  min: -61,
  max: 636,
  palette: [
    '#440154', '#482878', '#3E4A89', '#31688E', '#26828E', '#1F9E89', '#35B779',
    '#6DCD59', '#B4DE2C', '#FDE725'
  ]
};

var landCoverImage = landCover.visualize(landCoverVis).clip(areaOfInterest);

// Blend the clipped white image with the clipped land cover image
var blendedLayer = clippedWhiteImage.blend(landCoverImage);

Map.setCenter(lon, lat, 3);
Map.addLayer(blendedLayer, {}, 'SoilGrids250m 10kPa Q0.95');

// Define parameters for the thumbnail image
var pixels = 256;
var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

// Display the thumbnail of the blended layer at zoom level 7
print(ui.Thumbnail({
  image: blendedLayer,
  params: visParams,
}));