dataset = ee.ImageCollection('NASA/GLDAS/V021/NOAH/G025/T3H').filter(
    ee.Filter.date('2010-06-01', '2010-06-02')
)

average_surface_skin_temperature_k = dataset.select('AvgSurfT_inst')

average_surface_skin_temperature_k_vis = {
    'min': 250.0,
    'max': 300.0,
    'palette': ['1303ff', '42fff6', 'f3ff40', 'ff5d0f'],
}

m = geemap.Map()
m.set_center(71.72, 52.48, 3.0)
m.add_layer(
    average_surface_skin_temperature_k,
    average_surface_skin_temperature_k_vis,
    'Average Surface Skin Temperature [K]',
)
m
