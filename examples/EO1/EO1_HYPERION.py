dataset = ee.ImageCollection('EO1/HYPERION').filter(
    ee.Filter.date('2016-01-01', '2017-03-01')
)

rgb = dataset.select(['B050', 'B023', 'B015'])
rgb_vis = {'min': 1000.0, 'max': 14000.0, 'gamma': 2.5}

m = geemap.Map()
m.set_center(162.0044, -77.3463, 9)
m.add_layer(rgb.median(), rgb_vis, 'RGB')
m
