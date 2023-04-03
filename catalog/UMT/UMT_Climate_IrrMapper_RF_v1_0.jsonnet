local id = 'UMT/Climate/IrrMapper_RF/v1_0';
local subdir = 'UMT';

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
  title: 'IrrMapper Irrigated Lands',
  version: '1.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    IrrMapper is an annual classification of irrigation status in the 11
    Western United States made at Landsat scale (i.e., 30 m) using the
    Random Forest algorithm, covering years 1986 - present.
    While the [IrrMapper paper](https://www.mdpi.com/2072-4292/12/14/2328)
    describes classification of four classes (i.e., irrigated, dryland,
    uncultivated, wetland), the dataset is converted to a binary
    classification of irrigated and non-irrigated.
    'Irrigated' refers to the detection of any irrigation during the year.
    The IrrMapper random forest model was trained using an extensive
    geospatial database of land cover from each of four irrigated- and
    non-irrigated classes, including over 50,000 human-verified irrigated
    fields, 38,000 dryland fields, and over 500,000 square kilometers of
    uncultivated lands.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
  ],
  keywords: [
    'irrigated_land',
    'landsat_derived',
  ],
  providers: [
    ee.producer_provider('University of Montana / Montana Climate Office', 'https://climate.umt.edu/progress/irrmapper/default.php'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-124.5, 31.3, -99.0, 49.0, '1986-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'classification',
        description: 'Irrigated pixels have the value of 1, the other pixels are masked out.',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'IrrMapper Irrigated Lands (1986 - 2018)',
        lookat: {
          lat: 45.262,
          lon: -112.516,
          zoom: 10,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              1.0,
            ],
            palette: [
              'blue',
            ],
            bands: [
              'classification',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Ketchum, D.; Jencso, K.; Maneta, M.P.; Melton, F.; Jones, M.O.; Huntington, J.
    IrrMapper: A Machine Learning Approach for High Resolution Mapping of
    Irrigated Agriculture Across the Western U.S.,
    Remote Sens. 2020, 12, 2328. [doi:10.3390/rs12142328](https://doi.org/10.3390/rs12142328)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
