// Define the area of interest (AOI) around the new center
var lon = -5.4400;
var lat = 7.5500;
var delta = 3.5;
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

// Create a global white image
var globalWhiteImage = ee.Image(1).paint(ee.Geometry.Polygon(
    [[[-180, -90], [180, -90], [180, 90], [-180, 90]]]), 0)
    .visualize({palette: ['ffffff'], min: 0, max: 1});

var clippedWhiteImage = globalWhiteImage.clip(areaOfInterest);

// Load the land cover dataset
var landCover = ee.Image('BNETD/land_cover/v1/2020').select('classification');

var landCoverVis = {
  min: 1,
  max: 23,
  palette: ["276300", "59D757", "569D6E", "79CFAD", "34734C", "B4FFAD",
            "6EFA9A", "D68589", "EBD37F", "D0E09D", "E8BEFF", "E751FE",
            "F3BFF2", "9DFD00", "F2F38D", "B6D322", "E2FE5F", "F9FDCC",
            "4A70C0", "BEFFE8", "D20A02", "DBECEF", "DCDCDC"]
};

var landCoverImage = landCover.visualize(landCoverVis).clip(areaOfInterest);

// Blend the clipped white image with the clipped land cover image
var blendedLayer = clippedWhiteImage.blend(landCoverImage);


Map.setCenter(lon, lat, 7);
Map.addLayer(blendedLayer, {}, "Cote d'Ivoire Land Cover Map 2020");

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
