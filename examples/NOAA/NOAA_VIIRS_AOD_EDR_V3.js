function aodWithGoodQc(image) {
  var qcBand = image.select('QCAll');
  var mask = qcBand.eq(0);
  var aodBand = image.select('AOD550');
  var raster = aodBand.updateMask(mask);
  var raster_mean = raster.reduceNeighborhood({
    reducer: ee.Reducer.mean(),
    kernel: ee.Kernel.square({radius: 2, units: 'pixels'}),
    skipMasked: false
  });
  return raster.unmask(raster_mean);
}

var images = ee.ImageCollection('NOAA/VIIRS/AOD_EDR/V3')
  .filterDate('2023-05-16', '2023-05-17')
  .map(aodWithGoodQc);

Map.addLayer(
  images,
  {min: 0, max: 1, palette: ['800080', '0000ff', '00ffff', '008000', 'ffff00', 'ff0000']},
  'AOD550');
