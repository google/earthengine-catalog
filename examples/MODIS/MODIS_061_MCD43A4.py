dataset = ee.ImageCollection('MODIS/061/MCD43A4').filter(
    ee.Filter.date('2018-04-01', '2018-06-01')
)

true_color = dataset.select([
    'Nadir_Reflectance_Band1',
    'Nadir_Reflectance_Band4',
    'Nadir_Reflectance_Band3',
])

true_color_vis = {'min': 0, 'max': 4000, 'gamma': 1.4}

m = geemap.Map()
m.set_center(-7.03, 31.06, 2)
m.add_layer(true_color, true_color_vis, 'True Color')
m