dataset = ee.Image('AHN/AHN2_05M_INT')
elevation = dataset.select('elevation')
elevation_vis = {'min': -5.0, 'max': 30.0}

m = geemap.Map()
m.set_center(5.76583, 51.855276, 16)
m.add_layer(elevation, elevation_vis, 'Elevation')
m
