// This is a generic template for an Earth Engine ee.ImageCollection dataset
// STAC Collection entry. After replacing all the values, remove the
// explanatory comments, but keep the "TODO" comment.
//
// This template covers the basic case with just one Jsonnet file defining
// the dataset. For more complex examples with templating, look for directories
// with `.libsonnet` files.
//
// See https://jsonnet.org/ for more documentation on the Jsonnet language used
// here to create STAC JSON.
//
// Coding style:
// - Indenting should be two spaces.
// - Do not use tabs.
// - Limit line length to around 80 characters unless it breaks URL strings.
// - Use only ASCII characters. \n and 32..176 decimal range.
// - Use American English.
//
// STAC Specifications:
//   - Overall: https://github.com/radiantearth/stac-spec
//   - Extensions: https://github.com/stac-extensions/stac-extensions.github.io
//     - Electro-Optical: https://github.com/stac-extensions/eo
//     - Synthetic Aperture Radar: https://github.com/stac-extensions/sar
//     - Scientific: https://github.com/stac-extensions/scientific
//     - Version: https://github.com/stac-extensions/version

// This jsonnet file has to be named using the following convention:
//   <subdir>/<id_with_slashes_replaced_with_underbars>.jsonnet.

// The asset id as used in Earth Engine:
//   ee.ImageCollection('TEMPLATE/IMAGE_COLLECTION_V2_3');
local id = 'EDF/MethaneSAT/COP29';

// The directory under 'catalog' that contains the dataset.
// For datasets under 'projects', leave off the 'projects' component.
//   E.g., the 'projects/planet-nicfi/assets/basemaps/africa' asset is in the
//   'planet-nicfi' subdirectory.
local subdir = 'EDF';

// The version field can be any string. However, it is best to use
// the exact string that the data provider uses.
// Do not include a leading `V` in the version string.
// Prefer Semantic Versioning: https://semver.org/, which uses
// one to three numeric fields separated by decimal points.
// The version string might be different than the version portion of the `id`
// field, as the `id` field cannot have `.` characters.
local version = '1.0.0';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

// Change this to one of the licenses in:
// https://github.com/google/earthengine-catalog/blob/main/catalog/spdx.libsonnet
//
// - Least restrictive licenses (public domain or atribution-only licenses like
//   CC-BY-4) are preferred.
// - If the license is not in spdx.libsonnet, but is available in SPDX, you
//   can add it to spdx.libsonnet. See: https://spdx.org/licenses/
// - All other licenses should use spdx.proprietary. Here "proprietary" just
//   means that the license is not in SPDX.
// - If multiple licenses apply at the same time, use 'spdx.various'.
// - If there is a choice of more than one license, pick the most permissive
//   license.
// - Non-commercial and share-alike licenses are strongly discouraged, but if
//   they have to be used, add the dataset to
//   https://github.com/google/earthengine-catalog/blob/main/non_commercial_datasets.jsonnet
local license = spdx.proprietary;

