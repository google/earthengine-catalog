dataset = ee.ImageCollection('MODIS/006/MCD12Q1')

igbp_land_cover = dataset.select('LC_Type1')

igbp_land_cover_vis = {
    'min': 1.0,
    'max': 17.0,
    'palette': [
        '05450a', '086a10', '54a708', '78d203', '009900', 'c6b044', 'dcd159',
        'dade48', 'fbff13', 'b6ff05', '27ff87', 'c24f44', 'a5a5a5', 'ff6d4c',
        '69fff8', 'f9ffa4', '1c0dff'
    ],
}

m = geemap.Map()
m.set_center(6.746, 46.529, 6)
m.add_layer(igbp_land_cover, igbp_land_cover_vis, 'IGBP Land Cover')
m
