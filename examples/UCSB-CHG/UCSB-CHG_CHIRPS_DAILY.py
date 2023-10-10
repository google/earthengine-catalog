dataset = ee.ImageCollection('UCSB-CHG/CHIRPS/DAILY').filter(
    ee.Filter.date('2018-05-01', '2018-05-03')
)
precipitation = dataset.select('precipitation')
precipitation_vis = {
    'min': 1,
    'max': 17,
    'palette': ['001137', '0aab1e', 'e7eb05', 'ff4a2d', 'e90000'],
}

m = geemap.Map()
m.set_center(17.93, 7.71, 2)
m.add_layer(precipitation, precipitation_vis, 'Precipitation')
m
