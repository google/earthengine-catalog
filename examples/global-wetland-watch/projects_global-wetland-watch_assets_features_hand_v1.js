var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/features/hand/v1');

// Mosaic the tiles, convert to meters and keep the native 1 arc-second grid.
var hand = dataset.mosaic().multiply(0.1)
    .setDefaultProjection(dataset.first().projection());

var handVis = {
  bands: ['hand_1000'],
  min: 0,
  max: 50,
  palette: ['260d40', '3e2e5e', '544d7b', '71618c', '93658f', 'bd6992', 'd586aa',
            'dfabc9', 'e9cee4', 'f0eafa'],
};

// The three drainage networks as RGB: red = major rivers, green = medium rivers,
// blue = small streams. Dark areas are low relative to all three.
var rgbVis = {bands: ['hand_100000', 'hand_1000', 'hand_100'], min: 0, max: [250, 100, 40],
              gamma: 0.8};

// Sites of interest [lon, lat, zoom]. Change the line below to visit another site,
// e.g. SITES.brahmaputra.
var SITES = {
  luangPrabang: [102.13, 19.88, 12],  // Mekong valley near Luang Prabang, Laos
  brahmaputra: [92.0, 26.6, 11],      // Brahmaputra floodplain, Assam, India
  manaus: [-60.0, -3.1, 11],          // Amazon floodplain near Manaus, Brazil
};
var site = SITES.luangPrabang;

Map.setCenter(site[0], site[1], site[2]);
Map.addLayer(ee.Terrain.hillshade(hand.select('hand_1000')), {min: 100, max: 255}, 'Hillshade');
Map.addLayer(hand, rgbVis, 'HAND, three drainage networks (RGB)', false, 0.75);
Map.addLayer(hand, handVis, 'HAND, medium rivers (m)', true, 0.75);
