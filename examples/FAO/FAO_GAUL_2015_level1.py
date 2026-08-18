dataset = ee.FeatureCollection('FAO/GAUL/2015/level1')

dataset = dataset.style(fillColor='b5ffb4', color='00909F', width=1.0)

m = geemap.Map()
m.set_center(7.82, 49.1, 4)
m.add_layer(dataset, {}, 'First Level Administrative Units')
m
