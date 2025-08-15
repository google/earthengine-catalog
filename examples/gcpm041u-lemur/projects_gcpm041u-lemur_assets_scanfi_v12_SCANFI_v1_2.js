var dataset = ee.Image("projects/gcpm041u-lemur/assets/scanfi_v12/SCANFI_v1_2");
var balsamFir = dataset.select('balsamFir').selfMask();
var vis = {
  min: 0,
  max: 100,
  palette: ['ffffff', '05ff09']
};
Map.setCenter(-94, 56, 5);
Map.addLayer(balsamFir, vis, 'Balsam Fir Percentage')
