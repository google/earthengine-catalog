var nat_semi_grassland = ee.ImageCollection(
  "projects/global-pasture-watch/assets/ggc-30m/v1/nat-semi-grassland_p"
);

var lon = 86.02918216;
var lat = 43.73141844;

var nat_semi_grassland_2020 = nat_semi_grassland.filterDate('2020-01-01', '2021-01-01').first();

var palette = ['#f7f1e5', '#af8260', '#803d3b', '#322c2b'];
var vis = {min: 15, max: 85, palette: palette};

// Add a white background image to the map.
var background = ee.Image.rgb(255, 255, 255).visualize({min: 0, max: 255});
Map.addLayer(background, {min: 0, max: 1});

Map.setCenter(lon, lat, 10);
Map.addLayer(nat_semi_grassland_2020, vis);

// Degrees in EPSG:3857
var delta = 0.043 * 2;
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var parameters = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
  min: 15
};

var image = nat_semi_grassland_2020.visualize({palette: palette});
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();
print(ui.Thumbnail({image: imageWithBackground, params: parameters}));