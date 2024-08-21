// This is a generic template for an Earth Engine ee.FeatureCollection (table)
// dataset STAC Collection entry. After replacing all the values, remove the
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
//   ee.FeatureCollection('TEMPLATE/TABLE_V2_4');
local id = 'TEMPLATE/TABLE_V2_4';

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
local version = '2.4';

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
  // End date is exclusive. For example, if the dataset covers the whole of
  // year 2021, the end date should be "2022-01-01T00:00:00Z"
  // Global spatial extents should use ee.extent_global.
  extent: ee.extent_global('2006-01-24T00:00:00Z', '2011-05-13T00:00:00Z'),
  // Alternatively, non-global extents use min_x, min_y, max_x, max_y:
  // extent: ee.extent(-171.0, -15.0, 164.0, 70.0,
  //                   '2006-01-24T00:00:00Z', '2011-05-13T00:00:00Z'),

  // Summaries contain additional information specific to the dataset type.
  summaries: {
    // Platform and instrument fields are optional and can be left out,
    // but are recommended.
    // https://github.com/radiantearth/stac-spec/blob/master/item-spec/common-metadata.md#instrument
    // Name of the ship, aircraft, spacecraft, or other collecting device.
    platform: ['My_Satellite'],
    // Name of instrument or sensor used (e.g., MODIS, ASTER, OLI, Canon F-1).
    instruments: ['My_Instrument'],

    // Descriptions of non-geometry table fields (the geometry field is assumed
    // to always be present).
    'gee:schema': [
      {
        name: 'field1',
        description: 'Field 1 description',
        // Possible type values: int, double, string
        type: ee_const.var_type.int,
      },
      {
        name: 'field2',
        description: 'Field 2 description',
        type: ee_const.var_type.string,
      },
    ],

    // For table datasets in the Earth Engine catalog, FeatureViews will be
    // automatically created to provide fast visualization.
    // FeatureView creation parameters are described at
    // https://developers.google.com/earth-engine/guides/featureview_overview
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 1500,
      thinning_strategy: 'HIGHER_DENSITY',
    },

    // One or more visualizations.
    'gee:visualizations': [
      {
        display_name: 'My FeaureCollection',
        lookat: {
          lat: 37.0,
          lon: -6.0,
          zoom: 10,
        },
        // For points:
        table_visualization: {
          color: '489734',
          point_size: 3,
        },
        // For polygons:
        // table_visualization: {
        //   color: 'ffffff',
        //   fill_color: 'ffffff88',
        // },
      },
      {
        display_name: 'My FeatureView',
        visualize_as: 'FeatureView',
        lookat: {
          lat: 37.0,
          lon: -6.0,
          zoom: 10,
        },
      },
    ],
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

 // This says that the dataset is an ee.FeatureCollection.
  //   https://developers.google.com/earth-engine/apidocs/ee-featurecollection
  'gee:type': ee_const.gee_type.table,

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
