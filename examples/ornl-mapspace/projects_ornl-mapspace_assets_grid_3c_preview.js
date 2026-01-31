
var ms_grid3c = ee.ImageCollection(
  'projects/ornl-mapspace/assets/grid_3c');


var startDate = ee.Date('2021-01-01');
var endDate = startDate.advance(1, 'year');
var ms_grid3c2021 = ms_grid3c.filterDate(startDate, endDate);

var img_mosaic = ms_grid3c.mosaic();

var ms_grid3cVis = {bands: 'label',min: 10, max: 30, palette: ['3eca76','cf6aa6','e6e5d8']};


var lon = 18.25;
var lat = 8.06;

Map.setCenter(lon, lat, 4);

// Degrees in EPSG:3857.
var delta = 45;
// Width and Height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest, crs: 'EPSG:3857', format: 'png'};

var image = img_mosaic.visualize(ms_grid3cVis);

Map.addLayer(areaOfInterest, {color: 'red'}, 'Area of Interest', false);

print(ui.Thumbnail({image: image, params: visParams}));