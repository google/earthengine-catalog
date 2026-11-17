var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/coastal/intertidal_frequency/v1');

// ---- Choose a site ----------------------------------------------------
// Replace 'bahiaBlanca' with 'wadden', 'korea', 'herbertCreek' or 'sanSebastian'
// (sites are listed in SITES below).
var SITE = 'bahiaBlanca';

// ---- Choose a period and variant --------------------------------------
// '2017-2019', '2020-2022' or '2023-2025'; '2017-2022' where clouds, low light
// or sea ice limit observations. Select one period only: some areas have both.
var PERIOD = '2023-2025';
// 'all-tide' (all valid observations) or 'low-tide' (relative low tide only).
var TIDE_STATE = 'all-tide';

var image = dataset
    .filter(ee.Filter.eq('tide_state', TIDE_STATE))
    .filter(ee.Filter.eq('period', PERIOD))
    .mosaic();

var freqVis = {
  bands: ['inundationFrequency'],
  min: 0,
  max: 100,
  palette: ['fff7ec', 'fee8c8', 'fdd49e', 'fdbb84', 'fc8d59', 'ef6548', 'd7301f', 'b30000',
            '7f0000'],
};

var countVis = {
  bands: ['observationCount'],
  min: 0,
  max: 100,
  palette: ['000004', '51127c', 'b73779', 'fc8961', 'fcfdbf'],
};

// Sites [lon, lat, zoom]; add your own to explore elsewhere.
var SITES = {
  bahiaBlanca: [-62.2, -38.95, 11],     // Bahia Blanca estuary, Argentina
  wadden: [8.45, 53.7, 11],             // Wadden Sea, Germany
  korea: [126.258, 34.923, 12],         // Tidal flats of south-western Korea
  herbertCreek: [149.72, -22.4, 12],    // Herbert Creek, Queensland, Australia
  sanSebastian: [-68.4, -53.2, 11],     // Bahia San Sebastian, Argentina
};
var site = SITES[SITE];

Map.setCenter(site[0], site[1], site[2]);
Map.addLayer(image, countVis, 'Valid observations (' + PERIOD + ')', false);
Map.addLayer(image.selfMask(), freqVis,
             'Inundation frequency, ' + TIDE_STATE + ' (' + PERIOD + ', %)');
