local id = 'projects/radar-wur/assets/raddalert/v1';
local subdir = 'radar-wur';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,

  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],

  id: id,
  title: 'RADD Forest Disturbance Alerts',

  'gee:type': ee_const.gee_type.image_collection,
  'gee:status': 'beta',
  'gee:categories': [
    'forest-biomass',
  ],

  description: |||
    Radar satellite imagery from the European Space Agency's Sentinel-1 mission is used to map new disturbances in primary humid tropical forest at 10 m spatial scale and in near real-time.

    The dataset covers primary humid tropical forest of South America (13 countries), Central America (6 countries), Africa (25 countries), insular Southeast Asia (5 countries) and Pacific (1 country).

    The ImageCollection contains data for several geographic regions and product layers. Use the `geography` property to select a region:

    - `ca`: Central America
    - `sa`: South America
    - `africa`: Africa
    - `asia`: Asia and the Pacific

    Forest disturbance alert images can be selected by filtering the `layer` property for values containing `alert`. The collection also contains forest baseline images, which can be selected by filtering `layer` for values containing `forest_baseline`.

    The `Alert` band distinguishes low- and high-confidence disturbance alerts. The `Date` band records the date of the Sentinel-1 observation that first triggered the alert, encoded as YYDOY, where YY is the two-digit year and DOY is the day of year.

    **Notes and limitations**

    - This product does not separate human-caused deforestation from other forest disturbances.

    - False detections may occur in swamp forests due to the high sensitivity of short-wavelength C-band radar to moisture variations.

    - Small-scale changes, such as logging roads and small-scale agriculture, are typically detected in a timely manner because forest edges are relatively straightforward to detect using short-wavelength C-band radar. Large-scale patches, such as plantation expansion, may take longer to reach a sufficiently high probability to be flagged as alerts. These patches may appear similar to undisturbed forest in radar imagery due to conditions such as wet soil or remaining woody debris.

    - The product is constrained by the global forest baseline used, which may result in inconsistencies at the local level. In areas incorrectly labelled as primary forest in the baseline, commission errors may occur. Where forest loss occurred before monitoring began but was missed by the baseline input data, alerts may be detected well after the disturbance occurred. This affects alerts from early 2019 in Africa and early 2020 in other geographies.

    - A validation of confirmed alerts in the Congo Basin indicated 2% false positives and 5% false negatives for disturbances greater than 0.2 ha.
  |||,

  license: license.id,

  links: ee.standardLinks(subdir, id) + [
    ee.link.license('https://creativecommons.org/licenses/by/4.0/'),
  ],

  keywords: [
    'alerts',
    'forest',
    'radar',
    //'sentinel-1',
  ],

  providers: [
    ee.producer_provider(
      'Wageningen University and Research',
      'https://www.wur.nl/en/research/products-services/radd-forest-disturbance-alert'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],

  extent: ee.extent_global(
    '2019-01-01T00:00:00Z',
    null
  ),

  summaries: {
    // Image properties accessed using image.get(...).
    'gee:schema': [
      {
        name: 'geography',
        description: |||
          Geographic region. Values are `ca` for Central America,
          `sa` for South America, `africa` for Africa, and `asia`
          for Asia and the Pacific.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'layer',
        description: |||
          Product layer. Filter this property for values containing
          `alert` to select forest disturbance alert images, or
          `forest_baseline` to select forest baseline images.
        |||,
        type: ee_const.var_type.string,
      },
    ],

    gsd: [10],

    // ================================================================
    // IMPORTANT NOTE:
    //
    // This ImageCollection contains both `alerts` and `forest_baseline`
    // images. These do not necessarily have identical band schemas.
    //
    // Current Earth Engine catalog guidance recommends homogeneous
    // ImageCollections. Please confirm with the Earth Engine Data team
    // whether the existing collection can be catalogued as-is or whether
    // the baseline and alert products should be represented separately.
    //
    // The eo:bands below describe the `alerts` layer.
    // ================================================================

    'eo:bands': [
      {
        name: 'Alert',
        description: |||
          Forest disturbance alert confidence.

          Value 2 represents an unconfirmed (low-confidence) forest
          disturbance alert.

          Value 3 represents a confirmed (high-confidence) forest
          disturbance alert.
        |||,
        'gee:classes': [
          {
            value: 2,
            color: '0000FF',
            description: 'Unconfirmed (low-confidence) forest disturbance alert',
          },
          {
            value: 3,
            color: 'FF7F50',
            description: 'Confirmed (high-confidence) forest disturbance alert',
          },
        ],
      },
      {
        name: 'Date',
        description: |||
          Forest disturbance alert date encoded as YYDOY, where YY is the
          two-digit year and DOY is the day of year. For example, 22121
          represents day 121 of 2022.
        |||,
      },
    ],

    Alert: {
      minimum: 2,
      maximum: 3,
      'gee:estimated_range': false,
    },

    'gee:visualizations': [
      {
        display_name: 'Forest disturbance alerts',
        lookat: {
          lat: 0,
          lon: 20,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [2],
            max: [3],
            palette: [
              '0000FF',
              'FF7F50',
            ],
            bands: ['Alert'],
          },
        },
      },
    ],
  },

  'sci:citation': |||
    Reiche, J., Mullissa, A., Slagter, B., Gou, Y., Tsendbazar, N.-E.,
    Odongo-Braun, C., Vollrath, A., Weisse, M. J., Stolle, F.,
    Pickens, A., Donchyts, G., Clinton, N., Gorelick, N., & Herold, M.
    (2021). Forest disturbance alerts for the Congo Basin using
    Sentinel-1. Environmental Research Letters, 16(2), 024005.
    https://doi.org/10.1088/1748-9326/abd0a8
  |||,

  'gee:terms_of_use': ee.gee_terms_of_use(license),
}