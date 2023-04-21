var dataset = ee.ImageCollection('HYCOM/GLBu0_08/sea_temp_salinity')
                  .filter(ee.Filter.date('2018-08-01', '2018-08-15'));
var seaWaterTemperature = dataset.select('sst_0');
var visParams = {
  min: -20000.0,
  max: 15000.0,
  palette: ['000000', '005aff', '43c8c8', 'fff700', 'ff0000'],
};
Map.setCenter(-88.6, 26.4, 1);
Map.addLayer(seaWaterTemperature, visParams, 'Sea Water Temperature');
