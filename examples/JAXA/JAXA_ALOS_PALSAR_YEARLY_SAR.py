dataset = ee.ImageCollection('JAXA/ALOS/PALSAR/YEARLY/SAR').filter(
    ee.Filter.date('2017-01-01', '2018-01-01')
)

sar_hh = dataset.select('HH')
sar_hh_vis = {'min': 0.0, 'max': 10000.0}

m = geemap.Map()
m.set_center(136.85, 37.37, 4)
m.add_layer(sar_hh, sar_hh_vis, 'SAR HH')
m
