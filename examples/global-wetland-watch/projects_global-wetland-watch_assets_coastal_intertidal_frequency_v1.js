var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/coastal/intertidal_frequency/v1');

// Select one period: some areas have both 3-year periods and a 6-year period.
var image = dataset
    .filter(ee.Filter.eq('tide_state', 'all-tide'))
    .filter(ee.Filter.eq('period', '2023-2025'))
    .mosaic();

var freqVis = {
  bands: ['inundationFrequency'],
  min: 0,
  max: 100,
  palette: ['f7fcb9', 'addd8e', '41ab5d', '1d91c0', '253494'],
};

var countVis = {
  bands: ['observationCount'],
  min: 0,
  max: 100,
  palette: ['000004', '51127c', 'b73779', 'fc8961', 'fcfdbf'],
};

// Sites of interest [lon, lat, zoom]. Change the line below to visit another site,
// e.g. SITES.korea.
var SITES = {
  wadden: [8.6, 53.7, 11],              // Wadden Sea, Germany
  korea: [126.258, 34.923, 12],         // Tidal flats of south-western Korea
  herbertCreek: [149.7, -22.4, 12],     // Herbert Creek, Queensland, Australia
  sanSebastian: [-68.4, -53.2, 11],     // Bahia San Sebastian, Argentina
};
var site = SITES.wadden;

Map.setCenter(site[0], site[1], site[2]);
Map.addLayer(image, countVis, 'Valid observations', false);
Map.addLayer(image.selfMask(), freqVis, 'Inundation frequency, all tides (%)');
