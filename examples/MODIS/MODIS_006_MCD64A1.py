dataset = ee.ImageCollection('MODIS/006/MCD64A1').filter(
    ee.Filter.date('2017-01-01', '2018-05-01')
)

burned_area = dataset.select('BurnDate')

burned_area_vis = {
    'min': 30,
    'max': 341,
    'palette': ['4e0400', '951003', 'c61503', 'ff1901'],
}

m = geemap.Map()
m.set_center(6.746, 46.529, 2)
m.add_layer(burned_area, burned_area_vis, 'Burned Area')
m
