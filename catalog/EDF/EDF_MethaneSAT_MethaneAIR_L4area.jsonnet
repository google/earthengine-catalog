local id = 'EDF/MethaneSAT/MethaneAIR/L4area';
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
  title: 'MethaneAIR L4 Area Sources ' + version,
  version: version,

  description: |||
    **The area emissions model is still in development and not representative of
    a final product.**

    This dataset provides spatially disaggregated methane emission fluxes
    (kg/hr) using measurements from MethaneAIR flights focused on oil and gas
    producing regions throughout the United States. Total emissions for the
    survey area are obtained by summing the pixel values.
  ||| + methane + methaneair_l4 + methaneair  + |||
    The methane emission fluxes were produced using a geostatistical inverse
    modeling framework specialized to exploit the high spatial resolution, wide
    spatial coverage, and high precision of MethaneAIR data. Not all data
    products are available for all flights.
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
  extent: ee.extent(-112.56, 27.8, -73.45, 43.14,
                    '2021-07-30T00:00:00Z', '2023-10-13T00:00:00Z'),

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
        name: 'flight_id',
        description: 'Research flight number.',
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
      {
        name: 'area_source_total_kg_hr',
        description: 'Total value of area emissions for this flight in ' +
        'kg/hr. Missing values are indicated by -1.',
        type: ee_const.var_type.int,
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

  'gee:type': ee_const.gee_type.image_collection,
  'gee:user_uploaded': true,

  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(
      'https://library.edf.org/AssetLink/3u27pb5103r1m825jykd7v0347t4m41y.pdf')
  ],

  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
