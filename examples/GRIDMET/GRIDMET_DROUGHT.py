collection = ee.ImageCollection('GRIDMET/DROUGHT')

# Filter by date
d_s = '2020-03-30'
d_e = '2020-03-30'
d_s_utc = ee.Date(d_s, 'GMT')
d_e_utc = ee.Date(d_e, 'GMT')
filtered = collection.filterDate(d_s_utc, d_e_utc.advance(1, 'day'))

# Select variables pdsi and z
pdsi = filtered.select('pdsi')
z = filtered.select('z')

# Select variables for SPI/SPEI/EDDI
# Note that possible timescales for SPI/SPEI/EDDI are:
# 14d (14 day), 30d (30 day), 90d (90 day), 180d (180 day),
# 1y (1 year), 2y (2 year), 5y (5 year)
# Here we choose 2years = 48 months
spi_2_y = filtered.select('spi2y')
spei_2_y = filtered.select('spei2y')
eddi_2_y = filtered.select('spei2y')

# Make a color palette that is similar to USDM drought classification
usdm_colors = [
    '#0000aa',
    '#0000ff',
    '#00aaff',
    '#00ffff',
    '#aaff55',
    '#ffffff',
    '#ffff00',
    '#fcd37f',
    '#ffaa00',
    '#e60000',
    '#730000',
]

# Make color options for standardized variables spi/spei/eddi
min_colorbar = -2.5
max_colorbar = 2.5
colorbar_options_1 = {
    'min': min_colorbar,
    'max': max_colorbar,
    'palette': usdm_colors,
}

# Make color options for Palmer variables psdi/z
min_colorbar = -6
max_colorbar = 6
colorbar_options_2 = {
    'min': min_colorbar,
    'max': max_colorbar,
    'palette': usdm_colors,
}

# Add map layers to Google Map
m = geemap.Map()
m.add_layer(ee.Image(pdsi.first()), colorbar_options_2, 'pdsi')
m.add_layer(ee.Image(z.first()), colorbar_options_2, 'Palmer-z')
m.add_layer(ee.Image(spi_2_y.first()), colorbar_options_1, 'SPI-48months')
m.add_layer(ee.Image(spei_2_y.first()), colorbar_options_1, 'SPEI-48months')
m.add_layer(ee.Image(eddi_2_y.first()), colorbar_options_1, 'EDDI-48months')
m
