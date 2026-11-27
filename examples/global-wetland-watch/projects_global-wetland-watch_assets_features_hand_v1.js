var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/features/hand/v1');

// ---- Choose a site ----------------------------------------------------
// Replace 'kigezi' with 'luangPrabang' or 'manaus'
// (sites are listed in SITES below).
var SITE = 'kigezi';

// Mosaic the tiles, convert to meters and keep the native 1 arc-second grid
// (needed for the hillshade).
var hand = dataset.mosaic().multiply(0.1)
    .setDefaultProjection(dataset.first().projection());

var handVis = {
  bands: ['hand_1000'],
  min: 0,
  max: 50,
  palette: ['260d40', '3e2e5e', '544d7b', '71618c', '93658f', 'bd6992', 'd586aa',
            'dfabc9', 'e9cee4', 'f0eafa'],
};

// HAND colors shaded by a hillshade of HAND itself, so the terrain stands out.
var shade = ee.Terrain.hillshade(hand.select('hand_1000')).divide(255);
var shaded = hand.visualize(handVis).multiply(shade.multiply(0.6).add(0.4)).uint8();

// The three drainage networks as RGB: red = major rivers, green = medium rivers,
// blue = small streams. Dark areas are low relative to all three. Use this layer
// with the Inspector to read HAND values (m) for all three networks.
var rgbVis = {bands: ['hand_100000', 'hand_1000', 'hand_100'], min: 0, max: [250, 100, 40],
              gamma: 0.8};

// Sites [lon, lat, zoom]; add your own to explore elsewhere.
var SITES = {
  kigezi: [29.95, -1.25, 11],         // Kigezi highlands, south-western Uganda
  luangPrabang: [102.13, 19.88, 12],  // Mekong valley near Luang Prabang, Laos
  manaus: [-60.0, -3.1, 11],          // Amazon floodplain near Manaus, Brazil
};
var site = SITES[SITE];

Map.setCenter(site[0], site[1], site[2]);
Map.addLayer(hand, rgbVis, 'HAND, three drainage networks (RGB)', false);
Map.addLayer(shaded, {}, 'HAND, medium rivers (shaded)');
