local id = 'GOOGLE/SATELLITE_EMBEDDING/V1/ANNUAL';
local subdir = 'GOOGLE';
local version = '1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'Satellite Embedding V' + version,
  version: version,

  // TODO - b/407615327: Add model name and paper link.
  // TODO - b/378102183 : Add tutorial link.
  description: |||
    The Google Satellite Embedding dataset is a global, analysis-ready
    collection of learned geospatial [embeddings](https://developers.google.com/machine-learning/crash-course/embeddings/embedding-space).
    Each 10-meter pixel in this dataset is a 64-dimensional representation, or
    "[embedding vector](https://developers.google.com/machine-learning/glossary#embedding-vector),"
    that encodes temporal trajectories of surface conditions at and around that
    pixel as measured by various Earth observation instruments and datasets,
    over a single calendar year. Unlike conventional spectral inputs and
    indices, where bands reflect physical measurements, embeddings are feature
    vectors that summarize relationships across multi-source, multi-model
    observations in a less directly interpretable, but more powerful way.

    The dataset covers terrestrial land surfaces and shallow waters, including
    intertidal and reef zones, inland waterways, and coastal waterways.
    Coverage at the poles is limited by satellite orbits and instrument
    coverage.

    The collection is composed of images covering approximately 163,840 meters
    by 163,840 meters, and each image has 64 bands `{A00, A01, …, A63}`, one for
    each axis of the 64D embedding space. All bands should be used for
    downstream analysis as they collectively refer to a 64D coordinate in
    the embedding space and are not independently interpretable.

    All images are generated in their local Universal Transverse Mercator
    projection as indicated by the UTM_ZONE property, and have
    `system:time_start` and `system:time_end` properties that reflect the
    calendar year summarized by the embeddings; for example, an embedding image
    for 2021 will have a `system:start_time` equal to
    `ee.Date('2021-01-01 00:00:00')` and a `system:end_time` equal to
    `ee.Date('2022-01-01 00:00:00')`.

    The embeddings are unit-length, meaning they have a magnitude of 1 and
    do not require any additional normalization, and are distributed across the
    [unit sphere](https://en.wikipedia.org/wiki/Unit_sphere), making them
    well-suited for use with clustering algorithms and tree-based classifiers.
    The embedding space is also consistent across years, and embeddings from
    different years can be used for condition change detection by considering
    the dot product or angle between two embedding vectors. Furthermore, the
    embeddings are designed to be linearly composable, i.e., they can be
    aggregated to produce embeddings at coarser spatial resolutions or
    transformed with vector arithmetic, and still retain their semantic meaning
    and distance relationships.

    The embeddings are produced by a geospatial model that assimilates multiple
    sources including optical, radar, LiDAR, and other sources (Brown,
    Kazmierski, Pasquarella et al., in review).

    Because representations are learned across many sensors and images,
    embedding representations effectively mitigate common issues such as
    clouds, scan lines, sensor artifacts, or missing data, providing seamless
    analysis-ready features that can be directly substituted for other Earth
    Observation image sources in classification, regression, and change
    detection analyses. While some large scale swath and data availability
    artifacts may be noticeable, these typically represent minor vector offsets
    and generally do not significantly affect downstream processing or results.
  |||,

  keywords: [
    'annual',
    'global',
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
  // TODO - b/415819758: Update when all years are available.
  extent: ee.extent_global('2021-01-01T00:00:00Z', null),

  summaries: {
    'gee:schema': [
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
        name: 'UTM_ZONE',
        description:
          'The UTM zone of the coordinate reference system used to produce ' +
          'the image.',
        type: ee_const.var_type.string,
      },
      {
        name: 'DATASET_VERSION',
        description: 'The dataset version.',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [10],
    'eo:bands': [
      {
        name: 'A00',
        description: 'The 0th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A01',
        description: 'The 1st axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A02',
        description: 'The 2nd axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A03',
        description: 'The 3rd axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A04',
        description: 'The 4th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A05',
        description: 'The 5th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A06',
        description: 'The 6th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A07',
        description: 'The 7th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A08',
        description: 'The 8th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A09',
        description: 'The 9th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A10',
        description: 'The 10th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A11',
        description: 'The 11th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A12',
        description: 'The 12th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A13',
        description: 'The 13th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A14',
        description: 'The 14th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A15',
        description: 'The 15th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A16',
        description: 'The 16th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A17',
        description: 'The 17th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A18',
        description: 'The 18th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A19',
        description: 'The 19th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A20',
        description: 'The 20th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A21',
        description: 'The 21st axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A22',
        description: 'The 22nd axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A23',
        description: 'The 23rd axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A24',
        description: 'The 24th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A25',
        description: 'The 25th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A26',
        description: 'The 26th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A27',
        description: 'The 27th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A28',
        description: 'The 28th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A29',
        description: 'The 29th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A30',
        description: 'The 30th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A31',
        description: 'The 31st axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A32',
        description: 'The 32nd axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A33',
        description: 'The 33rd axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A34',
        description: 'The 34th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A35',
        description: 'The 35th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A36',
        description: 'The 36th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A37',
        description: 'The 37th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A38',
        description: 'The 38th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A39',
        description: 'The 39th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A40',
        description: 'The 40th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A41',
        description: 'The 41st axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A42',
        description: 'The 42nd axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A43',
        description: 'The 43rd axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A44',
        description: 'The 44th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A45',
        description: 'The 45th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A46',
        description: 'The 46th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A47',
        description: 'The 47th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A48',
        description: 'The 48th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A49',
        description: 'The 49th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A50',
        description: 'The 50th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A51',
        description: 'The 51st axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A52',
        description: 'The 52nd axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A53',
        description: 'The 53rd axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A54',
        description: 'The 54th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A55',
        description: 'The 55th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A56',
        description: 'The 56th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A57',
        description: 'The 57th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A58',
        description: 'The 58th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A59',
        description: 'The 59th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A60',
        description: 'The 60th axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A61',
        description: 'The 61st axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A62',
        description: 'The 62nd axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
      {
        name: 'A63',
        description: 'The 63rd axis of the embedding vector.',
        'gee:units': units.dimensionless,
      },
    ],

    A00: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A01: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A02: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A03: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A04: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A05: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A06: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A07: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A08: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A09: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A10: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A11: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A12: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A13: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A14: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A15: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A16: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A17: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A18: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A19: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A20: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A21: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A22: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A23: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A24: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A25: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A26: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A27: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A28: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A29: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A30: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A31: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A32: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A33: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A34: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A35: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A36: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A37: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A38: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A39: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A40: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A41: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A42: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A43: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A44: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A45: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A46: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A47: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A48: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A49: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A50: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A51: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A52: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A53: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A54: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A55: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A56: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A57: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A58: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A59: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A60: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A61: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A62: { minimum: -1, maximum: 1, 'gee:estimated_range': false },
    A63: { minimum: -1, maximum: 1, 'gee:estimated_range': false },

    'gee:visualizations': [
      {
        display_name: 'Satellite Embedding V1 Annual - A03, A02, A04',
        lookat: { lon: -74, lat: 40.75, zoom: 10 },
        image_visualization: {
          band_vis: {
            min: [-0.25],
            max: [0.25],
            bands: ['A03', 'A02', 'A04'],
          },
        },
      },
    ],
  },
  // TODO - b/408074300: Add DOI
  // 'sci:doi': '10.1234/TODO_DOI_STRING',
  // TODO - b/408074300: Add citation
  // 'sci:citation': |||
  //   Brown, C.F., Kazmierski, M. R., Pasquarella, V. J. et. al. TITLE: 2025,
  //   The Title of the Publication, Journal, Volume, Number, pages.
  //   [doi:TODO_DOI_STRING](https://doi.org/TODO_DOI_STRING),
  // |||,

  'gee:terms_of_use': ee.gee_terms_of_use(license) + '\n\n' + |||
    This dataset is licensed under
    [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) and requires
    the following attribution text: "This dataset is produced by Google and
    Google DeepMind."
  |||,

  // The fields below generally don't need to be changed.

  'gee:type': ee_const.gee_type.image_collection,

  // Files should use this line as-is. There is a local license variable at
  // the top of the file that sets the SPDX license entry.
  license: license.id,

  // The standard links cover the basic locations of the dataset, catalog
  // entries, code examples, etc.
  links: ee.standardLinks(subdir, id),

  // Here are some of the other links that are sometimes needed. Add by
  // concatenating a Jsonnet array like this:
  //   links: ee.standardLinks(subdir, id) + [more links here],
  // Versions have:
  //   ee.link.latest(latest_id, latest_url),
  //   ee.link.predecessor(predecessor_id, predecessor_url),
  //   ee.link.successor(successor_id, successor_url),
  // For more link types, see earthengine.libsonnet

  // This refers to a STAC term 'collection', not to Earth Engine collections.
  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    // The EO extension is required for bands.
    ee_const.ext_eo,
    // For synthetic aperture radar (SAR)
    // ee_const.ext_sar,
    // TODO - b/408074300: Uncomment when we have a citation.
    // ee_const.ext_sci,
    // Include the version extension if the dataset uses any of:
    // - the deprecated fields
    // - the version fields
    // - successor link
    // - predecessor link
    // - latest link
    ee_const.ext_ver,
  ],
}
