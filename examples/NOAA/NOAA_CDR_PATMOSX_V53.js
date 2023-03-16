var dataset = ee.ImageCollection('NOAA/CDR/PATMOSX/V53')
                  .filter(ee.Filter.date('2017-05-01', '2017-05-14'));
var cloudEmissivityAndHeight = dataset.select(
    ['cld_emiss_acha', 'cld_height_acha', 'cld_height_uncer_acha']);
Map.setCenter(71.72, 52.48, 1);
Map.addLayer(cloudEmissivityAndHeight, {}, 'Cloud Emissivity and Height');
