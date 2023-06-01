// This is a generic template for an Earth Engine ee.Image dataset
// STAC Collection entry. After replacing all the values, remove all the
// explanatory comments.
//
// This template covers the basic case where there is no templating across
// entries. For examples with extensive templating look for directories with
// `libsonnet` files.
//
// See https://jsonnet.org/ for more documentation on the Jsonnet language used
// here to create STAC JSON.
//
// Coding style:
// - Indenting should be two spaces.
// - Do not use tabs.
// - Fit to 80 columns unless that will break URL strings.
// - Use only ASCII characters. \n and 32..176 decimal range. See 'man ascii'.
// - Use American English.
//
// STAC Specifications:
//   - Overall https://github.com/radiantearth/stac-spec
//   - Extensions https://github.com/stac-extensions/stac-extensions.github.io
//     - Electro-Optical https://github.com/stac-extensions/eo
//     - Synthetic Aperture Radar https://github.com/stac-extensions/sar
//     - Scientific https://github.com/stac-extensions/scientific
//     - Version https://github.com/stac-extensions/scientific
//
// This has to be the subdir/subdir_rest_of_the_dataset_id. The filename
// must match this with .jsonnet appended.
local id = 'TEMPLATE/IMAGE_V2_1';
// The directory under catalog that corresponds to the organization.
// For datasets under 'projects', leave off the 'projects' component.
//   c.f. planet-nicfi
local subdir = 'TEMPLATE';
// The version field can be any string.  However, it is best to use
// 1 to 3 numeric fields separated by decimal points.
// Semantic Versioning https://semver.org/.  The best versions can be checked
// with the Debian tools.  e.g.
//
//   dpkg --compare-versions 1.2.3a lt 1.2.10 && echo true
//   true
// Do not include a leading `V` in the version string.
local version = '2.1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

// Change this to one of the license in:
// https://github.com/google/earthengine-catalog/blob/main/catalog/spdx.libsonnet
//
// - If the license is not in spdx.libsonnet and it is available in SPDX, you
//   can add it to spdx.libsonnet. See: https://spdx.org/licenses/
// - If multiple licenses apply, at the same time, use spdx.various.
// - All other licenses should use to spdx.proprietary. "proprietary" means
//   that the license is not in SPDX.
// - If there is more than one license, pick the most permissive license.
// - If the license is non-commercial and/or share-alike, add the dataset to
//   https://github.com/google/earthengine-catalog/blob/main/non_commercial_datasets.jsonnet
local license = spdx.proprietary;

