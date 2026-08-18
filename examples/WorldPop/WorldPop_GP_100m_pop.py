dataset = ee.ImageCollection('WorldPop/GP/100m/pop')

visualization = {
    'bands': ['population'],
    'min': 0.0,
    'max': 50.0,
    'palette': ['24126c', '1fff4f', 'd4ff50'],
}

m = geemap.Map()
m.set_center(113.643, 34.769, 7)
m.add_layer(dataset, visualization, 'Population')
m
