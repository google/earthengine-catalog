local id = 'COPERNICUS/MARINE/GLOBAL_SEA_SURFACE/NRT_DAILY_V2';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/COPERNICUS_MARINE_GLOBAL_SEA_SURFACE_NRT_DAILY_versions.libsonnet';

local subdir = 'COPERNICUS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local template = import 'templates/COPERNICUS_MARINE_GLOBAL_SEA_SURFACE.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.cc_by_4_0;

local self_ee_catalog_url = version_config.ee_catalog_url;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  version: version,
  title: 'Multi Observation Global Ocean Sea Surface Salinity and Sea Surface Density : Daily, Near Real Time V2',
  // TODO(b/567239281): Remove once the sample and thumbnail images are
  // generated, and deprecate NRT_DAILY at the same time.
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.image_collection,
  description: template.description + template.nrt_daily_description +
               template.nrt_daily_v2_description + template.documentation,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  'gee:categories': ['oceans'],
  keywords: [
    'copernicus',
  ],
  providers: [
    ee.producer_provider('Copernicus', 'https://doi.org/10.48670/moi-00051'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2024-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      14000.0,
    ],
    'eo:bands': [
      {
        name: 'sos',
        description: 'Sea Surface Salinity',
        'gee:units': units.practical_salinity_unit,
      },
      {
        name: 'sos_error',
        description: 'Sea Surface Salinity Error',
        'gee:units': units.practical_salinity_unit,
      },
      {
        name: 'dos',
        description: 'Sea Surface Density',
        'gee:units': units.density_si,
      },
      {
        name: 'dos_error',
        description: 'Sea Surface Density Error',
        'gee:units': units.density_si,
      },
      {
        name: 'sea_ice_fraction',
        description: 'Sea Surface Ice Fraction',
        'gee:units': units.percent,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'DOS',
        lookat: {
          lat: 52.0,
          lon: 71.0,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              1020.41,
            ],
            max: [
              1027.596,
            ],
            palette: [
              '040613',
              '121328',
              '3F59A5',
              '3E80C0',
              '3EADCB',
              '8CCBD6',
              'EAFDFD',
            ],
            bands: [
              'dos',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': template.citation,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': template.term_of_use,
}
