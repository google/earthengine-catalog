var imageCollection = ee.ImageCollection(
  "projects/global-precipitation-nowcast/assets/global_estimation"
);

// Select a single estimate.
var singleEstimate = imageCollection.filterDate('2022-12-30T12-00').first(); 
// mask to remove 0 values
var masked = singleEstimate.selfMask();


// Display on map.
var visParams = {
  min: 0,
  max: 15,
  palette: [
    '000096','0064ff', '00b4ff', '33db80', '9beb4a',
    'ffeb00', 'ffb300', 'ff6400', 'eb1e00', 'af0000'
  ]
};

Map.addLayer(
  masked,
  visParams,
  "Preciptation retrieval for 2022-12-30T12-00 in mm/hr"
);
