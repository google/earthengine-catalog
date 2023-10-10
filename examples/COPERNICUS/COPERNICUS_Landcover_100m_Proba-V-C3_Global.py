dataset = ee.Image('COPERNICUS/Landcover/100m/Proba-V-C3/Global/2019').select(
    'discrete_classification'
)

m = geemap.Map()
m.set_center(-88.6, 26.4, 1)
m.add_layer(dataset, {}, 'Land Cover')
m
