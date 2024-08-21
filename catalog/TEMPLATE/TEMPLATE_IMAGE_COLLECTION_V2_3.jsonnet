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
local id = 'TEMPLATE/IMAGE_COLLECTION_V2_3';

// The directory under 'catalog' that contains the dataset.
// For datasets under 'projects', leave off the 'projects' component.
//   E.g., the 'projects/planet-nicfi/assets/basemaps/africa' asset is in the
//   'planet-nicfi' subdirectory.
local subdir = 'TEMPLATE';

// The version field can be any string. However, it is best to use
// the exact string that the data provider uses.
// Do not include a leading `V` in the version string.
// Prefer Semantic Versioning: https://semver.org/, which uses
// one to three numeric fields separated by decimal points.
// The version string might be different than the version portion of the `id`
// field, as the `id` field cannot have `.` characters.
local version = '2.3';

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
  title: 'A short title for the dataset goes here V' + version,
  version: version,

  description: |||
    Write enough here for most people to understand:
    - what the dataset is for
    - what the dataset limitations are
    - how it was created
    - and anything else essential to know when working with the data.

    Things to consider when writing:
    - The first paragraph should be a concise description of the dataset and
      not a general introduction.
    - Write in the third person.
    - The text will be processed as CommonMark (a.k.a. Markdown) with multiple
      different processors. Note that Google's Markdown can handle tables, but
      STAC Browser does not support tables.
    - Define all acronyms, e.g. evapotranspiration (ET).
    - Make links to additional resources or manuals when appropriate.
    - Bare links must be put in Markdown links, e.g.
        - https://earthengine.google.com/ is just text
        - [https://earthengine.google.com/](https://earthengine.google.com/)
          is actually a link.
    - The triple pipe operator (`|||`) allows for writing multiline strings.
    - Indent 2 spaces under the |||.
  |||,

  // Please look through the list of existing keywords and pick two or more
  // that match the dataset.
  // https://developers.google.com/earth-engine/datasets/tags
  //
  // Please avoid creating new keywords. If you feel you need to add a new one,
  // add it but comment it out.
  keywords: [
    'elevation',
    'lidar',
  ],

  // Who created the data.
  // Prefer https rather than http links.
  providers: [
    // There can be multiple entries of ee.producer_provider and/or
    // ee.processor_provider.
    ee.producer_provider('Example Organization', 'https://example.com'),
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
    platform: ['My_Satellite'],
    // Name of instrument or sensor used (e.g., MODIS, ASTER, OLI, Canon F-1).
    instruments: ['My_Instrument'],

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
    unit: 'year',
    // How long the interval is (expressed in units above).
    interval: 1,
  },

  // The scientific extension.
  // The best DOI that describes the *data*.
  // Only use a research paper DOI if there is no dataset or data paper DOI.
  'sci:doi': '10.1234/TODO_DOI_STRING',
  // Use APA style for citations and publications. https://apastyle.apa.org/
  'sci:citation': |||
    AuthorLast, A. B., C. D., Author2Last and E. F. Author3Last: YEAR,
    The Title of the Publication, Journal, Volume, Number, pages.
    [doi:TODO_DOI_STRING](https://doi.org/TODO_DOI_STRING),
  |||,
  // Additional citations go here.
  'sci:publications': [
    {
      citation: |||
        AuthorLast, A. B., C. D., Author2Last and E. F. Author3Last: YEAR,
        The Title of the Publication, Journal, Volume, Number, pages.
        [doi:TODO_DOI_STRING](https://doi.org/TODO_DOI_STRING),
      |||,
      doi: '10.1234/TODO_DOI_STRING',
    },
  ],

  // For standard SPDX licenses, use:
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  // If there is a custom license (the license is set to spdx.proprietary, set
  // gee:terms_of_use to enough text that a reader has a sense of what they are
  // getting into. Be sure to add a link to the license in this Markdown text
  // and add the link to the license section with ee.link.license(url).
  // 'gee:terms_of_use': |||
  //   Put the custom license here.
  // |||,

  // The fields below generally don't need to be changed.

  // TODO(google): Remove gee:status when the dataset is ready.
  'gee:status': 'incomplete',

  // This says that the dataset is an ee.ImageCollection.
  //   https://developers.google.com/earth-engine/apidocs/ee-image-collection
  'gee:type': ee_const.gee_type.image_collection,

  // Files should use this line as-is. There is a local license variable at
  // the top of the file that sets the SPDX license entry.
  license: license.id,

  // The standard links cover the basic locations of the dataset, catalog
  // entries, code examples, etc.
  links: ee.standardLinks(subdir, id),

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
