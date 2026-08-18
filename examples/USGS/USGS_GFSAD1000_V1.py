dataset = ee.Image('USGS/GFSAD1000_V1')

crop_mask = dataset.select('landcover')

crop_mask_vis = {
    'min': 0.0,
    'max': 5.0,
    'palette': ['black', 'orange', 'brown', '02a50f', 'green', 'yellow'],
}

m = geemap.Map()
m.set_center(-17.22, 13.72, 2)
m.add_layer(crop_mask, crop_mask_vis, 'Crop Mask')
m
