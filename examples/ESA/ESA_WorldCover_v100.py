dataset = ee.ImageCollection('ESA/WorldCover/v100').first()

visualization = {
    'bands': ['Map'],
}

m = geemap.Map()
m.center_object(dataset)
m.add_layer(dataset, visualization, 'Landcover')
m
