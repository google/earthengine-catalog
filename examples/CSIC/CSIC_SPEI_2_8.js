// Retrieve the last date from the SPEI dataset.
var dataset = ee.ImageCollection("CSIC/SPEI/2_8").
  filterDate('2021-12-01', '2022-01-01');

// Select the 24-month analysis.
var spei24 = dataset.select('SPEI_24_month');

// Set the visualization ranges and color palette.
var visParams = {
  min: -2.33,
  max:  2.33,
  palette: [
    '8B1A1A', 'DE2929', 'F3641D',
    'FDC404', '9AFA94', '03F2FD',
    '12ADF3', '1771DE', '00008B',
  ]
};

// Set the map center to Spain's location.
Map.setCenter(-3.75, 40.47, 4);

// Display the SPEI 24-month layer.
Map.addLayer(spei24, visParams, 'SPEI 24 month');