// These are helper variables used below. Most files will just leave them as-is.
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  // Do not end the title with punctuation. Include version if it is known.
  title: 'MethaneSAT L3 Concentration released at COP29 V' + version,
  version: version,

  description: |||
    This early “Public Preview” dataset provides geospatial data for the 
    column-averaged dry-air mole fraction of methane in the atmosphere, "XCH₄", 
    retrieved from measurements by the MethaneSAT imaging spectrometer. XCH₄ is 
    defined as the total column amount (number of molecules above a unit surface 
    area) of methane ("CH₄") divided by the total amount of air (number of molecules 
    above a unit surface area, water vapor amount removed) along the line of sight 
    from the satellite’s spectrometer to the Earth's surface and back up to the Sun. 
    Additional data layers are provided for reference: observed albedo at 1622 nm, 
    surface pressure, and terrain height.
    The spatial footprint of individual MethaneSAT soundings is 110m x 400m when 
    viewing at nadir, with the long side in the satellite’s flight direction, and 
    with the short side that can be stretched wider at higher viewing zenith angles 
    (which is why some targets appear more rectangular than others). At nadir, the 
    swath width is ~220 km. The data on these native soundings is Level 2 (L2) data. 
    The precision of the L2 XCH₄ is 22-35 ppb (corresponding to 0.7-0.2 surface albedo).
    L2 concentrations (XCH₄) are retrieved from the measured high resolution (0.08 nm 
    sampling, 0.24 nm resolution) spectra from the 1.6 micron band using the CO2-Proxy 
    method ([Chan Miller et al. (2024)](https://doi.org/10.5194/amt-17-5429-2024)). 
    The Level 3 (L3) dataset is created by regridding the L2 data from the native 
    sounding locations to a regular 45m x 45m grid using the approach detailed in 
    [Sun et al. (2018)](https://doi.org/10.5194/amt-11-6679-2018). 
    
    Contact the data provider for more information about the project at this link: 
    [https://www.methanesat.org/contact/](https://www.methanesat.org/contact/).
  |||,

  // Please look through the list of existing keywords and pick two or more
  // that match the dataset.
  // https://developers.google.com/earth-engine/datasets/tags
  //
  // Please avoid creating new keywords. If you feel you need to add a new one,
  // add it but comment it out.
  keywords: [
    'climate',
    'emissions',
    'ghg',
    'methane',
    'edf',
    'methanesat',
  ],

  // Who created the data.
  // Prefer https rather than http links.
  providers: [
    // There can be multiple entries of ee.producer_provider and/or
    // ee.processor_provider.
    ee.producer_provider('Environmental Defense Fund - MethaneSAT', 'https://methanesat.org'),
    // This is always the last entry.
    ee.host_provider(self_ee_catalog_url),
  ],

  // Spatial and temporal extent.
  // What area and what time interval does the dataset cover?
  // Date/times must be in UTC, using the form 'YYYY-MM-DDTHH:MM:SSZ'.
  // End time may be `null` for ongoing datasets that are updated regularly.
  // End date is exclusive. For example, if the dataset covers the whole of
  // year 2021, the end date should be "2022-01-01T00:00:00Z"
  // Global spatial extents should use ee.extent_global.
  extent: ee.extent_global('2006-01-24T00:00:00Z', '2011-05-13T00:00:00Z'),
  // Alternatively, non-global extents use min_x, min_y, max_x, max_y:
  // extent: ee.extent(-171.0, -15.0, 164.0, 70.0,
  //                   '2006-01-24T00:00:00Z', null),

  // Summaries contain additional information specific to the dataset type.
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
  },

  // Observation repeat interval. For detail, see
  // https://github.com/google/earthengine-catalog/blob/main/checker/node/interval.py
  'gee:interval': {
    // One of:
    // - cadence: for daily, yearly, and other periodic collections.
    // - revisit_interval: for Landsat/Sentinel-style collections.
    // - climatological_interval: for climatological averages.
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
  'gee:terms_of_use': |||
    Use of this data is subject to [MethaneSAT's Content License Terms of
    Use](https://www.methanesat.org/sites/default/files/2024-10/MethaneSATGEE%20Terms%20of%20Use%20October%202024.pdf).
  |||,
  'gee:unusual_terms_of_use': true,

  // The fields below generally don't need to be changed.

  // TODO(google): Remove gee:status when the dataset is ready.
  'gee:status': 'incomplete',

  // This says that the dataset is an ee.ImageCollection.
  //   https://developers.google.com/earth-engine/apidocs/ee-image-collection
  'gee:type': ee_const.gee_type.image_collection,
  'gee:user_uploaded': true,

  // Files should use this line as-is. There is a local license variable at
  // the top of the file that sets the SPDX license entry.
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(
      'https://www.methanesat.org/sites/default/files/2024-10/MethaneSATGEE%20Terms%20of%20Use%20October%202024.pdf')
  ],  

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
    ee_const.ext_sci,
    // Include the version extension if the dataset uses any of:
    // - the deprecated fields
    // - the version fields
    // - successor link
    // - predecessor link
    // - latest link
    ee_const.ext_ver,
  ],
}
