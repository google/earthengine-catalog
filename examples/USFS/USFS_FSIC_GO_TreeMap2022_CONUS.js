var dataset = ee.ImageCollection('USFS/GTAC/TreeMap/v2022');

var TreeMap = dataset.filter('year == "2022"')
                     .filter('study_area == "CONUS"') 
                     .first();

// 'Official' TreeMap visualization palettes

var palettes = {
  bamako:     ['00404d','134b42','265737','3a652a','52741c','71870b','969206','c5ae32','e7cd68','ffe599'],
  lajolla:    ['ffffcc','fbec9a','f4cc68','eca855','e48751','d2624d','a54742','73382f','422818','1a1a01'],
  imola:      ['1a33b3','2446a9','2e599f','396b94','497b85','60927b','7bae74','98cb6d','c4ea67','ffff66']
};

var palettesR = {
  bamako_r:   palettes.bamako.reverse(),
  lajolla_r:  palettes.lajolla.reverse(),
  imola_r:    palettes.imola.reverse()
};

// Define each band's (attributes) visualization parameters
var layers = [
  {band: 'FLDSZCD',                                                               name: 'Field Stand-Size Class Code',                              shown: false},      
  {band: 'FLDTYPCD',                                                              name: 'Field Forest Type Code',                                   shown: true},    
  {band: 'FORTYPCD',                                                              name: 'Algorithm Forest Type Code',                               shown: false},    
  {band: 'STDSZCD',                                                               name: 'Algorithm Stand-Size Class Code',                          shown: false},      
  {band: 'TM_ID',                                                                 name: 'TreeMap ID',                                               shown: false}, 
  {band: 'VOLCFNET_L',        min: 137, max: 5790,  palette: palettesR.imola_r,   name: 'Volume, Live (ft³/acre)',                                  shown: false},
  {band: 'VOLCFNET_D',        min: 5,   max: 1326,  palette: palettesR.imola_r,   name: 'Volume, Standing Dead (ft³/acre)',                         shown: false},
  {band: 'VOLBFNET_L',        min: 441, max: 36522, palette: palettesR.imola_r,   name: 'Volume, Live (sawlog-board-ft/acre)',                      shown: false},
  {band: 'TPA_LIVE',          min: 252, max: 1666,  palette: palettesR.bamako_r,  name: 'Live Trees Per Acre',                                      shown: false},
  {band: 'TPA_DEAD',          min: 38,  max: 126,   palette: palettes.bamako,     name: 'Dead Trees Per Acre',                                      shown: false},
  {band: 'STANDHT',           min: 23,  max: 194,   palette: palettesR.bamako_r,  name: 'Height of Dominant Trees (ft)',                            shown: false},
  {band: 'SDIsum',            min: 30,  max: 460,   palette: palettesR.bamako_r,  name: 'Sum of Stand Density Index',                               shown: false},
  {band: 'QMD',               min: 2,   max: 25,    palette: palettesR.bamako_r,  name: 'Stand Quadratic Mean Diameter (in)',                       shown: false},
  {band: 'GSSTK',             min: 0,   max: 100,   palette: palettesR.bamako_r,  name: 'Growing-Stock Stocking (%)',                               shown: false},
  {band: 'DRYBIO_L',          min: 4,   max: 118,   palette: palettesR.lajolla_r, name: 'Dry Live Tree Biomass, Above Ground (tons/acre)',          shown: false},
  {band: 'DRYBIO_D',          min: 0,   max: 10,    palette: palettes.lajolla,    name: 'Dry Standing Dead Tree Biomass, Above Ground (tons/acre)', shown: false},
  {band: 'CARBON_L',          min: 2,   max: 50,    palette: palettesR.lajolla_r, name: 'Carbon, Live Above Ground (tons/acre)',                    shown: false},
  {band: 'CARBON_DWN',        min: 0,   max: 15,    palette: palettes.lajolla,    name: 'Carbon, Down Dead (tons/acre)',                            shown: false},
  {band: 'CARBON_D',          min: 0,   max: 10,    palette: palettes.lajolla,    name: 'Carbon, Standing Dead (tons/acre)',                        shown: false},
  {band: 'CANOPYPCT',         min: 0,   max: 100,   palette: palettesR.bamako_r,  name: 'Live Canopy Cover (%)',                                    shown: false},
  {band: 'BALIVE',            min: 24,  max: 217,   palette: palettesR.bamako_r,  name: 'Live Tree Basal Area (ft²/acre)',                          shown: false},
  {band: 'ALSTK',             min: 0,   max: 100,   palette: palettesR.bamako_r,  name: 'All-Live-Tree Stocking (%)',                               shown: false}
  ];




// Load all attributes to the map with their corresponding visualization parameters

layers.forEach(function(layer){
  var image = TreeMap.select(layer.band);
  var vis = {};
  if (layer.min === undefined) {
    Map.addLayer(image.randomVisualizer(), {}, layer.band + ': ' + layer.name, layer.shown);
  } else {
    Map.addLayer(image, {
    min : layer.min,
    max : layer.max,
    palette : layer.palette
  }, layer.band + ': ' + layer.name, layer.shown);
}
});


// Set basemap
Map.setOptions('TERRAIN');

// Center map on CONUS
Map.setCenter(-95.712891, 38, 5);