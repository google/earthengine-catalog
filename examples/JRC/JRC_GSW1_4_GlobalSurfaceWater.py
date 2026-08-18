dataset = ee.Image('JRC/GSW1_4/GlobalSurfaceWater')

visualization = {
    'bands': ['occurrence'],
    'min': 0.0,
    'max': 100.0,
    'palette': ['ffffff', 'ffbbbb', '0000ff'],
}

m = geemap.Map()
m.set_center(59.414, 45.182, 6)
m.add_layer(dataset, visualization, 'Occurrence')
m
