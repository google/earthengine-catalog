var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/features/hand/v1');
var hand = dataset.mosaic().select('hand_1000').multiply(0.1)
    .setDefaultProjection(dataset.first().projection());

var visParams = {
  min: 0,
  max: 20,
  palette: ['260d40', '3e2e5e', '544d7b', '71618c', '93658f', 'bd6992', 'd586aa',
            'dfabc9', 'e9cee4', 'f0eafa'],
};
// HAND colors shaded by a hillshade of HAND itself.
var shade = ee.Terrain.hillshade(hand).divide(255);
var image = hand.visualize(visParams).multiply(shade.multiply(0.6).add(0.4)).uint8();

// Kigezi highlands, Uganda.
var lon = 29.95;
var lat = -1.25;
Map.setCenter(lon, lat, 11);

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();
Map.addLayer(imageWithBackground, {}, 'HAND, medium rivers (m)');

var parameters = {
  dimensions: [256, 256],
  region: ee.Geometry.Rectangle([29.83, -1.37, 30.07, -1.13], null, false),
  crs: 'EPSG:3857',
  format: 'png'
};
print(ui.Thumbnail({image: imageWithBackground, params: parameters}));
