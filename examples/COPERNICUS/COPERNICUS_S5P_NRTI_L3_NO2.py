collection = (
    ee.ImageCollection('COPERNICUS/S5P/NRTI/L3_NO2')
    .select('NO2_column_number_density')
    .filterDate('2019-06-01', '2019-06-06')
)

band_viz = {
    'min': 0,
    'max': 0.0002,
    'palette': ['black', 'blue', 'purple', 'cyan', 'green', 'yellow', 'red'],
}

m = geemap.Map()
m.add_layer(collection.mean(), band_viz, 'S5P N02')
m.set_center(65.27, 24.11, 4)
m
