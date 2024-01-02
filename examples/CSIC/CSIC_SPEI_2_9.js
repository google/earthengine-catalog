// Retrieve the last date from the SPEI dataset.
var dataset = ee.ImageCollection("CSIC/SPEI/2_9").
  filterDate('2022-12-01', '2023-01-01');

// Select the 24-month analysis.
var spei24 = dataset.select('SPEI_24_month');

// Set the visualization ranges and color palette.
var visParams = {
  min: -2.33,
  max:  2.33,
  palette: [
    '8b1a1a', 'de2929', 'f3641d',
    'fdc404', '9afa94', '03f2fd',
    '12adf3', '1771de', '00008b',
  ]
};

// Set the map center to Spain's location.
Map.setCenter(-3.75, 40.47, 4);

// Display the SPEI 24-month layer.
Map.addLayer(spei24, visParams, 'SPEI 24 month');
