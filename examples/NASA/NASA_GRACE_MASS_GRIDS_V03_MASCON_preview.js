var dataset = ee.ImageCollection('NASA/GRACE/MASS_GRIDS_V03/MASCON')
                  .filter(ee.Filter.date('2016-08-01', '2016-08-30'));
var image = dataset.first()
var lon = -71;
var lat = 6;
Map.setCenter(lon, lat, 2);
var delta = 50;
// Width and height of the thumbnail image.
var pixels = 256;
var pressure_thickness = image.select('lwe_thickness');
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);
var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};
var palette = ['001137', '01abab', 'e7eb05', '620500'];
var image1 = pressure_thickness.visualize(
    {palette: palette, min: 25, max: -25});
Map.addLayer(image1, {}, 'pressure_thickness');
print(ui.Thumbnail({image: image1, params: visParams}));