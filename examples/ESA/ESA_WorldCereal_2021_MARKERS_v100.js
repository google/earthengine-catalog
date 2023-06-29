// var dataset = ee.ImageCollection('ESA/WorldCereal/2021/MARKERS/v100')
var dataset = ee.ImageCollection('projects/worldcereal/assets/2021_activecropland_v100')

// Set satellite background
Map.setOptions('SATELLITE');

// Filter on AEZ
var aez_46173 = dataset.filter('aez_id == 46173');

// Get the active cropland marker for the different seasons
var activemarker_summerseason = aez_46173.filter('season == "tc-maize-main"');
var activemarker_winterseason = aez_46173.filter('season == "tc-wintercereals"');

// Visualization specifics: red is inactive, green is active cropland
var visualization = {
  bands: ["classification"],
  max: 100,
  palette: ["eb0000","37e622"]
};

// Show active cropland in two major growing seasons in US.
Map.addLayer(activemarker_summerseason, visualization, 'Active cropland tc-maize-main');
Map.addLayer(activemarker_winterseason, visualization, 'Active cropland tc-wintercereals');

Map.setCenter(-98.987, 38.0454, 11)
