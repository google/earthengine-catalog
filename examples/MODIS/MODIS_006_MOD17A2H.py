dataset = ee.ImageCollection('MODIS/006/MOD17A2H').filter(
    ee.Filter.date('2018-01-01', '2018-05-01')
)

gpp = dataset.select('Gpp')

gpp_vis = {'min': 0, 'max': 600, 'palette': ['bbe029', '0a9501', '074b03']}

m = geemap.Map()
m.set_center(6.746, 46.529, 2)
m.add_layer(gpp, gpp_vis, 'GPP')
m
