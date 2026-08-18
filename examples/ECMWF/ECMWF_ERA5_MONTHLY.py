dataset = ee.ImageCollection('ECMWF/ERA5/MONTHLY')

visualization = {
    'bands': ['mean_2m_air_temperature'],
    'min': 250.0,
    'max': 320.0,
    'palette': [
        '000080', '0000d9', '4000ff', '8000ff', '0080ff', '00ffff',
        '00ff80', '80ff00', 'daff00', 'ffff00', 'fff500', 'ffda00',
        'ffb000', 'ffa400', 'ff4f00', 'ff2500', 'ff0a00', 'ff00ff',
    ],
}

m = geemap.Map()
m.set_center(22.2, 21.2, 0)
m.add_layer(
    dataset, visualization, 'Monthly average air temperature [K] at 2m height'
)
m
