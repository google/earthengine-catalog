local id = 'projects/edf-methanesat-ee/assets/public-preview/L4area';
local subdir = 'edf-methanesat-ee';
local version = '1.0.0';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local license = spdx.proprietary;
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'MethaneSAT L4 Area Sources Public Preview' + version,
  version: version,
  description: |||
    *The dispersed area emissions model is still in development and not 
    representative of a final product.*

    This early "Public Preview" dataset provides high precision data for methane 
    emissions over wide areas from the oil and gas sector. This includes total 
    emissions that come from discrete point sources and dispersed area sources. 
    These emissions data come from the Appalachian, Permian, and Uinta basins 
    in the United States; the Amu Darya and South Caspian basins in Turkmenistan; 
    and the Maturin basin in Venezuela. These novel measurements demonstrate the 
    importance of quantifying total methane emissions with high resolution to 
    meet global methane mitigation goals.

    Dispersed area emissions are estimated from methane concentration observations 
    in the form of column-averaged dry-air mole fractions of methane (XCH4) using 
    an inverse model. An atmospheric transport model - the Stochastic Time-Inverted 
    Lagrangian Transport (STILT) model; [Lin et al. (2003)](https://doi.org/10.1029/2002JD003161), 
    [Fasoli et al. (2018)](https://doi.org/10.5194/gmd-11-2813-2018); driven 
    by meteorological data from the National Centers for Environmental 
    Prediction ([NCEP](https://www.weather.gov/ncep/)) Global Forecast System 
    ([GFS](https://www.emc.ncep.noaa.gov/emc/pages/numerical_forecast_systems/gfs.php)) 
    - is used to link variations in observed XCH4 to potential upwind sources. 

    The sources of variation in observed XCH4 include 1) dispersed area emissions, 
    2) discrete point sources, 3) inflow across the domain boundary, and 
    4) the background concentration. Discrete point source emissions are 
    determined individually using a divergence integral approach described by 
    [Chulakadaba et al. (2023)](https://egusphere.copernicus.org/preprints/2023/egusphere-2023-822/) 
    and prescribed to the inverse model. XCH4 inflow across the domain boundary 
    and dispersed area emissions are then estimated simultaneously using an 
    inverse model with an enforced non-negative solution. Total emissions are 
    the sum of dispersed area and point source emissions.
    
    This set of initial observations made by MethaneSAT are consistent with 
    independent empirical data where available from other sources.
    Contact the data provider for more information about the project at this 
    link: [https://www.methanesat.org/contact/](https://www.methanesat.org/contact/).
  |||,
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
  extent: ee.extent_global('2006-01-24T00:00:00Z', '2025-01-17T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'flux',
        description: 'Methane emissions traceable to a 1km^2 area.',
        gsd: 1000,
        'gee:units': units.kg_per_hour_per_square_km,
      }
    ],
    flux: {minimum: 0, maximum: 28.3, 'gee:estimated_range': true},
    'gee:visualizations': [
      {
        display_name: 'Methane area sources flux in kg/h/km^2',
        lookat: { lon: -102.5, lat: 31.85, zoom: 8 },
        image_visualization: {
          band_vis: {
            min: [0],
            max: [18],
            bands: ['flux'],
            palette: ['navy', 'magenta', 'orange', 'yellow'],
          }
        },
      },
    ],
    'gee:schema': [
      {
        name: 'area_source_total_kg_hr',
        description: 'Total value of area emissions for this collection in ' +
        'kg/hr. Missing values are indicated by -1.',
        type: ee_const.var_type.int,
      },
      {
        name: 'collection_id',
        description: 'satellite observation number.',
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
    // One of: second, minute, hour, day, week, month, year, custom_time_unit.
    unit: 'day',
    // How long the interval is (expressed in units above).
    interval: 7,
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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
