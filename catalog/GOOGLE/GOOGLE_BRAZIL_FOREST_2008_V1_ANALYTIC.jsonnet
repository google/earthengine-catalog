local id = 'GOOGLE/BRAZIL_FOREST_2008/V1/ANALYTIC';
local subdir = 'GOOGLE';
local version = 'V1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local description = importstr 'GOOGLE_BRAZIL_FOREST_2008_V1_ANALYTIC_description.md';
local geo_prio = importstr 'includes/_BRAZIL_FOREST_2008_geo_prio.md';
local processing = importstr 'includes/_BRAZIL_FOREST_2008_processing.md';
local limitations = importstr 'includes/_BRAZIL_FOREST_2008_limitations.md';
local access_note = importstr 'includes/_BRAZIL_FOREST_2008_access_note.md';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Brazil Forest Imagery Dataset 2008: Analytic Basemap',
  version: version,
  'gee:type': ee_const.gee_type.image,
  'gee:status': 'beta',
  description: description + geo_prio + processing + limitations + access_note,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license('https://developers.google.com/earth-engine/datasets/catalog/Earth_Engine_SPOT_542_Datasets_License.pdf'),
  ],
  'gee:categories': ['satellite-imagery'],
  keywords: [
    'brazil',
    'forest-code',
    'multispectral',
    'imagery',
    'spot',
    'google',
  ],
  providers: [
    ee.producer_provider('Google Earth Engine', 'https://earthengine.google.com/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(xmin=-74, ymin=-34, xmax=-34, ymax=6, start='2007-01-01T00:00:00Z', end='2009-11-26T23:59:59Z'),
  summaries: {
    gsd: [
      10,
    ],
    'eo:bands': [
      {
        name: 'G',
        description: 'Green reflectance (top-of-atmosphere)',
        'gee:scale': 0.0001,
      },
      {
        name: 'R',
        description: 'Red reflectance (top-of-atmosphere)',
        'gee:scale': 0.0001,
      },
      {
        name: 'N',
        description: 'Near-infrared reflectance (top-of-atmosphere)',
        'gee:scale': 0.0001,
      },
      {
        name: 'date',
        description: 'Observation date as epoch (seconds)',
        'gee:units': units.seconds,
      },
      {
        name: 'scale',
        description: 'Pixel size of source image (see [Methodology](/earth-engine/guides/spot_brazil_forest_imagery_dataset_2008_v1))',
      },
      {
        name: 'satellite',
        description: 'Source satellite (SPOT 2, 4, or 5)',
      },
      {
        name: 'coregistered',
        description: 'Boolean: 1 if automated misregistration correction was applied (see [Methodology](/earth-engine/guides/spot_brazil_forest_imagery_dataset_2008_v1))',
      },
    ],
    G: {minimum: 0, maximum: 10000, 'gee:estimated_range': true},
    R: {minimum: 0, maximum: 10000, 'gee:estimated_range': true},
    N: {minimum: 0, maximum: 10000, 'gee:estimated_range': true},
    satellite: {minimum: 2, maximum: 5, 'gee:estimated_range': false},
    coregistered: {minimum: 0, maximum: 1, 'gee:estimated_range': false},
    'gee:visualizations': [
      {
        display_name: 'Analytic Basemap NIR/R/G',
        lookat: {lon: -55.0, lat: -10.0, zoom: 6},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [10000],
            bands: ['N', 'R', 'G'],
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
