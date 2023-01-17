// TODO(kumaraashutosh): Once scaled VNP21A1D assets have been ingested, remove
// the RAW suffix.
var dataset = ee.ImageCollection('NOAA/VIIRS/001/VNP21A1D_RAW')
                  .filter(ee.Filter.date('2022-11-01', '2022-12-01'));

var visualization = {
  bands: ['QC'],
  min: 250.0,
  max: 320.0,
};
Map.setCenter(-55.175, -28.781, 6);
Map.addLayer(dataset, visualization, 'Quality Check');
