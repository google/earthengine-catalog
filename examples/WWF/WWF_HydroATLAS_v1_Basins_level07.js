// Load the HydroATLAS dataset.
var basinATLAS = ee.FeatureCollection('WWF/HydroATLAS/v1/Basins/level07');

// Set visualization to show upstream drainage area.
var upstreamDrainageArea = ee.Image().byte().paint({
  featureCollection: basinATLAS,
  color: 'UP_AREA',
});

// Set map extent to show the Nile and surrounding basins.
Map.setCenter(-43.50, -24.70, 6);

// Create a viridis colormap.
var viridis = [
  '481567', '482677', '453781', '404788', '39568c', '33638d', '2d708e',
  '287d8e', '238a8d', '1f968b', '20a387', '29af7f', '3cbb75', '55c667',
  '73d055', '95d840', 'b8de29', 'dce319', 'fde725'];

// View the continent of South America.
var region = ee.Geometry.BBox(-80, -60, -20, 20);
Map.addLayer(upstreamDrainageArea.clip(region), {palette: viridis, max: 1e5},
             'Upstream Drainage Area [mm]', true, 0.8);
