local id = 'ISDASOIL/Africa/v1/bedrock_depth';
local subdir = 'ISDASOIL';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

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
  title: 'iSDAsoil Depth to Bedrock',
  version: 'v1',
  'gee:type': ee_const.gee_type.image,
  description: |||
    Depth to bedrock at 0-200 cm depth, predicted mean and standard deviation.

    Due to the potential cropland mask that was used for generating the data,
    many areas of exposed rock (where depth to bedrock would be 0 cm) have been
    masked out and therefore appear as nodata values. The maximum depth of this
    layer is 200 cm, but this does not represent the maximum possible soil depth,
    therefore values of 200 should be interpreted as >= 200.

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
    'bedrock',
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
        name: 'mean_0_200',
        description: 'Depth to bedrock, predicted mean at 0-200 cm depth',
        'gee:units': 'cm',
      },
      {
        name: 'stdev_0_200',
        description: 'Depth to bedrock, standard deviation at 0-20 cm depth',
        'gee:units': 'cm',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Depth to bedrock, 0-200 cm',
        lookat: {
          lat: 25.0,
          lon: -3.0,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              27.0,
            ],
            max: [
              200.0,
            ],
            bands: [
              'mean_0_200',
            ],
          },
        },
      },
    ],
    mean_0_200: {
      minimum: 27.0,
      maximum: 200.0,
      'gee:estimated_range': false,
    },
    stdev_0_200: {
      minimum: 9.0,
      maximum: 254.0,
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
