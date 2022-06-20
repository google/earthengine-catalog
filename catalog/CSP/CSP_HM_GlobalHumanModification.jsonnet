local id = 'CSP/HM/GlobalHumanModification';
local subdir = 'CSP';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_nc_sa_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'CSP gHM: Global Human Modification',
  version: '1.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The global Human Modification dataset (gHM) provides a cumulative measure of human modification
    of terrestrial lands globally at 1 square-kilometer resolution. The gHM
    values range from 0.0-1.0 and are calculated by estimating the proportion of a given location
    (pixel) that is modified, the estimated intensity of modification
    associated with a given type of human modification or "stressor".
    5 major anthropogenic stressors circa 2016 were mapped using 13
    individual datasets:

    * human settlement (population density, built-up areas)
    * agriculture (cropland, livestock)
    * transportation (major, minor, and two-track roads; railroads)
    * mining and energy production
    * electrical infrastructure (power lines, nighttime lights)

    Please see the paper for additional methodological details.
    This asset was re-projected to WGS84 for use in Earth Engine.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.source,
      href: 'https://gdra-tnc.org/current/',
    },
  ],
  keywords: [
    'csp',
    'fragmentation',
    'human_modification',
    'landcover',
    'landscape_gradient',
    'stressors',
    'tnc',
  ],
  providers: [
    ee.producer_provider('Conservation Science Partners', 'https://www.csp-inc.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2016-01-01T00:00:00Z', '2016-12-31T00:00:00Z'),
  summaries: {
    gsd: [
      1000.0,
    ],
    'eo:bands': [
      {
        name: 'gHM',
        description: 'global Human Modification',
        'gee:units': 'km^2',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Human modification',
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              1.0,
            ],
            palette: [
              '0c0c0c',
              '071aff',
              'ff0000',
              'ffbd03',
              'fbff05',
              'fffdfd',
            ],
            bands: [
              'gHM',
            ],
          },
        },
      },
    ],
    gHM: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Kennedy, C.M., J.R. Oakleaf, D.M. Theobald, S. Baurch-Murdo, and J. Kiesecker. 2019. Managing
    the middle: A shift in conservation priorities based on the global human modification gradient.
    Global Change Biology 00:1-16. [doi:10.1111/gcb.14549](https://doi.org/10.1111/gcb.14549)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'gee:terms_of_use': 'This dataset is available to use under the Creative Commons BY-NC-SA license.',
  'gee:unusual_terms_of_use': true,
  'gee:user_uploaded': true,
}
