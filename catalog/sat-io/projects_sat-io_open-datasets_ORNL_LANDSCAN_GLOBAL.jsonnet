local id = 'projects/sat-io/open-datasets/ORNL/LANDSCAN_GLOBAL';
local subdir = 'sat-io';

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
  ],
  id: id,
  title: 'LandScan Population Data Global 1km',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The LandScan dataset, provided by the Oak Ridge National Laboratory (ORNL), offers a comprehensive and high-resolution global population distribution dataset that serves as a valuable resource for a wide range of applications. Leveraging state-of-the-art spatial modeling techniques and advanced geospatial data sources, LandScan provides detailed information on population counts and density at a 30 arc-second resolution, enabling precise and up-to-date insights into human settlement patterns across the globe. With its accuracy and granularity, LandScan supports diverse fields such as urban planning, disaster response, epidemiology, and environmental research, making it an essential tool for decision-makers and researchers seeking to understand and address various societal and environmental challenges on a global scale.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'demography',
    'landscan',
    'population',
  ],
  providers: [
    ee.producer_provider('Oak Ridge National Laboratory', 'https://www.ornl.gov/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2022-12-31T00:00:00Z'),
  summaries: {
    gsd: [
      1000,
    ],
    'eo:bands': [
      {
        name: 'b1',
        description: 'Estimated Population count',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Population count',
        lookat: {
          lat: 48.2875,
          lon: 31.175,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
               0.0,
            ],
            max: [
              10.0,
            ],
            bands: [
              'b1',
            ],
            palette:['lemonchiffon', 'khaki', 'orange','orangered', 'red', 'maroon'],
          },
        },
      },
    ],
    b1: {
      minimum: 0.0,
      maximum: 21171.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation':|||
        Sims, K., Reith, A., Bright, E., Kaufman, J., Pyle, J., Epting, J., Gonzales, J., Adams, D., Powell, E., Urban, M., & Rose, A. (2023). LandScan Global 2022 [Data set]. Oak Ridge National Laboratory. https://doi.org/10.48690/1529167
  |||,
  'sci:doi': '10.48690/1529167',
  'gee:terms_of_use': |||
    Landscan datasets are licensed under the Creative Commons Attribution 4.0
    International License. Users are free to use, copy, distribute, transmit,
    and adapt the work for commercial and non-commercial purposes, without
    restriction, as long as clear attribution of the source is provided.
  |||,
}
