var dataset = ee.ImageCollection('NASA/GSFC/MERRA/aer_nv/2')
                  .filter(ee.Filter.date('1985-02-01', '1985-02-02'));
var image = dataset.first()
var lon = 26.73;
var lat = 4.26;
Map.setCenter(lon, lat, 2);
var delta = 50;
// Width and height of the thumbnail image.
var pixels = 256;
var pressure_thickness = image.select('DELP_72');
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
    {palette: palette, min: 1194.9099111470955, max: 1749.3213800941699});
Map.addLayer(image1, {}, 'pressure_thickness');
print(ui.Thumbnail({image: image1, params: visParams}));