local id = 'GOOGLE/CLOUD_SCORE_PLUS/V1/S2_HARMONIZED';
local subdir = 'GOOGLE';
local version = '1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  // Do not end the title with punctuation. Include version if it is known.
  title: 'Cloud Score+ S2_HARMONIZED V' + version,
  version: version,

  description: |||
    Cloud Score+ is a quality assessment (QA) processor for medium-to-high
    resolution optical satellite imagery. The Cloud Score+ S2_HARMONIZED
    dataset is being operationally produced from the
    [harmonized Sentinel-2 L1C collection](https://developers.google.com/earth-engine/datasets/catalog/COPERNICUS_S2_HARMONIZED),
    and Cloud Score+ outputs can be used to identify relatively clear pixels and
    effectively remove clouds and cloud shadows from [L1C (Top-of-Atmosphere)](https://developers.google.com/earth-engine/datasets/catalog/COPERNICUS_S2_HARMONIZED)
    or [L2A (Surface Reflectance)](https://developers.google.com/earth-engine/datasets/catalog/COPERNICUS_S2_SR_HARMONIZED)
    imagery.

    The Cloud Score+ S2_HARMONIZED dataset includes two QA bands, `cs` and
    `cs_cdf`, that both grade the usability of individual pixels with respect to
    surface visibility on a continuous scale between 0 and 1, where 0 represents
    "not clear" (occluded), while 1 represents "clear" (unoccluded) observations.
    The `cs` band scores QA based on a spectral distance between the observed
    pixel and a (theoretical) clear reference observation, while the `cs_cdf` band
    represents the likelihood an observed pixel is clear based on an estimated
    cumulative distribution of scores for a given location through time. In
    other words, `cs` can be thought of as a more instantaneous atmospheric
    similarity score (i.e., how similar is this pixel to what we'd expect to
    see in a perfectly a clear reference), while `cs_cdf` captures an expectation
    of the estimated score through time (i.e., if we had all the scores for this
    pixel through time, how would this score rank?).

    Images in the Cloud Score+ S2_HARMONIZED collection have the same id and
    `system:index` properties as the individual [Sentinel-2 L1C](https://developers.google.com/earth-engine/datasets/catalog/COPERNICUS_S2_HARMONIZED)
    assets from which they were produced such that Cloud Score+ bands can be
    linked to source images based on their shared `system:index`.

    Cloud Score+ backfill for the entire Sentinel-2 archive is currently in
    progress and Dataset Availability dates will be updated periodically as new
    results are added to the Cloud Score+ collection.

    For more information about the Cloud Score+ dataset and modelling
    approach, see
    [this Medium post](https://medium.com/google-earth/all-clear-with-cloud-score-bd6ee2e2235e).
  |||,


  keywords: [
    'google',
    'cloud',
    'sentinel2_derived',
  ],

  // Who created the data.
  // Prefer https rather than http links.
  providers: [
    ee.producer_provider('Google Earth Engine', 'https://earthengine.google.com/'),
    ee.host_provider(self_ee_catalog_url),
  ],

  extent: ee.extent_global('2015-06-27T00:00:00Z', null),

  // Summaries contain additional information specific to the dataset type.
  summaries: {
    // Describe all of the bands in the order they appear in an ee.Image.
    // For each band, only `name` and `description` are required.
    // If the pixel size is the same for all bands, set it here.
    // (In STAC, pixel size is called "gsd", or "ground sample distance".)
    // https://en.wikipedia.org/wiki/Ground_sample_distance
    // Value is in meters. If the pixel size is in degrees, multiply by 111,195.
    // gsd: [15],
    gsd: [
      10,
    ],
    'eo:bands': [
      {
        name: 'cs',
        description: |||
          Pixel quality score based on spectral distance from a
          (theoretical) clear reference
        |||,
        'gee:units': units.dimensionless,
      },
      {
        name: 'cs_cdf',
        description: |||
          Value of the cumulative distribution function of possible
          `cs` values for the estimated `cs` value
        |||,
        'gee:units': units.dimensionless,
      },
    ],

    cs: { minimum: 0, maximum: 1, 'gee:estimated_range': false },
    cs_cdf: { minimum: 0, maximum: 1, 'gee:estimated_range': false },

    // One or more band visualizations.
    'gee:visualizations': [
      {
        display_name: 'Cloud Score Plus (cs_cdf)',
        lookat: { lon: 31.2196, lat: -16.1377, zoom: 11 },
        image_visualization: {
          band_vis: {
            min: [0],
            max: [1],
            palette: ['white', 'black'],
            bands: ['cs_cdf'],
          },
        },
      },
    ],

    'gee:schema': [
      {
        name: 'DATE_PRODUCT_GENERATED',
        description: 'Production date.',
        type: ee_const.var_type.string,
      },
      {
        name: 'MGRS_TILE',
        description:
          'Sentinel-2 Military Grid Reference System ID.',
        type: ee_const.var_type.string,
      },
      {
        name: 'MODEL_VERSION',
        description:
          'Cloud Score+ model version.',
        type: ee_const.var_type.string,
      },
      {
        name: 'NO_CONTEXT_FRACTION',
        description:
          'Fraction of subtiles processed with no temporal context.',
        type: ee_const.var_type.double,
      },
      {
        name: 'PROCESSING_SOFTWARE_VERSION',
        description:
          'Cloud Score+ processing software version.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SOURCE_ASSET_ID',
        description:
          'Earth Engine Asset ID for source image.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SOURCE_PRODUCT_ID',
        description:
          'Sentinel-2 Product ID for source image.',
        type: ee_const.var_type.string,
      },
    ],
  },


  // Use APA style for citations and publications. https://apastyle.apa.org/
  'sci:citation': |||
    Pasquarella, V. J., Brown, C. F., Czerwinski, W., & Rucklidge, W. J. (2023)
    Comprehensive Quality Assessment of Optical Satellite Imagery Using Weakly
    Supervised Video Learning. In Proceedings of the IEEE/CVF Conference on
    Computer Vision and Pattern Recognition (pp. 2124-2134).
    [PDF](https://openaccess.thecvf.com/content/CVPR2023W/EarthVision/html/Pasquarella_Comprehensive_Quality_Assessment_of_Optical_Satellite_Imagery_Using_Weakly_Supervised_CVPRW_2023_paper.html)
  |||,
  // // Additional citations go here.
  // 'sci:publications': [
  //   {
  //     citation: |||
  //       AuthorLast, A. B., C. D., Author2Last and E. F. Author3Last: YEAR,
  //       The Title of the Publication, Journal, Volume, Number, pages.
  //       [doi:TODO_DOI_STRING](https://doi.org/TODO_DOI_STRING),
  //     |||,
  //     doi: '10.1234/TODO_DOI_STRING',
  //   },
  // ],

  // For standard SPDX licenses, use:
  'gee:terms_of_use': ee.gee_terms_of_use(license),


  // The fields below generally don't need to be changed.

  'gee:type': ee_const.gee_type.image_collection,

  license: license.id,

  links: ee.standardLinks(subdir, id),

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
