dataset = ee.ImageCollection('ECMWF/ERA5_LAND/MONTHLY_AGGR').first()

visualization = {
    'bands': ['temperature_2m'],
    'min': 250,
    'max': 320,
    'palette': [
        '000080', '0000d9', '4000ff', '8000ff', '0080ff', '00ffff',
        '00ff80', '80ff00', 'daff00', 'ffff00', 'fff500', 'ffda00',
        'ffb000', 'ffa400', 'ff4f00', 'ff2500', 'ff0a00', 'ff00ff',
    ],
}

m = geemap.Map()
m.set_center(70, 45, 3)
m.add_layer(
    dataset, visualization, 'Air temperature [K] at 2m height', True, 0.8
)
m
