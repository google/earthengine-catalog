collection = (
    ee.ImageCollection('COPERNICUS/S5P/OFFL/L3_CO')
    .select('CO_column_number_density')
    .filterDate('2019-06-01', '2019-06-11')
)

band_viz = {
    'min': 0,
    'max': 0.05,
    'palette': ['black', 'blue', 'purple', 'cyan', 'green', 'yellow', 'red'],
}

m = geemap.Map()
m.add_layer(collection.mean(), band_viz, 'S5P CO')
m.set_center(-25.01, -4.28, 4)
m
