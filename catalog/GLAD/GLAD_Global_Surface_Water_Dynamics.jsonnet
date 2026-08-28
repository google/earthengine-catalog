local id = 'GLAD/GLAD_Global_Surface_Water_Dynamics';

// The directory under 'catalog' that contains the dataset.
// For datasets under 'projects', leave off the 'projects' component.
//   E.g., the 'projects/planet-nicfi/assets/basemaps/africa' asset is in the
//   'planet-nicfi' subdirectory.

// TODO:
// Q: Not sure what above comment mean. Assuming that our  datasets under catalog
local subdir = 'GLAD';

// The version field can be any string. However, it is best to use
// the exact string that the data provider uses.
// Do not include a leading `V` in the version string.
// Prefer Semantic Versioning: https://semver.org/, which uses
// one to three numeric fields separated by decimal points.
// The version string might be different than the version portion of the `id`
// field, as the `id` field cannot have `.` characters.

// TODO:
// Q: Do we have version for dataset?
// MAJOR version when you make incompatible API changes
// MINOR version when you add functionality in a backward compatible manner
// PATCH version when you make backward compatible bug fixes
// local version = '1.0.0';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

// These are helper variables used below. Most files will just leave them as-is.
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;


{
  'gee:status': 'beta',
  id: id,
  title: 'GLAD Global Surface Water Dynamics',
  description: |||
    Global maps derived from all Landsat scenes 1999-2025 highlight the changes in open surface water extent during this period. Water and land are mapped in every Landsat scene with cloud, shadow, and ice masked out. The percent of valid observations identified as water are calculated per month. These monthly water percentages are then aggregated by year (annual water percent) and interannual dynamics are mapped both as a three band image highlighting the dynamics types and intensities and as a discrete classification of dynamic type.

    By evaluating the entire time-series, rather than just a start and end year or by epoch, areas that are interannually variable going back and forth between land and water majority states on the annual scale are mapped as wet period, dry period, or high frequency change (changing majority state three or more times). In the 3-band dynamics summary layer, the annual time-series is converted to three points that best describe the annual water percent curve.

    For more details please see the publication: [https://doi.org/10.1016/j.rse.2020.111792](https://doi.org/10.1016/j.rse.2020.111792). Explore the dataset in an Earth Engine App: [https://glad.earthengine.app/view/surface-water-dynamics](https://glad.earthengine.app/view/surface-water-dynamics)

    Note that the percent layers correspond to the temporal percent of the period not the spatial percent of open water coverage and have values of 0-100% and 255 as no data.

    GLAD surface water datasets available:
    - R-G-B interannual dynamics maps
    - interannual stable and change classes
    - annual water percent
    - monthly mean water percent
    - individual month water percent

    **_RGB_**
    For the criteria used to transform the annual time-series data into this three-band summary, please refer to [sections 2.2.2 and 2.2.3 of the publication](https://doi.org/10.1016/j.rse.2020.111792).

  |||,

  // One or more category keywords. For the current list, see
  // https://github.com/google/earthengine-catalog/blob/main/checker/node/gee_categories.py
  // All categories will also be added as keywords.
  // TODO: check categories
  'gee:categories': ['oceans', 'surface-ground-water'],

  // Please look through the list of existing keywords and pick two or more
  // that match the dataset.
  // https://developers.google.com/earth-engine/datasets/tags
  //
  // Please avoid creating new keywords. If you feel you need to add a new one,
  // add it but comment it out.
  //
  // TODO: Check keywords
  keywords: [
    'water',
    'landsat',
  ],

  providers: [
    // There can be multiple entries of ee.producer_provider and/or
    // ee.processor_provider.
    // ee.producer_provider('Example Organization', 'https://example.com'),
    // TODO: Check this.
    // Not sure whether the 'Example Organization' need to be registered first. But after checking the NASA and other Org's catalog, Looks like it just a org name + dataset page link (or doi)
    ee.producer_provider('The Global Land Analysis and Discovery (GLAD) laboratory at the University of Maryland', 'https://glad.umd.edu/dataset/global-surface-water-dynamics'),
    // This is always the last entry.
    ee.host_provider(self_ee_catalog_url),
  ],

  // Spatial and temporal extent.
  // What area and what time interval does the dataset cover?
  // Date/times must be in UTC, using the form 'YYYY-MM-DDTHH:MM:SSZ'.
  // End date is exclusive. For example, if the dataset covers the whole of
  // year 2021, the end date should be "2022-01-01T00:00:00Z"
  // Global spatial extents should use ee.extent_global.
  //
  // TODO: check this. The extent below include year 1999-2025
  extent: ee.extent_global('1999-01-01T00:00:00Z', '2026-01-01T00:00:00Z'),

  //TODO: Complete this. more example at https://github.com/google/earthengine-catalog/blob/main/catalog/TEMPLATE/TEMPLATE_IMAGE_V2_1.jsonnet
  summaries: {
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
    ],
    // One or more band visualizations.
    'gee:visualizations': [
      // Example with three bands, but only one value for min and max.
      {
        // Give units when possible.
        display_name: 'Describe what is shown 1',
        // Do not use too many significant digits.
        lookat: { lon: -122.03, lat: 39.67, zoom: 11 },
        // See for details:
        // https://developers.google.com/earth-engine/guides/image_visualization
        image_visualization:
          {
            band_vis: {
              min: [0],
              max: [255],
              // Which bands to map to red, green, and blue rgb channels.
              bands: ['band_name_1', 'band_name_2', 'band_name_3'],
            },
          },
      },
    ],
  },

  'sci:citation': |||
    Pickens, A.H., Hansen, M.C., Hancher, M., Stehman, S.V., Tyukavina, A., Potapov, P., Marroquin, B., Sherani, Z., 2020. Mapping and sampling to characterize global inland water dynamics from 1999 to 2018 with full Landsat time-series. Remote Sensing of Environment 243, 111792. [doi:10.1016/j.rse.2020.111792](https://doi.org/10.1016/j.rse.2020.111792)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
