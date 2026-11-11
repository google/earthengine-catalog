var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/features/ccdc/palsar2/v1');
var ccdc = dataset.mosaic();

// HH harmonic coefficients of the segment containing mid-2020.
var t = 2020.5;
var tStart = ccdc.select('tStart');
var tEnd = ccdc.select('tEnd');
var segment = tStart.lte(t).and(tEnd.gte(t)).arrayArgmax().arrayGet([0])
    .where(tEnd.arrayGet([-1]).lte(t), tEnd.arrayArgmax().arrayGet([0]));
var hh = ccdc.select('HH_coefs').arraySlice(0, segment, segment.add(1)).arrayProject([1]);
var image = ee.Image.cat([hh.arrayGet([3]), hh.arrayGet([2]), hh.arrayGet([4])]);

var visParams = {min: [-1.5, -2, -1], max: [2, 1, 1]};

var lon = 30.5;
var lat = 7.5;
Map.setCenter(lon, lat, 9);

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
var imageWithBackground =
    ee.ImageCollection([background, image.visualize(visParams)]).mosaic();
Map.addLayer(imageWithBackground, {}, 'HH seasonal coefficients (sin, cos, cos2)');

var delta = 0.6;
var parameters = {
  dimensions: [256, 256],
  region: ee.Geometry.Rectangle(
      [lon - delta, lat - delta, lon + delta, lat + delta], null, false),
  crs: 'EPSG:3857',
  format: 'png'
};
print(ui.Thumbnail({image: imageWithBackground, params: parameters}));
