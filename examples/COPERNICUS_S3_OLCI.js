var dataset = ee.ImageCollection('COPERNICUS/S3/OLCI')
                  .filterDate('2018-04-01', '2018-04-04');

// Select bands for visualization and apply band-specific scale factors.
var rgb = dataset.select(['Oa08_radiance', 'Oa06_radiance', 'Oa04_radiance'])
              .median()
              // Convert to radiance units.
              .multiply(ee.Image([0.00876539, 0.0123538, 0.0115198]));

var visParams = {
  min: 0,
  max: 6,
  gamma: 1.5,
};

Map.setCenter(46.043, 1.45, 5);
Map.addLayer(rgb, visParams, 'RGB');
