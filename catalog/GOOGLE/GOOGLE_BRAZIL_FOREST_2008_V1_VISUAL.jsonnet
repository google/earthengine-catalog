local id = 'GOOGLE/BRAZIL_FOREST_2008/V1/VISUAL';
local subdir = 'GOOGLE';
local version = 'V1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Brazil Forest Imagery Dataset 2008: Visual Basemap',
  version: version,
  'gee:type': ee_const.gee_type.image,
  'gee:status': 'beta',
  description: importstr 'GOOGLE_BRAZIL_FOREST_2008_V1_VISUAL_description.md',
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license('https://developers.google.com/earth-engine/datasets/catalog/Earth_Engine_SPOT_542_Datasets_License.pdf'),
  ],
  'gee:categories': ['satellite-imagery'],
  keywords: [
    'brazil',
    'forest-code',
    'deforestation',
    'rgb',
    'spot',
    'google',
  ],
  providers: [
    ee.producer_provider('Google', 'https://research.google.com/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(xmin=-74, ymin=-34, xmax=-34, ymax=6, start='2007-01-01T00:00:00Z', end='2009-11-26T23:59:59Z'),
  summaries: {
    gsd: [
      5,
    ],
    'eo:bands': [
      {
        name: 'R',
        description: 'Red reflectance (8-bit)',
      },
      {
        name: 'G',
        description: 'Green reflectance (8-bit)',
      },
      {
        name: 'B',
        description: 'Blue reflectance (8-bit)',
      },
      {
        name: 'date',
        description: 'Observation date as Unix timestamp (seconds)',
      },
      {
        name: 'scale',
        description: 'Pixel size of source image',
      },
      {
        name: 'satellite',
        description: 'Source sensor (SPOT 2, 4, or 5)',
      },
      {
        name: 'coregistered',
        description: 'Boolean: 1 if automated misregistration correction was applied',
      },
    ],
    R: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    G: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    B: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    satellite: {minimum: 2, maximum: 5, 'gee:estimated_range': false},
    coregistered: {minimum: 0, maximum: 1, 'gee:estimated_range': false},
    'gee:visualizations': [
      {
        display_name: 'Visual Basemap RGB',
        lookat: {lon: -55.0, lat: -10.0, zoom: 6},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [255],
            bands: ['R', 'G', 'B'],
          },
        },
      },
    ],
  },
  'gee:terms_of_use': |||
    Use of this dataset is subject to the [Brazil Forest Imagery Dataset 2008 license agreement](https://developers.google.com/earth-engine/datasets/catalog/Earth_Engine_SPOT_542_Datasets_License.pdf) and requires the following attribution:

    “Google LLC, Brazil Forest Imagery Dataset 2008 created from circa 2008 SPOT images acquired by CNES's Spot World Heritage Programme.”

    Contains modified imagery from SPOT satellites made available by the CNES SPOT World Heritage Programme (https://regards.cnes.fr/html/swh/Home-swh3.html).
  |||,
}
