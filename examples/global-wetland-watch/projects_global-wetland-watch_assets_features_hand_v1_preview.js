var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/features/hand/v1');
var hand = dataset.mosaic().select('hand_1000').multiply(0.1)
    .setDefaultProjection(dataset.first().projection());

var visParams = {
  min: 0,
  max: 50,
  palette: ['260d40', '3e2e5e', '544d7b', '71618c', '93658f', 'bd6992', 'd586aa',
            'dfabc9', 'e9cee4', 'f0eafa'],
};
// HAND colors shaded by a hillshade of HAND itself.
var shade = ee.Terrain.hillshade(hand).divide(255);
var image = hand.visualize(visParams).multiply(shade.multiply(0.6).add(0.4)).uint8();

var lon = 102.13;
var lat = 19.88;
Map.setCenter(lon, lat, 12);

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
var imageWithBackground =
    ee.ImageCollection([background, image]).mosaic();
Map.addLayer(imageWithBackground, {}, 'HAND, medium rivers (m)');

var delta = 0.12;
var parameters = {
  dimensions: [256, 256],
  region: ee.Geometry.Rectangle(
      [lon - delta, lat - delta, lon + delta, lat + delta], null, false),
  crs: 'EPSG:3857',
  format: 'png'
};
print(ui.Thumbnail({image: imageWithBackground, params: parameters}));
