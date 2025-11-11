dataset = ee.ImageCollection('NOAA/CDR/AVHRR/NDVI/V5').filter(
    ee.Filter.date('2018-05-01', '2018-06-01')
)

ndvi = dataset.select('NDVI')

ndvi_vis = {
    'min': -1000.0,
    'max': 5000.0,
    'palette': [
        'ffffff',
        'ce7e45',
        'fcd163',
        'c6ca02',
        '22cc04',
        '99b718',
        '207401',
        '012e01',
    ],
}

m = geemap.Map()
m.set_center(7.71, 17.93, 2)
m.add_layer(ndvi, ndvi_vis, 'NDVI')
m
