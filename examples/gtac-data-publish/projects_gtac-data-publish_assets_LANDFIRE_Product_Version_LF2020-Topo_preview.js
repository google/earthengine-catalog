var dataset = ee.ImageCollection('projects/gtac-data-publish/assets/LANDFIRE/Product_Version/LF2020-Topo');

var rawImage = dataset
    .filterDate('2020-01-01', '2021-01-01')
    .filter(ee.Filter.eq('study_area', 'CONUS'))
    .first()
    .select('Elev');

var visualization = rawImage.visualize({
  min: -100,
  max: 4500,
  palette: ['00204c', '2a4a84', '4d798e', '7ba66f', 'c9cc57', 'fee838']
});

var gray = 150;
var background =
    ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
var imageWithBackground =
    ee.ImageCollection([background, visualization]).mosaic();

var region = ee.Geometry.Rectangle(
    [-106.8, 38.2, -104.3, 40.5], null, false);
var imageParams = {
  dimensions: [512,512],
  region: region,
  crs: 'EPSG:3857',
  format: 'png'
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
