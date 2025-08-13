var ugpp = ee.ImageCollection(
    "projects/global-pasture-watch/assets/ggpp-30m/v1/ugpp_m"
)

var lon = 86.02918216;
var lat = 43.73141844;

var ugpp = ugpp.filterDate('2020-01-01', '2021-01-01').first().divide(2500);

var palette = ['#faccfa', '#f19d6b', '#828232', '#226061', '#011959'];
var vis = {min: 0, max: 1, palette: palette};

var background = ee.Image.rgb(255, 255, 255).visualize({min: 0, max: 255});
Map.addLayer(background, {min: 0, max: 1});

Map.setCenter(lon, lat, 14);
Map.addLayer(ugpp, vis);

var delta = 0.043 * 2;
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var parameters = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png'
};

var image = ugpp.visualize({palette: palette, min: 0, max:1});
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();
print(ui.Thumbnail({image: image, params: parameters}));