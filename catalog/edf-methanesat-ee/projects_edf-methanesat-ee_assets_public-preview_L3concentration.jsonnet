local id = 'projects/edf-methanesat-ee/assets/public-preview/L3concentration';
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
  title: 'MethaneSAT L3 Concentration Public Preview V' + version,
  version: version,
  description: |||
    This early "Public Preview" dataset provides geospatial data for the
    column-averaged dry-air mole fraction of methane in the atmosphere, "XCH4",
    retrieved from measurements by the MethaneSAT imaging spectrometer. XCH4 is
    defined as the total column amount (number of molecules above a unit surface
    area) of methane ("CH4") divided by the total amount of air (number of molecules
    above a unit surface area, water vapor amount removed) along the line of sight
    from the satellite’s spectrometer to the Earth's surface and back up to the Sun.
    Additional data layers are provided for reference: observed albedo at 1622 nm,
    surface pressure, and terrain height.

    The spatial footprint of individual MethaneSAT soundings is 110 m x 400 m when
    viewing at nadir, with the long side in the satellite’s flight direction, and
    with the short side that can be stretched wider at higher viewing zenith angles
    (which is why some targets appear more rectangular than others). At nadir, the
    swath width is ~220 km. The data on these native soundings is Level 2 (L2) data.
    The precision of the L2 XCH4 is 22-35 ppb (corresponding to 0.7-0.2 surface albedo).
    L2 concentrations (XCH4) are retrieved from the measured high resolution (0.08 nm
    sampling, 0.24 nm resolution) spectra from the 1.6 micron band using the CO2-Proxy
    method ([Chan Miller et al. (2024)](https://doi.org/10.5194/amt-17-5429-2024)).
    The Level 3 (L3) dataset is created by regridding the L2 data from the native
    sounding locations to a regular 45 m x 45 m grid using the approach detailed in
    [Sun et al. (2018)](https://doi.org/10.5194/amt-11-6679-2018).

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
  ],
  providers: [
    ee.producer_provider('Environmental Defense Fund - MethaneSAT', 'https://methanesat.org'),
    // This is always the last entry.
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2024-05-22T00:00:00Z', null),
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
        name: 'collection_id',
        description: 'Satellite Observation ID.',
        type: ee_const.var_type.string,
      },
      {
        name: 'num_samples',
        description: |||
          The integral of the spatial pixel's super Gaussian function over the area of
          that grid cell. This was the value used in this processing run of this collection.
        |||,
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
