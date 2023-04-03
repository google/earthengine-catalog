var dataset = ee.ImageCollection('MODIS/006/MOD08_M3')
                  .filter(ee.Filter.date('2018-01-01', '2018-05-01'));
var aerosolOpticalDepth =
    dataset.select('Aerosol_Optical_Depth_Land_Ocean_Mean_Mean');
var aerosolOpticalDepthVis = {
  min: 0.0,
  max: 3000.0,
  palette: ['ffffff', '1303ff', '01ff09', 'ff2f00'],
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(
    aerosolOpticalDepth, aerosolOpticalDepthVis, 'Aerosol Optical Depth');
