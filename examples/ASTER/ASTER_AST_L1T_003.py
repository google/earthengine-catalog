dataset = ee.ImageCollection('ASTER/AST_L1T_003').filter(
    ee.Filter.date('2018-01-01', '2018-08-15')
)

false_color = dataset.select(['B3N', 'B02', 'B01'])
false_color_vis = {'min': 0.0, 'max': 255.0}

m = geemap.Map()
m.set_center(-122.0272, 39.6734, 11)
m.add_layer(false_color.median(), false_color_vis, 'False Color')
m
