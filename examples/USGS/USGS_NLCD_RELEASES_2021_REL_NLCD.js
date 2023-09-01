var dataset = ee.ImageCollection('projects/usgs-gee-audra-griebel/assets/eros/NLCD_2021/NLCD');
// Import the NLCD collection.
//var dataset = ee.ImageCollection('USGS/NLCD_RELEASES/2021_REL/NLCD');

// The collection contains images for the 2021 year release and the full suite of products.
print('Products:', dataset.aggregate_array('system:index'));

// Filter the collection to the 2021 product.
var nlcd2021 = dataset.filter(ee.Filter.eq('system:index', '2021')).first();

// Each product has multiple bands for describing aspects of land cover.
print('Bands:', nlcd2021.bandNames());

// Select the land cover band.
var landcover = nlcd2021.select('landcover');

var palette = [
  // landcover values
   //'palette': [
    '466b9f', // 11: Open water
    'd1def8', // 12: Perennial ice/snow
    'dec5c5', // 21: Developed, open space
    'd99282', // 22: Developed, low intensity
    'eb0000', // 23: Developed, medium intensity
    'ab0000', // 24: Developed high intensity
    'b3ac9f', // 31: Barren land (rock/sand/clay)
    '68ab5f', // 41: Deciduous forest
    '1c5f2c', // 42: Evergreen forest
    'b5c58f', // 42: Mixed forest
    'ccb879', // 52: Shrub/scrub
    'dfdfc2', // 71: Grassland/herbaceous
    'dcd939', // 81: Pasture/hay
    'ab6c28', // 82: Cultivated crops
    'b8d9eb', // 90: Woody wetlands
    '6c9fb8', // 95: Emergent herbaceous wetlands
   ];
//};

// Map landcover pixel values onto palette indices.
var landcover_values = ee.List([
  11, 12, 21, 22, 23, 24, 31, 41, 42, 43, 52, 71, 81, 82, 90, 95
]);
var max = landcover_values.size().subtract(1);
var landcover_indices = ee.List.sequence(0, max);

// Display land cover on the map.
Map.setCenter(-95, 38, 5);
//Map.addLayer(landcover, vis, 'Landcover');
Map.addLayer(
  landcover.remap(landcover_values, landcover_indices)
    .visualize({min:0, max:max, palette:palette}),
  null, 'landcover');