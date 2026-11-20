var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/results/multiannual/v1');

// ---- Choose a site ----------------------------------------------------
// Replace 'tonleSap' with 'sundarbans' or 'pantanal'
// (sites are listed in SITES below).
var SITE = 'tonleSap';

// ---- Choose a window --------------------------------------------------
// 3-year: '2017-2019', '2020-2022' or '2023-2025';
// 5-year: '2017-2021', '2019-2023' or '2021-2025'.
var PERIOD = '2023-2025';

// Select one window and mosaic the regional tiles.
var typology = dataset.filter(ee.Filter.eq('period', PERIOD)).mosaic();

// One color per class value from 1 to 31 (values 6-9 and 17-20 are unused).
var typologyVis = {
  bands: ['mode_class'],
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

var probabilityVis = {
  bands: ['mean_prob'],
  min: 0,
  max: 100,
  palette: ['7e1700', '995215', 'b0802b', 'c8b455', 'd0e3a3', 'a4e5d3', '5dc1d3', '3292c2',
            '2064ae', '033198'],
};

// Sites [lon, lat, zoom]; add your own to explore elsewhere.
var SITES = {
  tonleSap: [104.0, 12.95, 9],   // Tonle Sap lake and floodplain, Cambodia
  sundarbans: [89.2, 21.9, 10],  // Sundarbans mangroves, Bangladesh and India
  pantanal: [-57.2, -18.2, 10],  // Pantanal, Brazil
};
var site = SITES[SITE];

Map.setCenter(site[0], site[1], site[2]);
Map.addLayer(typology, probabilityVis, 'Mean wetland probability (' + PERIOD + ')', false);
Map.addLayer(typology, typologyVis, 'Dominant wetland type (' + PERIOD + ')');
