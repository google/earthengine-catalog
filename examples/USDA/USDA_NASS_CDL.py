dataset = (
    ee.ImageCollection('USDA/NASS/CDL')
    .filter(ee.Filter.date('2018-01-01', '2019-12-31'))
    .first()
)

crop_landcover = dataset.select('cropland')

m = geemap.Map()
m.set_center(-100.55, 40.71, 4)
m.add_layer(crop_landcover, {}, 'Crop Landcover')
m
