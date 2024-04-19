var dataset = ee.Image('NASA/GRACE/MASS_GRIDS_V04/LAND/20170501_20170522');
var lon = -65.3243125;
var lat = -2.32792983272088;
Map.setCenter(lon, lat, 2);
var delta = 70;
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
var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
Map.addLayer(background);

var palette = ['001137', '01abab', 'e7eb05', '620500'];
var image1 = lwe_thickness.visualize(
    {palette: palette, min: -0.7845402964290882, max: 0.5693220260300134});
Map.addLayer(image1, {}, 'lwe_thickness');
var imageWithBackground = ee.ImageCollection([background, image1]).mosaic();
print(ui.Thumbnail({image: imageWithBackground, params: visParams}));