var domi_grassland = ee.ImageCollection(
  "projects/global-pasture-watch/assets/ggc-30m/v1/grassland_c"
);

var lon = -71.15659688;
var lat = 5.93254056;

var domi_grassland_2020 = domi_grassland.filterDate('2020-01-01', '2021-01-01').first();
domi_grassland_2020 = domi_grassland_2020.selfMask()

var palette = [ 'ff9916', 'ffcd73'];
var vis = {min: 1, max: 2, palette: palette};

// Add a white background image to the map.
var background = ee.Image.rgb(255, 255, 255).visualize({min: 0, max: 255});
Map.addLayer(background, {min: 0, max: 1});

Map.setCenter(lon, lat, 4);
Map.addLayer(domi_grassland_2020, vis);

// Degrees in EPSG:3857
var delta = 0.043 * 30;
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var parameters = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png'
};

var image = domi_grassland_2020.visualize(vis);
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();
print(ui.Thumbnail({image: imageWithBackground, params: parameters}));