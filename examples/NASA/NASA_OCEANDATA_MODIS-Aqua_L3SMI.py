dataset = ee.ImageCollection('NASA/OCEANDATA/MODIS-Aqua/L3SMI').filterDate(
    '2016-01-01', '2016-01-31'
)

remote_sensing_reflectance = dataset.select(['Rrs_645', 'Rrs_555', 'Rrs_443'])

remote_sensing_reflectance_vis = {'min': 0.0, 'max': 0.011}

m = geemap.Map()
m.set_center(-52.12, -46.13, 4)
m.add_layer(
    remote_sensing_reflectance,
    remote_sensing_reflectance_vis,
    'Remote Sensing Reflectance',
)
m
