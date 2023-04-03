var dataset = ee.ImageCollection('WRI/GFW/FORMA/raw_output_ndvi')
                  .filter(ee.Filter.date('2018-01-01', '2018-01-02'));
var percentOfClearing = dataset.select('clearing');
var visParams = {
  min: 0.0,
  max: 1.0,
};
Map.setCenter(25.73, -7.61, 2);
Map.addLayer(
    percentOfClearing, visParams, 'Percent of clearing in the last 365 days');
