// Import the NLCD collection.
var dataset = ee.ImageCollection('USGS/NLCD');

// The collection contains images for multiple years and regions in the USA.
print('Products:', dataset.aggregate_array('system:index'));

// Filter the collection to the 2016 product.
var nlcd2016 = dataset.filter(ee.Filter.eq('system:index', 'NLCD2016')).first();

// Each product has multiple bands for describing aspects of land cover.
print('Bands:', nlcd2016.bandNames());

// Select the land cover band.
var landcover = nlcd2016.select('landcover');

// Display land cover on the map.
Map.setCenter(-95, 38, 5);
Map.addLayer(landcover, null, 'Landcover');
