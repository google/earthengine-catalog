dataset = ee.ImageCollection('MODIS/061/MOD09GQ').filter(
    ee.Filter.date('2018-01-01', '2018-05-01')
)

false_color_vis = {
    'min': -100,
    'max': 8000,
    'bands': ['sur_refl_b02', 'sur_refl_b02', 'sur_refl_b01'],
}

m = geemap.Map()
m.set_center(6.746, 46.529, 2)
m.add_layer(dataset, false_color_vis, 'False Color')
m
