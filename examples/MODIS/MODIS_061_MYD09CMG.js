var dataset = ee.ImageCollection('MODIS/061/MYD09CMG')
                  .filter(ee.Filter.date('2018-01-01', '2018-05-01'));
var trueColor =
    dataset.select([
      'Coarse_Resolution_Surface_Reflectance_Band_1',
      'Coarse_Resolution_Surface_Reflectance_Band_2',
      'Coarse_Resolution_Surface_Reflectance_Band_3'
      ]);
var trueColorVis = {
  min: -0.4,
  max: 1.0,
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(trueColor, trueColorVis, 'True Color');
