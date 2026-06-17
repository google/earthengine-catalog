dataset = ee.ImageCollection('FIRMS').filter(
    ee.Filter.date('2018-08-01', '2018-08-10')
)

fires = dataset.select('T21')

fires_vis = {'min': 325.0, 'max': 400.0, 'palette': ['red', 'orange', 'yellow']}

m = geemap.Map()
m.set_center(-119.086, 47.295, 6)
m.add_layer(fires, fires_vis, 'Fires')
m
