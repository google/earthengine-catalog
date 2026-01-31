def quality_mask(im):
  return im.updateMask(im.select('quality_flag').eq(1)).updateMask(
      im.select('degrade_flag').eq(0)
  )


dataset = (
    ee.ImageCollection('LARSE/GEDI/GEDI02_A_002_MONTHLY')
    .map(quality_mask)
    .select('rh98')
)

gedi_vis = {
    'min': 1,
    'max': 60,
    'palette': 'darkred,red,orange,green,darkgreen',
}

m = geemap.Map()
m.set_center(-74.803466, -9.342209, 10)
m.add_layer(dataset, gedi_vis, 'rh98')
m
