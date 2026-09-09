local id = 'OPERA/DIST/L3_DIST-ANN-HLS/V1';
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
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'OPERA Land Surface Disturbance Annual from Harmonized Landsat Sentinel-2 (DIST-ANN-HLS) V1',
  version: 'V1',
  description: |||
    The Observational Products for End-Users from Remote Sensing Analysis (OPERA)
    Land Surface Disturbance Annual from Harmonized Landsat Sentinel-2 (DIST-ANN-HLS)
    product Version 1 summarizes the DIST-ALERT data product into an annual vegetation
    disturbance data product.

    The DIST-ANN-HLS product provides annual metrics and classifications of
    vegetation disturbance detected from Harmonized Landsat-8/9 and Sentinel-2A/B
    (HLS) surface reflectance data at 30-meter resolution. Disturbances include abrupt
    events such as wildfire, logging, and clearing, as well as ongoing or longer-term
    changes. The product includes both vegetation-specific disturbance metrics (VEG)
    and generic disturbance metrics (GEN) across 21 raster layers.

    Documentation:

      * [DIST Product Suite Website](https://www.jpl.nasa.gov/go/opera/products/dist-product-suite/)
      * [OPERA DIST-HLS Product Specification Document](https://lpdaac.usgs.gov/documents/1766/OPERA_DIST_HLS_Product_Specification_V1.pdf)
      * [OPERA DIST-HLS Algorithm Theoretical Basis Document](https://lpdaac.usgs.gov/documents/1835/OPERA_DIST_ATBD__V1.pdf)
      * [NASA Earthdata Search](https://search.earthdata.nasa.gov/search/granules?p=C2519119034-LPCLOUD)
  |||,
  'gee:type': ee_const.gee_type.image_collection,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/SNWG/OPERA_L3_DIST-ANN-HLS_V1.001',
    },
  ],
  'gee:categories': ['forest-biomass'],
  keywords: [
    'disturbance',
    'forest',
    'geophysical',
    'landsat_derived',
    'nasa',
    'opera',
    'sentinel2_derived',
    'vegetation',
  ],
  providers: [
    ee.producer_provider('NASA JPL', 'https://www.jpl.nasa.gov/go/opera'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(
    -180.0, -84.0, 180.0, 84.0,
    '2023-01-01T00:00:00Z', null),
  'sci:doi': '10.5067/SNWG/OPERA_L3_DIST-ANN-HLS_V1.001',
  'gee:terms_of_use': |||
    This dataset is openly shared, without restriction, in accordance with
    the [EOSDIS Data Use and Citation Guidance](https://www.earthdata.nasa.gov/engage/open-data-services-software-policies/data-use-guidance)
  |||,
  'sci:citation': |||
    Hansen, M. (2024). OPERA Land Surface Disturbance Annual from Harmonized Landsat
    Sentinel-2 product (Version 1) [Dataset]. NASA Land Processes Distributed Active
    Archive Center. https://doi.org/10.5067/SNWG/OPERA_L3_DIST-ANN-HLS_V1.001
  |||,
  summaries: {
    gsd: [30],
    'eo:bands': [
      {
        name: 'VEG-DIST-STATUS',
        description: |||
          Status of vegetation disturbance within the calendar year.
        |||,
        'gee:classes': [
          {
            description: 'No disturbance detected',
            color: '2e7d32',
            value: 0,
          },
          {
            description: 'Confirmed <50% ongoing disturbance',
            color: 'ffeb3b',
            value: 3,
          },
          {
            description: 'Confirmed >=50% ongoing disturbance',
            color: 'f44336',
            value: 6,
          },
          {
            description: 'Confirmed <50% finished disturbance',
            color: 'ff9800',
            value: 7,
          },
          {
            description: 'Confirmed >=50% finished disturbance',
            color: 'b71c1c',
            value: 8,
          },
          {
            description: 'Confirmed <50% disturbance from previous year',
            color: 'd7ccc8',
            value: 9,
          },
          {
            description: 'Confirmed >=50% disturbance from previous year',
            color: '8d6e63',
            value: 10,
          },
        ],
      },
      {
        name: 'VEG-ANOM-MAX',
        description: 'Maximum vegetation loss anomaly observed during the year.',
        'gee:units': units.percent,
      },
      {
        name: 'VEG-DIST-DATE',
        description: |||
          Day of initial vegetation disturbance detection, denoted as the number of days
          since December 31, 2020.
          Fill value: -1.
        |||,
        'gee:units': units.day,
      },
      {
        name: 'VEG-DIST-DUR',
        description: |||
          Duration of ongoing vegetation loss anomalies in days.
          Fill value: -1.
        |||,
        'gee:units': units.day,
      },
      {
        name: 'VEG-DIST-CONF',
        description: |||
          Confidence level of vegetation disturbance detection.
          Fill value: -1.
        |||,
      },
      {
        name: 'VEG-DIST-COUNT',
        description: |||
          Count of observations with detected vegetation loss during the calendar year.
        |||,
        'gee:units': units.count,
      },
      {
        name: 'VEG-CONF-PREV',
        description: |||
          Vegetation loss alert from previous year confirmed in current year.
        |||,
        'gee:classes': [
          {
            description: 'No disturbance',
            color: '121212',
            value: 0,
          },
          {
            description: 'Confirmed low previous year',
            color: 'd7ccc8',
            value: 1,
          },
          {
            description: 'Confirmed high previous year',
            color: '8d6e63',
            value: 2,
          },
        ],
      },
      {
        name: 'VEG-CONF-COUNT',
        description: |||
          Count of separate vegetation disturbance alerts during the calendar year.
        |||,
        'gee:units': units.count,
      },
      {
        name: 'VEG-LAST-DATE',
        description: |||
          Day of last observation for vegetation disturbance monitoring, denoted as the
          number of days since December 31, 2020.
          Fill value: -1.
        |||,
        'gee:units': units.day,
      },
      {
        name: 'VEG-HIST',
        description: |||
          Vegetation cover percent of baseline at time of maximum anomaly (0-100%, 200 = no disturbance).
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'VEG-IND-MAX',
        description: |||
          Maximum vegetation cover indicator, representing estimated percent vegetation cover (0-100%).
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'VEG-IND-3YR-MIN',
        description: |||
          Minimum vegetation index percent over 3-year historical baseline.
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'GEN-DIST-STATUS',
        description: |||
          Status of generic spectral disturbance within the calendar year.
        |||,
        'gee:classes': [
          {
            description: 'No disturbance detected',
            color: '2e7d32',
            value: 0,
          },
          {
            description: 'Confirmed <50% ongoing disturbance',
            color: 'ffeb3b',
            value: 3,
          },
          {
            description: 'Confirmed >=50% ongoing disturbance',
            color: 'f44336',
            value: 6,
          },
          {
            description: 'Confirmed <50% finished disturbance',
            color: 'ff9800',
            value: 7,
          },
          {
            description: 'Confirmed >=50% finished disturbance',
            color: 'b71c1c',
            value: 8,
          },
          {
            description: 'Confirmed <50% disturbance from previous year',
            color: 'd7ccc8',
            value: 9,
          },
          {
            description: 'Confirmed >=50% disturbance from previous year',
            color: '8d6e63',
            value: 10,
          },
        ],
      },
      {
        name: 'GEN-ANOM-MAX',
        description: |||
          Maximum generic spectral anomaly observed during the year.
          Fill value: -1.
        |||,
      },
      {
        name: 'GEN-DIST-DATE',
        description: |||
          Day of initial generic disturbance detection, denoted as the number of days
          since December 31, 2020.
          Fill value: -1.
        |||,
        'gee:units': units.day,
      },
      {
        name: 'GEN-DIST-DUR',
        description: |||
          Duration of ongoing generic disturbance anomalies in days.
          Fill value: -1.
        |||,
        'gee:units': units.day,
      },
      {
        name: 'GEN-DIST-CONF',
        description: |||
          Confidence level of generic disturbance detection.
          Fill value: -1.
        |||,
      },
      {
        name: 'GEN-DIST-COUNT',
        description: |||
          Count of observations with detected generic disturbance during the calendar year.
        |||,
        'gee:units': units.count,
      },
      {
        name: 'GEN-CONF-PREV',
        description: |||
          Generic disturbance alert from previous year confirmed in current year.
        |||,
        'gee:classes': [
          {
            description: 'No disturbance',
            color: '121212',
            value: 0,
          },
          {
            description: 'Confirmed low previous year',
            color: 'd7ccc8',
            value: 1,
          },
          {
            description: 'Confirmed high previous year',
            color: '8d6e63',
            value: 2,
          },
        ],
      },
      {
        name: 'GEN-CONF-COUNT',
        description: |||
          Count of separate generic disturbance alerts during the calendar year.
        |||,
        'gee:units': units.count,
      },
      {
        name: 'GEN-LAST-DATE',
        description: |||
          Day of last observation for generic disturbance monitoring, denoted as the number
          of days since December 31, 2020.
          Fill value: -1.
        |||,
        'gee:units': units.day,
      },
    ],
    'gee:schema': [
      {
        name: 'Percent_data',
        description: 'Percentage of valid data pixels within the granule tile footprint.',
        type: ee_const.var_type.double,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Vegetation Disturbance Status',
        lookat: {
          lat: -14.05,
          lon: -60.64,
          zoom: 9,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              10,
            ],
            palette: [
              '2e7d32',
              '2e7d32',
              '2e7d32',
              'ffeb3b',
              'ff9800',
              'ff5722',
              'f44336',
              'ff9800',
              'b71c1c',
              'd7ccc8',
              '8d6e63',
            ],
            bands: [
              'VEG-DIST-STATUS',
            ],
          },
        },
      },
    ],
  },
}
