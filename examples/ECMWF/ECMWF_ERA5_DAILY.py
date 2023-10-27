# Example script to load and visualize ERA5 climate reanalysis parameters in
# Google Earth Engine

# Daily mean 2m air temperature
era5_2mt = (
    ee.ImageCollection('ECMWF/ERA5/DAILY')
    .select('mean_2m_air_temperature')
    .filter(ee.Filter.date('2019-07-01', '2019-07-31'))
)
display(era5_2mt)

# Daily total precipitation sums
era5_tp = (
    ee.ImageCollection('ECMWF/ERA5/DAILY')
    .select('total_precipitation')
    .filter(ee.Filter.date('2019-07-01', '2019-07-31'))
)

# Daily mean 2m dewpoint temperature
era5_2d = (
    ee.ImageCollection('ECMWF/ERA5/DAILY')
    .select('dewpoint_2m_temperature')
    .filter(ee.Filter.date('2019-07-01', '2019-07-31'))
)

# Daily mean sea-level pressure
era5_mslp = (
    ee.ImageCollection('ECMWF/ERA5/DAILY')
    .select('mean_sea_level_pressure')
    .filter(ee.Filter.date('2019-07-01', '2019-07-31'))
)

# Daily mean surface pressure
era5_sp = (
    ee.ImageCollection('ECMWF/ERA5/DAILY')
    .select('surface_pressure')
    .filter(ee.Filter.date('2019-07-01', '2019-07-31'))
)

# Daily mean 10m u-component of wind
era5_u_wind_10m = (
    ee.ImageCollection('ECMWF/ERA5/DAILY')
    .select('u_component_of_wind_10m')
    .filter(ee.Filter.date('2019-07-01', '2019-07-31'))
)

# Convert pressure levels from Pa to hPa - Example for surface pressure
era5_sp = era5_sp.map(
    lambda image: image.divide(100).set(
        'system:time_start', image.get('system:time_start')
    )
)

# Visualization palette for total precipitation
vis_tp = {
    'min': 0.0,
    'max': 0.1,
    'palette': ['ffffff', '00ffff', '0080ff', 'da00ff', 'ffa400', 'ff0000'],
}

# Visualization palette for temperature (mean, min and max) and 2m dewpoint
# temperature
vis_2mt = {
    'min': 250,
    'max': 320,
    'palette': [
        '000080',
        '0000d9',
        '4000ff',
        '8000ff',
        '0080ff',
        '00ffff',
        '00ff80',
        '80ff00',
        'daff00',
        'ffff00',
        'fff500',
        'ffda00',
        'ffb000',
        'ffa400',
        'ff4f00',
        'ff2500',
        'ff0a00',
        'ff00ff',
    ],
}

# Visualization palette for u- and v-component of 10m wind
vis_wind = {
    'min': 0,
    'max': 30,
    'palette': [
        'ffffff',
        'ffff71',
        'deff00',
        '9eff00',
        '77b038',
        '007e55',
        '005f51',
        '004b51',
        '013a7b',
        '023aad',
    ],
}

# Visualization palette for pressure (surface pressure, mean sea level
# pressure) - adjust min and max values for mslp to 'min':990 and 'max':1050
vis_pressure = {
    'min': 500,
    'max': 1150,
    'palette': [
        '01ffff',
        '058bff',
        '0600ff',
        'df00ff',
        'ff00ff',
        'ff8c00',
        'ff8c00',
    ],
}


# Add layer to map
m = geemap.Map()
m.add_layer(
    era5_tp.filter(ee.Filter.date('2019-07-15')),
    vis_tp,
    'Daily total precipitation sums',
)
m.add_layer(
    era5_2d.filter(ee.Filter.date('2019-07-15')),
    vis_2mt,
    'Daily mean 2m dewpoint temperature',
)
m.add_layer(
    era5_2mt.filter(ee.Filter.date('2019-07-15')),
    vis_2mt,
    'Daily mean 2m air temperature',
)
m.add_layer(
    era5_u_wind_10m.filter(ee.Filter.date('2019-07-15')),
    vis_wind,
    'Daily mean 10m u-component of wind',
)
m.add_layer(
    era5_sp.filter(ee.Filter.date('2019-07-15')),
    vis_pressure,
    'Daily mean surface pressure',
)

m.set_center(21.2, 22.2, 2)
m
