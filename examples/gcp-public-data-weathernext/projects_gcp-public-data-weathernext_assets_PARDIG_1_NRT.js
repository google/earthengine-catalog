// PARDIG-NRT 15-minute global precipitation rate for a single timestamp.
var dataset =
    ee.ImageCollection(
          'projects/gcp-public-data-weathernext/assets/PARDIG_1_NRT')
        .filterDate('2021-05-17T12:15:00Z');

// Convert m/hr to mm/hr and mask low precipitation.
var precipitation = dataset.first()
    .select('precipitation')
    .multiply(1000);
precipitation = precipitation.updateMask(precipitation.gt(0.5));

var palette = [
  '000096', '0064ff', '00b4ff', '33db80', '9beb4a',
  'ffeb00', 'ffb300', 'ff6400', 'eb1e00', 'af0000'
];
var precipitationVis = {min: 1, max: 15, palette: palette};

Map.setCenter(78, 20, 4);
Map.addLayer(precipitation, precipitationVis, 'Precipitation (mm/hr)');
