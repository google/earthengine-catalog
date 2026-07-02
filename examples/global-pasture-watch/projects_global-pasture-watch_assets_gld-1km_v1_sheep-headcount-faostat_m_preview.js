var headcount = ee.ImageCollection(
  "projects/global-pasture-watch/assets/gld-1km/v1/sheep-headcount-faostat_m"
)

var lon = 73; //-47.50;
var lat = 35; //-7.20;

var headcount = headcount.filterDate('2020-01-01', '2021-01-01').first()

var palette = ["#d7d7d7","#ffffd4","#fed98e","#fe9929","#d95f0e", "#993404"];
var vis = {min: 0, max: 160, palette: palette};

var background = ee.Image.rgb(255, 255, 255).visualize({min: 0, max: 255});
Map.addLayer(background, {min: 0, max: 1});

Map.setCenter(lon, lat, 6);
Map.addLayer(headcount, vis);

var delta = 0.043 * 50;
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var parameters = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png'
};

var image = headcount.divide(160).visualize({palette: palette, min: 0, max:1});
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();
print(ui.Thumbnail({image: image, params: parameters}));