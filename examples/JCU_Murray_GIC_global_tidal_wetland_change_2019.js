var dataset = ee.Image('JCU/Murray/GIC/global_tidal_wetland_change/2019');

Map.setCenter(103.7, 1.3, 12);
Map.setOptions('SATELLITE');

var plasma = [
  '0d0887', '3d049b', '6903a5', '8d0fa1', 'ae2891', 'cb4679', 'df6363',
  'f0844c', 'faa638', 'fbcc27', 'f0f921'
];
Map.addLayer(
    dataset.select('twprobabilityStart'), {palette: plasma, min: 0, max: 100},
    'twprobabilityStart', false, 1);
Map.addLayer(
    dataset.select('twprobabilityEnd'), {palette: plasma, min: 0, max: 100},
    'twprobabilityEnd', false, 1);

var lossPalette = ['FE4A49'];
var gainPalette = ['2AB7CA'];
Map.addLayer(
    dataset.select('loss'), {palette: lossPalette, min: 1, max: 1},
    'Tidal wetland loss', true, 1);
Map.addLayer(
    dataset.select('gain'), {palette: gainPalette, min: 1, max: 1},
    'Tidal wetland gain', true, 1);

var viridis = ['440154', '414487', '2a788e', '22a884', '7ad151', 'fde725'];
Map.addLayer(
    dataset.select('lossYear'), {palette: viridis, min: 4, max: 19},
    'Year of loss', false, 0.9);
Map.addLayer(
    dataset.select('gainYear'), {palette: viridis, min: 4, max: 19},
    'Year of gain', false, 0.9);

// ecosystem type
var classPalette = ['9e9d9d', 'ededed', 'FF9900', '009966', '960000', '006699'];
var classNames =
    ['null', 'null', 'Tidal flat', 'Mangrove', 'null', 'Tidal marsh'];
Map.addLayer(
    dataset.select('lossType'), {palette: classPalette, min: 0, max: 5},
    'Loss type', false, 0.9);
Map.addLayer(
    dataset.select('gainType'), {palette: classPalette, min: 0, max: 5},
    'Gain type', false, 0.9);
