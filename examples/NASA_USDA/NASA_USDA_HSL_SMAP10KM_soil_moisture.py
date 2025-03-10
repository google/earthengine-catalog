dataset = ee.ImageCollection('NASA_USDA/HSL/SMAP10KM_soil_moisture').filter(
    ee.Filter.date('2017-04-01', '2017-04-30')
)

soil_moisture = dataset.select('ssm')

soil_moisture_vis = {
    'min': 0.0,
    'max': 28.0,
    'palette': ['0300ff', '418504', 'efff07', 'efff07', 'ff0303'],
}

m = geemap.Map()
m.set_center(-6.746, 46.529, 2)
m.add_layer(soil_moisture, soil_moisture_vis, 'Soil Moisture')
m
