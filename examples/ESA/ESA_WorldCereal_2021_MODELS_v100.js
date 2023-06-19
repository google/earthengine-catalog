// var dataset = ee.ImageCollection('ESA/WorldCereal/2021/MODELS/v100')
var dataset = ee.ImageCollection('projects/worldcereal/assets/2021_v100')

// Typically we'd want to mask the "other" class (value 0)
// in the images
function mask_other(img) {
  return img.updateMask(img.neq(0))
}

// Apply the mask_other function to the collection
dataset = dataset.map(mask_other)

/*--------------------------------------------------
Basic example for a global mosaic of temporary crops
--------------------------------------------------*/

// Get a global mosaic for all AEZ of temporary crops
var temporarycrops = dataset.filter(
  ee.Filter.eq('product', 'temporarycrops')
  ).mosaic()

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

// Get a global mosaic for all AEZ of temporary crops
var maize = dataset.filter(
  ee.Filter.eq('season', 'tc-maize-main')
  ).filter(ee.Filter.eq('product', 'maize')
    ).filter(ee.Filter.eq('aez_id', 46172))

// Visualization specifics
var visualization_class = {
  bands: ["classification"],
  max: 100,
  palette: ["#ebc334"]
};

// Show maize classification
Map.addLayer(maize, visualization_class, 'Maize');
