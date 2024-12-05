var cultiv_grassland = ee.ImageCollection(
  "projects/global-pasture-watch/assets/ggc-30m/v1/cultiv-grassland_p"
);

var lon = -51.24642275;
var lat = -15.10079993;

var cultiv_grassland_2020 = cultiv_grassland.filterDate('2022-01-01', '2023-01-01').first();

var palette = ['#f5f5f5', '#fdaf27', '#ae7947', '#3a2200'];
var vis = {min: 0, max: 100, palette: palette};

Map.setCenter(lon, lat, 10);
Map.addLayer(cultiv_grassland_2020, vis);

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
  forceRgbOutput: true,
};

var image = cultiv_grassland_2020.visualize({palette: palette});
print(ui.Thumbnail({image: image, params: parameters}));