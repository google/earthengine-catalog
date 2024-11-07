dataset = ee.ImageCollection('COPERNICUS/DEM/GLO30')
elevation = dataset.select('DEM')

elevation_vis = {
    'min': 0.0,
    'max': 1000.0,
    'palette': ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
}

m = geemap.Map()
m.set_center(-6.746, 46.529, 4)
m.add_layer(elevation, elevation_vis, 'DEM')
m
