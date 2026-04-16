// Use mosaic to hide the tile information.
var dataset = ee.ImageCollection('COPERNICUS/DEM/GLO30').mosaic();

Map.setCenter(-6.746, 46.529, 4);

// Relative, vertical accuracy in form of the standard deviation of
// the interferometric phase error.
var hem = dataset.select('HEM');
var hemVis = {
  // Range of the values is 0.09 to 43.4.
  min: 0.0,
  max: 4.0,
  palette: ['blue', 'green', 'yellow', 'orange', 'darkorange', 'red'],
};
Map.addLayer(hem, hemVis, 'Height Error Mask (HEM; m)', false);

var edm = dataset.select('EDM');
var edmVis = {
  min: 0,
  max: 13,
  palette: [
    'black',      // 0: Void (no data)
    'white',      // 1: Not edited
    'red',        // 2: Infill of external elevation data
    'green',      // 3: Interpolated pixels
    'orange',     // 4: Smoothed pixels
    'yellow',     // 5: Airport editing
    'magenta',    // 6: Raised negative elevation pixels
    'cyan',       // 7: Flattened pixels
    'blue',       // 8: Ocean pixels
    'purple',     // 9: Lake pixels
    'brown',      // 10: River pixels
    'lightgray',  // 11: Shoreline pixels
    'olive',      // 12: Morphed pixels
    'steelblue',  // 13: Shifted pixels
  ],
};
Map.addLayer(edm, edmVis, 'Editing and Masking (EDM)', false, 0.75);

// Source data diagram.
var flm = dataset.select('FLM');
var originalValues = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 100, 101];
var remappedValues = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
var flmRemapped = flm.remap(originalValues, remappedValues).rename('FLM');
var flmVis = {
  min: 0,
  max: 11,
  palette: [
    'black',    // 0: Void (no data)
    'white',    // 1: Edited (except filled pixels)
    'grey',     // 2: Not edited / not filled
    'red',      // 3: ASTER
    'green',    // 4: SRTM90
    'blue',     // 5: SRTM30
    'yellow',   // 6: GMTED2010
    'cyan',     // 7: SRTM30plus
    'magenta',  // 8: TerraSAR-X Radargrammetric DEM
    'orange',   // 9: AW3D30
    'purple',   // 100 -> remapped to 10: Norway DEM
    'brown',    // 101 -> remapped to 11: DSM05 Spain
  ],
};
Map.addLayer(flmRemapped, flmVis, 'Fill and Lineage Mask (FLM)', false, 0.75);

var wbm = dataset.select('WBM');
var wbmVis = {
  min: 0,
  max: 3,
  palette: [
    'lightgray',   // 0: No water.
    'cadetblue',   // 1: Ocean.
    'darkblue',    // 2: Lake.
    'blueviolet',  // 3: River.
  ],
};
Map.addLayer(wbm, wbmVis, 'Water Body Mask (WBM)', false, 0.75);

var dsm = dataset.select('DEM')
              .setDefaultProjection('EPSG:3857', null, 30)
              .rename('DSM');
var dsmVis = {
  min: 0.0,
  max: 3000.0,
  palette:
      ['333399', '00a2e5', '55dd77', 'ffff99', 'aa926b', 'aa928d', 'ffffff'],
};
Map.addLayer(dsm, dsmVis, 'Digital Surface Model (DSM; m)', true, 0.75);

// Multiply by 20 to exaggerate the hillshade for a better visualization.
Map.addLayer(
    ee.Terrain.hillshade(dsm.multiply(20.0)), null,
    'Digital Surface Model (DSM) Hillshade', true, 0.75);
