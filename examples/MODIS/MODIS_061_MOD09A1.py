dataset = ee.ImageCollection('MODIS/061/MOD09A1').filter(
    ee.Filter.date('2018-01-01', '2018-05-01')
)

true_color = dataset.select(['sur_refl_b01', 'sur_refl_b04', 'sur_refl_b03'])

true_color_vis = {'min': -100.0, 'max': 3000.0}

m = geemap.Map()
m.set_center(6.746, 46.529, 6)
m.add_layer(true_color, true_color_vis, 'True Color')
m
