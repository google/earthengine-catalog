dataset = ee.Image('ESA/GLOBCOVER_L4_200901_200912_V2_3')
landcover = dataset.select('landcover')

m = geemap.Map()
m.set_center(-88.6, 26.4, 3)
m.add_layer(landcover, {}, 'Landcover')
m
