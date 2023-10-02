var usdm = ee.Image(
  ee
    .ImageCollection("projects/sat-io/open-datasets/us-drought-monitor")
    .sort("system:time_start", false)
    .first()
);

var lon = -98.19;
var lat = 40;

Map.setCenter(lon, lat, 5);

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({ min: 0, max: 255 });

// Degrees in EPSG:3857.
var delta = 10;
// Width and height of the thumbnail image.
var pixels = 256;

var image = usdm.visualize({
  min: 0,
  max: 4,
  palette: ["FFFF00", "FCD37F", "FFAA00", "E60000", "730000"],
});
Map.addLayer(
  image,
  {},
  "United States Drought Monitor (USDM; Drought Class)",
  false
);

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

var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

Map.addLayer(imageWithBackground, {}, "United States Drought Monitor");

print(ui.Thumbnail({ image: imageWithBackground, params: imageParams }));
