dataset = ee.ImageCollection('LANDSAT/LT05/C02/T1_TOA').filterDate(
    '2011-01-01', '2011-12-31'
)

true_color_321 = dataset.select(['B3', 'B2', 'B1'])

true_color_321_vis = {'min': 0.0, 'max': 0.4, 'gamma': 1.2}

m = geemap.Map()
m.set_center(6.746, 46.529, 6)
m.add_layer(true_color_321, true_color_321_vis, 'True Color (321)')
m
