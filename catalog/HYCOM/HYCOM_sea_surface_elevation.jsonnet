local id = 'HYCOM/sea_surface_elevation';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/sea_surface_elevation_versions.libsonnet';

local subdir = 'HYCOM';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local template = import 'HYCOM.libsonnet';
local units = import 'units.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'HYCOM: Hybrid Coordinate Ocean Model, Sea Surface Elevation',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: template.description,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'elevation',
    'hycom',
    'nopp',
    'ocean',
    'ssh',
    'water',
  ],
  providers: [
    ee.producer_provider('NOPP', 'https://hycom.org/'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -80.48, 180.0, 80.48, '1992-10-02T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'experiment',
        description: 'Experiment number',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      8905.6,
    ],
    'eo:bands': [
      {
        name: 'surface_elevation',
        description: 'Sea surface elevation anomaly relative to the modeled elevation mean',
        'gee:units': units.meter,
        'gee:scale': 0.001,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Surface Elevation',
        lookat: {
          lat: 28.3,
          lon: -28.1,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              -2000.0,
            ],
            max: [
              2000.0,
            ],
            palette: [
              'blue',
              'cyan',
              'yellow',
              'red',
            ],
            bands: [
              'surface_elevation',
            ],
          },
        },
      },
    ],
    surface_elevation: {
      minimum: -5681.0,
      maximum: 5965.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    J. A. Cummings and O. M. Smedstad. 2013: Variational Data Assimilation for
    the Global Ocean. Data Assimilation for Atmospheric, Oceanic and Hydrologic
    Applications vol II, chapter 13, 303-343.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': 'This dataset is freely available with no restrictions.',
}
