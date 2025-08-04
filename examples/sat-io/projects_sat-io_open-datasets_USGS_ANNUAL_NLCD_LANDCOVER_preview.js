// Import the NLCD Annual Landcover image.
var dataset = ee.ImageCollection(
  "projects/sat-io/open-datasets/USGS/ANNUAL_NLCD/LANDCOVER"
);

var lon = -95;
var lat = 36;
Map.setCenter(lon, lat, 5);

var waterLand = ee.Image("NOAA/NGDC/ETOPO1").select("bedrock").gt(0.0);
var backgroundPalette = ["cadetblue", "lightgray"];
var waterLandVis = { palette: backgroundPalette };
var waterLandBackground = waterLand.visualize({ palette: backgroundPalette });

// Degrees in EPSG:3857.
var delta = 14.5;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta],
  null,
  false
);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: "EPSG:3857",
  format: "png",
};

var originalClasses = [
  11, 12, 21, 22, 23, 24, 31, 41, 42, 43, 52, 71, 81, 82, 90, 95,
];
var remappedClasses = ee.List.sequence(1, originalClasses.length);
var palette = [
  "#466b9f",
  "#d1def8",
  "#dec5c5",
  "#d99282",
  "#eb0000",
  "#ab0000",
  "#b3ac9f",
  "#68ab5f",
  "#1c5f2c",
  "#b5c58f",
  "#ccb879",
  "#dfdfc2",
  "#dcd939",
  "#ab6c28",
  "#b8d9eb",
  "#6c9fb8",
];

// Function to remap each image's land cover classes and keep the year property
function remapImage(image) {
  var remapped = image.remap(originalClasses, remappedClasses, null);
  return remapped
    .copyProperties(image, ["year"])
    .set("system:time_start", image.get("system:time_start"));
}

// Apply remapping to the entire collection
var remappedCollection = dataset.map(remapImage);

// Filter the collection to the last product.
var nlcd_last = dataset.sort("system:time_start", false).first();

// Select to the landcover band
var landcover = nlcd_last.select("b1");

var image = landcover.select("b1");
Map.addLayer(image, { min: 0, max: 15, palette: palette }, "Annual NLCD");

var imageWithBackground = ee
  .ImageCollection([waterLandBackground, image])
  .mosaic();
Map.addLayer(imageWithBackground, null, "landcover");
print(ui.Thumbnail({ image: imageWithBackground, params: imageParams }));
