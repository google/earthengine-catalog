local id = 'projects/edf-methanesat-ee/assets/msat/L4area';
local subdir = 'edf-methanesat-ee';
local version = '1.0.0';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local versions = import 'versions.libsonnet';
local versions_table = import 'templates/msat_L4area_versions.libsonnet';
local version_config = versions(subdir, versions_table, id);
local version_internal = version_config.version;
local license = spdx.proprietary;
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'MethaneSAT L4 Area Sources V' + version,
  version: version_internal,
  description: |||
    This dataset provides the most recently processed data for methane emissions on an
    approximately 4 km x 4 km grid. These data include total methane emissions and their spatial
    distribution at high resolution to meet global methane mitigation goals.

    These methane emissions estimates were made using the Column Observations to Regional
    Emissions (CORE) algorithm. The primary input to CORE is methane concentration observations
    in the form of column-averaged dry-air mole fractions of methane (XCH4). An atmospheric
    transport model; the Stochastic Time-Inverted Lagrangian Transport (STILT) model;
    [Lin et al. (2003)](https://doi.org/10.1029/2002JD003161),
    [Fasoli et al. (2018)](https://doi.org/10.5194/gmd-11-2813-2018);
    driven by meteorological data from the National Centers for Environmental Prediction
    ([NCEP](https://www.weather.gov/ncep/)) Global Forecast System
    ([GFS](https://www.emc.ncep.noaa.gov/emc/pages/numerical_forecast_systems/gfs.php));
    links variations in observed
    XCH4 to potential upwind sources. Emissions and inflow across the upwind boundary are
    inferred with a Bayesian inverse model using Hamiltonian Monte Carlo (HMC) sampling
    implemented in the Stan probabilistic programming framework
    ([Carpenter et al., 2017](https://www.jstatsoft.org/article/view/v076i01)). The
    CORE algorithm will continue to be updated as the team improves the methodology. Any
    significant changes in methodology will be documented through updates to the MethaneSAT
    Level-4 Dispersed Emissions Product
    [Algorithm Theoretical Basis Document](https://zenodo.org/records/20030295) (ATBD).

    These observations made by MethaneSAT are broadly consistent with independent empirical
    data where available from other sources. Not all data products (L3 concentration, L4 area and
    L4 point) are available for all collection IDs. Individual heat maps can have spatial misallocations
    due to several factors, including wind field uncertainty, observational uncertainty and variable
    emission rates. Users are advised to interpret individual emission grids with caution. For more
    about definitions and limitations, see ourabout definitions and limitations, see our
    [technical explanation](https://www.methanesat.org/sites/default/files/2026-07/MethaneSAT%20Dispersed%20Area%20Emissions%20Definitions%20and%20Limitations.pdf).
    To learn more about MethaneSAT algorithm versions, see this [overview](https://www.methanesat.org/sites/default/files/2026-07/Overview%20of%20MethaneSAT%20Algorithm%20Versions.pdf).

    Contact the data provider for more information about the project at this link:
    [https://www.methanesat.org/contact/](https://www.methanesat.org/contact/).

    ---

    7/2/2025 Important Update:

    Note: The satellite lost contact with the ground in June of 2025:
    [MethaneSAT Loses Contact with Satellite | MethaneSAT](https://www.methanesat.org/project-updates/methanesat-loses-contact-satellite).
    Existing datasets will remain accessible on Google platforms and on our
    web portal for the foreseeable future. They have been reprocessed using greatly improved
    algorithms and released in August, 2026. The reprocessed data are superior in all respects
    compared to our interim releases earlier in 2026, and additional scenes have been added that
    were not available previously. These datasets should be used for future analysis in preference to
    previous releases, which are deprecated.

    To stay up to date with further updates, please sign up for our
    [newsletter](https://mailchi.mp/methanesat/methanesat-newsletter-sign-up). For additional
    information about the data products, algorithms, or calibration, view the publications on our
    [website](https://www.methanesat.org/scienceandresearch).
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
  // Setting an end date of 'null' because this value will change often as more
  // data is added to the dataset regularly. Earth Engine will compute our end
  // date for us instead.
  extent: ee.extent_global('2024-05-01T00:00:00Z', '2025-06-20T00:00:00Z'),
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
        name: 'target_mean_total_kg_hr',
        description: 'Total value of area emissions in the target for this ' +
        'collection in kg/hr. Missing values are indicated by -1.',
        type: ee_const.var_type.double,
      },
      {
        name: 'target_total_flux_lower_bound_kg_hr',
        description: 'Lower bound on the 95% confidence interval of the total ' +
        'value of area emissions in the target for this collection in kg/hr.',
        type: ee_const.var_type.double,
      },
      {
        name: 'target_total_flux_upper_bound_kg_hr',
        description: 'Upper bound on the 95% confidence interval of the total ' +
        'value of area emissions in the target for this collection in kg/hr.',
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
