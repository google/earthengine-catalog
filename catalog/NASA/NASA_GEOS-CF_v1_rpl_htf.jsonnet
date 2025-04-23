local id = 'NASA/GEOS-CF/v1/rpl/htf';
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local template = import 'NASA_GEOS-CF_v1.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: 'Collection',
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  'gee:type': ee_const.gee_type.image_collection,
  title: 'GEOS-CF rpl htf v1: Goddard Earth Observing System Composition Forecast',
  version: 'v1',
  description: |||
    This dataset contains meteorological replay (rpl) of high-temporal
    frequency data (htf).
  ||| + template.description,
  'sci:citation': template.sci_citation,
  'sci:doi': '10.1029/2020MS002413',
  providers: [
    ee.producer_provider(
      'NASA / GMAO',
      'https://gmao.gsfc.nasa.gov/weather_prediction/GEOS-CF/'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  license: license.id,
  links: ee.standardLinks(subdir, id),
  extent: ee.extent_global('2018-01-01T00:00:00Z', null),
  'gee:categories': ['atmosphere'],
  keywords: [
    'composition',
    'forecast',
    'geos',
    'gmao',
    'nasa',
  ],
  'gee:terms_of_use': template.gee_terms_of_use,
  summaries: {
    gsd: [
      27750.0,
    ],
    'eo:bands': [
      {
        name: 'CO',
        description: 'Carbon monoxide (CO, MW = 28.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'NO2',
        description: 'Nitrogen dioxide (NO2, MW = 46.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'O3',
        description: 'Ozone (O3, MW = 48.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'PM25_RH35_GCC',
        description: 'Particulate matter with diameter below 2.5 um RH 35',
        'gee:units': 'ug m-3',
      },
      {
        name: 'PM25_RH35_GOCART',
        description: 'Total reconstructed PM2.5 RH 35',
        'gee:units': units.density_si,
      },
      {
        name: 'Q',
        description: 'Specific humidity',
        'gee:units': units.mass_fraction,
      },
      {
        name: 'RH',
        description: 'Relative humidity after moist',
      },
      {
        name: 'SLP',
        description: 'Sea level pressure',
        'gee:units': units.pascal,
      },
      {
        name: 'SO2',
        description: 'Sulfur dioxide (SO2, MW = 64.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'T',
        description: 'Air temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'U',
        description: 'Eastward wind',
        'gee:units': units.velocity_si,
      },
      {
        name: 'V',
        description: 'Northward wind',
        'gee:units': units.velocity_si,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Temperature',
        lookat: {
          lat: 20.0,
          lon: 100.0,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              220,
            ],
            max: [
              320,
            ],
            palette: [
              'd7191c',
              'fdae61',
              'ffffbf',
              'abd9e9',
              '2c7bb6',
            ],
            bands: [
              'T',
            ],
          },
        },
      },
      {
        display_name: 'NO2',
        lookat: {
          lat: 20.0,
          lon: 100.0,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              6.96e-11,
            ],
            max: [
              4.42e-8,
            ],
            bands: [
              'NO2',
            ],
          },
        },
      },
    ],
  },
}
