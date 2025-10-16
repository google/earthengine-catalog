var svh = ee.ImageCollection(
    "projects/global-pasture-watch/assets/gsvh-30m/v1/short-veg-height_m"
)

var lon = -51.24642275;
var lat = -15.10079993;

var svh = svh.filterDate('2020-01-01', '2021-01-01').first().divide(100);

var palette = ["#fcffa4","#f98d0a","#bb3755","#57106e","#000004"];
var vis = {min: 0, max: 1, palette: palette};

var background = ee.Image.rgb(255, 255, 255).visualize({min: 0, max: 255});
Map.addLayer(background, {min: 0, max: 1});

Map.setCenter(lon, lat, 14);
Map.addLayer(svh, vis);

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

var image = svh.visualize({palette: palette, min: 0, max:1});
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();
print(ui.Thumbnail({image: image, params: parameters}));