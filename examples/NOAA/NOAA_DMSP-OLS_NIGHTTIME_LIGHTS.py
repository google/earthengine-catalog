dataset = ee.ImageCollection('NOAA/DMSP-OLS/NIGHTTIME_LIGHTS').filter(
    ee.Filter.date('2010-01-01', '2010-12-31')
)

nighttime_lights = dataset.select('avg_vis')

nighttime_lights_vis = {'min': 3.0, 'max': 60.0}

m = geemap.Map()
m.set_center(7.82, 49.1, 4)
m.add_layer(nighttime_lights, nighttime_lights_vis, 'Nighttime Lights')
m
