// Import the NLCD collection.
var dataset = ee.ImageCollection('USGS/NLCD_RELEASES/2021_REL/NLCD');

// The collection contains images for the 2021 year release and the full suite
// of products.
print('Products:', dataset.aggregate_array('system:index'));

// Filter the collection to the 2021 product.
var nlcd2021 = dataset.filter(ee.Filter.eq('system:index', '2021')).first();

// Each product has multiple bands for describing aspects of land cover.
print('Bands:', nlcd2021.bandNames());

// Select the land cover band.
var landcover = nlcd2021.select('landcover');

// Display land cover on the map.
Map.setCenter(-95, 38, 5);
Map.addLayer(landcover, null, 'Landcover');
