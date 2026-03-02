collection = ee.ImageCollection(
    'JAXA/ALOS/PALSAR-2/Level2_2/ScanSAR'
).filterBounds(ee.Geometry.Point(143, -5))

image = collection.first()

m = geemap.Map()
m.add_layer(image.select(['HH']), {'min': 0, 'max': 8000}, 'HH polarization')
m.center_object(image)
m
