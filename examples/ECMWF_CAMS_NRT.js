var dataset = ee.ImageCollection('ECMWF/CAMS/NRT')
                  .filter(ee.Filter.date('2019-01-01', '2019-01-31'));
var aod = dataset.select('total_aerosol_optical_depth_at_550nm_surface');
var visParams = {
  min: 0.000096,
  max: 3.582552,
  palette: [
    "5E4FA2",
    "3288BD",
    "66C2A5",
    "ABE0A4",
    "E6F598",
    "FFFFBF",
    "FEE08B",
    "FDAE61",
    "F46D43",
    "D53E4F",
    "9E0142"
  ]
};
Map.setCenter(-94.18, 16.8, 1);
Map.addLayer(aod, visParams, 'Total Aerosal Optical Depth');
