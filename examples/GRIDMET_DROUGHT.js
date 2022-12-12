var collection = ee.ImageCollection('GRIDMET/DROUGHT');
print(collection);

// Filter by date
var dS = '2020-03-30';
var dE = '2020-03-30';
var dSUTC = ee.Date(dS, 'GMT');
var dEUTC = ee.Date(dE, 'GMT');
var filtered = collection.filterDate(dSUTC, dEUTC.advance(1, 'day'));
print(collection.aggregate_array('system:index'));

// Select variables pdsi and z
var PDSI = filtered.select('pdsi');
var Z = filtered.select('z');

// Select variables for SPI/SPEI/EDDI
// Note that possible timescales for SPI/SPEI/EDDI are:
// 14d (14 day), 30d (30 day), 90d (90 day), 180d (180 day),
// 1y (1 year), 2y (2 year), 5y (5 year)
// Here we choose 2years = 48 months
var SPI2y = filtered.select('spi2y');
var SPEI2y = filtered.select('spei2y');
var EDDI2y = filtered.select('spei2y');

// Make a color palette that is similar to USDM drought classification
var usdmColors = "0000aa,0000ff,00aaff,00ffff,aaff55,ffffff,ffff00,fcd37f,ffaa00,e60000,730000";

// Make color options for standardized variables spi/spei/eddi
var minColorbar= -2.5;
var maxColorbar= 2.5;
var colorbarOptions1 = {
  'min':minColorbar,
  'max':maxColorbar,
  'palette': usdmColors
};

// Make color options for Palmer variables psdi/z
var minColorbar= -6;
var maxColorbar= 6;
var colorbarOptions2 = {
  'min':minColorbar,
  'max':maxColorbar,
  'palette': usdmColors
};

// Add map layers to Google Map
Map.addLayer(ee.Image(PDSI.first()), colorbarOptions2, 'PDSI');
Map.addLayer(ee.Image(Z.first()), colorbarOptions2, 'Palmer-Z');
Map.addLayer(ee.Image(SPI2y.first()), colorbarOptions1, 'SPI-48months');
Map.addLayer(ee.Image(SPEI2y.first()), colorbarOptions1, 'SPEI-48months');
Map.addLayer(ee.Image(EDDI2y.first()), colorbarOptions1, 'EDDI-48months');
