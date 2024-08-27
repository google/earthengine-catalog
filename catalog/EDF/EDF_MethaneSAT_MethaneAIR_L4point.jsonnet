local id = 'EDF/MethaneSAT/MethaneAIR/L4point';
local subdir = 'EDF';
local version = 'v1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local methane = importstr 'methane.md';
local methaneair = importstr 'methaneair.md';
local methaneair_l4 = importstr 'methaneair_l4.md';
local publications = importstr 'publications.md';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'MethaneAIR L4 Point Sources ' + version,
  version: version,

  description: |||
    This dataset provides data for high-emitting methane point source detections
    (kg/hr) over 13 oil and gas or coal extraction areas from Colorado, New
    Mexico, and Texas in the west to Pennsylvania, Ohio, and West Virginia in
    the east, plus three urban areas (New York City, Phoenix, and Salt Lake
    City).
  ||| + methane + methaneair_l4 + methaneair  + |||
    The methane emission fluxes were produced using a point source detection and
    emissions quantification framework specialized to exploit the high spatial
    resolution, wide spatial coverage, and high precision of MethaneAIR data
    (methodology is described in [Chulakdabba et al. (2023)](https://doi.org/10.5194/amt-16-5771-2023).)
    The point source quantification framework was extensively tested in blind
    controlled-release experiments as detailed in [Chulakdabba et al. (2023)](https://doi.org/10.5194/amt-16-5771-2023)
    and [Abbadi et al. (2024)](https://doi.org/10.1021/acs.est.4c02439). Not all
    data products are available for all flights.
  ||| + publications,
  keywords: [
    'climate',
    'emissions',
    'ghg',
    'methane',
    'edf',
    'methanesat',
    'methaneair'
  ],
  providers: [
    ee.producer_provider('Environmental Defense Fund - MethaneSAT', 'https://methanesat.org'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-112.5, 27.9, -74, 47.6,
                    '2021-07-30T00:00:00Z', '2023-10-13T00:00:00Z'),

  summaries: {
    platform: ['MethaneAIR'],
    'gee:schema': [
      {
        name: 'plume_id',
        description: 'Plume id (unique per flight).',
        type: ee_const.var_type.int,
      },
      {
        name: 'flux',
        description: 'Methane flux quantification.',
        units: units.kg_per_hour,
        type: ee_const.var_type.int,
      },
      {
        name: 'flux_hi',
        description: 'Higher estimate of methane flux quantification, in kg/h.',
        units: units.kg_per_hour,
        type: ee_const.var_type.int,
      },
      {
        name: 'flux_lo',
        description: 'Lower estimate of methane flux quantification, in kg/h.',
        units: units.kg_per_hour,
        type: ee_const.var_type.int,
      },
      {
        name: 'flux_sd',
        description: 'Standard deviation of methane flux quantification, in ' + 
        'kg/h.',
        units: units.kg_per_hour,
        type: ee_const.var_type.int,
      },
      {
        name: 'in_gim_bound',
        description: 'Whether the point source is within the footprint of ' + 
        'the L4 GIM area emissions product (0 if false, 1 if true).',
        type: ee_const.var_type.int,
      },
      {
        name: 'flight_id',
        description: 'Research flight identifier.',
        type: ee_const.var_type.string,
      },
      {
        name: 'basin',
        description: 'Oil and Gas basin (e.g. Permian) or area of interest ' +
        '(e.g. New York City).',
        type: ee_const.var_type.string,
      },
      {
        name: 'time_coverage_start',
        description: 'Data collection start time in YYYY-MM-DDThh:mm:ssZ ' +
        'format STRING (ISO 8601).',
        type: ee_const.var_type.string,
      },
      {
        name: 'time_coverage_end',
        description: 'Data collection end time in YYYY-MM-DDThh:mm:ssZ ' +
        'format STRING (ISO 8601).',
        type: ee_const.var_type.string,
      },
      {
        name: 'processing_id',
        description: |||
          (internal) Processing run identifier that represents the calculations
          that led to the features. It is not an attribute describing the
          flight, but the processing pipeline.
        |||,
        type: ee_const.var_type.string,
      },
    ],

    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 150,
      thinning_strategy: 'HIGHER_DENSITY',
    },

    'gee:visualizations': [
      {
        display_name: 'Methane point sources flux',
        lookat: { lon: -102.5, lat: 31.85, zoom: 8 },
        table_visualization: {
          color: 'red',
          point_size: 3,
        },
      },
      {
        display_name: 'FeatureView visualization of point flux sources',
        visualize_as: 'FeatureView',
        lookat: { lon: -102.5, lat: 31.85, zoom: 8 },
      },
    ],
  },

  'sci:citation': |||
    Chulakadabba, A., Sargent, M., Lauvaux, T., Benmergui, J. S., Franklin, J.
    E., Chan Miller, C., Wilzewski, J. S., Roche, S., Conway, E., Souri, A. H.,
    Sun, K., Luo, B., Hawthrone, J., Samra, J., Daube, B. C., Liu, X., Chance,
    K., Li, Y., Gautam, R., Omara, M., Rutherford, J. S., Sherwin, E. D.,
    Brandt, A., and Wofsy, S. C. 2023. Methane point source quantification using
    MethaneAIR: a new airborne imaging spectrometer, Atmos. Meas. Tech., 16,
    5771-5785.
    [doi:10.5194/amt-16-5771-2023](https://doi.org/10.5194/amt-16-5771-2023),
  |||,
  'gee:terms_of_use': |||
    Use of this data is subject to [MethaneSAT's Content License Terms of
    Use](https://library.edf.org/AssetLink/3u27pb5103r1m825jykd7v0347t4m41y.pdf).
  |||,
  'gee:unusual_terms_of_use': true,

  'gee:type': ee_const.gee_type.table,
  'gee:user_uploaded': true,

  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
    ee.link.license(
      'https://library.edf.org/AssetLink/3u27pb5103r1m825jykd7v0347t4m41y.pdf')
  ],


  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
