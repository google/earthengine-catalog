// This is a generic template for an Earth Engine ee.Image dataset
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
//   ee.Image('TEMPLATE/IMAGE_V2_1');
local id = 'scanfi_v12/SCANFI_v1_2';

// The directory under 'catalog' that contains the dataset.
// For datasets under 'projects', leave off the 'projects' component.
//   E.g., the 'projects/planet-nicfi/assets/basemaps/africa' asset is in the
//   'planet-nicfi' subdirectory.
local subdir = 'gcpm041u-lemur';

// The version field can be any string. However, it is best to use
// the exact string that the data provider uses.
// Do not include a leading `V` in the version string.
// Prefer Semantic Versioning: https://semver.org/, which uses
// one to three numeric fields separated by decimal points.
// The version string might be different than the version portion of the `id`
// field, as the `id` field cannot have `.` characters.
local version = '1.2';

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
local license = spdx.ogl_canada_2_0;

// These are helper variables used below. Most files will just leave them as-is.
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  // Do not end the title with punctuation. Include version if it is known.
  title: 'SCANFI: the Spatialized CAnadian National Forest Inventory data product' + version,
  version: version,

  description: |||
    This data publication contains a set of 30m resolution raster files representing 2020 
    Canadian wall-to-wall maps of broad land cover type, forest canopy height, degree of 
    crown closure and aboveground tree biomass, along with species composition of several 
    major tree species. The Spatialized CAnadian National Forest Inventory data product (SCANFI) 
    was developed using the newly updated National Forest Inventory photo-plot dataset, which 
    consists of a regular sample grid of photo-interpreted high-resolution imagery covering all 
    of Canada’s non-arctic landmass. SCANFI was produced using temporally harmonized summer and 
    winter Landsat spectral imagery along with hundreds of tile-level regional models based on 
    a novel k-nearest neighbours and random forest imputation method.
    
    A full description of all methods and validation analyses can be found in Guindon et al. (2024). 
    As the Arctic ecozones are outside NFI’s covered areas, the vegetation attributes in these 
    regions were predicted using a single random forest model. The vegetation attributes in these 
    arctic areas could not be rigorously validated. The raster file 
    « SCANFI_aux_arcticExtrapolationArea.tif » identifies these zones.

    Full metadata, download links, layers description and data constraints, that should be known 
    before usage, can be found on Canada Open:
    [https://doi.org/10.23687/18e6a919-53fd-41ce-b4e2-44a9707c52dc](https://doi.org/10.23687/18e6a919-53fd-41ce-b4e2-44a9707c52dc)

    Details on the product development and validation can be found in the following publication:
    Guindon, L., Manka, F., Correia, D.L.P., Villemaire, P., Smiley, B., Bernier, P., Gauthier, S., 
    Beaudoin, A., Boucher, J., and Boulanger, Y. 2024. A new approach for Spatializing the Canadian 
    National Forest Inventory (SCANFI) using Landsat dense time series. Can. J. For. Res. [https://doi.org/10.1139/cjfr-2023-0118](https://doi.org/10.1139/cjfr-2023-0118)

    Please cite this dataset as:
    Guindon L., Villemaire P., Correia D.L.P., Manka F., Lacarte S., Smiley B. 2023. SCANFI: Spatialized CAnadian National Forest Inventory data product. Natural Resources Canada, Canadian Forest Service, Laurentian Forestry Centre, Quebec, Canada. https://doi.org/10.23687/18e6a919-53fd-41ce-b4e2-44a9707c52dc

    Contains information licensed under the
    [Open Government Licence - Canada](https://open.canada.ca/en/open-government-licence-canada)
  |||,


  // One or more category keywords. For the current list, see
  // https://github.com/google/earthengine-catalog/blob/main/checker/node/gee_categories.py
  // All categories will also be added as keywords.
  'gee:categories': ['climate', 'soil'],

  // Please look through the list of existing keywords and pick two or more
  // that match the dataset.
  // https://developers.google.com/earth-engine/datasets/tags
  //
  // Please avoid creating new keywords. If you feel you need to add a new one,
  // add it but comment it out.
  keywords: [
    'ecosystems',
    'forest-biomass',
    'landuse-landcover',
    //'forests',
    //'forest attributes',
    //'tree species',
    //'Canada',
  ],

  // Who created the data.
  // Prefer https rather than http links.
  providers: [
    // There can be multiple entries of ee.producer_provider and/or
    // ee.processor_provider.
    ee.producer_provider('NRCan', 'https://open.canada.ca/data/en/dataset/18e6a919-53fd-41ce-b4e2-44a9707c52dc'),
    // This is always the last entry.
    ee.host_provider(self_ee_catalog_url),
  ],

  // Spatial and temporal extent.
  // What area and what time interval does the dataset cover?
  // Date/times must be in UTC, using the form 'YYYY-MM-DDTHH:MM:SSZ'.
  // End date is exclusive. For example, if the dataset covers the whole of
  // year 2021, the end date should be "2022-01-01T00:00:00Z"
  // Global spatial extents should use ee.extent_global.
  // extent: ee.extent_global('2006-01-24T00:00:00Z', '2011-05-13T00:00:00Z'),
  // Alternatively, non-global extents use min_x, min_y, max_x, max_y:
  extent: ee.extent(-142.0, 41.0, -52.0, 84.0,
                    '2020-01-01T00:00:00Z', '2021-01-01T00:00:00Z'),

  // Summaries contain additional information specific to the dataset type.
  summaries: {
    // Platform and instrument fields are optional and can be left out,
    // but are recommended.
    // https://github.com/radiantearth/stac-spec/blob/master/item-spec/common-metadata.md#instrument
    // Name of the ship, aircraft, spacecraft, or other collecting device.
    // platform: ['My_Satellite'],
    // Name of instrument or sensor used (e.g., MODIS, ASTER, OLI, Canon F-1).
    // instruments: ['My_Instrument'],

    // Describe all of the bands in the order they appear in an ee.Image.
    // For each band, only `name` and `description` are required.
    // If the pixel size is the same for all bands, set it here.
    // (In STAC, pixel size is called "gsd", or "ground sample distance".)
    // https://en.wikipedia.org/wiki/Ground_sample_distance
    // Value is in meters. If the pixel size is in degrees, multiply by 111,195.
    gsd: [30],
    'eo:bands': [
      {
        name: 'Landcover',
        description: 'NFI land cover class values: Land cover classes include Bryoid (1), Herbs (2), Rock (3), Shrub (4), 
                        Treed broadleaf (5), Treed conifer (6), Treed mixed (7) and  Water (8)',
        // Only for bands with enumerated values.
        'gee:classes': [
          { value: 1, color: 'e64bfa', description: 'Bryoid' },
          { value: 2, color: 'e7e56c', description: 'Herbs' },
          { value: 3, color: '000000', description: 'Rock' },
          { value: 4, color: 'bd0006', description: 'Shrub' },
          { value: 5, color: '95ea4b', description: 'Treed broadleaf' },
          { value: 6, color: '048e4e', description: 'Coniferous' },
          { value: 7, color: '16d132', description: 'Treed mixed' },
          { value: 8, color: '3be5ff', description: 'Water' },
        ],
      },
      {
        name: 'Biomass',
        description: 'Aboveground tree biomass (tons/ha): biomass derived from total merchantable volume estimates produced by provincial agencies',
        // gsd: 15,  // Pixel size (ground sample distance). Value is in meters.
                  // If the pixel size is in degrees, multiply by 111,195.
        // center_wavelength: 0.56,  // in nm
        // Note that gee:wavelength is more expressive than 'center_wavelength',
        // as it allows value ranges and units.
        // 'gee:wavelength': '0.520-0.600 &mu;m',
        // See here for predefined units and prefer those over using a custom
        // units string.
        // https://github.com/google/earthengine-catalog/blob/main/catalog/units.libsonnet
        'gee:units': units.tonnes_per_hectare,
      },
      {
        name: 'Height',
        description: 'Height (meters): vegetation height',
        'gee:units': units.meter,
      },
      {
        name: 'Crown_closure',
        description: 'Crown closure (%): percentage of pixel covered by the tree canopy',
        'gee:units': units.percent,
      },
      {
        name: 'Balsam_fir',
        description: 'Balsam fir (%): estimated as the proportion of the canopy covered by Abies balsamea',
        'gee:units': ee_const.percent,
      },
      {
        name: 'Black_spruce',
        description: 'Black spruce (%): estimated as the proportion of the canopy covered by Picea mariana',
        'gee:units': ee_const.percent,
      },
      {
        name: 'Douglas_fir',
        description: 'Douglas fir (%): estimated as the proportion of the canopy covered by Pseudotsuga menziesii',
        'gee:units': ee_const.percent,
      },
      {
        name: 'Jack_pine',
        description: 'Jack pine (%): estimated as the proportion of the canopy covered by Pinus banksiana',
        'gee:units': ee_const.percent,
      },
      {
        name: 'Lodgepole_pine',
        description: 'Lodgepole pine (%): estimated as the proportion of the canopy covered by Pinus contorta',
        'gee:units': ee_const.percent,
      },
      {
        name: 'Ponderosa_pine',
        description: 'Ponderosa pine (%): estimated as the proportion of the canopy covered by Pinus ponderosa',
        'gee:units': ee_const.percent,
      },
      {
        name: 'Tamarack',
        description: 'Tamarack_tree (%): estimated as the proportion of the canopy covered by Larix laricina',
        'gee:units': ee_const.percent,
      },
      {
        name: 'White_and_red_pine',
        description: 'White and red pine (%): estimated as the proportion of the canopy covered by Pinus strobus and Pinus resinosa',
        'gee:units': ee_const.percent,
      },
      {
        name: 'Broadleaf',
        description: 'Broadleaf tree cover in percentage (PrcB)',
        'gee:units': ee_const.percent,
      },
      {
        name: 'Other_coniferous',
        description: 'Other coniferous tree cover in percentage (PrcC)',
        'gee:units': ee_const.percent,
      },
      {
        name: 'articExtrapolationArea',
        description: 'Flag for marking Artic unreliable extrapolated pixels',
        // Only for bands with enumerated values.
        'gee:classes': [
          {value: 1, color: '000000', description: 'Artic Extrapolation Area'},
        ],
      },
    ],

    // Optional band statistics - one entry per band.
    // If the exact statistics are known, then set gee:estimated_range to true.
    // band_name_1: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    // band_name_2: {minimum: 0, maximum: 1e8, 'gee:estimated_range': false},
    // band_name_3: {minimum: 0, maximum: 100, 'gee:estimated_range': false},
    // band_name_4: {minimum: 0, maximum: 100, 'gee:estimated_range': false},

    // One or more band visualizations.
    'gee:visualizations': [
      // Example with one band and a palette for the colors.
      {
        display_name: 'SCANFI land cover',
        lookat: {lon: -122, lat: 39, zoom: 14},
        image_visualization: {
          band_vis: {
            min: [1],
            max: [8],
            // Use W3C color names or 6-character hex (e.g., green is 00ff00).
            // https://www.w3.org/wiki/CSS/Properties/color/keywords
            palette: [
              'e64bfa',
              'e7e56c',
              '000000',
              'bd0006',
              '95ea4b',
              '048e4e',
              '16d132',
              '3be5ff'
            ],
            bands: ['Landcover'],
          },
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
  // 'gee:terms_of_use': ee.gee_terms_of_use(license),
  // If there is a custom license (the license is set to spdx.proprietary, set
  // gee:terms_of_use to enough text that a reader has a sense of what they are
  // getting into. Be sure to add a link to the license in this Markdown text
  // and add the link to the license section with ee.link.license(url).
  // 'gee:terms_of_use': |||
  //   Put the custom license here.
  // |||,
  'gee:terms_of_use': |||
    Licensed under the
    [Open Government Licence - Canada](https://open.canada.ca/en/open-government-licence-canada).
  |||,

  // The fields below generally don't need to be changed.

  // TODO(google): Remove gee:status when the dataset is ready.
  'gee:status': 'incomplete',

  // This says that the dataset is an ee.Image.
  //   https://developers.google.com/earth-engine/apidocs/ee-image
  'gee:type': ee_const.gee_type.image,

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
