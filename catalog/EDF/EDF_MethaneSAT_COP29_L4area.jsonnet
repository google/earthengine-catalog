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
  title: 'MethaneSAT L4 Area Sources released at COP29' + version,
  version: version,

  description: |||
    *The dispersed area emissions model is still in development and not 
    representative of a final product.*

    This early “Public Preview” dataset provides high precision data for methane 
    emissions over wide areas from the oil and gas sector. This includes total 
    emissions that come from discrete point sources and dispersed area sources. 
    These emissions data come from the Appalachian, Permian, and Uinta basins 
    in the United States; the Amu Darya and South Caspian basins in Turkmenistan; 
    and the Maturin basin in Venezuela. These novel measurements demonstrate the 
    importance of quantifying total methane emissions with high resolution to 
    meet global methane mitigation goals.

    Dispersed area emissions are estimated from methane concentration observations 
    in the form of column-averaged dry-air mole fractions of methane (XCH₄) using 
    an inverse model. An atmospheric transport model - the Stochastic Time-Inverted 
    Lagrangian Transport (STILT) model; [Lin et al. (2003)](https://doi.org/10.1029/2002JD003161), 
    [Fasoli et al. (2018)](https://doi.org/10.5194/gmd-11-2813-2018); driven 
    by meteorological data from the National Centers for Environmental 
    Prediction ([NCEP](https://www.weather.gov/ncep/)) Global Forecast System 
    ([GFS](https://www.emc.ncep.noaa.gov/emc/pages/numerical_forecast_systems/gfs.php)) 
    - is used to link variations in observed XCH₄ to potential upwind sources. 
    The sources of variation in observed XCH₄ include 1) dispersed area emissions, 
    2) discrete point sources, 3) inflow across the domain boundary, and 
    4) the background concentration. Discrete point source emissions are 
    determined individually using a divergence integral approach described by 
    [Chulakadaba et al. (2023)](https://egusphere.copernicus.org/preprints/2023/egusphere-2023-822/) 
    and prescribed to the inverse model. XCH₄ inflow across the domain boundary 
    and dispersed area emissions are then estimated simultaneously using an 
    inverse model with an enforced non-negative solution. Total emissions are 
    the sum of dispersed area and point source emissions.
    
    This set of initial observations made by MethaneSAT are consistent with 
    independent empirical data where available from other sources.
    Contact the data provider for more information about the project at this 
    link: [https://www.methanesat.org/contact/](https://www.methanesat.org/contact/).

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
    // Platform and instrument fields are optional and can be left out,
    // but are recommended.
    // https://github.com/radiantearth/stac-spec/blob/master/item-spec/common-metadata.md#instrument
    // Name of the ship, aircraft, spacecraft, or other collecting device.
    platform: ['MethaneSAT'],
    // Name of instrument or sensor used (e.g., MODIS, ASTER, OLI, Canon F-1).
    instruments: ['MethaneSAT'],

    // Describe all of the bands in the order they appear in an ee.Image.
    // For each band, only `name` and `description` are required.
    // If the pixel size is the same for all bands, set it here.
    // (In STAC, pixel size is called "gsd", or "ground sample distance".)
    // https://en.wikipedia.org/wiki/Ground_sample_distance
    // Value is in meters. If the pixel size is in degrees, multiply by 111,195.
    // gsd: [15],
    'eo:bands': [
      {
        name: 'band_name_1',
        description: 'Describe the band',
        gsd: 15,  // Pixel size (ground sample distance). Value is in meters.
                  // If the pixel size is in degrees, multiply by 111,195.
        center_wavelength: 0.56,  // in nm
        // Note that gee:wavelength is more expressive than 'center_wavelength',
        // as it allows value ranges and units.
        'gee:wavelength': '0.520-0.600 &mu;m',
        // See here for predefined units and prefer those over using a custom
        // units string.
        // https://github.com/google/earthengine-catalog/blob/main/catalog/units.libsonnet
        'gee:units': units.dn,
      },
      {
        name: 'band_name_2',
        description: 'Describe the band',
        gsd: 20,
        // For units without dimensions.
        'gee:units': units.dimensionless,
      },
      {
        name: 'band_name_3',
        description: 'Describe the band',
        gsd: 41,
        'gee:units': units.percent,
      },
      {
        name: 'band_name_4',
        description: 'Example of gee:classes',
        gsd: 1.2,
        // Only for bands with enumerated values.
        'gee:classes': [
          {value: 10, color: 'ff0000', description: 'Red thing'},
          {value: 11, color: '00ff00', description: 'Green thing'},
          {value: 20, color: '0000ff', description: 'Blue thing'},
          {value: 99, color: 'ffffff', description: 'White thing'},
        ],
      },
    ],

    // Optional band statistics - one entry per band.
    // If the exact statistics are known, then set gee:estimated_range to true.
    band_name_1: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    band_name_2: {minimum: 0, maximum: 1e8, 'gee:estimated_range': false},
    band_name_3: {minimum: 0, maximum: 100, 'gee:estimated_range': false},
    band_name_4: {minimum: 0, maximum: 100, 'gee:estimated_range': false},

    // One or more band visualizations.
    'gee:visualizations': [
      // Example with three bands, but only one value for min and max.
      {
        // Give units when possible.
        display_name: 'Describe what is shown 1',
        // Do not use too many significant digits.
        lookat: {lon: -122.03, lat: 39.67, zoom: 11},
        // See for details:
        // https://developers.google.com/earth-engine/guides/image_visualization
        image_visualization: {
          band_vis: {
            min: [0],
            max: [255],
            // Which bands to map to red, green, and blue rgb channels.
            bands: ['band_name_1', 'band_name_2', 'band_name_3'],
          }
        },
      },
      // Example with one band.
      {
        display_name: 'Describe what is shown 2',
        lookat: {lon: -122, lat: 39, zoom: 4},
        image_visualization: {band_vis: {bands: ['band_name_4']}},
      },
      // Example with one band and a palette for the colors.
      {
        display_name: 'Describe what is shown 3',
        lookat: {lon: -122, lat: 39, zoom: 14},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [100],
            // Use W3C color names or 6-character hex (e.g., green is 00ff00).
            // https://www.w3.org/wiki/CSS/Properties/color/keywords
            palette: ['blue', 'red'],
            bands: ['band_name_3'],
          },
        },
      },
    ],

    // Describes values set on each image.
    'gee:schema': [
      {
        name: 'Property_name',
        description: 'Describe the property',
        // Possible type values: int, double, string
        type: ee_const.var_type.double,
        'units': units.dimensionless,
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
    unit: 'week',
    // How long the interval is (expressed in units above).
    interval: 1,
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
