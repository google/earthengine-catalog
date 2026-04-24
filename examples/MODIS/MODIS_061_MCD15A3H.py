dataset = ee.ImageCollection('MODIS/061/MCD15A3H')

default_visualization = dataset.first().select('Fpar')

default_visualization_vis = {
    'min': 0.0,
    'max': 100.0,
    'palette': ['e1e4b4', '999d60', '2ec409', '0a4b06'],
}

m = geemap.Map()
m.set_center(6.746, 46.529, 6)
m.add_layer(
    default_visualization, default_visualization_vis, 'Default visualization'
)
m
