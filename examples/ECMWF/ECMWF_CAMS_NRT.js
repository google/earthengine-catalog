var dataset = ee.ImageCollection('ECMWF/CAMS/NRT')
                  .filter(ee.Filter.date('2019-01-01', '2019-01-31'));
var aod = dataset.select('total_aerosol_optical_depth_at_550nm_surface');
var visParams = {
  min: 0.0,
  max: 3.6,
  palette: [
    '5e4fa2', '3288bd', '66c2a5', 'abe0a4', 'e6f598', 'ffffbf',
    'fee08b', 'fdae61', 'f46d43', 'd53e4f', '9e0142'
  ]
};
Map.setCenter(70, 45, 3);
Map.addLayer(aod, visParams, 'Total Aerosal Optical Depth', true, 0.8);
