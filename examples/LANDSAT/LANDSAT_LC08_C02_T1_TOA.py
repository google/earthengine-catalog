dataset = ee.ImageCollection('LANDSAT/LC08/C02/T1_TOA').filterDate(
    '2017-01-01', '2017-12-31'
)
true_color_432 = dataset.select(['B4', 'B3', 'B2'])
true_color_432_vis = {
    'min': 0.0,
    'max': 0.4,
}
m = geemap.Map()
m.set_center(6.746, 46.529, 6)
m.add_layer(true_color_432, true_color_432_vis, 'True Color (432)')
m
