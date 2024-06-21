var dataset = ee.ImageCollection('NASA/GPM_L3/IMERG_MONTHLY_V07')
    .filterDate('2022-01-01', '2023-01-01');

// Select the max precipitation and mask out low precipitation values.
var precipitation = dataset.select('precipitation').max();
var mask = precipitation.gt(0.25);
var precipitation = precipitation.updateMask(mask);

var palette = [
  '000096','0064ff', '00b4ff', '33db80', '9beb4a',
  'ffeb00', 'ffb300', 'ff6400', 'eb1e00', 'af0000'
];
var precipitationVis = {min: 0.0, max: 1.5, palette: palette};
Map.addLayer(precipitation, precipitationVis, 'Precipitation (mm/hr)');
Map.setCenter(-76, 33, 3);
