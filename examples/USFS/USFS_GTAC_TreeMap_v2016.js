// Load the full dataset
var dataset = ee.ImageCollection('USFS/GTAC/TreeMap/v2016');

// Get the 2016 image
var tm2016 = dataset.filterDate('2016', '2017').first();

// 'Official' TreeMap 2016 palettes
var bamako = ['00404d', '134b42', '265737', '3a652a', '52741c', '71870b', '969206', 'c5ae32', 'e7cd68', 'ffe599'];
var bamako_r = JSON.parse(JSON.stringify(bamako)).reverse();
var lajolla = ['ffffcc','fbec9a','f4cc68','eca855','e48751','d2624d','a54742','73382f','422818','1a1a01'];
var lajolla_r = JSON.parse(JSON.stringify(lajolla)).reverse();
var imola = ['1a33b3','2446a9','2e599f','396b94','497b85','60927b','7bae74','98cb6d','c4ea67','ffff66'];
var imola_r = JSON.parse(JSON.stringify(imola)).reverse();

// Select all 22 attributes
var alstk = tm2016.select('ALSTK');
var balive = tm2016.select('BALIVE');
var canopypct = tm2016.select('CANOPYPCT');
var carbon_d = tm2016.select('CARBON_D');
var carbon_dwn = tm2016.select('CARBON_DWN');
var carbon_l = tm2016.select('CARBON_L');
var drybio_d = tm2016.select('DRYBIO_D');
var drybio_l = tm2016.select('DRYBIO_L');
var fldszcd = tm2016.select('FLDSZCD');
var fldtypcd = tm2016.select('FLDTYPCD');
var fortypcd = tm2016.select('FORTYPCD');
var gsstk = tm2016.select('GSSTK');
var qmd_rmrs = tm2016.select('QMD_RMRS');
var sdipct_rmrs = tm2016.select('SDIPCT_RMRS');
var standht = tm2016.select('STANDHT');
var stdszcd = tm2016.select('STDSZCD');
var tpa_dead = tm2016.select('TPA_DEAD');
var tpa_live = tm2016.select('TPA_LIVE');
var value = tm2016.select('Value');
var volbfnet_l = tm2016.select('VOLBFNET_L');
var volcfnet_d = tm2016.select('VOLCFNET_D');
var volcfnet_l = tm2016.select('VOLCFNET_L');

// Add all attributes to the map with the 'official' visualization
Map.addLayer(alstk, {'min': 0, 'max': 100, 'palette': bamako_r}, 'ALSTK: All-Live-Tree Stocking (percent)', false);
Map.addLayer(balive, {'min': 24, 'max': 217, 'palette': bamako_r}, 'BALIVE: Live Tree Basal Area (ft²)', false);
Map.addLayer(canopypct, {'min': 0, 'max': 100, 'palette': bamako_r}, 'CANOPYPCT: Live Canopy Cover (percent)', false);
Map.addLayer(carbon_d, {'min': 0, 'max': 9, 'palette': lajolla}, 'CARBON_D: Carbon, Standing Dead (tons/acre)', false);
Map.addLayer(carbon_dwn, {'min': 0, 'max': 7, 'palette': lajolla}, 'CARBON_DWN: Carbon, Down Dead (tons/acre)', false);
Map.addLayer(carbon_l, {'min': 2, 'max': 59, 'palette': lajolla_r}, 'CARBON_L: Carbon, Live Above Ground (tons/acre)', false);
Map.addLayer(drybio_d, {'min': 0, 'max': 10, 'palette': lajolla}, 'DRYBIO_D: Dry Standing Dead Tree Biomass, Above Ground (tons/acre)', false);
Map.addLayer(drybio_l, {'min': 4, 'max': 118, 'palette': lajolla_r}, 'DRYBIO_L: Dry Live Tree Biomass, Above Ground (tons/acre)', false);
Map.addLayer(fldszcd, {}, 'FLDSZCD: Field Stand-Size Class Code', false);
Map.addLayer(fldtypcd, {}, 'FLDTYPCD: Field Forest Type Code');
Map.addLayer(fortypcd, {}, 'FORTYPCD: Algorithm Forest Type Code', false);
Map.addLayer(gsstk, {'min': 0, 'max': 100, 'palette': bamako_r}, 'GSSTK: Growing-Stock Stocking (percent)', false);
Map.addLayer(qmd_rmrs, {'min': 2, 'max': 25, 'palette': bamako_r}, 'QMD_RMRS: Stand Quadratic Mean Diameter (in)', false);
Map.addLayer(sdipct_rmrs, {'min': 6, 'max': 99, 'palette': bamako_r}, 'SDIPCT_RMRS: Stand Density Index (percent of maximum)', false);
Map.addLayer(standht, {'min': 23, 'max': 194, 'palette': bamako_r}, 'STANDHT: Height of Dominant Trees (ft)', false);
Map.addLayer(stdszcd, {}, 'STDSZCD: Algorithm Stand-Size Class Code', false);
Map.addLayer(tpa_dead, {'min': 38, 'max': 126, 'palette': bamako}, 'TPA_DEAD: Dead Trees Per Acre', false);
Map.addLayer(tpa_live, {'min': 252, 'max': 1666, 'palette': bamako_r}, 'TPA_LIVE: Live Trees Per Acre', false);
Map.addLayer(value.randomVisualizer(), {}, 'Value: TreeMap ID', false);
Map.addLayer(volbfnet_l, {'min': 441, 'max': 36522, 'palette': imola_r}, 'VOLBFNET_L: Volume, Live (sawlog-board-ft/acre)', false);
Map.addLayer(volcfnet_d, {'min': 5, 'max': 1326, 'palette': imola_r}, 'VOLCFNET_D: Volume, Standing Dead (ft³/acre)', false);
Map.addLayer(volcfnet_l, {'min': 137, 'max': 5790, 'palette': imola_r}, 'VOLCFNET_L: Volume, Live (ft³/acre)', false);

// Set basemap
Map.setOptions('TERRAIN');

// Center map on CONUS
Map.setCenter(-95.712891, 38, 5);