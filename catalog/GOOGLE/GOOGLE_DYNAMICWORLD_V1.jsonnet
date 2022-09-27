local id = 'GOOGLE/DYNAMICWORLD/V1';
local subdir = 'GOOGLE';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version + '-boom',
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'bad title@Dynamic World V1',
  version: 'V1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Dynamic World is a 10m near-real-time (NRT) Land Use/Land Cover (LULC)
    dataset that includes class probabilities and label information for nine
    classes.

    Dynamic World predictions are available for the Sentinel-2 L1C collection
    from 2015-06-27 to present. The revisit frequency of Sentinel-2 is between
    2-5 days depending on latitude. Dynamic World predictions are generated for
    Sentinel-2 L1C images with CLOUDY_PIXEL_PERCENTAGE <= 35%.
    Predictions are masked to remove clouds and cloud shadows using a
    combination of S2 Cloud Probability, Cloud Displacement Index, and
    Directional Distance Transform.

    Images in the Dynamic World collection have names matching the individual
    Sentinel-2 L1C asset names from which they were derived, e.g:

      ee.Image('COPERNICUS/S2/20160711T084022_20160711T084751_T35PKT')

    has a matching Dynamic World image named:
      ee.Image('GOOGLE/DYNAMICWORLD/V1/20160711T084022_20160711T084751_T35PKT').

    All probability bands except the "label" band collectively sum to 1.

    To learn more about the Dynamic World dataset and see examples for
    generating composites, calculating regional statistics, and working with the
    time series, see the [Introduction to Dynamic World](https://developers.google.com/earth-engine/tutorials/community/introduction-to-dynamic-world-pt-1) tutorial series.

    Given Dynamic World class estimations are derived from single images using a
    spatial context from a small moving window, top-1 "probabilities" for
    predicted land covers that are in-part defined by cover over time, like
    crops, can be comparatively low in the absence of obvious distinguishing
    features. High-return surfaces in arid climates, sand, sunglint, etc may
    also exhibit this phenomenon.

    To select only pixels that confidently belong to a Dynamic World class,
    it is recommended to mask Dynamic World outputs by thresholding the
    estimated "probability" of the top-1 prediction.
  |||,
  // license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    ee.link.license('https://sentinels.copernicus.eu/documents/247904/690755/Sentinel_Data_Legal_Notice'),
  ],
  keywords: [
    'zzz',
    'global',
    'google',
    'landcover',
    'landuse',
    'nrt',
    'sentinel2-derived',
  ],
  providers: [
    ee.producer_provider('World Resources Institute', 'https://www.wri.org/'),
    ee.producer_provider('Google', 'https://research.google.com/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2099-06-23T00:00:00Z', '2015-06-23T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'dynamicworld_algorithm_version',
        description: 'The version string uniquely identifying the Dynamic World model and inference process used to produce the image.',
        type: ee_const.var_type.string,
      },
      {
        name: 'qa_algorithm_version',
        description: 'The version string uniquely identifying the cloud masking process used to produce the image.',
        type: ee_const.var_type.string,
      }
    ],
    gsd: [
      10,
    ],
    'eo:bands': [
      {
        name: 'water',
        description: 'Estimated probability of complete coverage by water',
      },
      {
        name: 'trees',
        description: 'Estimated probability of complete coverage by trees',
      },
      {
        name: 'grass',
        description: 'Estimated probability of complete coverage by grass',
      },
      {
        name: 'flooded_vegetation',
        description: 'Estimated probability of complete coverage by flooded vegetation',
      },
      {
        name: 'crops',
        description: 'Estimated probability of complete coverage by crops',
      },
      {
        name: 'shrub_and_scrub',
        description: 'Estimated probability of complete coverage by shrub and scrub',
      },
      {
        name: 'built',
        description: 'Estimated probability of complete coverage by built',
      },
      {
        name: 'bare',
        description: 'Estimated probability of complete coverage by bare',
      },
      {
        name: 'snow_and_ice',
        description: 'Estimated probability of complete coverage by snow and ice',
      },
      {
        name: 'label',
        description: 'Index of the band with the highest estimated probability',
        'gee:classes': [
          {
            value: 0,
            color: '419BDF',
            description: 'water',
          },
          {
            value: 1,
            color: '397D49',
            description: 'trees',
          },
          {
            value: 2,
            color: '88B053',
            description: 'grass',
          },
          {
            value: 3,
            color: '7A87C6',
            description: 'flooded_vegetation',
          },
          {
            value: 4,
            color: 'E49635',
            description: 'crops',
          },
          {
            value: 5,
            color: 'DFC35A',
            description: 'shrub_and_scrub',
          },
          {
            value: 6,
            color: 'C4281B',
            description: 'built',
          },
          {
            value: 7,
            color: 'A59B8F',
            description: 'bare',
          },
          {
            value: 8,
            color: 'B39FE1',
            description: 'snow_and_ice',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Dynamic World V1',
        lookat: {
          lat: 52.4305,
          lon: 20.6729,
          zoom: 12,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              8,
            ],
            palette: [
              '419BDF',
              '397D49',
              '88B053',
              '7A87C6',
              'E49635',
              'DFC35A',
              'C4281B',
              'A59B8F',
              'B39FE1',
            ],
            bands: [
              'label',
            ],
          },
        },
      },
    ],
    water: {
      minimum: 0,
      maximum: 1,
      'gee:estimated_range': false,
    },
    trees: {
      minimum: 0,
      maximum: 1,
      'gee:estimated_range': false,
    },
    grass: {
      minimum: 0,
      maximum: 1,
      'gee:estimated_range': false,
    },
    flooded_vegetation: {
      minimum: 0,
      maximum: 1,
      'gee:estimated_range': false,
    },
    crops: {
      minimum: 0,
      maximum: 1,
      'gee:estimated_range': false,
    },
    shrub_and_scrub: {
      minimum: 0,
      maximum: 1,
      'gee:estimated_range': false,
    },
    built: {
      minimum: 0,
      maximum: 1,
      'gee:estimated_range': false,
    },
    bare: {
      minimum: 0,
      maximum: 1,
      'gee:estimated_range': false,
    },
    snow_and_ice: {
      minimum: 0,
      maximum: 1,
      'gee:estimated_range': false,
    },
    label: {
      minimum: 0,
      maximum: 8,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Brown, C.F., Brumby, S.P., Guzder-Williams, B. et al. Dynamic World, Near
    real-time global 10 m land use land cover mapping. Sci Data 9, 251 (2022).
    [doi:10.1038/s41597-022-01307-4](https://doi.org/10.1038/s41597-022-01307-4)
  |||,
  'gee:terms_of_use': |||
    This dataset is licensed under
    [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) and requires the
    following attribution: "This dataset is produced for the Dynamic World
    Project by Google in partnership with National Geographic Society and the
    World Resources Institute."

    Contains modified Copernicus Sentinel data [2015-present].
    See the
    [Sentinel Data Legal Notice](https://sentinels.copernicus.eu/documents/247904/690755/Sentinel_Data_Legal_Notice).
  |||,
}
