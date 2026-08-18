dataset = ee.ImageCollection('NOAA/GFS0P25').filter(
    ee.Filter.date('2018-03-01', '2018-03-02')
)

temperature_above_ground = dataset.select('temperature_2m_above_ground')

vis_params = {
    'min': -40.0,
    'max': 35.0,
    'palette': ['blue', 'purple', 'cyan', 'green', 'yellow', 'red'],
}

m = geemap.Map()
m.set_center(71.72, 52.48, 3.0)
m.add_layer(temperature_above_ground, vis_params, 'Temperature Above Ground')
m
