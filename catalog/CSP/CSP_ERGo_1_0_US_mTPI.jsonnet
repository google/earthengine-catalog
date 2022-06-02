local id = 'CSP/ERGo/1_0/US/mTPI';
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
  title: 'US NED mTPI (Multi-Scale Topographic Position Index)',
  version: '1.0',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The mTPI distinguishes ridge from valley forms. It is calculated using
    elevation data for each location subtracted by the mean elevation within a
    neighborhood. mTPI uses moving windows of radius (km): 115.8, 89.9, 35.5,
    13.1, 5.6, 2.8, and 1.2. It is based on the USGS's 10m NED DEM (available
    in EE as USGS/NED).

    The Conservation Science Partners (CSP) Ecologically Relevant Geomorphology
    (ERGo) Datasets, Landforms and Physiography contain detailed, multi-scale
    data on landforms and physiographic (aka land facet) patterns. Although
    there are many potential uses of these data, the original purpose for these
    data was to develop an ecologically relevant classification and map of
    landforms and physiographic classes that are suitable for climate adaptation
    planning. Because there is large uncertainty associated with future climate
    conditions and even more uncertainty around ecological responses, providing
    information about what is unlikely to change offers a strong foundation for
    managers to build robust climate adaptation plans. The quantification of
    these features of the landscape is sensitive to the resolution, so we
    provide the highest resolution possible given the extent and characteristics
    of a given index.
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
      270.0,
    ],
    'eo:bands': [
      {
        name: 'elevation',
        description: 'NED-derived mTPI ranging from negative (valleys) to positive (ridges) values',
        'gee:units': 'Meters',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'US mTPI',
        lookat: {
          lat: 40.3439,
          lon: -105.8636,
          zoom: 11,
        },
        image_visualization: {
          band_vis: {
            min: [
              -200.0,
            ],
            max: [
              200.0,
            ],
            palette: [
              '0b1eff',
              '4be450',
              'fffca4',
              'ffa011',
              'ff0000',
            ],
            bands: [
              'elevation',
            ],
          },
        },
      },
    ],
    elevation: {
      minimum: -378.0,
      maximum: 493.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Theobald, D. M., Harrison-Atlas, D., Monahan, W. B., & Albano, C. M.
    (2015). Ecologically-relevant maps of landforms and physiographic diversity
    for climate adaptation planning. PloS one, 10(12),
    [e0143619](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0143619)
  |||,
  'gee:terms_of_use': 'This dataset is available to use under the Creative Commons BY-NC-SA license.',
  'gee:unusual_terms_of_use': true,
  'gee:user_uploaded': true,
}
