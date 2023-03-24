local id = 'ISDASOIL/Africa/v1/texture_class';
local subdir = 'ISDASOIL';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

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
  title: 'iSDAsoil USDA Texture Class',
  version: 'v1',
  'gee:type': ee_const.gee_type.image,
  description: |||
    USDA Texture Class at soil depths of 0-20 cm and 20-50 cm.
    In areas of dense jungle (generally over central Africa), model accuracy is
    low and therefore artifacts such as banding (striping) might be seen.

    Soil property predictions were made by
    [Innovative Solutions for Decision Agriculture Ltd. (iSDA)](https://isda-africa.com/)
    at 30 m pixel size using machine learning coupled with remote sensing data
    and a training set of over 100,000 analyzed soil samples.

    Further information can be found in the
    [FAQ](https://www.isda-africa.com/isdasoil/faq/) and
    [technical information documentation](https://www.isda-africa.com/isdasoil/technical-information/). To submit an issue or request support, please visit
    [the iSDAsoil site](https://isda-africa.com/isdasoil).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
  ],
  keywords: [
    'africa',
    'aluminium',
    'isda',
    'soil',
  ],
  providers: [
    ee.producer_provider('iSDA', 'https://isda-africa.com/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-31.46, -35.22, 57.08, 37.98,
                    '2001-01-01T00:00:00Z', '2017-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'texture_0_20',
        description: 'USDA Texture Class at 0-20 cm depth',
        'gee:classes': [
          {
            value: 1,
            color: 'd5c36b',
            description: 'Clay',
          },
          {
            value: 2,
            color: 'b96947',
            description: 'Silty Clay',
          },
          {
            value: 3,
            color: '9d3706',
            description: 'Sandy Clay',
          },
          {
            value: 4,
            color: 'ae868f',
            description: 'Clay Loam',
          },
          {
            value: 5,
            color: 'f86714',
            description: 'Silty Clay Loam',
          },
          {
            value: 6,
            color: '46d143',
            description: 'Sandy Clay Loam',
          },
          {
            value: 7,
            color: '368f20',
            description: 'Loam',
          },
          {
            value: 8,
            color: '3e5a14',
            description: 'Silt Loam',
          },
          {
            value: 9,
            color: 'ffd557',
            description: 'Sandy Loam',
          },
          {
            value: 10,
            color: 'fff72e',
            description: 'Silt',
          },
          {
            value: 11,
            color: 'ff5a9d',
            description: 'Loamy Sand',
          },
          {
            value: 12,
            color: 'ff005b',
            description: 'Sand',
          },
        ],
      },
      {
        name: 'texture_20_50',
        description: 'USDA Texture Class at 20-50 cm depth',
        'gee:classes': [
          {
            value: 1,
            color: 'd5c36b',
            description: 'Clay',
          },
          {
            value: 2,
            color: 'b96947',
            description: 'Silty Clay',
          },
          {
            value: 3,
            color: '9d3706',
            description: 'Sandy Clay',
          },
          {
            value: 4,
            color: 'ae868f',
            description: 'Clay Loam',
          },
          {
            value: 5,
            color: 'f86714',
            description: 'Silty Clay Loam',
          },
          {
            value: 6,
            color: '46d143',
            description: 'Sandy Clay Loam',
          },
          {
            value: 7,
            color: '368f20',
            description: 'Loam',
          },
          {
            value: 8,
            color: '3e5a14',
            description: 'Silt Loam',
          },
          {
            value: 9,
            color: 'ffd557',
            description: 'Sandy Loam',
          },
          {
            value: 10,
            color: 'fff72e',
            description: 'Silt',
          },
          {
            value: 11,
            color: 'ff5a9d',
            description: 'Loamy Sand',
          },
          {
            value: 12,
            color: 'ff005b',
            description: 'Sand',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'USDA Texture Class at soil depths of 0-20 cm',
        lookat: {
          lat: 25.0,
          lon: -3.0,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'texture_0_20',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Hengl, T., Miller, M.A.E., Kri&zcaron;an, J., et al. African soil properties and nutrients
    mapped at 30 m spatial resolution using two-scale ensemble machine learning.
    Sci Rep 11, 6130 (2021).
    [doi:10.1038/s41598-021-85639-y](https://doi.org/10.1038/s41598-021-85639-y)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
