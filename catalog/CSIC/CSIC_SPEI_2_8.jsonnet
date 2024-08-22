local versions = import 'versions.libsonnet';
local version_table = import 'CSIC_SPEI_versions.libsonnet';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local id = 'CSIC/SPEI/2_8';
local subdir = 'CSIC';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.cc_by_4_0;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'SPEIbase: Standardised Precipitation-Evapotranspiration Index ' +
    'database, Version ' + version + ' [deprecated]',
  version: version,
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Global SPEI database (SPEIbase) offers long-time robust information
    about drought conditions at the global scale, with a 0.5 degree pixel size
    and monthly cadence. It provides SPEI time scales from 1 to 48 months.

    The Standardized Precipitatin-Evapotranspiration Index (SPEI) expresses,
    as a standardized variate (mean zero and unit variance), the deviations of
    the current climatic balance (precipitation minus evapotranspiration
    potential) with respect to the long-term balance. The reference period for
    the calculation in the SPEIbase corresponds to the whole study period.
    Being a standardized variate means that the SPEI condition can be compared
    across space and time.

    The SPEIbase is based on the
    [FAO-56 Penman-Monteith estimation](https://www.fao.org/3/x0490e/x0490e06.htm)
    estimation of potential evapotranspiration.
    This is a major difference with respect to the SPEI Global Drought Monitor,
    that uses the Thornthwaite PET estimation.
    The Penman-Montheith method is considered a superior method, so the
    SPEIbase is recommended for most uses including long-term climatological
    analysis.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.20350/digitalCSIC/15121',
    },
  ] + version_config.version_links,
  keywords: [
    'climate',
    'climate_change',
    'drought',
    'evapotranspiration',
    'global',
    'monthly',
    'palmer',
    'precipitation',
    'temperature',
  ],
  providers: [
    ee.producer_provider('Spanish National Research Council (CSIC)',
      'https://spei.csic.es/'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('1901-01-01T00:00:00Z', '2021-01-01T00:00:00Z'),
  summaries: {
    gsd: [55660],
    'eo:bands': [
      {
        name: 'SPEI_01_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous month',
      },
      {
        name: 'SPEI_02_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 2 months',
      },
      {
        name: 'SPEI_03_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 3 months',
      },
      {
        name: 'SPEI_04_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 4 months',
      },
      {
        name: 'SPEI_05_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 5 months',
      },
      {
        name: 'SPEI_06_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 6 months',
      },
      {
        name: 'SPEI_07_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 7 months',
      },
      {
        name: 'SPEI_08_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 8 months',
      },{
        name: 'SPEI_09_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 9 months',
      },
      {
        name: 'SPEI_10_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 10 months',
      },
      {
        name: 'SPEI_11_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 11 months',
      },
      {
        name: 'SPEI_12_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 12 months',
      },{
        name: 'SPEI_13_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 13 months',
      },
      {
        name: 'SPEI_14_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 14 months',
      },
      {
        name: 'SPEI_15_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 15 months',
      },
      {
        name: 'SPEI_16_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 16 months',
      },
      {
        name: 'SPEI_17_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 17 months',
      },
      {
        name: 'SPEI_18_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 18 months',
      },
      {
        name: 'SPEI_19_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 19 months',
      },
      {
        name: 'SPEI_20_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 20 months',
      },
      {
        name: 'SPEI_21_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 21 months',
      },
      {
        name: 'SPEI_22_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 22 months',
      },
      {
        name: 'SPEI_23_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 23 months',
      },
      {
        name: 'SPEI_24_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 24 months',
      },
      {
        name: 'SPEI_25_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 25 months',
      },
      {
        name: 'SPEI_26_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 26 months',
      },
      {
        name: 'SPEI_27_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 27 months',
      },
      {
        name: 'SPEI_28_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 28 months',
      },
      {
        name: 'SPEI_29_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 29 months',
      },
      {
        name: 'SPEI_30_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 30 months',
      },
      {
        name: 'SPEI_31_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 31 months',
      },
      {
        name: 'SPEI_32_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 32 months',
      },
      {
        name: 'SPEI_33_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 33 months',
      },{
        name: 'SPEI_34_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 34 months',
      },
      {
        name: 'SPEI_35_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 35 months',
      },
      {
        name: 'SPEI_36_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 36 months',
      },
      {
        name: 'SPEI_37_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 37 months',
      },{
        name: 'SPEI_38_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 38 months',
      },
      {
        name: 'SPEI_39_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 39 months',
      },
      {
        name: 'SPEI_40_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 40 months',
      },
      {
        name: 'SPEI_41_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 41 months',
      },
      {
        name: 'SPEI_42_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 42 months',
      },
      {
        name: 'SPEI_43_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 43 months',
      },
      {
        name: 'SPEI_44_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 44 months',
      },
      {
        name: 'SPEI_45_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 45 months',
      },
      {
        name: 'SPEI_46_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 46 months',
      },
      {
        name: 'SPEI_47_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 47 months',
      },
      {
        name: 'SPEI_48_month',
        description: 'Standardized Precipitation-Evapotranspiration Index ' +
          '(SPEI) where precipitation and evapotranspiration data was  ' +
          'accumulated over the previous 48 months',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'SPEI',
        lookat: {lon: -3.75, lat: 40.47, zoom: 4},
        image_visualization: {
          band_vis: {
            min: [-2.33],
            max: [2.33],
            palette: [
              '8b1a1a', 'de2929', 'f3641d',
              'fdc404', '9afa94', '03f2fd',
              '12adf3', '1771de', '00008b',
            ],
            bands: ['SPEI_24_month'],
          },
        },
      },
    ],
    SPEI_01_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_02_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_03_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_04_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_05_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_06_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_07_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_08_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_09_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_10_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_11_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_12_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_13_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_14_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_15_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_16_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_17_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_18_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_19_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_20_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_21_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_22_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_23_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_24_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_25_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_26_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_27_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_28_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_29_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_30_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_31_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_32_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_33_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_34_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_35_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_36_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_37_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_38_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_39_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_40_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_41_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_42_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_43_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_44_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_45_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_46_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_47_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
    SPEI_48_month: {minimum: -2.33, maximum: 2.33, 'gee:estimated_range': false},
  },
  'sci:doi': '10.20350/digitalCSIC/15121',
  'sci:citation': |||
    Product: Beguería, Santiago; Vicente Serrano, Sergio M.;
    Reig-Gracia, Fergus; Latorre Garcés, Borja; 2023;
    SPEIbase v.2.8 [Dataset]; DIGITAL.CSIC; Version 2.8.
    [doi:10.20350/digitalCSIC/15121](https://doi.org/10.20350/digitalCSIC/15121)
  |||,
  'sci:publications': [
    {
      citation: |||
        Related publication: Vicente-Serrano S.M., Beguería S.,
        López-Moreno J.I. (2010):
        A Multi-scalar drought index sensitive to global warming:
        The Standardized Precipitation Evapotranspiration Index - SPEI.
        Journal of Climate 23(7), 1696-1718.
        [doi:10.1175/2009JCLI2909.1](https://doi.org/10.1175/2009JCLI2909.1)
      |||,
      doi: '10.1175/2009JCLI2909.1',
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license) + '\n\n' + |||
    The SPEI database is available under the
    [CC-BY 4.0 license](https://creativecommons.org/licenses/by/4.0/).

    Any public use of the database or works derived from it must include
    proper attribution.
    Attribution should be given by referencing the document titled:
    Beguería, Santiago; Vicente Serrano, Sergio M.; Reig-Gracia, Fergus;
    Latorre Garcés, Borja; 2023;
    SPEIbase v.2.8 [Dataset]; DIGITAL.CSIC; Version 2.8.
    [doi:10.20350/digitalCSIC/15121](https://doi.org/10.20350/digitalCSIC/15121)
  |||,
  'gee:user_uploaded': true,
}
