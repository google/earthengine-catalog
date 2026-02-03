local id = 'OPERA/DSWX/L3_V1/HLS';
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
  title: 'Dynamic Surface Water Extent from Harmonized Landsat Sentinel-2 (DSWx-HLS) V1',
  version: 'V1',
  description: |||
    This dataset contains Level-3 Dynamic OPERA surface water extent product
    version 1. The data are validated surface water extent observations
    beginning April 2023. Known issues and caveats on usage are described
    in the product documentation. The input dataset for generating each product is
    the Harmonized Landsat-8 and Sentinel-2A/B/C (HLS) product version 2.0.
    HLS products provide surface reflectance (SR) data from the
    Operational Land Imager (OLI) aboard the Landsat 8 satellite and the
    MultiSpectral Instrument (MSI) aboard the Sentinel-2A/B/C satellite.

    Documentation:

      * [DSWx-HLS Product Specification Document](https://d2pn8kiwq2w21t.cloudfront.net/documents/OPERA_DSWx-HLS_ProductSpec_v1.0.0_D-107395_RevB.pdf)
      * [DSWx Product Suite Website](https://www.jpl.nasa.gov/go/opera/products/dswx-product-suite/)
      * [DSWx-HLS Algorithm Theoretical Basis Document (ATBD)](https://archive.podaac.earthdata.nasa.gov/podaac-ops-cumulus-docs/web-misc/opera/atbd/DSWx-HLS_ATBD_V1_4_DAAC_Distribution.pdf)
  |||,
  'gee:type': ee_const.gee_type.image_collection,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/OPDSW-PL3V1',
    },
   ],
  'gee:categories': ['surface-ground-water'],
  'keywords': [
    'geophysical', 'opera', 'nasa', 'surface', 'water',
    'landsat_derived', 'sentinel2_derived'
  ],
  providers: [
    ee.producer_provider('NASA JPL', 'https://www.jpl.nasa.gov/go/opera'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(
    -180, -84, 180, 84,
    '2023-04-04T04:37:01Z', null),
  'sci:doi': '10.5067/OPDSW-PL3V1',
  'gee:terms_of_use': |||
    This dataset is openly shared, without restriction, in accordance with
    the [EOSDIS Data Use and Citation Guidance](https://www.earthdata.nasa.gov/engage/open-data-services-software-policies/data-use-guidance)
  |||,
  'sci:citation': |||
    OPERA . 2023. OPERA Dynamic Surface Water Extent from Harmonized Landsat
    Sentinel-2 (Version 1). Ver. 1.0. PO.DAAC, CA, USA. Dataset accessed
    [YYYY-MM-DD] at https://doi.org/10.5067/OPDSW-PL3V1
  |||,
  summaries: {
    gsd: [30],
    'eo:bands': [
      {
        name: 'WTR_Water_classification',
        description: |||
          Water Classification - This represents pixel-wise classification
          into one of three water classes (not water, open water, and
          partial surface water), snow/ice, cloud/cloud shadow and
          adjacent to cloud/cloud shadow, ocean masked, or no data
          classes as a result of processing the diagnostic
          (DIAG) layer through all intermediate steps/layers
        |||,
        'gee:classes': [
            {
              description: |||
                Not water - An area with valid reflectance data that is
                not water, snow/ice, cloud/cloud shadow, or ocean mask,
                a landcover masked may be applied.
              |||,
              color: 'ffffff',
              value: 0
            },
            {
              description: |||
                Open water - an area that is entirely water and unobstructed to
                the sensor, including obstructions by vegetation, terrain, and
                buildings.
              |||,
              color: '0000ff',
              value: 1,
            },
            {
              description: |||
                Partial surface water - an inundated area that is at least 20%
                and less than 100% open water. This may be referred to as
                "subpixel inundation" when referring to a pixel’s area.
                Examples include wetlands, water bodies with
                emergent vegetation, and pixels bisected by coastlines.
              |||,
              color: '0088ff',
              value: 2,
            },
            {
              description: |||
                Snow/ice - an area identified as snow/ice according to input
                HLS Fmask quality assurance (QA) data.
              |||,
              color: 'f2f2f2',
              value: 252,
            },
            {
              description: |||
                Cloud/cloud shadow - an area identified as cloud, cloud shadow,
                or adjacent to those features according to input HLS Fmask
                quality assurance (QA) data.
              |||,
              color: 'dfdfdf',
              value: 253,
            },
            {
              description: |||
                Ocean masked - an area identified as ocean using
                a shoreline database with an added margin.
              |||,
              color: 'da00ff',
              value: 254,
            }
        ],
      },
      {
        name: 'BWTR_Binary_water',
        description: |||
          The binary water map is derived from the WTR layer as a union of
          water classes (open water and partial surface water) into a
          binary map indicating areas with and without water. This layer
          is meant to provide users with a quick view for water/no-water.
          Invalid data classes (snow/ice, cloud/cloud shadow along with
          adjacent to cloud/cloud shadow, ocean masked, and fill value)
          are also provided to indicate areas in which the binary
          classification does not provide water/no-water classification.
        |||,
        'gee:classes': [
          {
            description: |||
              Not water - an area with valid reflectance data that is not
              water (class 1) and not snow/ice (class 252),
              cloud/cloud shadow (class 253), or ocean masked (class 254).
            |||,
            color: 'ffffff',
            value: 0,
          },
          {
            description: |||
              Water - an area classified as "open water" or
              "partial surface water" (see WTR layer).
            |||,
            color: '0000ff',
            value: 1,
          },
          {
            description: |||
              Snow/ice - an area identified as snow/ice according to
              input HLS Fmask quality assurance (QA) data.
            |||,
            color: 'f2f2f2',
            value: 252,
          },
          {
            description: |||
              Cloud/cloud shadow - an area identified as
              cloud or cloud shadow or adjacent to cloud/cloud shadow
              according to input HLS Fmask quality assurance (QA) data.
            |||,
            color: 'dfdfdf',
            value: 253,
          },
          {
            description: |||
              Ocean masked - an area identified as ocean using a
              shoreline database with an added margin
            |||,
            color: 'da00ff',
            value: 254,
          },
        ],
      },
      {
        name: 'CONF_Confidence',
        description: |||
          A representation of the confidence associated with the WTR
          classification that is based on a combination of DIAG results
          and quality assurance information provided with the input HLS
          data. For example, the Open water class of the WTR layer is
          split into two classes: High Confidence and Moderate Confidence
          while WTR Partial surface water class pixels of WTR are flagged
          as either partial surface water conservative or partial surface
          water aggressive, with the latter exhibiting less certainty.
          As in the WTR and BWTR layers, pixels for which water
          retrievals are difficult or impossible due to snow/ice,
          cloud/shadow, or fill values are also noted in the CONF layer.
        |||,
        'gee:classes': [
          {
            description: |||
              Not water - an area with valid reflectance data that is not
              water or ocean masked (class 254) and is not identified as
              snow/ice, cloud/cloud shadow, adjacent to cloud/cloud shadow,
              or snow/ice in the input HLS Fmask quality assurance (QA) data.
              "not water" (class 0) also exists where terrain shadow and/or
              land cover masking is applied.
            |||,
            color: 'ffffff',
            value: 0,
          },
          {
            description: |||
              Open water high-confidence - an area that is entirely
              water with high-confidence that has not also been ocean masked
              (class 254) and is not identified as snow/ice, cloud/cloud shadow,
              adjacent to cloud/cloud shadow, or snow/ice in the input HLS Fmask
              quality assurance (QA) data.
            |||,
            color: '0000ff',
            value: 1,
          },
          {
            description: |||
              Open water moderate-confidence - an area that is entirely water
              with moderate-confidence that has not also been ocean masked
              (class 254) and is not identified as snow/ice, or cloud/cloud shadow,
              adjacent to cloud/cloud shadow, or snow/ice in the input HLS
              Fmask quality assurance (QA) data.
            |||,
            color: '0088ff',
            value: 2,
          },
          {
            description: |||
              Partial surface water conservative - an inundated area that is
              at least approximately 50% and less than 100% open water with
              a conservative classification that has not also been ocean masked
              (class 254) and is not identified as snow/ice, cloud/cloud shadow'
            |||,
            color: '66a3ff',
            value: 3,
          },
          {
            description: |||
              Partial surface water aggressive - an inundated area that is at
              least approximately 20% and less than 100% open water with an
              aggressive classification that has not also been ocean masked
              (class 254) and is not identified as snow/ice, cloud/cloud shadow
            |||,
            color: 'b3d9ff',
            value: 4,
          },
          {
            description: |||
              Not water - an area with valid reflectance data that is not water
              or ocean masked (class 254) but is potentially obstructed by
              cloud/cloud shadow according to the input HLS Fmask
            |||,
            color: 'cccccc',
            value: 10,
          },
          {
            description: |||
              Open water high-confidence - an area that is entirely water
              with high-confidence that has not also been ocean masked
              (class 254) but is potentially obstructed by cloud/cloud
              shadow according to the input HLS Fmask.
            |||,
            color: '0000ff',
            value: 11,
          },
          {
            description: |||
              Open water moderate-confidence - an area that is entirely
              water with moderate-confidence that has not also been ocean
              masked (class 254) but is potentially obstructed by cloud/cloud
              shadow according to the input HLS Fmask.
            |||,
            color: '00aaff',
            value: 12,
          },
          {
            description: |||
               Partial surface water conservative - an inundated area that is
               at least approximately 50% and less than 100% open water
               with a conservative classification that has not also been
               ocean masked (class 254) but is potentially obstructed by
               cloud/cloud shadow according to the input HLS Fmask.
            |||,
            color: '2244ff',
            value: 13,
          },
          {
            description: |||
              Partial surface water aggressive - an inundated area that is at
              least 20% and less than approximately 50% open water and
              less than 100% open water with a less strict classification that
              has not also been ocean masked (class 254) but is potentially
              obstructed by cloud/cloud shadow according to the input HLS 
              Fmask.
            |||,
            color: '6644ff',
            value: 14,
          },
          {
            description: |||
              Not water - an area with valid reflectance data that is not
              water, that is marked as snow/ice according to the input HLS
              Fmask, but not obstructed by cloud/cloud shadow according to
              the input HLS Fmask and is not ocean masked (class 254). "not
              water" (class 0) also exists where terrain shadow and/or land
              cover masking is applied.
            |||,
            color: 'ffffff',
            value: 20,
          },
          {
            description: |||
              Open water high-confidence - an area that is entirely water
              with high-confidence and that is marked as snow/ice according
              to the input HLS Fmask, but not obstructed by cloud/cloud
              shadow according to the input HLS Fmask and is not ocean masked
              (class 254)
            |||,
            color: '0000ff',
            value: 21,
          },
          {
            description: |||
              Open water moderate-confidence - an area that is entirely
              water with moderate-confidence and that is marked as snow/ice
              according to the input HLS Fmask, but not obstructed by
              cloud/cloud shadow according to the input HLS Fmask and is not
              ocean masked (class 254).
            |||,
            color: '5555ff',
            value: 22,
          },
          {
            description: |||
              Partial surface water conservative - an inundated area that
              is at least 50% and less than 100% open water with a
              conservative classification and that is marked as snow/ice
              according to the input HLS Fmask, but not obstructed by
              cloud/cloud shadow according to the input HLS Fmask and
              is not ocean masked (class 254).
            |||,
            color: '7777ff',
            value: 23,
          },
          {
            description: |||
              Partial surface water aggressive - an inundated area
              that is at least 20% and less than approximately 50%
              open water, that is a less strict classification and
              that is marked as snow/ice according to the input HLS
              Fmask, but not obstructed by cloud/cloud shadow
              according to the input HLS Fmask and is not ocean
              masked (class 254).
            |||,
            color: '2222cc',
            value: 24,
          },
          {
            description: |||
              Ocean masked - an area identified as ocean using a
              shoreline database with an added margin.
            |||,
            color: 'da00ff',
            value: 254,
          },
        ],
      },
      {
        name: 'DIAG_diagnostic',
        description: |||
          A layer coded to indicate which of five initial DSWx-HLS tests
          were positive for water detection on a per-pixel basis. Values
          range from 0 (i.e, 00000), indicating that none of the five
          DSWx-HLS tests returned a positive result, to 11111, denoting
          that all tests resulted positive. The tests are described in
          [DSWX-HLS ATBD](https://archive.podaac.earthdata.nasa.gov/podaac-ops-cumulus-docs/web-misc/opera/atbd/DSWx-HLS_ATBD_V1_4_DAAC_Distribution.pdf)
          and [Jones, John W. 2019](https://doi.org/10.3390/rs11040374)
          are used to derive the confidence layer above. The
          combination of positive tests for a particular class determines
          its confidence value. The Fill value (no data) is represented
          by the number 65535.
        |||,
      },
      {
        name: 'WTR1_Interpretation_of_diagnostic_layer_into_water_classes',
        description: |||
          Classification of the DIAG layer results in open water, partial
          surface water, and no-water. This layer is further refined
          through the application of masks resulting in Layers 6 (WTR-2)
          and 1 (WTR).
        |||,
        'gee:classes': [
          {
            description: |||
              Not water - an area with valid reflectance data that is
              not open water (class 1) or partial surface water (class 2).
            |||,
            color: 'ffffff',
            value: 0,
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
              Partial surface water - an inundated area that is at least
              20% and less than 100% open water. This may be referred to as
              "subpixel inundation" when referring to a pixel's area. Examples
              include wetlands, water bodies with emergent vegetation, and
              pixels bisected by coastlines.
            |||,
            color: '0088ff',
            value: 2,
          },
          {
            description: |||
              Ocean masked - an area identified as ocean using a shoreline
              database with an added margin (not applicable for the standard
              DSWx-HLS product v1.0).
            |||,
            color: 'da00ff',
            value: 254,
          },
        ],
      },
      {
        name: 'WTR2_Refined_WTR1_given_HLS_FMASK',
        description: |||
          The WTR-2 layer is derived from the WTR-1 (Layer 5) outcome by
          applying additional tests based on land cover and terrain shadow
          information, and aerosol overcorrection mitigation, as described
          in [DSWX-HLS ATBD](https://archive.podaac.earthdata.nasa.gov/podaac-ops-cumulus-docs/web-misc/opera/atbd/DSWx-HLS_ATBD_V1_4_DAAC_Distribution.pdf)
          and [Jones, John W. 2019](https://doi.org/10.3390/rs11040374)
          to mask (eliminate) false-positive water detections.
        |||,
        'gee:classes': [
          {
            description: |||
              Not water - an area with valid reflectance data that is not
              open water (class 1) or partial surface water (class 2)
            |||,
            color: 'ffffff',
            value: 0,
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
              Partial surface water - an inundated area that is at least 20%
              and less than 100% open water. This may be referred to as
              "subpixel inundation" when referring to a pixel's area.
              Examples include wetlands, water bodies with emergent vegetation,
              and pixels bisected by coastlines.
            |||,
            color: '0088ff',
            value: 2,
          },
          {
            description: |||
              Ocean masked - an area identified as ocean using a shoreline
              database with an added margin.
            |||,
            color: 'da00ff',
            value: 254,
          },
        ],
      },
      {
        name: 'LAND_land_cover_classification',
        description: |||
          Land cover thematic layer used to determine where additional
          testing is performed to potentially mask WTR-1 layer water
          detections to produce the intermediate WTR-2 layer.
        |||,
        'gee:classes': [
          {
            description: |||
              Low intensity developed. Values range from 0 to 99
              (number = last two digits of ESA WorldCover dataset year)
            |||,
            color: 'e6e6e6',
            value: 0,
          },
          {
            description: |||
              High intensity developed. Values range from 100 to 199. 
              (number = 100 + last two digits of ESA WorldCover dataset year)
            |||,
            color: 'cccccc',
            value: 100,
          },
          {
            description: 'Water, wetland, mangrove forest',
            color: '0000ff',
            value: 200,
          },
          {
            description: 'A variety of forest classes',
            color: '00ff00',
            value: 201,
          },
        ],
      },
      {
        name: 'SHAD_terrain_shadow',
        description: |||
          Mask used to eliminate likely locations of terrain-induced shadow
          based on a classification of shadow areas generated for the capture
          date/time of the input HLS image from Digital Elevation Model
          data. This is used in the creation of the intermediate layer
          WTR-2.
        |||,
        'gee:classes': [
          {
            description: 'Shadow',
            color: '808080',
            value: 0,
          },
          {
            description: 'Not shadow',
            color: 'ffffff',
            value: 1,
          },
        ],
      },
      {
        name: 'HLS_CLOUD_SNOW_FMASK_classification',
        description: |||
          Cloud, cloud-shadow, and snow/ice classification layer from HLS input.
        |||,
        'gee:classes': [
          {
            description: 'Not masked',
            color: 'ffffff',
            value: 0
          },
          {
            description: |||
              Cloud shadow, adjacent to cloud/cloud shadow, or both
            |||,
            color: 'a9a9a9',
            value: 1
          },
          {
            description: 'Snow/ice',
            color: 'f2f2f2',
            value: 2
          },
          {
            description: |||
              Snow/ice and class 1 (cloud shadow or adjacent
              to cloud/cloud shadow)
            |||,
            color: 'd3d3d3',
            value: 3
          },
          {
            description: 'Cloud',
            color: 'dfdfdf',
            value: 4 
          },
          {
            description: |||
              Cloud and class 1 (cloud shadow or adjacent to
              cloud/cloud shadow)
            |||,
            color: 'c0c0c0',
            value: 5
          },
          {
            description: 'Cloud and snow/ice',
            color: 'b0b0b0',
            value: 6
          },
          {
            description: |||
              Cloud, snow/ice, and class 1 (cloud shadow or adjacent
              to cloud/cloud shadow)
            |||,
            color: 'a0a0a0',
            value: 7
          },
          {
            description: 'Fmask identified water',
            color: '0000ff',
            value: 8
          },
          {
            description: |||
              Fmask identified water, cloud shadow or
              adjacent to cloud/cloud shadow'
            |||,
            color: '87cefa',
            value: 9
          },
          {
            description: 'Fmask identified water, snow/ice',
            color: 'add8e6',
            value: 10 
          },
          {
            description: |||
              Fmask identified water, snow/ice and class 1
              (cloud shadow or adjacent to cloud/cloud shadow)
            |||,
            color: 'b0e0e6',
            value: 11
          },
          {
            description: 'Fmask identified water, cloud',
            color: '6495ed',
            value: 12
          },
          {
            description: |||
              Fmask identified water, cloud and class 1 (cloud shadow
              or adjacent to cloud/cloud shadow)
            |||,
            color: '4682b4',
            value: 13
          },
          {
            description: 'Fmask identified water, cloud and snow/ice',
            color: '4169e1',
            value: 14
          },
          {
            description: |||
              Fmask identified water, cloud, snow/ice, and
              class 1 (cloud shadow or adjacent to cloud/cloud shadow)
            |||,
            color: '1e90ff',
            value: 15
          },
        ],
      },
    ],
    'gee:schema': [
      {
        name: 'AEROSOL_CLASS_REMAPPING_ENABLED',
        description: |||
          Indicates if the aerosol class remapping is enabled (TRUE)
          or disabled (FALSE).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'CLOUD_COVERAGE',
        description: |||
          The percentage of pixels with observational data (as opposed
          to fill value and ocean masked) that HLS QA mask marks as
          cloud, cloud shadow, or adjacent-to-cloud.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'INPUT_HLS_PRODUCT_CLOUD_COVERAGE',
        description: |||
          The percentage of the tile area with observational data
          (as opposed to fill value) in the input HLS product.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'NBAR_SOLAR_ZENITH',
        description: |||
           The solar zenith angle used in Nadir Bidirectional
           Reflectance Distribution Function Adjusted Reflectance
           (NBAR) derivation.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'PROCESSING_DATETIME',
        description: |||
          DSWx-HLS product processing date. Format: YYYY-MM-DDTHH:MM:SSZ.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'PRODUCT_VERSION',
        description: |||
          The DSWx-HLS product version (same as in the product filename).
          It increments with changes to the structure and/or metadata
          contained within the product.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SENSOR',
        description: 'Name of the sensor instrument (e.g., "OLI" or "MSI")',
        type: ee_const.var_type.string,
      },
      {
        name: 'SPACECRAFT_NAME',
        description: |||
           Name of the sensor platform (e.g., "Landsat-8", "Sentinel-2A",
           or "Sentinel-2B")
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SPATIAL_COVERAGE_EXCLUDING_MASKED_OCEAN',
        description: |||
          The percentage of the tile area with observational data (as
          opposed to fill value and ocean masked) excluding masked ocean.
        |||,
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
