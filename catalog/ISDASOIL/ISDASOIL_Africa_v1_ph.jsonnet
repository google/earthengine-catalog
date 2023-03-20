local id = 'ISDASOIL/Africa/v1/ph';
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
  title: 'iSDAsoil pH',
  version: 'v1',
  'gee:type': ee_const.gee_type.image,
  description: |||
    pH at soil depths of 0-20 cm and 20-50 cm,
    predicted mean and standard deviation.

    Pixel values must be back-transformed with `x/10`.

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
    'isda',
    'ph',
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
        name: 'mean_0_20',
        description: 'pH, predicted mean at 0-20 cm depth',
      },
      {
        name: 'mean_20_50',
        description: 'pH, predicted mean at 20-50 cm depth',
      },
      {
        name: 'stdev_0_20',
        description: 'pH, standard deviation at 0-20 cm depth',
      },
      {
        name: 'stdev_20_50',
        description: 'pH, standard deviation at 20-50 cm depth',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'pH, predicted mean at 0-20 cm depth',
        lookat: {
          lat: 25.0,
          lon: -3.0,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              3.0,
            ],
            max: [
              8.0,
            ],
            bands: [
              'mean_0_20',
            ],
          },
        },
      },
    ],
    mean_0_20: {
      minimum: 35.0,
      maximum: 103.0,
      'gee:estimated_range': false,
    },
    mean_20_50: {
      minimum: 35.0,
      maximum: 102.0,
      'gee:estimated_range': false,
    },
    stdev_0_20: {
      minimum: 0.0,
      maximum: 18.0,
      'gee:estimated_range': false,
    },
    stdev_20_50: {
      minimum: 0.0,
      maximum: 18.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Hengl, T., Miller, M.A.E., Križan, J., et al. African soil properties and nutrients
    mapped at 30 m spatial resolution using two-scale ensemble machine learning.
    Sci Rep 11, 6130 (2021).
    [doi:10.1038/s41598-021-85639-y](https://doi.org/10.1038/s41598-021-85639-y)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
