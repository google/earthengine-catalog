dataset = ee.ImageCollection('SKYSAT/GEN-A/PUBLIC/ORTHO/RGB')

rgb = dataset.select(['R', 'G', 'B'])

rgb_vis = {'min': 11.0, 'max': 190.0}

m = geemap.Map()
m.set_center(-70.892, 41.6555, 15)
m.add_layer(rgb, rgb_vis, 'RGB')
m
