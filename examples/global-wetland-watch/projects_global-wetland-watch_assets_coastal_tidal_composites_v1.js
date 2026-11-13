var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/coastal/tidal_composites/v1');

var period = dataset.filter(ee.Filter.eq('period', '2023-2025'));
var highTide = period.filter(ee.Filter.eq('tide_state', 'high')).mosaic();
var lowTide = period.filter(ee.Filter.eq('tide_state', 'low')).mosaic();

var rgbVis = {bands: ['B4', 'B3', 'B2'], min: 0, max: 2500};

// Side-by-side maps with a slider: high tide on the left, low tide on the right.
var leftMap = ui.Map();
var rightMap = ui.Map();
leftMap.addLayer(highTide, rgbVis, 'High tide (2023-2025)');
rightMap.addLayer(lowTide, rgbVis, 'Low tide (2023-2025)');
leftMap.add(ui.Label('High tide'));
rightMap.add(ui.Label('Low tide', {position: 'top-right'}));
ui.Map.Linker([leftMap, rightMap]);
ui.root.widgets().reset(
    [ui.SplitPanel({firstPanel: leftMap, secondPanel: rightMap, wipe: true})]);

// Sites of interest [lon, lat, zoom]. Change the line below to visit another site,
// e.g. SITES.korea.
var SITES = {
  wadden: [8.6, 53.7, 11],              // Wadden Sea, Germany
  korea: [126.258, 34.923, 12],         // Tidal flats of south-western Korea
  herbertCreek: [149.7, -22.4, 12],     // Herbert Creek, Queensland, Australia
  sanSebastian: [-68.4, -53.2, 11],     // Bahia San Sebastian, Argentina
};
var site = SITES.wadden;

leftMap.setCenter(site[0], site[1], site[2]);
