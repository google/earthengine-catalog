dataset = ee.ImageCollection('NOAA/CFSV2/FOR6H').filter(
    ee.Filter.date('2018-03-01', '2018-03-14')
)

temperature_above_ground = dataset.select('Temperature_height_above_ground')

vis_params = {
    'min': 220.0,
    'max': 310.0,
    'palette': ['blue', 'purple', 'cyan', 'green', 'yellow', 'red'],
}

m = geemap.Map()
m.set_center(-88.6, 26.4, 1)
m.add_layer(temperature_above_ground, vis_params, 'Temperature Above Ground')
m
