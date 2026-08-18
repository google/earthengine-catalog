dataset = ee.ImageCollection('USDA/NAIP/DOQQ').filter(
    ee.Filter.date('2017-01-01', '2018-12-31')
)

true_color = dataset.select(['R', 'G', 'B'])

true_color_vis = {'min': 0, 'max': 255}

m = geemap.Map()
m.set_center(-73.9958, 40.7278, 15)
m.add_layer(true_color, true_color_vis, 'True Color')
m
