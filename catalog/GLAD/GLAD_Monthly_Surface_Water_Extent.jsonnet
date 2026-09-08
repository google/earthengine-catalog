local id = 'projects/glad/water/C2/individualMonths';

//TODO: verify this subdir path
// 'projects/glad/water/C2/individualMonths'
local subdir = 'glad/water/C2/individualMonths';

local version = '2.0.0';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

// These are helper variables used below. Most files will just leave them as-is.
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  // Do not end the title with punctuation. Include version if it is known.
  title: 'Monthly Surface Water Extent V' + version,
  version: version,

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

  |||,

  'gee:categories': ['landuse-landcover', 'surface-ground-water'],

  // Please look through the list of existing keywords and pick two or more
  // that match the dataset.
  // https://developers.google.com/earth-engine/datasets/tags
  //
  // Please avoid creating new keywords. If you feel you need to add a new one,
  // add it but comment it out.
  keywords: [
    'monthly',
    'global',
    'landsat-derived',
    'water',
  ],

  // Who created the data.
  // Prefer https rather than http links.
  providers: [
    // There can be multiple entries of ee.producer_provider and/or
    // ee.processor_provider.
    ee.producer_provider('The Global Land Analysis and Discovery (GLAD) laboratory at the University of Maryland', 'https://glad.umd.edu/dataset'),
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
  // TODO: Add time
  extent: ee.extent_global('2006-01-24T00:00:00Z', '2011-05-13T00:00:00Z'),
  // Alternatively, non-global extents use min_x, min_y, max_x, max_y:
  // extent: ee.extent(-171.0, -15.0, 164.0, 70.0,
  //                   '2006-01-24T00:00:00Z', null),

  // Summaries contain additional information specific to the dataset type.
  // TODO: Add summaries
  summaries: {

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
  'sci:doi': '10.1016/j.rse.2020.111792',
  // Use APA style for citations and publications. https://apastyle.apa.org/
  'sci:citation': |||
    Pickens, A.H., Hansen, M.C., Hancher, M., Stehman, S.V., Tyukavina, A., Potapov, P., Marroquin, B., Sherani, Z., 2020. Mapping and sampling to characterize global inland water dynamics from 1999 to 2018 with full Landsat time-series. Remote Sensing of Environment 243, 111792. [doi:10.1016/j.rse.2020.111792](https://doi.org/10.1016/j.rse.2020.111792),
  |||,

  // For standard SPDX licenses, use:
  'gee:terms_of_use': ee.gee_terms_of_use(license),


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
