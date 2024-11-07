local id = 'NOAA/CPC/Precipitation';
local subdir = 'NOAA';

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
  ],
  id: id,
  title: 'CPC Global Unified Gauge-Based Analysis of Daily Precipitation',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The CPC Unified Gauge-Based Analysis of Global Daily Precipitation dataset
    offers daily precipitation estimates over land from 1979 to the present.
    Developed by NOAA's Climate Prediction Center (CPC), it leverages an optimal
    interpolation technique to combine data from a global network of rain
    gauges, with over 30,000 gauges contributing to the retrospective version
    (1979-2005) and around 17,000 to the real-time version (2006-present).
    Data is provided at a 0.5-degree resolution and includes both precipitation
    amounts (in 0.1 mm) and the number of gauges used for each grid cell,
    allowing users to assess data quality.

    The dataset's quality is acknowledged to be poor over tropical Africa and
    Antarctica, and generally varies with gauge density. Real-time data is
    subject to revision as more complete station data becomes available.

    [This](https://ftp.cpc.ncep.noaa.gov/precip/CPC_UNI_PRCP/GAUGE_GLB/DOCU/)
    folder has all the technical documentation.

    NOTE: The historical data spanning from 1979 to 2005 is not available in the
    current version of the dataset.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'daily',
    'noaa',
    'precipitation',
    'weather',
  ],
  providers: [
    ee.producer_provider('NOAA Physical Sciences Laboratory', 'https://psl.noaa.gov/data/gridded/data.cpc.globalprecip.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2006-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      55500.0,
    ],
    'eo:bands': [
      {
        name: 'precipitation',
        description: 'Daily total precipitation estimate in 0.1 mm',
        'gee:units': units.millimeter,
      },
      {
        name: 'num_gauges',
        description: |||
          Number of rain gauges contributing to the precipitation estimate
          within the 0.5-degree grid cell
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'NOAA CPC Precipitation',
        lookat: {
          lon: -68.36,
          lat: -6.73,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              150.0,
            ],
            palette: [
              'ADD8E6',
              '008000',
              'FFFF00',
              'FFA500',
              'FF0000',
              '800080',
            ],
            bands: [
              'precipitation',
            ],
          },
        },
      },
    ],
    precipitation: {
      minimum: 0,
      maximum: 10671.53,
      'gee:estimated_range': true,
    },
    num_gauges: {
      minimum: 0,
      maximum: 121,
      'gee:estimated_range': true,
    },
  },
  'sci:publications': [
    {
      citation: |||
        (Interpolation algorithm) Xie_et_al_2007_JHM_EAG.pdf Xie,
        P., A. Yatagai, M. Chen, T. Hayasaka, Y. Fukushima, C. Liu, and
        S. Yang (2007), A gauge-based analysis of daily precipitation over East
        Asia, J. Hydrometeorol., 8, 607. 626.
      |||,
    },
    {
      citation: |||
        (Gauge Algorithm Evaluation) Chen_et_al_2008_JGR_Gauge_Algo.pdf
        Chen, M., W. Shi, P. Xie, V. B. S. Silva, V E. Kousky, R. Wayne Higgins,
        and J. E. Janowiak (2008), Assessing objective techniques for
        gauge-based analyses of global daily precipitation,
        J. Geophys. Res., 113, D04110,
        [doi:10.1029/2007JD009132](https://doi.org/10.1029/2007JD009132)
      |||,
      doi: '10.1029/2007JD009132',
    },
  ],
  'gee:terms_of_use': |||
    The NOAA CPC datasets are available without restriction
    on use or distribution. NOAA PSL does request that the
    user give proper attribution and identify NOAA PSL, where applicable,
    as the source of the data.
  |||,
}
