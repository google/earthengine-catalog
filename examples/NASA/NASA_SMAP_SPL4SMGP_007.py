dataset = ee.ImageCollection('NASA/SMAP/SPL4SMGP/007').filter(
    ee.Filter.date('2017-04-01', '2017-04-30')
)

sm_surface = dataset.select('sm_surface')

sm_surface_vis = {
    'min': 0.0,
    'max': 0.9,
    'palette': ['0300ff', '418504', 'efff07', 'efff07', 'ff0303'],
}

m = geemap.Map()
m.set_center(-6.746, 46.529, 2)
m.add_layer(sm_surface, sm_surface_vis, 'SM Surface')
m
