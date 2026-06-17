dataset = ee.Image('COPERNICUS/CORINE/V20/100m/2012')
land_cover = dataset.select('landcover')

m = geemap.Map()
m.set_center(16.436, 39.825, 6)
m.add_layer(land_cover, {}, 'Land Cover')
m
