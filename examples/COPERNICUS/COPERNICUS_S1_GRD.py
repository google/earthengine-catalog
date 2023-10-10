def mask_edge(image):
  edge = image.lt(-30.0)
  masked_image = image.mask().And(edge.Not())
  return image.updateMask(masked_image)


img_vv = (
    ee.ImageCollection('COPERNICUS/S1_GRD')
    .filter(ee.Filter.listContains('transmitterReceiverPolarisation', 'VV'))
    .filter(ee.Filter.eq('instrumentMode', 'IW'))
    .select('VV')
    .map(mask_edge)
)

desc = img_vv.filter(ee.Filter.eq('orbitProperties_pass', 'DESCENDING'))
asc = img_vv.filter(ee.Filter.eq('orbitProperties_pass', 'ASCENDING'))

spring = ee.Filter.date('2015-03-01', '2015-04-20')
late_spring = ee.Filter.date('2015-04-21', '2015-06-10')
summer = ee.Filter.date('2015-06-11', '2015-08-31')

desc_change = ee.Image.cat(
    desc.filter(spring).mean(),
    desc.filter(late_spring).mean(),
    desc.filter(summer).mean(),
)

asc_change = ee.Image.cat(
    asc.filter(spring).mean(),
    asc.filter(late_spring).mean(),
    asc.filter(summer).mean(),
)

m = geemap.Map()
m.set_center(5.2013, 47.3277, 12)
m.add_layer(asc_change, {'min': -25, 'max': 5}, 'Multi-T Mean ASC', True)
m.add_layer(desc_change, {'min': -25, 'max': 5}, 'Multi-T Mean DESC', True)
m
