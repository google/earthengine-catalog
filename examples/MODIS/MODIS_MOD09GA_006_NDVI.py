dataset = ee.ImageCollection('MODIS/MOD09GA_006_NDVI').filter(
    ee.Filter.date('2018-04-01', '2018-06-01')
)

colorized = dataset.select('NDVI')

colorized_vis = {
    'min': 0,
    'max': 1,
    'palette': [
        'ffffff', 'ce7e45', 'df923d', 'f1b555', 'fcd163', '99b718', '74a901',
        '66a000', '529400', '3e8601', '207401', '056201', '004c00', '023b01',
        '012e01', '011d01', '011301'
    ],
}

m = geemap.Map()
m.set_center(-7.03125, 31.0529339857, 2)
m.add_layer(colorized, colorized_vis, 'Colorized')
m
