local id = 'projects/edf-methanesat-ee/assets/mair/L4point';
local subdir = 'edf-methanesat-ee';
local version = '1.0.0';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local methane = importstr 'methane.md';
local units = import 'units.libsonnet';
local license = spdx.proprietary;
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'MethaneAIR L4 Point Sources V' + version,
  version: version,
  description: |||
    This dataset provides data for high-emitting methane point source detections
    (kg/hr) over 13 oil and gas or coal extraction areas from Colorado, New
    Mexico, and Texas in the west to Pennsylvania, Ohio, and West Virginia in
    the east, plus three urban areas (New York City, Phoenix, and Salt Lake
    City).

    This dataset was generated using MethaneAIR measurements taken on flights
    between 09 July 2025 and 10 October 2025. MethaneAIR is managed by
    [MethaneSAT LLC](https://www.methanesat.org/), a wholly owned subsidiary of
    Environmental Defense Fund. The methane emission fluxes were produced using a
    point source detection and emissions quantification framework specialized to exploit the high spatial
    resolution, wide spatial coverage, and high precision of MethaneAIR data
    (methodology is described in [Chulakdabba et al. (2023)](https://doi.org/10.5194/amt-16-5771-2023).)
    The point source quantification framework was extensively tested in blind
    controlled-release experiments as detailed in [Chulakdabba et al. (2023)](https://doi.org/10.5194/amt-16-5771-2023)
    and [Abbadi et al. (2024)](https://doi.org/10.1021/acs.est.4c02439). Not all
    data products are available for all flights.

    For additional information about the MethaneAIR instrument, instrument
    calibration and emission detections, please refer to recent publications by
    [Loughner et al. (2021)](https://doi.org/10.1175/JAMC-D-20-0158.1),
    [Staebell et al. (2021)](https://doi.org/10.5194/amt-14-3737-2021),
    [Conway et al. (2023)](https://doi.org/10.5194/amt-2023-111),
    [Chulakadabba et al. (2023)](https://doi.org/10.5194/egusphere-2023-822),
    [Abbadi et al. (2023)](https://doi.org/10.31223/X51D4C),
    [Omara et al. (2023)](https://doi.org/10.5194/essd-15-3761-2023),
    and [Miller et al. (2023)](https://doi.org/10.5194/egusphere-2023-1962).

    Contact the data provider for more information about the project at this link:
    [https://www.methanesat.org/contact/](https://www.methanesat.org/contact/).

  |||,
  'gee:categories': ['atmosphere'],
  keywords: [
    'climate',
    'emissions',
    'ghg',
    'methane',
    'edf',
    'methanesat',
    'methaneair',
  ],
  providers: [
    ee.producer_provider('Environmental Defense Fund - MethaneSAT', 'https://methanesat.org'),
    // This is always the last entry.
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2025-07-09T00:00:00Z', '2025-10-10T00:00:00Z'),
  // The dataset is not public, and a sample FV has been generated.
  'gee:skip_featureview_generation': true,
  summaries: {
    platform: ['MethaneSAT'],
    'gee:schema': [
      {
        name: 'plume_id',
        description: 'Plume id (unique per flight).',
        type: ee_const.var_type.string,
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
        description: 'Standard deviation of methane flux quantification, in kg/h.',
        units: units.kg_per_hour,
        type: ee_const.var_type.int,
      },
      {
        name: 'in_gim_bound',
        description: |||
          Whether the point source is within the footprint of the L4 GIM area
          emissions product (0 if false, 1 if true).
        |||,
        units: units.kg_per_hour,
        type: ee_const.var_type.int,
      },
      {
        name: 'flight_id',
        description: 'Research flight identifier.',
        type: ee_const.var_type.string,
      },
      {
        name: 'basin',
        description: |||
          Oil and Gas basin (e.g. Permian) or area of interest (e.g. New York City).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'time_coverage_start',
        description: 'Data collection end time in YYYY-MM-DDThh:mm:ssZ ' +
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
  'gee:status': 'beta',
  'gee:terms_of_use': importstr 'terms_of_use.md',
  'gee:unusual_terms_of_use': true,
  'gee:type': ee_const.gee_type.table,
  'gee:user_uploaded': true,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
    ee.link.license(
      'https://www.methanesat.org/sites/default/files/2024-10/MethaneSATGEE%20Terms%20of%20Use%20October%202024.pdf')
  ],
  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
