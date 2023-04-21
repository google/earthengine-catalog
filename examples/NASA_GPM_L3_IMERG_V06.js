// GPM V6 30 minute data around hurricane Dorian for a single day.
var range = ee.Date('2019-09-03').getRange('day');
var dataset = ee.ImageCollection('NASA/GPM_L3/IMERG_V06')
    .filter(ee.Filter.date(range));

// Select the max precipitation and mask out low precipitation values.
var precipitation = dataset.select('precipitationCal').max();
var mask = precipitation.gt(0.5);
var precipitation = precipitation.updateMask(mask);

var palette = [
  '000096','0064ff', '00b4ff', '33db80', '9beb4a',
  'ffeb00', 'ffb300', 'ff6400', 'eb1e00', 'af0000'
];
var precipitationVis = {min: 0.0, max: 15.0, palette: palette};
Map.addLayer(precipitation, precipitationVis, 'Precipitation');
Map.setCenter(-76, 33, 3);
