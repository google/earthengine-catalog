var dataset = ee.FeatureCollection('USGS/LIMA/SR_METADATA');

// Calculate the age of each feature by subtracting
// the acquisition date from "today".
var feature_ages = dataset.map(
  function(feature) {
    var today = ee.Date.fromYMD(2024, 1, 12);
    var acq_date = ee.Date.parse(
      'yyyy-MM-dd', feature.get('ACQ_DATE'));
    var diff = today.difference(acq_date, 'day');
    return feature.set({'ACQ_AGE': diff});
  }
);

// Reduce by calculating the smallest ACQ_AGE,
// which gives the most recent acquisition date for
// that area.
var reduced_ages = feature_ages.reduceToImage({
  properties: ['ACQ_AGE'],
  reducer: ee.Reducer.min()
});

var reduced_ages_vis = {
  min: 6000,
  max: 9000,
  palette: ['00ff00', 'ff0000'],
};

var lon = -43.6;
var lat = -74.2;
var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.setCenter(lon, lat, 2);
Map.addLayer(
  reduced_ages,
  reduced_ages_vis,
  'Acquisition Age');