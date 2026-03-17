local id = 'projects/edf-methanesat-ee/assets/mair/L3concentration';
local subdir = 'edf-methanesat-ee';
local version = '1.1.0';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local license = spdx.proprietary;
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'MethaneAIR L3 Concentration V' + version,
  version: version,
  description: |||
    This dataset provides geospatial data for the total column dry air mole
    fraction of methane in the atmosphere, "XCH4", as observed by the MethaneAIR
    imaging spectrometer. XCH4 is defined as the total column amount (number of
    molecules) of methane ("CH4") divided by the total amount of air (number of
    molecules, water vapor amount removed) along the line of sight from the
    airborne spectrometer to the earth's surface and back up to the sun.
    Additional data layers are provided for reference: observed albedo at 1622
    nm, surface pressure, and terrain height.

    The aircraft was flown at 11.5 - 13 km altitude (37,000 - 43,000 feet),
    acquiring 10 frames per second with a swath of 4.5 - 4.8 km with a 25 degree
    field of view and 896 pixels across track, giving a native pixel size at
    nadir of approximately 25m along track and 5 m across track. The
    spectroscopic data are aggregated by 5 across track, giving a mean pixel
    size of 25m x 25m. Concentrations (XCH4) are retrieved from these high
    resolution (0.1 nm sampling, 0.3nm resolution), spatially distributed
    spectra ([Chan Miller et al. (2024)](https://doi.org/10.5194/egusphere-2023-1962)),
    then gridded on a 0.0001 x 0.0001 degree grid (approximately 10m x 8m over
    the US). The precision of the gridded data is approximately 25 parts per
    billion (1s, about 1.3%), and a spatial correlation length (1/e) of about
    70m. There are some variations from flight-to-flight according to operating
    conditions, look angle and surface albedo.

    The flight pattern was typically a series of oval swaths in a Zamboni
    pattern to cover a region, typically about 70 km x 100 km, over a 2 - 3 hour
    interval. The data presented here are averaged where flight tracks overlap,
    typically at the edges of each swath and in the urns at the top and bottom
    of the Zamboni pattern.

    This dataset was generated using MethaneAIR measurements taken on flights
    between 09 July 2025 and 10 October 2025. MethaneAIR is managed by
    [MethaneSAT LLC](https://www.methanesat.org/), a wholly owned subsidiary of
    Environmental Defense Fund. Methane emission fluxes were produced using a
    geostatistical inverse modeling framework on each of these Zamboni swaths.

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
  summaries: {
    'gsd': [10.2],
    'eo:bands': [
      {
        name: 'XCH4',
        description: 'Retrieved column-averaged dry-air CH4 mole fraction.',
        'gee:units': units.ppb,
      },
      {
        name: 'albedo',
        description: 'Ratio of solar radiance at the ground to observed ' +
        'radiance at the sensor.',
      },
      {
        name: 'surface_pressure',
        description: 'Air pressure at the surface.',
        'gee:units': units.hectopascal,
      },
      {
        name: 'terrain_height',
        description: 'Elevation with respect to WGS84 reference ellipsoid.',
        'gee:units': units.kilometer,
      }
    ],
    XCH4: {minimum: 1894.00, maximum: 2114.65, 'gee:estimated_range': true},
    albedo: {minimum: 0, maximum: 1, 'gee:estimated_range': false},
    surface_pressure: {minimum: 725.95, maximum: 1011.33, 'gee:estimated_range': true},
    terrain_height: {minimum: 0.026, maximum: 2.915, 'gee:estimated_range': true},
    'gee:visualizations': [
      {
        display_name: 'Retrieved column-averaged dry-air CH4 mole fraction.',
        lookat: { lon: -102.9, lat: 32, zoom: 8 },
        image_visualization: {
          band_vis: {
            min: [1870],
            max: [2030],
            bands: ['XCH4'],
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
        description: 'Oil and Gas basin (e.g. Permian) or area of interest (e.g. New York City).',
        type: ee_const.var_type.string,
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
  'gee:status': 'beta',
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
