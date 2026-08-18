dataset = ee.ImageCollection('NOAA/VIIRS/DNB/MONTHLY_V1/VCMCFG').filter(
    ee.Filter.date('2017-05-01', '2017-05-31')
)

nighttime = dataset.select('avg_rad')

nighttime_vis = {'min': 0.0, 'max': 60.0}

m = geemap.Map()
m.set_center(-77.1056, 38.8904, 8)
m.add_layer(nighttime, nighttime_vis, 'Nighttime')
m
