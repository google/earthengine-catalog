// Load the HydroATLAS dataset.
var basinATLAS = ee.FeatureCollection("WWF/HydroATLAS/v1/Basins/level6");

// Set visualization to show upstream drainage area.
var upstreamDrainageArea = ee.Image().byte().paint({
  featureCollection: basinATLAS,
  color: 'UP_AREA',
});

// Set map extent to show the Nile and surrounding basins.
Map.setCenter(36.35, 24.0, 4.5);

// Create a viridis colormap.
var viridis = ['#481567FF', '#482677FF', '#453781FF', '#404788FF',
               '#39568CFF', '#33638DFF', '#2D708EFF', '#287D8EFF',
               '#238A8DFF', '#1F968BFF', '#20A387FF', '#29AF7FFF',
               '#3CBB75FF', '#55C667FF', '#73D055FF', '#95D840FF',
               '#B8DE29FF', '#DCE319FF', '#FDE725FF'];

Map.addLayer(upstreamDrainageArea, {palette: viridis, max: 1e5},
             'Upstream Drainage Area [mm]', true, 0.8);
