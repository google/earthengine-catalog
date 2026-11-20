var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/results/annual/v1');

// ---- Choose a site ----------------------------------------------------
// Replace 'mahakam' with 'mamiraua', 'congo' or 'okavango'
// (sites are listed in SITES below).
var SITE = 'mahakam';

// ---- Choose a year ----------------------------------------------------
// Any year from 2017 to 2025.
var YEAR = 2024;

// Images are tiled by region; select one year and mosaic the tiles.
var typology = dataset.filter(ee.Filter.eq('year', YEAR)).mosaic();

// One color per class value from 1 to 31 (values 6-9 and 17-20 are unused).
var typologyVis = {
  bands: ['wetland_classification'],
  min: 1,
  max: 31,
  palette: [
    'f2d27c',  // 1  Sandy shoreline
    'c06b3e',  // 2  Muddy shoreline
    '6f6f6f',  // 3  Rocky shoreline
    'e6d8a8',  // 4  Salt marsh
    '7fa65a',  // 5  Intertidal forest and shrub
    'ffffff', 'ffffff', 'ffffff', 'ffffff',  // 6-9 (unused)
    '1f5f3a',  // 10 Permanent marsh
    'b5cf4a',  // 11 Seasonal floodplain marsh
    '4e7a55',  // 12 Forested wetland
    'f1a6a6',  // 13 Aquafarm
    '7a5b2e',  // 14 Bog
    'b89a5a',  // 15 Fen
    'f0d35c',  // 16 Aquatic and semi-aquatic cropland
    'ffffff', 'ffffff', 'ffffff', 'ffffff',  // 17-20 (unused)
    '3fa9a6',  // 21 Reservoir
    '7fe3e6',  // 22 Canal, ditch and drain
    '8f63a8',  // 23 Salt and soda lake
    'e8ddf0',  // 24 Saltpan
    '5fa8d3',  // 25 Lake
    '4f66b2',  // 26 Coastal river delta and estuary
    '1f3f7a',  // 27 Ocean
    '6a8fd9',  // 28 River and stream
    'c7dbf2',  // 29 Floodplain
    '3b86b3',  // 30 Lagoon
    'bdbdbd',  // 31 Unclassified water
  ],
};

// Model confidence that a pixel is a wetland (%).
var probabilityVis = {
  bands: ['wetland_probability'],
  min: 0,
  max: 100,
  palette: ['7e1700', '995215', 'b0802b', 'c8b455', 'd0e3a3', 'a4e5d3', '5dc1d3', '3292c2',
            '2064ae', '033198'],
};

// Sites [lon, lat, zoom]; add your own to explore elsewhere.
var SITES = {
  mahakam: [117.35, -0.6, 10],  // Mahakam Delta, East Kalimantan, Indonesia
  mamiraua: [-65.3, -2.5, 11],  // Amazon floodplain, Mamiraua Reserve, Brazil
  congo: [18.0, -0.8, 10],      // Cuvette Centrale peat swamp forests, Congo
  okavango: [22.9, -19.3, 10],  // Okavango Delta, Botswana
};
var site = SITES[SITE];

Map.setCenter(site[0], site[1], site[2]);
Map.addLayer(typology, probabilityVis, 'Wetland probability (' + YEAR + ')', false);
Map.addLayer(typology, typologyVis, 'Wetland typology (' + YEAR + ')');
