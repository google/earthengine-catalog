dataset = ee.ImageCollection('MODIS/006/MOD16A2').filter(
    ee.Filter.date('2018-01-01', '2018-05-01')
)

evapotranspiration = dataset.select('ET')

evapotranspiration_vis = {
    'min': 0,
    'max': 300,
    'palette': [
        'ffffff',
        'fcd163',
        '99b718',
        '66a000',
        '3e8601',
        '207401',
        '056201',
        '004c00',
        '011301',
    ],
}

m = geemap.Map()
m.set_center(6.746, 46.529, 2)
m.add_layer(evapotranspiration, evapotranspiration_vis, 'Evapotranspiration')
m
