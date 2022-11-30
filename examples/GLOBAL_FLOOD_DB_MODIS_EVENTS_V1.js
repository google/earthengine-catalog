var gfd = ee.ImageCollection('GLOBAL_FLOOD_DB/MODIS_EVENTS/V1');

// An individual flood event - flooding due to Hurricane Isaac in the USA.
var hurricaneIsaacDartmouthId = 3977;
var hurricaneIsaacUsa = ee.Image(
    gfd.filterMetadata('id', 'equals', hurricaneIsaacDartmouthId).first());
Map.setOptions('SATELLITE');
Map.setCenter(-90.2922, 29.4064, 9);
Map.addLayer(
  hurricaneIsaacUsa.select('flooded').selfMask(),
  {min: 0, max: 1, palette: '001133'},
  'Hurricane Isaac - Inundation Extent');

// The duration (number of days a flood event lasted).
var durationPalette = ['C3EFFE', '1341E8', '051CB0', '001133'];
Map.addLayer(
  hurricaneIsaacUsa.select('duration').selfMask(),
  {min: 0, max: 4, palette: durationPalette},
  'Hurricane Isaac - Duration');

// Map all floods to generate the satellite-observed historical flood plain.
var gfdFloodedSum = gfd.select('flooded').sum();
Map.addLayer(
  gfdFloodedSum.selfMask(),
  {min: 0, max: 10, palette: durationPalette},
  'GFD Satellite Observed Flood Plain');

// Overlay permanent water to distinguish flood water.
var jrc = gfd.select('jrc_perm_water').sum().gte(1);
Map.addLayer(
  jrc.selfMask(),
  {min: 0, max: 1, palette: 'C3EFFE'},
  'JRC Permanent Water');
