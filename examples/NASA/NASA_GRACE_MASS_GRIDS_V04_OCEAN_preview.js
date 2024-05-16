var dataset = ee.Image('NASA/GRACE/MASS_GRIDS_V04/OCEAN/20020403_20020430');
var lon = -102;
var lat = 36;
Map.setCenter(lon, lat, 2);
var delta = 54;
// Width and height of the thumbnail image.
var pixels = 256;
var lwe_thickness = dataset.select('lwe_thickness_csr');
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);
var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};
var gray = 100;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
Map.addLayer(background);

var palette = ['001137', '01abab', 'e7eb05', '620500'];
var image1 = lwe_thickness.visualize(
    {palette: palette, min: -0.0799629208930322, max: 0.07938676715178997});
Map.addLayer(image1, {}, 'lwe_thickness');
var imageWithBackground = ee.ImageCollection([background, image1]).mosaic();
print(ui.Thumbnail({image: imageWithBackground, params: visParams}));
