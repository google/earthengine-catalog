local id = 'ECMWF/ERA5/HOURLY_PRESSURE_LEVELS';
local subdir = 'ECMWF';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local era5 = import 'templates/ECMWF_ERA5.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local levels = [
  1, 2, 3, 5, 7, 10, 20, 30, 50, 70, 100, 125, 150, 175, 200, 225, 250, 300,
  350, 400, 450, 500, 550, 600, 650, 700, 750, 775, 800, 825, 850, 875, 900,
  925, 950, 975, 1000,
];

local params = [
  {
    name: 'divergence',
    desc: 'The divergence of the wind',
    units: units.reciprocal_second,
  },
  {
    name: 'fraction_of_cloud_cover',
    desc: 'The fraction of cloud cover',
    units: units.dimensionless,
  },
  {
    name: 'ozone_mass_mixing_ratio',
    desc: 'The mass mixing ratio of ozone',
    units: units.dimensionless,
  },
  {
    name: 'potential_vorticity',
    desc: 'The potential vorticity',
    units: units.pvu,
  },
  {
    name: 'relative_humidity',
    desc: 'The relative humidity',
    units: units.percent,
  },
  {
    name: 'specific_cloud_ice_water_content',
    desc: 'The specific cloud ice water content',
    units: units.dimensionless,
  },
  {
    name: 'specific_cloud_liquid_water_content',
    desc: 'The specific cloud liquid water content',
    units: units.dimensionless,
  },
  {
    name: 'specific_humidity',
    desc: 'The specific humidity',
    units: units.dimensionless,
  },
  {
    name: 'specific_rain_water_content',
    desc: 'The specific rain water content',
    units: units.dimensionless,
  },
  {
    name: 'specific_snow_water_content',
    desc: 'The specific snow water content',
    units: units.dimensionless,
  },
  {
    name: 'temperature',
    desc: 'The temperature',
    units: units.kelvin,
  },
  {
    name: 'u_component_of_wind',
    desc: 'The eastward component of the wind',
    units: units.velocity_si,
  },
  {
    name: 'v_component_of_wind',
    desc: 'The northward component of the wind',
    units: units.velocity_si,
  },
  {
    name: 'vertical_velocity',
    desc: 'The vertical velocity',
    units: units.pascal_per_second,
  },
  {
    name: 'vorticity',
    desc: 'The vorticity of the wind',
    units: units.reciprocal_second,
  },
];

local bands = [
  {
    name: '%s_%dhPa' % [p.name, l],
    description: '%s at the %d hPa pressure level.' % [p.desc, l],
    'gee:units': p.units,
  }
  for p in params
  for l in levels
];

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'ERA5 Hourly Pressure Levels - ECMWF Climate Reanalysis',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    ERA5 is the fifth generation ECMWF atmospheric reanalysis of the global
    climate. Reanalysis combines model data with observations from across the
    world into a globally complete and consistent dataset. ERA5 replaces its
    predecessor, the ERA-Interim reanalysis.

    This dataset contains 3D parameters at 37 pressure levels.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['climate'],
  keywords: [
    'climate',
    'copernicus',
    'ecmwf',
    'era5',
    'atmosphere',
    'reanalysis',
    'weather',
    'pressure',
    'hourly',
    'temperature',
    'wind',
  ],
  providers: [
    ee.producer_provider(
      'Copernicus Climate Change Service (C3S)',
      'https://cds.climate.copernicus.eu/datasets/' +
      'reanalysis-era5-pressure-levels?tab=overview'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1940-01-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'hour',
        description: 'Hour of the day',
        type: ee_const.var_type.int,
      },
    ],
    gsd: [
      27830.0,
    ],
    'eo:bands': bands,
    'gee:visualizations': [
      {
        display_name: 'U component of wind at 1000hPa',
        lookat: {
          lat: 40.71,
          lon: -100.55,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              -15.0,
            ],
            max: [
              15.0,
            ],
            palette: [
              'blue',
              'cyan',
              'white',
              'yellow',
              'red',
            ],
            bands: [
              'u_component_of_wind_1000hPa',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': era5.citation,
  'gee:interval': {
    type: 'cadence',
    unit: 'hour',
    interval: 1,
  },
  'gee:terms_of_use': era5.terms_of_use,
}
