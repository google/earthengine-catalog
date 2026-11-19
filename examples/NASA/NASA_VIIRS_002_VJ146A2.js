var dataset = ee.ImageCollection('NASA/VIIRS/002/VJ146A2')
                  .filter(ee.Filter.date('2024-11-20', '2024-11-25'));

var nighttime = dataset.select('Gap_Filled_DNB_BRDF_Corrected_NTL');

var visParams = {
  min: 0.2,
  max: 4.0,
  palette: ['000839', '005082', '00a8cc', 'ffa41b', 'ffe867', 'ffffff'],
};

Map.setCenter(-95.0, 38.0, 4);
Map.addLayer(nighttime, visParams, 'Nighttime Lights');
