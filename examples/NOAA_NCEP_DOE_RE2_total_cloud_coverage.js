// Import the dataset, filter the first five months of 2020.
var dataset = ee.ImageCollection('NOAA/NCEP_DOE_RE2/total_cloud_coverage')
                  .filter(ee.Filter.date('2020-01-01', '2020-06-01'));

// Select the total cloud cover band.
var totalCloudCoverage = dataset.select('tcdc');

// Reduce the image collection to per-pixel mean.
var totalCloudCoverageMean = totalCloudCoverage.mean();

// Define visualization parameters.
var vis = {
  min: 0,
  max: 80,  // dataset max is 100
  palette: ['black', 'white'],
};

// Display the dataset.
Map.setCenter(0, 20, 2);
Map.addLayer(totalCloudCoverageMean, vis, 'Total Cloud Coverage Data', false);

// Display a visualization image with opacity defined by cloud cover.
var visImg = totalCloudCoverageMean.visualize(vis)
  .updateMask(totalCloudCoverageMean.divide(100));
Map.addLayer(visImg, null, 'Total Cloud Coverage Vis.', true);
