dataset = ee.ImageCollection('MODIS/006/MOD13Q1').filter(
    ee.Filter.date('2018-01-01', '2018-05-01')
)

ndvi = dataset.select('NDVI')

ndvi_vis = {
    'min': 0,
    'max': 8000,
    'palette': [
        'ffffff', 'ce7e45', 'df923d', 'f1b555', 'fcd163', '99b718', '74a901',
        '66a000', '529400', '3e8601', '207401', '056201', '004c00', '023b01',
        '012e01', '011d01', '011301'
    ],
}

m = geemap.Map()
m.set_center(6.746, 46.529, 2)
m.add_layer(ndvi, ndvi_vis, 'NDVI')
m
