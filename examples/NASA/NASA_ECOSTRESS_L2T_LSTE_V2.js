var image = ee.ImageCollection('NASA/ECOSTRESS/L2T_LSTE/V2')
                  .filter(ee.Filter.date('2025-03-01', '2025-05-01'));
var lst = image.select('LST').mean();

var lstVis = {
  min: 294.8999938964844,
  max: 298.4200134277344,
  palette: ['00008B', 'A9A9A9', 'CD853F', 'FFFF00', '90EE90', '006400'],
};
Map.addLayer(lst, lstVis, 'LST');

var lstErr = image.select('LST_err');
var lstErrVis = {
  min: 2.8399999141693115,
  max: 3.200000047683716,
  palette: ['green', 'yellow', 'red'],
};
Map.addLayer(lstErr, lstErrVis, 'LST_err');

var qc = image.select('QC');
var qcVis = {
  min: 0,
  max: 2497,
  palette: ['black', 'purple', 'white'],
};
Map.addLayer(qc, qcVis, 'QC');

var emisWB = image.select('EmisWB');
var emisWBVis = {
  min: 0.8859999775886536,
  max: 0.9459999799728394,
  palette: ['blue', 'cyan', 'green'],
};
Map.addLayer(emisWB, emisWBVis, 'EmisWB');

var cloud = image.select('cloud');
var cloudVis = {
  min: 0,
  max: 1,
  palette: ['FF0000', 'white'],
};
Map.addLayer(cloud, cloudVis, 'cloud');

var height = image.select('height');
var heightVis = {
  min: 46.57216262817383,
  max: 47.15089416503906,
  palette: ['brown', 'grey', 'white'],
};
Map.addLayer(height, heightVis, 'height');

var water = image.select('water');
var waterVis = {
  min: 0,
  max: 1,
  palette: ['FF0000', 'blue'],
};
Map.addLayer(water, waterVis, 'water');

var viewZenith = image.select('view_zenith');
var viewZenithVis = {
  min: 27.346546173095703,
  max: 28.611562728881836,
  palette: ['yellow', 'orange', 'red'],
};
Map.addLayer(viewZenith, viewZenithVis, 'view_zenith');
