local id = 'LANDSAT/COMPOSITES/C02/T1_L2_ANNUAL';
local subdir = 'LANDSAT';
local version = 'COMPOSITES/C02';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local notes = import 'templates/LANDSAT_COMPOSITES_L2.libsonnet';
local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  version: version,
  title: 'Landsat Collection 2 Tier 1 Level 2 Annual Composite',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    These Landsat Collection 2 Tier 1 Level 2 composites are made from Tier 1
    Level 2 orthorectified scenes, and include the SR bands:
    blue, green, red, nir, swir1, swir2, and thermal.

    These composites are created from
    all the scenes in
    each annual period beginning from the first day of the year and
    continuing to the last day of the year.  All the images from each year
    are included in the composite, with the most recent pixel as the composite value.
  |||  +  notes.description,
  license: license.id,
    links: ee.standardLinks(subdir, id) + [
  ],
  'gee:categories': ['satellite-imagery'],
  keywords: [
    'landsat',
    'landsat-composite',
    'sr',
    'usgs',
  ],
  providers: [
    ee.producer_provider('Google', 'https://earthengine.google.com'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1984-01-01T00:00:00Z', null),
  summaries: {
    gsd: [30.0],
    'eo:bands': [
      {
        name: 'blue',
        description: 'Blue (surface reflectance)',
      },
      {
        name: 'green',
        description: 'Green (surface reflectance)',
      },
      {
        name: 'red',
        description: 'Red (surface reflectance)',
      },
      {
        name: 'nir',
        description: 'Near infrared (surface reflectance)',
      },
      {
        name: 'swir1',
        description: 'Shortwave infrared 1 (surface reflectance)',
      },
      {
        name: 'swir2',
        description: 'Shortwave infrared 2 (surface reflectance)',
      },
      {
        name: 'thermal',
        description: 'Surface temperature',
        'gee:units': units.kelvin,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'True Color Composite',
        lookat: {
          lon: 6.746,
          lat: 46.529,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0
            ],
            max: [
              0.3
            ],
            bands: [
              'red',
              'green',
              'blue'
            ],
          },
        },
      },
    ],
  },
  'gee:min_zoom_level': 5,
  'gee:interval': {type: 'cadence', unit: 'year', interval: 1},
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
