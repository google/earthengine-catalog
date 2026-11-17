var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/coastal/tidal_composites/v1');

// ---- Choose a site ----------------------------------------------------
// Replace 'bijagos' with 'wadden', 'korea', 'herbertCreek' or 'sanSebastian'
// (sites are listed in SITES below).
var SITE = 'bijagos';

// ---- Choose a period --------------------------------------------------
// '2017-2019', '2020-2022' or '2023-2025'; '2017-2022' where only the 6-year
// composite exists (persistently cloudy, dark or icy coasts).
var PERIOD = '2023-2025';

var period = dataset.filter(ee.Filter.eq('period', PERIOD));
var highTide = period.filter(ee.Filter.eq('tide_state', 'high')).mosaic();
var lowTide = period.filter(ee.Filter.eq('tide_state', 'low')).mosaic();

var rgbVis = {bands: ['B4', 'B3', 'B2'], min: 0, max: 2300};

// Sites [lon, lat, zoom]; add your own to explore elsewhere.
var SITES = {
  bijagos: [-15.75, 11.35, 10],         // Bijagos Archipelago, Guinea-Bissau
  wadden: [8.45, 53.7, 11],             // Wadden Sea, Germany
  korea: [126.258, 34.923, 12],         // Tidal flats of south-western Korea
  herbertCreek: [149.72, -22.4, 12],    // Herbert Creek, Queensland, Australia
  sanSebastian: [-68.4, -53.2, 11],     // Bahia San Sebastian, Argentina
};
var site = SITES[SITE];

// Side-by-side maps with a slider: high tide on the left, low tide on the right.
// Both maps are centered on the site before they are linked and displayed.
var leftMap = ui.Map();
var rightMap = ui.Map();
leftMap.setCenter(site[0], site[1], site[2]);
rightMap.setCenter(site[0], site[1], site[2]);
leftMap.addLayer(highTide, rgbVis, 'High tide (' + PERIOD + ')');
rightMap.addLayer(lowTide, rgbVis, 'Low tide (' + PERIOD + ')');
leftMap.add(ui.Label('High tide'));
rightMap.add(ui.Label('Low tide', {position: 'top-right'}));
ui.Map.Linker([leftMap, rightMap]);
ui.root.widgets().reset(
    [ui.SplitPanel({firstPanel: leftMap, secondPanel: rightMap, wipe: true})]);
