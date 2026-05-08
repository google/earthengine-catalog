# Import the dataset a collection of composite granules from 2019.
dataset = ee.ImageCollection('BIOPAMA/GlobalOilPalm/v1')

# Select the classification band.
op_class = dataset.select('classification')

# Mosaic all of the granules into a single image.
mosaic = op_class.mosaic()

# Define visualization parameters.
classification_vis = {
    'min': 1,
    'max': 3,
    'palette': ['ff0000', 'ef00ff', '696969'],
}

# Create a mask to add transparency to non-oil palm plantation class pixels.
mask = mosaic.neq(3)
mask = mask.where(mask.eq(0), 0.6)

# Display the data on the map.
m = geemap.Map()
m.add_layer(
    mosaic.updateMask(mask),
    classification_vis,
    'Oil palm plantation type',
    True,
)
m.set_center(-3.0175, 5.2745, 12)
m
