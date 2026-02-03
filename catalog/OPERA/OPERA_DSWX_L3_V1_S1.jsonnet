local id = 'OPERA/DSWX/L3_V1/S1';
local subdir = 'OPERA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  'gee:status': 'beta',
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Dynamic Surface Water Extent from Sentinel-1 (DSWx-S1) V1',
  version: 'V1',
  description: |||
    This dataset contains Level-3 Dynamic OPERA surface water extent from
    Sentinel-1 (DSWX-S1). DSWx-S1 provides near-global geographical
    mapping of surface water extent over land at a spatial resolution
    of 30 meters over the Military Grid reference System (MGRS) grid
    system, with a temporal revisit frequency between 6-12 days.
    Using Sentinel-1 radar observations, DSWx-S1 maps open inland water
    bodies greater than 3 hectares and 200 meters in width, irrespective
    of cloud conditions and daylight illumination that often pose
    challenges to optical sensors. Forward production of the DSWx-S1 data
    record began in Sept 2024.

    Documentation:

      * [DSWx-S1 Product Specification Document](https://archive.podaac.earthdata.nasa.gov/podaac-ops-cumulus-docs/web-misc/opera/D-108761_OPERA_DSWx_S1AB_ProductSpec_Rev_A.pdf)
      * [DSWx Product Suite Website](https://www.jpl.nasa.gov/go/opera/products/dswx-product-suite/)
      * [DSWx-S1 Algorithm Theoretical Basis Document](https://archive.podaac.earthdata.nasa.gov/podaac-ops-cumulus-docs/web-misc/opera/atbd/D-108763_Rev_A_OPERA_DSWx_S1_NI_ATBD_20240530_SIGNED.pdf)
  |||,
  'gee:type': ee_const.gee_type.image_collection,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/OPDSWS1-L3V1',
    },
   ],
  'gee:categories': ['surface-ground-water'],
  'keywords': [
    'geophysical', 'opera', 'nasa', 'surface', 'water', 'sentinel1_derived'
  ],
  providers: [
    ee.producer_provider('NASA JPL', 'https://www.jpl.nasa.gov/go/opera'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(
    -180, -84, 180, 84,
    '2024-08-01T00:00:00Z', null),
  'sci:doi': '10.5067/OPDSWS1-L3V1',
  'gee:terms_of_use': |||
    This dataset is openly shared, without restriction, in accordance with
    the [EOSDIS Data Use and Citation Guidance](https://www.earthdata.nasa.gov/engage/open-data-services-software-policies/data-use-guidance)
  |||,
  'sci:citation': |||
    OPERA . 2024. OPERA Dynamic Surface Water Extent from Sentinel-1 product
    (Version 1). Ver. 1.0. PO.DAAC, CA, USA. Dataset accessed [YYYY-MM-DD]
    at https://doi.org/10.5067/OPDSWS1-L3V1
  |||,
  summaries: {
    gsd: [30],
    'eo:bands': [
      {
        name: 'WTR_Water_classification',
        description: |||
          Masked interpreted water classification layer. This represents
          pixel-wise classification into one of three water
          classes (not water, open water and inundated vegetation), masks
          (HAND mask and layover/shadow mask), or no data
          classes.
        |||,
        'gee:classes': [
            {
              description: |||
                Not water - an area with valid data that is not open water
                (class 1), inundated vegetation (class 3), height above nearest
                drainage masked (class 250), or layover/shadow masked
                (class 251). Masking can result in “not water” (class 0) where
                land cover masking is applied.
              |||,
              color: 'ffffff',
              value: 0
            },
            {
              description: |||
                Open water - an area that is entirely water and unobstructed
                to the sensor, including obstructions by vegetation, terrain,
                and buildings.
              |||,
              color: '0000ff',
              value: 1,
            },
            {
              description: |||
                Inundated vegetation - an area that is considered inundated,
                extracted from the high value in dual polarization ratio
                and the wetland class in land cover map.
              |||,
              color: '66c2a5',
              value: 3,
            },
            {
              description: |||
                Height Above Nearest Drainage (HAND) masked - an area where
                topographic height is higher than the HAND threshold.
              |||,
              color: 'd3d3d3',
              value: 250,
            },
            {
              description: |||
                Layover/shadow masked - an area identified as layover or
                shadow computed from the geometry of the digital elevation
                model and sensor. The area is directly copied from input
                burst RTC-S1 products.
              |||,
              color: 'a9a9a9',
              value: 251,
            },
            {
              description: |||
                Ocean masked - an area identified as ocean using
                a shoreline database with an added margin.
              |||,
              color: '000080',
              value: 254,
            },
        ],
      },
      {
        name: 'BWTR_Binary_water',
        description: |||
          The binary water map is derived from the WTR layer as a union
          of water classes (open water and inundated vegetation) into a
          binary map indicating areas with and without water. Invalid
          data classes (HAND masked, layover/shadow masked and fill
          value) are also provided to indicate areas in which the binary
          classification does not provide water/not water classification.
        |||,
        'gee:classes': [
          {
            description: |||
              Not water - an area with valid data that is not water
              (class 1) and not HAND masked (class 252), layover or
              shadow (class 253)
            |||,
            color: 'ffffff',
            value: 0,
          },
          {
            description: |||
              water - an area classified as "open water" or
              "inundated vegetation" (see WTR layer).
            |||,
            color: '0000ff',
            value: 1,
          },
          {
            description: |||
              Height Above Nearest Drainage (HAND) masked - an area where
              topographic height is higher than the HAND threshold.
            |||,
            color: 'd3d3d3',
            value: 250,
          },
          {
            description: |||
              Layover/shadow masked - an area identified as layover or
              shadow computed from the geometry of the digital elevation
              model and sensor. The area is directly copied from input
              burst RTC-S1 products.
            |||,
            color: 'a9a9a9',
            value: 251,
          },
        ],
      },
      {
        name: 'CONF_Confidence',
        description: |||
          A representation of the confidence associated with the WTR
          classification that is based on DIAG results. For example,
          the Open water class of the WTR layer is split into two
          classes: High Confidence and Moderate Confidence.
          Additionally, this layer includes areas characterized by low
          backscattering that are not water: Low-backscattering not water
          and land cover masked. Detailed explanations of these
          classifications are outlined in the
          [DSWx-S1 ATBD](https://archive.podaac.earthdata.nasa.gov/podaac-ops-cumulus-docs/web-misc/opera/atbd/D-108763_Rev_A_OPERA_DSWx_S1_NI_ATBD_20240530_SIGNED.pdf).
          Similar to the WTR and BWTR
          layers, the Confidence (CONF) layer also marks pixels where water
          detection is challenging or unfeasible due to factors like
          layover/shadow effects, no-data areas, and regions where water
          presence is hydrologically unrealistic (identified by HAND mask).
        |||,
        'gee:classes': [
          {
            description: |||
              Not water - an area with valid data that is not open water
              high-confidence (class 1), open water moderate-confidence
              (class 2), inundated vegetation (class 3), low-backscattering
              not water estimated from bimodality test(class 5),
              low-backscattering not water estimated from ancillary mask
              (class 6), height above nearest drainage masked (class 250),
              or layover/shadow masked (class 251).
            |||,
            color: 'ffffff',
            value: 0,
          },
          {
            description: |||
              Open water high-confidence - an area that is entirely water
              and unobstructed to the sensor, including obstructions by
              vegetation, terrain, and buildings and is not overlapping
              with wetland areas in the Input land cover map.
            |||,
            color: '0000ff',
            value: 1,
          },
          {
            description: |||
              Open water moderate-confidence - an area with higher
              backscattering than initial thresholds, considered as water
              due to the unimodal distribution with surrounding water pixels
              and not overlapping with wetland areas in the Input land cover
              map.
            |||,
            color: '0088ff',
            value: 2,
          },
          {
            description: |||
              Potential inundated vegetation - an area with a high dual
              polarization ratio that is not overlapping with wetland areas
              in the input land cover map.
            |||,
            color: '66c2a5',
            value: 5,
          },
          {
            description: |||
              Low-backscattering not water (bimodality test) - an area with
              lower backscattering than thresholds, not considered water
              based on the bimodality test, and not overlapping with wetland
              areas in the input land cover map.
            |||,
            color: 'e0e0e0',
            value: 6,
          },
          {
            description: |||
              Low-backscattering not water (ancillary mask) - an area
              with lower backscattering than the threshold, considered not
              water based on historical records of water extents,
              backscattering level, slope angle, and land cover classes,
              and not overlapping with wetland areas in the input land
              cover map.
            |||,
            color: 'cccccc',
            value: 7,
          },
          {
            description: |||
              Not water - an area with valid data that is not open water
              high-confidence (class 31), open water moderate-confidence
              (class 32), inundated vegetation (class 35), low-backscattering
              not water estimated from bimodality test(class 36),
              lowbackscattering not water estimated from ancillary mask
              (class 37), height above nearest drainage masked (class 250),
              or layover/shadow masked (class 251) and overlap with wetland
              areas in the Input land cover map.
            |||,
            color: 'aaaaaa',
            value: 30,
          },
          {
            description: |||
              Open water high-confidence - an area entirely composed of
              water, unobstructed to the sensor by vegetation, terrain, or
              buildings, and overlapping with wetland areas in the input
              land cover map.
            |||,
            color: '0040ff',
            value: 31,
          },
          {
            description: |||
              Open water moderate-confidence - an area with higher
              backscattering than initial thresholds, considered water
              due to its unimodal distribution with surrounding water
              pixels, and overlapping with wetland areas in the input
              land cover map
            |||,
            color: '4080ff',
            value: 32,
          },
          {
            description: |||
              Inundated vegetation - an area considered inundated due
              to a high value in dual polarization ratio and overlapping with
              wetland areas in the input land cover map.
            |||,
            color: '20b2aa',
            value: 35,
          },
          {
            description: |||
              Low-backscattering not water (bimodality test) - an area with
              lower backscattering than thresholds, not considered water
              based on the bimodality test, and overlapping with wetland
              areas in the input land cover map.
            |||,
            color: 'bbbbbb',
            value: 36,
          },
          {
            description: |||
              Low-backscattering not water (ancillary mask) - an area with
              lower backscattering than the threshold, considered not water
              based on historical records of water extents, backscattering
              level, slope angle, and land cover classes, and overlapping
              with wetland areas in the input land cover map.
            |||,
            color: '888888',
            value: 37,
          },
          {
            description: |||
              Height Above Nearest Drainage (HAND) masked - an area
              where topographic height is higher than the HAND threshold.
            |||,
            color: 'd3d3d3',
            value: 250,
          },
          {
            description: |||
              Layover/shadow masked - an area identified as layover
              or shadow computed from the geometry of the digital
              elevation model and sensor. The area is directly
              copied from input burst RTC products.
            |||,
            color: 'a9a9a9',
            value: 251,
          },
        ],
      },
      {
        name: 'DIAG_diagnostic',
        description: |||
          A metric of Fuzzy values is computed using ancillary
          data, including HAND, terrain slope angle, reference water,
          and RTC-S1 backscattering, applying specific thresholds.
          These values fall within a range of 0 to 100, where a higher
          value signifies a greater likelihood of the presence of open water.
        |||,
        'gee:classes': [
          {
            description: |||
              Fuzzy value associated with the WTR classification that
              is computed from backscattering intensity, reference water,
              slope angle, and HAND values.  (Values 0 to 100)
            |||,
            color: 'bb0000',
            value: 0,
          },
          {
            description: |||
              Height Above Nearest Drainage (HAND) masked - an area where
              topographic height is higher than the HAND threshold.
            |||,
            color: 'd3d3d3',
            value: 252,
          },
          {
            description: |||
              Layover/shadow masked - an area identified as layover or
              shadow computed from the geometry of the digital elevation
              model and sensor. The area is directly copied from input
              burst RTC-S1 products.
            |||,
            color: 'a9a9a9',
            value: 253,
          },
        ],
      },
    ],
    'gee:schema': [
      {
        name: 'DSWX_PRODUCT_VERSION',
        description: 'The DSWx-S1 product version',
        type: ee_const.var_type.string,
      },
      {
        name: 'LAYOVER_SHADOW_COVERAGE',
        description: |||
          The percentage of layover and shadow in the DSWx-S1
          product based on OPERA RTC-S1 product.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'POLARIZATION',
        description: 'Polarizations (e.g. VV, VH)',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROCESSING_DATETIME',
        description: |||
          DSWx-S1 product processing date. Format: YYYY-MM-DDTHH:MM:SSZ.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'RTC_ORBIT_PASS_DIRECTION',
        description: 'Orbit direction (e.g. Ascending or Descending).',
        type: ee_const.var_type.string,
      },
      {
        name: 'RTC_PRODUCT_VERSION',
        description: 'The version of OPERA RTC algorithm used for RTC products.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SENSOR',
        description: 'Name of the sensor instrument (e.g., "IW")',
        type: ee_const.var_type.string,
      },
      {
        name: 'SPACECRAFT_NAME',
        description: 'Name of the sensor platform (e.g., Sentinel-1A/B)',
        type: ee_const.var_type.string,
      },
      {
        name: 'SPATIAL_COVERAGE',
        description: 'The area percentage of the tile with data.',
        type: ee_const.var_type.double,
      }
    ],
    'gee:visualizations': [
      {
        display_name: 'Surface Water',
        lookat: {
          lat: 30,
          lon: -93,
          zoom: 12,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              3,
            ],
            palette: [
              'white',
              'blue',
              'cyan',
              'black'
            ],
            bands: [
              'WTR_Water_classification',
            ],
          },
        },
      },
    ],
  }
}
