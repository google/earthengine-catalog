var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/results/annual/v1');

// Images are tiled by region; select one year and mosaic the tiles.
var typology2024 = dataset.filter(ee.Filter.eq('year', 2024)).mosaic();

var typologyVis = {
  bands: ['wetland_classification'],
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

// Model confidence that a pixel is a wetland (%).
var probabilityVis = {
  bands: ['wetland_probability'],
  min: 0,
  max: 100,
  palette: ['ffffcc', 'a1dab4', '41b6c4', '2c7fb8', '253494'],
};

// Sites of interest [lon, lat, zoom]. Change the line below to visit another site,
// e.g. SITES.congo.
var SITES = {
  mamiraua: [-65.3, -2.5, 11],  // Amazon floodplain, Mamiraua Reserve, Brazil
  congo: [18.0, -0.8, 10],      // Cuvette Centrale peat swamp forests, Congo
  okavango: [22.9, -19.3, 10],  // Okavango Delta, Botswana
};
var site = SITES.mamiraua;

Map.setCenter(site[0], site[1], site[2]);
Map.addLayer(typology2024, probabilityVis, 'Wetland probability (2024)', false);
Map.addLayer(typology2024, typologyVis, 'Wetland typology (2024)');
