dataset = ee.FeatureCollection('USDOS/LSIB_SIMPLE/2017')

countries = dataset.style(fillColor='b5ffb4', color='00909F', width=3)

m = geemap.Map()
m.set_center(16.35, 48.83, 4)
m.add_layer(countries, {}, 'USDOS/LSIB_SIMPLE/2017', True, 0.8)
m
