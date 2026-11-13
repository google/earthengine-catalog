var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/results/multiannual/v1');

// Select the 3-year window 2023-2025 and mosaic the regional tiles.
var window = dataset.filter(ee.Filter.eq('period', '2023-2025')).mosaic();

var typologyVis = {
  bands: ['mode_class'],
  min: 1,
  max: 31,
  // Entry i is the color of class value i + 1; values 6-9 and 17-20 are unused.
  palette: [
    'f2d27c', 'c06b3e', '6f6f6f', 'e6d8a8', '7fa65a',  // 1-5
    'ffffff', 'ffffff', 'ffffff', 'ffffff',            // 6-9
    '1f5f3a', 'b5cf4a', '4e7a55', 'f1a6a6', '7a5b2e',  // 10-14
    'b89a5a', 'f0d35c',                                // 15-16
    'ffffff', 'ffffff', 'ffffff', 'ffffff',            // 17-20
    '3fa9a6', '7fe3e6', '8f63a8', 'e8ddf0', '5fa8d3',  // 21-25
    '4f66b2', '1f3f7a', '6a8fd9', 'c7dbf2', '3b86b3',  // 26-30
    'bdbdbd',                                          // 31
  ],
};

var probabilityVis = {
  bands: ['mean_prob'],
  min: 0,
  max: 100,
  palette: ['ffffcc', 'a1dab4', '41b6c4', '2c7fb8', '253494'],
};

// Sites of interest [lon, lat, zoom]. Change the line below to visit another site,
// e.g. SITES.pantanal.
var SITES = {
  sundarbans: [89.2, 21.9, 10],  // Sundarbans mangroves, Bangladesh and India
  pantanal: [-57.2, -18.2, 10],  // Pantanal, Brazil
};
var site = SITES.sundarbans;

Map.setCenter(site[0], site[1], site[2]);
Map.addLayer(window, probabilityVis, 'Mean wetland probability (2023-2025)', false);
Map.addLayer(window, typologyVis, 'Dominant wetland type (2023-2025)');
