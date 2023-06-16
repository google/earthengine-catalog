local id = 'ESA/WorldCereal/2021/MODELS/v100';
local subdir = 'ESA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'ESA WorldCereal 10m v100',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Write enough here for most people to understand:
    - what a dataset is for
    - what it's limitations are
    - how it was created
    - and anything else essential to know when working with the data.

    Things to consider when writing:
    - The text will be processed as CommonMark (a.k.a. MarkDown)
    - Define all acronyms.  e.g. Absolutely Amazing Sensor (AAS).
    - Make links to additional resources or manuals when appropriate
    - Bare links must be put in markdown links.  e.g.
        - https://earthengine.google.com/ is just text
        - [https://earthengine.google.com/](https://earthengine.google.com/)
          is actually a link.
    - The accordion operator (`|||`) allows for writing multiline strings.
    - Indent 2 spaces under the |||.
  |||,
  license: license.id,

  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference)],
  keywords: ['agriculture', 'copernicus', 'crop', 'esa', 'global', 'landcover', 'landsat', 'sentinel1_derived', 'sentinel2_derived'],
  providers: [
    ee.producer_provider(
      'ESA WorldCereal Consortium',
      'https://esa-worldcereal.org/en'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2020-01-01T00:00:00Z', '2021-12-31T23:59:59Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'aez_id',
        description: 'ID of the AEZ to which the product belongs.',
        type: ee_const.var_type.int
      },
      {
        name: 'product',
        description: 'WorldCereal product name.',
        type: ee_const.var_type.string,
      },
      {
        name: 'season',
        description: 'Season for which the product is valid.',
        type: ee_const.var_type.string,
      },
      {
        name: 'start_date',
        description: 'Start date (yyyy-mm-dd) for which the product is valid.',
        type: ee_const.var_type.string,
      },
      {
        name: 'end_date',
        description: 'End date (yyyy-mm-dd) for which the product is valid.',
        type: ee_const.var_type.string
      },
    ],
    gsd: [10],
    'eo:bands': [
      {
        name: 'classification',
        description: 'Classification'
      },
      {
        name: 'confidence',
        description: 'Confidence'
      },
    ],
    classification: {minimum: 0.0, maximum: 100.0, 'gee:estimated_range': false},
    confidence: {minimum: 0.0, maximum: 100.0, 'gee:estimated_range': false},
    'gee:visualizations': [{
      display_name: 'Classification confidence',
      lookat: {lon: -103.8881, lat: 53.0371, zoom: 10},
      image_visualization: {
        band_vis: {
          min: [0],
          max: [100],
          palette: [
            'be0000','fff816','069711'
          ],
          bands: ['confidence'],
        },
      },
    }],
  },
  'sci:doi': '10.5194/essd-2023-184',
  'sci:citation': |||
    Van Tricht, K., Degerickx, J., Gilliams, S., Zanaga, D., Battude, M., Grosu, A., ... & Szantoi, Z. (2023). WorldCereal: a dynamic open-source system for global-scale, seasonal, and reproducible crop and irrigation mapping. Earth System Science Data Discussions, 2023, 1-36.
    [doi:10.5194/essd-2023-184](https://doi.org/10.5194/essd-2023-184),
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