// These are helpers used below.  Most files will just leave them as is.
local basename = std.strReplace(id, '/', '_');
// local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  // TODO(schwehr): Remove skip_indexing when the dataset is ready.
  'gee:skip_indexing': true,
  'gee:user_uploaded': true,

  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    // The EO extension is required for bands.
    ee_const.ext_eo,
    // For synthetic aperture radar (SAR)
    // ee_const.ext_sar,
    ee_const.ext_sci,
    // Include the version extension if the dataset uses:
    // the deprecated or version fields
    // successor link, predecessor link, or latest link
    ee_const.ext_ver,
  ],
  id: id,
  // Do not end with punctuation.
  title: 'A short title goes here V' + version,
  version: version,

  // This says that the dataset is an ee.Image.
  //   https://developers.google.com/earth-engine/apidocs/ee-image
  'gee:type': ee_const.gee_type.image,

  description: |||
    Write enough here for most people to understand:
    - what the dataset is for
    - what the dataset limitations are
    - how it was created
    - and anything else essential to know when working with the data.

    Things to consider when writing:
    - Write in the third person.
    - The text will be processed as CommonMark (a.k.a. MarkDown) with multiple
      different processors. Google's can handle tables, but STAC Browser does
      not support tables.
    - Define all acronyms.  e.g. Absolutely Amazing Sensor (AAS).
    - Make links to additional resources or manuals when appropriate
    - Bare links must be put in markdown links.  e.g.
        - https://earthengine.google.com/ is just text
        - [https://earthengine.google.com/](https://earthengine.google.com/)
          is actually a link.
    - The accordion operator (`|||`) allows for writing multiline strings.
    - Indent 2 spaces under the |||.
  |||,
  // Files should use this lines as-is.  There is a local license variable at
  // the top of the file that sets the spdx license entry.
  license: license.id,
  // The standard links cover the basic locations of the dataset, catalog
  // entries, code examples, etc.
  links: ee.standardLinks(subdir, id),
  // Here are some of the other links that are sometimes needed.  Added by doing
  // links: ee.standardLinks(subdir, id) + [more links here],
  // Versions have:
  //  ee.link.latest(latest_id, latest_url),
  //  ee.link.predecessor(predecessor_id, predecessor_url),
  //  ee.link.successor(successor_id, successor_url),
  // For more link types, see earthengine.libsonnet

  // Please look through the list of existing keywords and pick two or more
  // that match the dataset.
  // https://developers.google.com/earth-engine/datasets/tags
  //
  // Please avoid creating new keywords.
  keywords: [
    'elevation',
    'lidar',
  ],
  // Who created the data.
  // Prefer https to http links.
  providers: [
    // There can be multiple entries of ee.producer_provider and/or
    // ee.processor_provider.
    ee.producer_provider('Example Organization', 'https://example.com'),
    // This is always the last entry.
    ee.host_provider(self_ee_catalog_url),
  ],
  // Spatial and temporal extent.
  // Where and when does the dataset cover?  Date/times are UTC using "Z" for
  // the timezone.  They must be YYYY-MM-DDTHH:MM:SSZ.
  // End time may be `None` for on going datasets that are updated regularly.
  // Global extents should use ee.extent_global.
  extent: ee.extent_global('2006-01-24T00:00:00Z', '2011-05-13T00:00:00Z'),
  // Alternatively, local extents use:
  // extent: ee.extent(-171.0, -15.0, 164.0, 70.0,
  //                   '2012-02-07T00:00:00Z', None),

  // Summaries contain additional information specific to the dataset type.
  summaries: {
    // Describes values set on each image.
    // TODO(schwehr): Describe difference between scheam and properties???
    'gee:schema': [
      {
        name: 'Property_name',
        description: 'Describe the property',
        type: ee_const.var_type.double,  // See var_type for the possibilities
        'units': units.dimensionless,
      },
    ],

    // https://github.com/radiantearth/stac-spec/blob/master/item-spec/common-metadata.md#instrument
    // "mission" is not currently allowed.
    // Name of the constellation to which the platform belongs.
    constellation: ['My_Constellation'],
    // Name of the ship, aircraft, spacecraft, or other collecting device.
    platform: ['My_Satellite'],
    // Name of instrument or sensor used (e.g., MODIS, ASTER, OLI, Canon F-1).
    instruments: ['My_Instrument'],

    // Describe all of the bands in the order they appear in an ee.Image.
    // If the ground separation distance (GSD) is the same for all bands, set it
    // here. Value is in meters.
    // gsd: [15],
    'eo:bands': [
      {
        name: 'band_name_1',
        description: 'Describe the band',
        center_wavelength: 0.56,  // in nm
        gsd: 15,  // ground separation distance in meters
        'gee:wavelength': '0.520-0.600 &mu;m',
        'gee:units': units.dn,
      },
      {
        name: 'band_name_2',
        description: 'Describe the band',
        gsd: 20,
        'gee:units': units.dimensionless,  // For units without dimensions.
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

    // 1 or more band visualizations
    'gee:visualizations': [
      // Example with 3 bands, but only 1 value for min and max.
      {
        // Give units when possible.
        display_name: 'Describe what is shown 1',
        // Do not use too many significant digits.
        // Try to avoid zoom levels of 0-3 for datasets with many assets as that
        // can be hard on the system.
        lookat: {lon: -122.03, lat: 39.67, zoom: 11},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [255],
            // Which bands to map to red, green, and blue rgb channels.
            bands: ['band_name_1', 'band_name_2', 'band_name_3'],
          }
        },
      },
      // Example with one band having gee:classes.
      {
        display_name: 'Discribe what is shown 2',
        lookat: {lon: -122, lat: 39, zoom: 4},
        image_visualization: {band_vis: {bands: ['band_name_4']}},
      },
      // Example with one band and a palette for the colors.
      {
        display_name: 'Discribe what is shown 3',
        lookat: {lon: -122, lat: 39, zoom: 14},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [100],
            // Use W3C color names or 6 character hex (e.g., green is 00ff00).
            // https://www.w3.org/wiki/CSS/Properties/color/keywords
            palette: ['blue', 'red'],
            bands: ['band_name_3'],
          },
        },
      },
    ],
  },
  // The scientific extension.
  // The best DOI that describes the *data*.
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
  // getting into.  Be sure to add a link to the license in this markdown text
  // and add the link to the license section with ee.link.license(url).
  // 'gee:terms_of_use': |||
  //   Put the custom license here.
  // |||,
}
