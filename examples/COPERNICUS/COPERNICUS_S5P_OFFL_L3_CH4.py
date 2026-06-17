collection = (
    ee.ImageCollection('COPERNICUS/S5P/OFFL/L3_CH4')
    .select('CH4_column_volume_mixing_ratio_dry_air')
    .filterDate('2019-06-01', '2019-07-16')
)

band_viz = {
    'min': 1750,
    'max': 1900,
    'palette': ['black', 'blue', 'purple', 'cyan', 'green', 'yellow', 'red'],
}

m = geemap.Map()
m.add_layer(collection.mean(), band_viz, 'S5P CH4')
m.set_center(0.0, 0.0, 2)
m
