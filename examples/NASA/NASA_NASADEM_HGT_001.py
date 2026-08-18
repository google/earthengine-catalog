# Import the dataset and select the elevation band.
dataset = ee.Image('NASA/NASADEM_HGT/001')

elevation = dataset.select('elevation')

# Add a white background image to the map.
background = ee.Image(1)
m = geemap.Map()
m.set_center(17.93, 7.71, 2)
m.add_layer(background, {'min': 0, 'max': 1})

# Set elevation visualization properties.
elevation_vis = {'min': 0, 'max': 2000}

# Set elevation <= 0 as transparent and add to the map.
m.add_layer(elevation.updateMask(elevation.gt(0)), elevation_vis, 'Elevation')
m
