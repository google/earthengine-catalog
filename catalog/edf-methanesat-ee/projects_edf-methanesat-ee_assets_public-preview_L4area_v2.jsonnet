local id = 'projects/edf-methanesat-ee/assets/public-preview/L4area_v2';
local subdir = 'edf-methanesat-ee';
local version = '2.0.0';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local license = spdx.proprietary;
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'MethaneSAT L4 Area Sources Public Preview V' + version,
  version: version,
  description: |||
    *The dispersed area emissions model is still in development and not
    representative of a final product.*

    This early "Public Preview" dataset provides high precision data for methane
    emissions from dispersed area sources. These emissions data come from the
    Appalachian, Permian, and Uinta basins in the United States; the Amu Darya and
    South Caspian basins in Turkmenistan; and the Maturin basin in Venezuela. These
    novel measurements demonstrate the importance of quantifying total methane emissions
    with high resolution to meet global methane mitigation goals.

    Total emissions for a scene–from both dispersed area and point source emissions–may
    be obtained by summing the area emissions and point source emissions for a given
    collection ID (see L4 Point Sources Public Preview).

    Dispersed area emissions are estimated from methane concentration observations
    in the form of column-averaged dry-air mole fractions of methane (XCH4) using
    an inverse model. An atmospheric transport model - the Stochastic Time-Inverted
    Lagrangian Transport (STILT) model; [Lin et al. (2003)](https://doi.org/10.1029/2002JD003161),
    [Fasoli et al. (2018)](https://doi.org/10.5194/gmd-11-2813-2018); driven
    by meteorological data from the National Centers for Environmental
    Prediction ([NCEP](https://www.weather.gov/ncep/)) Global Forecast System
    ([GFS](https://www.emc.ncep.noaa.gov/emc/pages/numerical_forecast_systems/gfs.php))
    - is used to link variations in observed XCH4 to potential upwind sources.

    These predictive linkages are used to invert an estimated set of emissions from the
    observations of MethaneSAT using a novel Markov Chain Monte Carlo technique nicknamed CORE
    (Conserved and Optimized Retrieval of Emissions). Inflow across the domain boundary and
    pre-existing background concentrations are estimated, but not reported. 

    This set of initial observations made by MethaneSAT are consistent with
    independent empirical data where available from other sources. Not all data products
    (L3 concentration, L4 area and L4 points) are available for all collection IDs.
    Contact the data provider for more information about the project at this
    link: [https://www.methanesat.org/contact/](https://www.methanesat.org/contact/).

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
  |||,
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
    // This is always the last entry.
    ee.host_provider(self_ee_catalog_url),
  ],
  // Setting an end date of 'null' because this value will change often as more data is added
  // to the dataset regularly. Earth Engine will compute our end date for us instead.
  extent: ee.extent_global('2024-05-01T00:00:00Z', null),
  summaries: {
    // Values that are true for all bands.
    // gsd: pixel size (ground sample distance), in meters.
    gsd: [4000],
    'eo:bands': [
      {
        name: 'mean_flux',
        description: 'Methane emissions traceable to a 4km^2 area.',
        'gee:units': units.kg_per_hour,
      },
      {
        name: 'lower_bound_flux',
        description: 'Lower bound on the 95% confidence interval of flux.',
        'gee:units': units.kg_per_hour,
      },
      {
        name: 'upper_bound_flux',
        description: 'Upper bound on the 95% confidence interval of flux.',
        'gee:units': units.kg_per_hour,
      },
    ],
    mean_flux: {minimum: 0, maximum: 15000, 'gee:estimated_range': true},
    lower_bound_flux: {minimum: 0, maximum: 15000, 'gee:estimated_range': true},
    upper_bound_flux: {minimum: 0, maximum: 15000, 'gee:estimated_range': true},
    'gee:visualizations': [
      {
        display_name: 'Methane area sources flux in kg/hr',
        lookat: { lon: -99.82, lat: 28.12, zoom: 9 },
        image_visualization: {
          band_vis: {
            min: [0],
            max: [625],
            bands: ['mean_flux'],
            palette: ['navy', 'magenta', 'orange', 'yellow'],
          }
        },
      },
    ],
    'gee:schema': [
      {
        name: 'mean_total_kg_hr',
        description: 'Total value of area emissions for this collection in ' +
        'kg/hr. Missing values are indicated by -1.',
        type: ee_const.var_type.double,
      },
      {
        name: 'total_flux_lower_bound_kg_hr',
        description: 'Lower bound on the 95% confidence interval of the total ' +
        'value of area emissions for this collection in kg/hr.',
        type: ee_const.var_type.double,
      },
      {
        name: 'total_flux_upper_bound_kg_hr',
        description: 'Upper bound on the 95% confidence interval of the total ' +
        'value of area emissions for this collection in kg/hr.',
        type: ee_const.var_type.double,
      },
      {
        name: 'flux_noise_floor_kg_hr',
        description: 'Below this value, we believe fluxes are indistinguishable from 0.',
        type: ee_const.var_type.double,
      },
      {
        name: 'collection_id',
        description: 'satellite observation number.',
        type: ee_const.var_type.string,
      },
      {
        name: 'ovr_resampling',
        description: 'Resampling method used.',
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
      {
        name: 'target_id',
        description: 'Satellite Target ID.',
        type: ee_const.var_type.int,
      },
      {
        name: 'time_coverage_end',
        description: 'Data collection end time in YYYY-MM-DDThh:mm:ssZ ' +
        'format STRING (ISO 8601).',
        type: ee_const.var_type.string,
      },
      {
        name: 'time_coverage_start',
        description: 'Data collection start time in YYYY-MM-DDThh:mm:ssZ ' +
        'format STRING (ISO 8601).',
        type: ee_const.var_type.string,
      },
    ],
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    // How long the interval is (expressed in units above).
    interval: 14,
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
  'gee:unusual_terms_of_use': true,
  'gee:type': ee_const.gee_type.image_collection,
  'gee:user_uploaded': true,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(
      'https://www.methanesat.org/sites/default/files/2025-02/MethaneSAT%20-%20Content%20License%20Terms%20of%20Use%20%28Revised%202-12-2025%29%5B25%5D.pdf')
  ],
  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
}
