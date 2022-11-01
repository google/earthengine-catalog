local id = 'CSP/ERGo/1_0/Global/ALOS_landforms';
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
  title: 'Global ALOS Landforms',
  version: '1.0',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The ALOS Landform dataset provides landform classes created by combining
    the Continuous Heat-Insolation Load Index (ALOS CHILI) and the
    multi-scale Topographic Position Index (ALOS mTPI) datasets. It is
    based on the 30m \"AVE\" band of JAXA's ALOS DEM (available in EE as
    JAXA/ALOS/AW3D30_V1_1).

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
    'global',
    'landforms',
    'slope',
    'topography',
  ],
  providers: [
    ee.producer_provider('Conservation Science Partners', 'https://www.csp-inc.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2006-01-24T00:00:00Z', '2011-05-13T00:00:00Z'),
  summaries: {
    gsd: [
      90.0,
    ],
    'eo:bands': [
      {
        name: 'constant',
        description: 'ALOS-derived landform classes',
        'gee:classes': [
          {
            value: 11,
            color: '141414',
            description: 'Peak/ridge (warm)',
          },
          {
            value: 12,
            color: '383838',
            description: 'Peak/ridge',
          },
          {
            value: 13,
            color: '808080',
            description: 'Peak/ridge (cool)',
          },
          {
            value: 14,
            color: 'EBEB8F',
            description: 'Mountain/divide',
          },
          {
            value: 15,
            color: 'F7D311',
            description: 'Cliff',
          },
          {
            value: 21,
            color: 'AA0000',
            description: 'Upper slope (warm)',
          },
          {
            value: 22,
            color: 'D89382',
            description: 'Upper slope',
          },
          {
            value: 23,
            color: 'DDC9C9',
            description: 'Upper slope (cool)',
          },
          {
            value: 24,
            color: 'DCCDCE',
            description: 'Upper slope (flat)',
          },
          {
            value: 31,
            color: '1C6330',
            description: 'Lower slope (warm)',
          },
          {
            value: 32,
            color: '68AA63',
            description: 'Lower slope',
          },
          {
            value: 33,
            color: 'B5C98E',
            description: 'Lower slope (cool)',
          },
          {
            value: 34,
            color: 'E1F0E5',
            description: 'Lower slope (flat)',
          },
          {
            value: 41,
            color: 'a975ba',
            description: 'Valley',
          },
          {
            value: 42,
            color: '6f198c',
            description: 'Valley (narrow)',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Landforms',
        lookat: {
          lat: 40.5498,
          lon: -105.58,
          zoom: 11,
        },
        image_visualization: {
          band_vis: {
            min: [
              11.0,
            ],
            max: [
              42.0,
            ],
            palette: [
              '141414',
              '383838',
              '808080',
              'EBEB8F',
              'F7D311',
              'AA0000',
              'D89382',
              'DDC9C9',
              'DCCDCE',
              '1C6330',
              '68AA63',
              'B5C98E',
              'E1F0E5',
              'a975ba',
              '6f198c',
            ],
            bands: [
              'constant',
            ],
          },
        },
      },
    ],
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
