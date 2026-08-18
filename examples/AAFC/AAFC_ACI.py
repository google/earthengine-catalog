dataset = ee.ImageCollection('AAFC/ACI')
crop_2016 = dataset.filter(ee.Filter.date('2016-01-01', '2016-12-31')).first()

m = geemap.Map()
m.set_center(-103.8881, 53.0372, 10)
m.add_layer(crop_2016, {}, '2016 Canada AAFC Annual Crop Inventory')
m
