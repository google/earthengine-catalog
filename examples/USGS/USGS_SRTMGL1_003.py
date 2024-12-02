dataset = ee.Image('USGS/SRTMGL1_003')
elevation = dataset.select('elevation')
slope = ee.Terrain.slope(elevation)

m = geemap.Map()
m.set_center(-112.8598, 36.2841, 10)
m.add_layer(slope, {'min': 0, 'max': 60}, 'slope')
m
