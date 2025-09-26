local id = 'NASA/GEOS-CF/v2/ana/htf';
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local template = import 'NASA_GEOS-CF_v2.libsonnet';
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
  title: 'GEOS-CF Ana htf v2: Goddard Earth Observing System Composition Forecast',
  version: 'v2',
  description: |||
    This dataset contains analysis (ana) of high-temporal frequency data (htf) at 15 minute intervals. 
    It is created from the original GEOS-CF collection htf_inst_15mn_glo_L1440x721_slv.
  ||| + template.description,
  'sci:citation': template.sci_citation,
  'sci:doi': '10.1029/2020MS002413',
  providers: [
    ee.producer_provider(
      'NASA / GMAO',
      'https://gmao.gsfc.nasa.gov/gmao-products/geos-cf/'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  license: license.id,
  links: ee.standardLinks(subdir, id),
  extent: ee.extent_global('2025-08-04T00:00:00Z', null),
  'gee:categories': ['atmosphere'],
  keywords: [
    'composition',
    'forecast',
    'geos',
    'geos-cf',
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
        description: 'Carbon monoxide (CO, MW = 28.01 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'NO2',
        description: 'Nitrogen dioxide (NO2, MW = 46.01 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'O3',
        description: 'Ozone (O3, MW = 48.0 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'PM25_RH35',
        description: 'Particulate matter with diameter below 2.5 um mass at RH 35% (includes water) mass concentration in dry air',
        'gee:units': 'ug m-3',
      },
      {
        name: 'SLP',
        description: 'Sea level pressure',
        'gee:units': units.pascal,
      },
      {
        name: 'SO2',
        description: 'Sulfur dioxide (SO2, MW = 64.04 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
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
        display_name: 'Nitrogen Dioxide',
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
