var dataset = ee.ImageCollection('projects/gtac-data-publish/assets/LCMS/Product_Version/2025-11');

var lcms = dataset.filterDate('2023', '2024')  // range: [1985, 2025]
               .filter('study_area == "CONUS"')  // "AK" 
               .first();


// LCMS Change product visualization parameters
var changeViz = {
  min: [1.0],
  max: [16.0],
  palette: [
    'ff09f3',
    '541aff',
    'e4f5fd',
    'cc982e',
    '0adaff',
    'a10018',
    'd54309',
    'fafa4b',
    'afde1c',
    'ffc80d',
    'a64c28',
    'f39268',
    'c291d5',
    '00a398',
    '3d4551',
    '1b1716',
  ],
  bands: ['Change'],
};

// LCMS Land Cover product visualization parameters
var lcViz = {
  min: [1.0],
  max: [15.0],
  palette: [
    '004e2b',
    '009344',
    '61bb46',
    'acbb67',
    '8b8560',
    'cafd4b',
    'f89a1c',
    '8fa55f',
    'bebb8e',
    'e5e98a',
    'ddb925',
    '893f54',
    'e4f5fd',
    '00b6f0',
    '1b1716',
  ],
  bands: ['Land_Cover'],
};

// LCMS Land Use product visualization parameters
var luViz = {
  min: [1.0],
  max: [6.0],
  palette: [
    'fbff97',
    'e6558b',
    '004e2b',
    '9dbac5',
    'a6976a',
    '1b1716',
  ],
  bands: ['Land_Use'],
};


Map.addLayer(lcms.select('Land_Cover'), lcViz, 'Land Cover');
Map.addLayer(lcms.select('Land_Use'), luViz, 'Land Use');
Map.addLayer(lcms.select('Change'), changeViz, 'Vegetation Change', false);

Map.setCenter(-98.58, 38.14, 4);
