var image = ee.Image("LARSE/GEDI/GRIDDEDVEG_002/V1/6KM/gediv002_sens-a0_vf_20230101_20230316");

var lon = -46.46;
var lat = -11;
Map.setCenter(lon, lat, 5);

var delta = 5;
var pixels = 256;// Width and height of the thumbnail image.
var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);
var visParams = {
dimensions: [pixels, pixels],
region: areaOfInterest,
crs: 'EPSG:4326',
format: 'png',
};

var palette = ['darkred','red','orange','green','darkgreen'];
var p95 = image.select('p95');
var imagep95 = p95.visualize(
    {palette: palette, min: 1, max: 60});

var background = ee.Image.rgb(255, 255, 255).visualize({min: 0, max: 255});

var imageWithBackground = ee.ImageCollection([background, imagep95]).mosaic();
Map.addLayer(imagep95, {}, 'p95');
print(ui.Thumbnail({image: imageWithBackground, params: visParams}));