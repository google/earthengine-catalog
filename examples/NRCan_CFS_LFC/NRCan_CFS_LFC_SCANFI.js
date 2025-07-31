var dataset = ee.Image('NRCan_CFS_LFC/NRCan_CFS_LFC_SCANFI');
var balsamFir = dataset.select('balsamFir').selfMask();
var vis = {
  min: 0,
  max: 100,
  palette: ['ffffff', '05ff09']
};
Map.setCenter(-94, 56, 5);
Map.addLayer(balsamFir, vis, 'Balsam Fir Percentage')
