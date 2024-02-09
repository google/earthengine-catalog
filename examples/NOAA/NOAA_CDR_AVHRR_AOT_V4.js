var dataset = ee.ImageCollection('NOAA/CDR/AVHRR/AOT/V4')
                  .filter(ee.Filter.date('2018-02-01', '2018-03-01'));
var aerosolOpticalThickness = dataset.select('aot');
var visParams = {
  min: 0.0,
  max: 0.5,
  palette: ['800080', '0000ff', '00ffff', '008000', 'ffff00', 'ff0000'],
};
Map.setCenter(-88.6, 26.4, 3);
Map.addLayer(
    aerosolOpticalThickness, visParams,
    'Aerosol Optical Thickness');
