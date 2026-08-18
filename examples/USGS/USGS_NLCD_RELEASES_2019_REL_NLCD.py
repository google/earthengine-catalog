# Import the NLCD collection.
dataset = ee.ImageCollection('USGS/NLCD_RELEASES/2019_REL/NLCD')

# The collection contains images for multiple years and regions in the USA.
display('Products:', dataset.aggregate_array('system:index'))

# Filter the collection to the 2016 product.
nlcd_2016 = dataset.filter(ee.Filter.eq('system:index', '2016')).first()

# Each product has multiple bands for describing aspects of land cover.
display('Bands:', nlcd_2016.bandNames())

# Select the land cover band.
landcover = nlcd_2016.select('landcover')

# Display land cover on the map.
m = geemap.Map()
m.set_center(-95, 38, 5)
m.add_layer(landcover, None, 'Landcover')
m
