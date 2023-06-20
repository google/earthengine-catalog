// var dataset = ee.ImageCollection('ESA/WorldCereal/2021/MODELS/v100')
var dataset = ee.ImageCollection('projects/worldcereal/assets/2021_v100')

// Typically we'd want to mask the "other" class (value 0)
// in the images
function mask_other(img) {
  return img.updateMask(img.neq(0))
}

// Apply the mask_other function to the collection
dataset = dataset.map(mask_other);

/*--------------------------------------------------
Basic example for a global mosaic of temporary crops
--------------------------------------------------*/

// Get a global mosaic for all AEZ of temporary crops
var temporarycrops = dataset.filter(
  ee.Filter.eq('product', 'temporarycrops')
  ).mosaic();

// Visualization specifics
var visualization_class = {
  bands: ["classification"],
  max: 100,
  palette: ["ff0000"]
};

var visualization_conf = {
  bands: ['confidence'],
  min: [0],
  max: [100],
  palette: ['be0000','fff816','069711'],
};

// Show global classification mosaic
Map.centerObject(temporarycrops);
Map.addLayer(temporarycrops, visualization_class, 'Temporary crops');

// By default don't show confidence layer
Map.addLayer(temporarycrops, visualization_conf, 'Temporary crops confidence', 0);

/*--------------------------------------------------
Advanced example for tc-maize-main season products
in a specific AEZ
--------------------------------------------------*/

// Filter on AEZ and season
var tc_maize_main_46172 = dataset.filter(
  ee.Filter.eq('season', 'tc-maize-main')
  ).filter(ee.Filter.eq('aez_id', 46172));

// Get the different products
var maize = tc_maize_main_46172.filter(ee.Filter.eq('product', 'maize'))
var irrigation = tc_maize_main_46172.filter(ee.Filter.eq('product', 'irrigation'))


// Visualization specifics
var visualization_maize = {
  bands: ["classification"],
  max: 100,
  palette: ["#ebc334"]
};

var visualization_irrigation = {
  bands: ["classification"],
  max: 100,
  palette: ["#2d79eb"]
};


// Show maize classification
Map.addLayer(maize, visualization_maize, 'Maize');
Map.addLayer(irrigation, visualization_irrigation, 'Active irrigation');

// Uncomment the line below to zoom to a region
// where maize, other crops and active irrigation are visible
Map.setCenter(-0.9911, 43.5017, 12)