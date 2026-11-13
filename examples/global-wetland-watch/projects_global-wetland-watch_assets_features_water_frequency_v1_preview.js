var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/features/water/frequency/v1');
var image = dataset.filter(ee.Filter.eq('product', 'multiannual')).mosaic().selfMask();

var visParams = {
  bands: ['swf'],
  min: 0,
  max: 100,
  palette: ['ffffff', 'b3cde3', '6497b1', '005b96', '03396c'],
};

var lon = -57.2;
var lat = -18.2;
Map.setCenter(lon, lat, 9);

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
var imageWithBackground =
    ee.ImageCollection([background, image.visualize(visParams)]).mosaic();
Map.addLayer(imageWithBackground, {}, 'Surface water frequency (2017-2025)');

var delta = 0.5;
var parameters = {
  dimensions: [256, 256],
  region: ee.Geometry.Rectangle(
      [lon - delta, lat - delta, lon + delta, lat + delta], null, false),
  crs: 'EPSG:3857',
  format: 'png'
};
print(ui.Thumbnail({image: imageWithBackground, params: parameters}));
