dataset = ee.ImageCollection('IDAHO_EPSCOR/GRIDMET').filter(
    ee.Filter.date('2018-08-01', '2018-08-15')
)

maximum_temperature = dataset.select('tmmx')

maximum_temperature_vis = {
    'min': 290.0,
    'max': 314.0,
    'palette': ['d8d8d8', '4addff', '5affa3', 'f2ff89', 'ff725c'],
}

m = geemap.Map()
m.set_center(-115.356, 38.686, 5)
m.add_layer(maximum_temperature, maximum_temperature_vis, 'Maximum Temperature')
m
