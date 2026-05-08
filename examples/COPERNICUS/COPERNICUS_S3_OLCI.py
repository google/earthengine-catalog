dataset = ee.ImageCollection('COPERNICUS/S3/OLCI').filterDate(
    '2018-04-01', '2018-04-04'
)

# Select bands for visualization and apply band-specific scale factors.
rgb = (
    dataset.select(['Oa08_radiance', 'Oa06_radiance', 'Oa04_radiance'])
    .median()
    .multiply(ee.Image([0.00876539, 0.0123538, 0.0115198]))
)  # Convert to radiance units.

vis_params = {'min': 0, 'max': 6, 'gamma': 1.5}

m = geemap.Map()
m.set_center(46.043, 1.45, 5)
m.add_layer(rgb, vis_params, 'RGB')
m
