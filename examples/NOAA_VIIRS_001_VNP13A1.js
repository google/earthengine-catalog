var dataset = ee.ImageCollection("NOAA/VIIRS/001/VNP13A1");
var mean_evi_january_2018 = dataset
    .filterDate('2018-01-01', '2018-01-31')
    .select('EVI')
    .mean();
var evi_vis = {
  min: 0.0,
  max: 10000.0,
  palette: ["000000", "004400", "008800", "00BB00", "00FF00"],
};
Map.setCenter(95.571, 27.808, 8);
Map.addLayer(mean_evi_january_2018, evi_vis, 'Mean EVI January 2018');
