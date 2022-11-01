local id = 'CSP/ERGo/1_0/US/physiography';
local subdir = 'CSP';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_nc_sa_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'US Physiography',
  version: '1.0',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The Physiography dataset represents the spatial intersection of landforms
    (available in EE as ERGo/1_0/US/landforms) and lithology (available in EE
    as ERGo/1_0/US/lithology) data layers. It provides 247 unique combinations
    out of a possible 270. The values for each type are formed by concatenating
    the landform and lithology types (e.g., 1101 is \"Peak/ridge\" landform on
    \"carbonate\" lithology). This data layer is sometimes referred to as
    characterizing \"land facets\".

    The landforms layer is based on the USGS's 10m NED DEM (available in EE
    as USGS/NED). The lithology layer is not basen on any DEM.

    This dataset is provided just for the US, because of the availability
    of the lithology data layer, though these data are likely available for
    other countries.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'aspect',
    'csp',
    'elevation',
    'ergo',
    'geophysical',
    'landforms',
    'slope',
    'topography',
    'us',
  ],
  providers: [
    ee.producer_provider('Conservation Science Partners', 'https://www.csp-inc.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-132.09, 12.54, -60.35, 56.21,
                    '2006-01-24T00:00:00Z', '2011-05-13T00:00:00Z'),
  summaries: {
    gsd: [
      90.0,
    ],
    'eo:bands': [
      {
        name: 'constant',
        description: 'Landforms and lithology intersection',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Physiography',
        lookat: {
          lat: 40.5242,
          lon: -105.4248,
          zoom: 8,
        },
        image_visualization: {
          band_vis: {
            min: [
              1100.0,
            ],
            max: [
              4220.0,
            ],
            bands: [
              'constant',
            ],
          },
        },
      },
    ],
    constant: {
      minimum: 1100.0,
      maximum: 4220.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Theobald, D. M., Harrison-Atlas, D., Monahan, W. B., & Albano, C. M.
    (2015). Ecologically-relevant maps of landforms and physiographic diversity
    for climate adaptation planning. PloS one, 10(12),
    [e0143619](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0143619)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:unusual_terms_of_use': true,
  'gee:user_uploaded': true,
}
