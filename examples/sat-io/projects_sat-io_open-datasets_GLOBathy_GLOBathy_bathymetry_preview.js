var globathy = ee.Image(
  "projects/sat-io/open-datasets/GLOBathy/GLOBathy_bathymetry"
);

var lon = -88.078;
var lat = 42.508;

Map.setCenter(lon, lat, 5);

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({ min: 0, max: 255 });

// Degrees in EPSG:3857.
var delta = 10;
// Width and height of the thumbnail image.
var pixels = 256;

var image = globathy.visualize({
  min: 1,
  max: 700,
  palette: [
    "001219",
    "005f73",
    "0a9396",
    "94d2bd",
    "e9d8a6",
    "ee9b00",
    "ca6702",
    "bb3e03",
    "ae2012",
    "9b2226",
  ],
});
Map.addLayer(image, {}, "GloBathy Bathymetry (m)", false);

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

Map.addLayer(imageWithBackground, {}, "GloBathy Bathymetry");

print(ui.Thumbnail({ image: imageWithBackground, params: imageParams }));
