var dataset = ee.ImageCollection('projects/gtac-data-publish/assets/TreeMap/Product_Version/2026-1');

// Filter to the 2023 CONUS image and convert to a single image.
var treemap = dataset.filter(ee.Filter.calendarRange(2023, 2023, 'year'))
               .filter('study_area == "CONUS"').first();

// Pull band names client-side once so we can resolve schema differences
// between product years (for example 2023 vs 2016 variable naming).
var availableBands = ee.List(treemap.bandNames()).getInfo();

// load palette definitions
var palettes_gena = require('users/gena/packages:palettes');

// 'Official' TreeMap visualization palettes
var palettes = {
  bamako: palettes_gena.crameri.bamako[10],
  lajolla: palettes_gena.crameri.lajolla[10],
  imola: palettes_gena.crameri.imola[10],     
};

var palettesR = {
  bamako_r:   palettes.bamako.slice().reverse(),
  lajolla_r:  palettes.lajolla.slice().reverse(),
  imola_r:    palettes.imola.slice().reverse()
};

function resolveBandName(candidates, bandList) {
  for (var i = 0; i < candidates.length; i++) {
    if (bandList.indexOf(candidates[i]) > -1) {
      return candidates[i];
    }
  }
  return null;
}

// Define each band's (attributes) visualization parameters
var layers = [
        
  {bands: ['FLDTYPCD'],                                                             name: 'Field Forest Type Code',                                   shown: true},
  {bands: ['FORTYPCD'],                                                             name: 'Algorithm Forest Type Code',                               shown: false},
  {bands: ['FLDSZCD'],                                                              name: 'Field Stand-Size Class Code',                              shown: false},
  {bands: ['STDSZCD'],                                                              name: 'Algorithm Stand-Size Class Code',                          shown: false},
  {bands: ['TM_ID', 'Value'],                                                       name: 'TreeMap ID',                                               shown: false},
  {bands: ['VOLCFNET_L'],        min: 137, max: 5790,  palette: palettesR.imola_r,  name: 'Volume, Live (ft³/acre)',                                  shown: false},
  {bands: ['VOLCFNET_D'],        min: 5,   max: 1326,  palette: palettesR.imola_r,  name: 'Volume, Standing Dead (ft³/acre)',                         shown: false},
  {bands: ['VOLBFNET_L'],        min: 441, max: 36522, palette: palettesR.imola_r,  name: 'Volume, Live (sawlog-board-ft/acre)',                      shown: false},
  {bands: ['TPA_LIVE'],          min: 252, max: 1666,  palette: palettesR.bamako_r, name: 'Live Trees Per Acre',                                      shown: false},
  {bands: ['TPA_DEAD'],          min: 38,  max: 126,   palette: palettes.bamako,    name: 'Dead Trees Per Acre',                                      shown: false},
  {bands: ['STANDHT'],           min: 23,  max: 194,   palette: palettesR.bamako_r, name: 'Height of Dominant Trees (ft)',                            shown: false},
  {bands: ['SDIsum', 'SDIPCT_RMRS'], min: 30,  max: 460,   palette: palettesR.bamako_r, name: 'Sum of Stand Density Index',                               shown: false},
  {bands: ['QMD', 'QMD_RMRS'],   min: 2,   max: 25,    palette: palettesR.bamako_r, name: 'Stand Quadratic Mean Diameter (in)',                       shown: false},
  {bands: ['GSSTK'],             min: 0,   max: 100,   palette: palettesR.bamako_r, name: 'Growing-Stock Stocking (%)',                               shown: false},
  {bands: ['DRYBIO_L'],          min: 4,   max: 118,   palette: palettesR.lajolla_r,name: 'Dry Live Tree Biomass, Above Ground (tons/acre)',          shown: false},
  {bands: ['DRYBIO_D'],          min: 0,   max: 10,    palette: palettes.lajolla,   name: 'Dry Standing Dead Tree Biomass, Above Ground (tons/acre)', shown: false},
  {bands: ['CARBON_L'],          min: 2,   max: 50,    palette: palettesR.lajolla_r,name: 'Carbon, Live Above Ground (tons/acre)',                    shown: false},
  {bands: ['CARBON_DWN'],        min: 0,   max: 15,    palette: palettes.lajolla,   name: 'Carbon, Down Dead (tons/acre)',                            shown: false},
  {bands: ['CARBON_D'],          min: 0,   max: 10,    palette: palettes.lajolla,   name: 'Carbon, Standing Dead (tons/acre)',                        shown: false},
  {bands: ['CANOPYPCT'],         min: 0,   max: 100,   palette: palettesR.bamako_r, name: 'Live Canopy Cover (%)',                                    shown: false},
  {bands: ['BALIVE'],            min: 24,  max: 217,   palette: palettesR.bamako_r, name: 'Live Tree Basal Area (ft²/acre)',                          shown: false},
  {bands: ['ALSTK'],             min: 0,   max: 100,   palette: palettesR.bamako_r, name: 'All-Live-Tree Stocking (%)',                               shown: false}
  ];




// Load all attributes to the map with their corresponding visualization parameters
layers.forEach(function(layer){
  var selectedBand = resolveBandName(layer.bands, availableBands);
  if (!selectedBand) {
    print('Skipping missing band(s): ' + layer.bands.join(', '));
    return;
  }

  var image = treemap.select(selectedBand);
  var layerName = selectedBand + ': ' + layer.name;
  if (layer.min === undefined) {
    // For categorical bands like FORTYPCD, Earth Engine will automatically 
    // use the default visualization (gee:classes colors) saved on the asset 
    // when we pass an empty visParams object.
    Map.addLayer(image, {}, layerName, layer.shown);
  } else {
    Map.addLayer(image, {
      min : layer.min,
      max : layer.max,
      palette : layer.palette
    }, layerName, layer.shown);
  }
});


// Set basemap
Map.setOptions('TERRAIN');

// Center map on CONUS
Map.setCenter(-95.712891, 38, 5);