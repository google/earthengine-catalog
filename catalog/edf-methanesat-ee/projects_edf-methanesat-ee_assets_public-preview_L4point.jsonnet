local id = 'projects/edf-methanesat-ee/assets/public-preview/L4point';
local subdir = 'edf-methanesat-ee';
local version = '1.0.0';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local methane = importstr 'methane.md';
local publications = importstr 'publications.md';
local units = import 'units.libsonnet';
local license = spdx.proprietary;
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'MethaneSAT L4 Point Sources Public Preview V' + version,
  version: version,
  description: |||
    This early "Public Preview" dataset provides high precision data for methane emissions from
    discrete point sources. These methane emission fluxes were produced using a point source
    detection and emissions quantification framework specialized to exploit the high spatial
    resolution, wide spatial coverage, and high precision of MethaneSAT data (methodology is
    described in [Chulakdabba et al. (2023)](https://doi.org/10.5194/amt-16-5771-2023).)
    The point source quantification framework was extensively tested in blind controlled-release
    experiments as detailed in
    [Chulakdabba et al. (2023)](https://doi.org/10.5194/amt-16-5771-2023) and
    [Abbadi et al. (2024)](https://doi.org/10.1021/acs.est.4c02439). 

    Total emissions for a scene–from both dispersed area and point source emissions–may be
    obtained by summing the area emissions and point source emissions for a given collection ID
    (see L4 Area Sources Public Preview).

    Not all data products (L3 concentration, L4 area and L4 points) are available for all
    collection IDs. Contact the data provider for more information about the project at this link:
    [https://www.methanesat.org/contact/](https://www.methanesat.org/contact/).

    ---

    7/2/2025 Important Update: 

    As you may be aware, we recently lost contact with the satellite. After exploring all possible  
    recovery options, we have now confirmed that it is no longer functioning, due to an
    undetermined problem with the outer platform carrying our methane detector. While there is no
    question this is a setback, we are undeterred in our efforts to drive down methane pollution.
    Please see our official statement here:
    [MethaneSAT Loses Contact with Satellite | MethaneSAT](https://www.methanesat.org/project-updates/methanesat-loses-contact-satellite).

    What this means for the Public Preview data: The existing datasets will remain accessible on
    Google platforms and on our web portal for the foreseeable future. Additionally, over the next
    few months, we will release substantial new data collected by MethaneSAT prior to the loss of
    contact. This will include hundreds of scenes (of targets that are roughly 200kmx200km). We
    hope this will be useful for you. Should there be any changes to data availability, we will
    notify you well in advance.

    Looking ahead: While we don’t have all the answers yet, we plan to leverage our advanced Data
    Processing Platform (DPP) to quantify other streams of satellite and/or aerial data. We will
    also take the necessary time to evaluate the best next step in our efforts to enable methane
    reductions. To stay up to date with further updates, feel free to sign up for our
    [newsletter](https://mailchi.mp/methanesat/methanesat-newsletter-sign-up).
  ||| + publications,
  'gee:categories': ['atmosphere'],
  keywords: [
    'climate',
    'emissions',
    'ghg',
    'methane',
    'edf',
    'methanesat',
  ],
  providers: [
    ee.producer_provider('Environmental Defense Fund - MethaneSAT', 'https://methanesat.org'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2024-06-14T00:00:00Z', '2025-01-17T00:00:00Z'),
  // The dataset is not public, and a sample FV has been generated.
  'gee:skip_featureview_generation': true,
  summaries: {
    platform: ['MethaneSAT'],
    'gee:schema': [
      {
        name: 'collection_id',
        description: 'Satellite observation identifier.',
        type: ee_const.var_type.string,
      },
      {
        name: 'date',
        description: 'Data collection date ' +
        'format STRING (ISO 8601).',
        type: ee_const.var_type.string,
      },
      {
        name: 'flux',
        description: |||
          Methane flux quantification. Note: this may be null in the case that we're confident
          in the presence and location of the point but not its flux value.
        |||,
        units: units.kg_per_hour,
        type: ee_const.var_type.int,
      },
      {
        name: 'flux_sd',
        description: |||
          Standard deviation of methane flux quantification, in kg/h. Note: this may be null in
          the case that we're confident in the presence and location of the point but not its
          flux value.
        |||,
        units: units.kg_per_hour,
        type: ee_const.var_type.int,
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
      {
        name: 'plume_id',
        description: 'Plume id (unique across satellite observations).',
        type: ee_const.var_type.string,
      },
      {
        name: 'plume_id_in_scene',
        description: 'Plume id (unique per satellite observation).',
        type: ee_const.var_type.int,
      },
      {
        name: 'region',
        description: 'Region of scene.',
        type: ee_const.var_type.string,
      },
      {
        name: 'target_id',
        description: 'Satellite Target ID.',
        type: ee_const.var_type.int,
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
