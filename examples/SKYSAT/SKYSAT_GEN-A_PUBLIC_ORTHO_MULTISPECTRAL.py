dataset = ee.ImageCollection('SKYSAT/GEN-A/PUBLIC/ORTHO/MULTISPECTRAL')

false_color = dataset.select(['N', 'G', 'B'])

false_color_vis = {'min': 200.0, 'max': 6000.0}

m = geemap.Map()
m.set_center(-70.892, 41.6555, 15)
m.add_layer(false_color, false_color_vis, 'False Color')
m
