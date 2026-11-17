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

// Annual sine, annual cosine and semi-annual cosine as RGB; a tighter range than in the
// example so the seasonal pattern shows at basin scale.
var visParams = {min: [-0.75, -1, -0.5], max: [1, 0.5, 0.5]};

// Central Amazon basin, Brazil.
var lon = -66.0;
var lat = -4.2;
Map.setCenter(lon, lat, 6);

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
var imageWithBackground =
    ee.ImageCollection([background, image.visualize(visParams)]).mosaic();
Map.addLayer(imageWithBackground, {}, 'HH seasonal coefficients (sin, cos, cos2)');

var parameters = {
  dimensions: [256, 256],
  region: ee.Geometry.Rectangle([-70.0, -8.1759, -62.0, -0.2038], null, false),
  crs: 'EPSG:3857',
  format: 'png'
};
print(ui.Thumbnail({image: imageWithBackground, params: parameters}));
