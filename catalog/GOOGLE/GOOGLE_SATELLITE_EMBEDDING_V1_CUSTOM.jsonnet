local id = 'GOOGLE/SATELLITE_EMBEDDING/V1/CUSTOM';
local subdir = 'GOOGLE';
local version = '1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local samples_description = importstr 'custom_satellite_embedding_samples.md';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local ordinal(n) =
  local mod100 = n % 100;
  local mod10 = n % 10;
  if mod100 >= 11 && mod100 <= 13 then 'th'
  else if mod10 == 1 then 'st'
  else if mod10 == 2 then 'nd'
  else if mod10 == 3 then 'rd'
  else 'th';

local eo_bands = [
  {
    name: std.format('A%02d', i),
    description: std.format(
      'The %d%s axis of the embedding vector.', [i, ordinal(i)]
    ),
    'gee:units': units.dimensionless,
  }
  for i in std.range(0, 63)
];

local band_ranges = {
  [std.format('A%02d', i)]: {
    minimum: -1,
    maximum: 1,
    'gee:estimated_range': false,
  }
  for i in std.range(0, 63)
};

{
  id: id,
  title: 'Custom Satellite Embeddings Samples',
  version: version,

  description: samples_description,

  keywords: [
    'embeddings',
    'google',
    'landsat_derived',
    'sentinel1_derived',
    'sentinel2_derived',
  ],

  'gee:categories': ['satellite-imagery'],

  providers: [
    ee.producer_provider('Google Earth Engine', 'https://earthengine.google.com/'),
    ee.producer_provider('Google DeepMind', 'https://deepmind.google/'),
    ee.host_provider(self_ee_catalog_url),
  ],

  extent: ee.extent_global('2024-12-07T00:00:00Z', '2026-05-15T00:00:00Z'),

  summaries: {
    'gee:schema': [
      {
        name: 'DATASET',
        description: 'The sample dataset name.',
        type: ee_const.var_type.string,
      },
      {
        name: 'DATASET_VERSION',
        description: 'The dataset version.',
        type: ee_const.var_type.string,
      },
      {
        name: 'END_DATE',
        description:
          'Exclusive end date of the time interval covered by the image ' +
          '(YYYY-MM-DD).',
        type: ee_const.var_type.string,
      },
      {
        name: 'IMAGE_ID',
        description: 'Unique identifier of the image within the dataset.',
        type: ee_const.var_type.string,
      },
      {
        name: 'MODEL_VERSION',
        description:
          'The version string uniquely identifying the model version used to ' +
          'produce the image.',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROCESSING_SOFTWARE_VERSION',
        description:
          'The version string uniquely identifying the model data processing ' +
          'software used to produce the image.',
        type: ee_const.var_type.string,
      },
      {
        name: 'START_DATE',
        description:
          'Inclusive start date of the time interval covered by the image ' +
          '(YYYY-MM-DD).',
        type: ee_const.var_type.string,
      },
      {
        name: 'UTM_ZONE',
        description:
          'The UTM zone of the coordinate reference system used to produce ' +
          'the image.',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [10],
    'eo:bands': eo_bands,
    'gee:visualizations': [
      {
        display_name: 'Corcoran City Agricultural Change - A01, A16, A09',
        lookat: { lon: -119.56, lat: 36.10, zoom: 12 },
        image_visualization: {
          band_vis: {
            min: [-0.3],
            max: [0.3],
            bands: ['A01', 'A16', 'A09'],
          },
        },
      },
    ],
  } + band_ranges,

  'sci:citation': |||
    Brown, C. F., Kazmierski, M. R., Pasquarella, V. J., Rucklidge, W. J.,
    Samsikova, M., Zhang, C., Shelhamer, E., Lahera, E., Wiles, O.,
    Ilyushchenko, S., Gorelick, N., Zhang, L. L., Alj, S., Schechter, E.,
    Askay, S., Guinan, O., Moore, R., Boukouvalas, A., &amp; Kohli, P. (2025).
    AlphaEarth Foundations: An embedding field model for accurate and
    efficient global mapping from sparse label data. arXiv preprint
    arXiv:2507.22291. [doi:10.48550/arXiv.2507.22291](https://doi.org/10.48550/arXiv.2507.22291)
  |||,

  'gee:terms_of_use': ee.gee_terms_of_use(license) + '\n\n' + |||
    This collection of datasets is licensed under
    [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) and requires
    the following attribution text: "Custom Satellite Embeddings from
    AlphaEarth Foundations are produced by Google and Google DeepMind." Use
    of these public datasets is subject to the
    [Google Cloud Acceptable Use Policy](https://cloud.google.com/terms/aup).
  |||,

  'gee:type': ee_const.gee_type.folder,

  license: license.id,

  links: ee.standardLinks(subdir, id),

  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
