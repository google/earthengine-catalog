local id = 'GRIDMET/DROUGHT';
local subdir = 'GRIDMET';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

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
  title: 'GRIDMET DROUGHT: CONUS Drought Indices',
  version: ee_const.version_unknown,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset contains drought indices derived from the 4-km daily Gridded
    Surface Meteorological (GRIDMET) dataset. The drought indices provided include
    the standardized precipitation index (SPI), the evaporative drought demand
    index (EDDI), the standardized precipitation evapotranspiration index (SPEI),
    the Palmer Drought Severity Index (PDSI) and Palmer Z Index (Z).

    SPI, EDDI, and SPEI are supplied on different time scales corresponding to the
    time aggregation of precipitation, reference evapotranspiration, and
    precipitation minus reference evapotranspiration, respectively. The time scales
    include 14 day, 30 day, 90 day, 180 day, 270 day, 1 year, 2 years and 5 years.
    The standardization is done by using a non-parametric standardized probability
    based method where plotting positions are used to obtain probabilities which
    are transformed to indices assuming an inverse-normal distribution. All data
    are standardized over a common time period of 1981-2016.

    PDSI and Z are calculated using a modified version of the Palmer formula which
    uses reference evapotranspiration and precipitation from GRIDMET, and a static
    soil water holding capacity layer (top 1500mm) from STATSGO. Modifications to
    the coefficients of the original Palmer formula are applied to calculate PDSI.
    The baseline period for PDSI and Z calculations is 1979-2018.

    Interpretation of the drought indices in this dataset is different for PDSI and
    Z than for SPI, SPEI and EDDI. Utilizing the interpretation from the US Drought
    monitor, values of these drought indices have the following meaning:

    PDSI and z:

      * 5.0 or more (extremely wet)
      * 4.0 to 4.99 (very wet)
      * 3.0 to 3.99 (moderately wet),
      * 2.0 to 2.99 (slightly wet)
      * 1.0 to 1.99 (incipient wet spell)
      * -0.99 to 0.99(near normal)
      * -1.99 to -1.00 (incipient dry spell)
      * -2.99 to -2.00 (mild drought)
      * -3.99 to -3.00 (moderate drought)
      * -4.99 to -4.00 (severe drought)
      * -5.0 or less (extreme drought)

    SPI/SPEI/EDDI:

      * 2.0 or more (extremely wet)
      * 1.6 to 1.99 (very wet)
      * 1.3 to 1.59 (moderately wet),
      * 0.8 to 1.29 (slightly wet)
      * 0.5 to 0.79 (incipient wet spell)
      * -0.49 to 0.49(near normal),
      * -0.79 to -0.5 (incipient dry spell)
      * -1.29 to -0.8 (mild drought)
      * -1.59 to -1.3 (moderate drought)
      * -1.99 to -1.6 (severe drought)
      * -2.0 or less (extreme drought).

    This dataset contains provisional products that are replaced with
    updated versions when the complete source data become available.
    Products can be distinguished by the value of the 'status' property.
    At first, assets are ingested with status='early'. After several
    days, they are replaced by assets with status='provisional'.
    After about 2 months, they are replaced by the final assets with
    status='permanent'.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'climate',
    'climatic_water_balance',
    'conus',
    'crop',
    'drought',
    'eddi',
    'evapotranspiration',
    'geophysical',
    'gridmet',
    'merced',
    'metdata',
    'palmer',
    'pdsi',
    'precipitation',
    'spei',
    'spi',
  ],
  providers: [
    ee.producer_provider('University of California Merced', 'http://www.climatologylab.org/gridmet.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-124.9, 24.9, -66.8, 49.6, '1980-01-05T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'status',
        description: "'early', 'provisional', or 'permanent'",
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      4638.3,
    ],
    'eo:bands': [
      {
        name: 'spi14d',
        description: 'Standardized Precipitation Index (SPI) where precipitation was aggregated\nfor the last 14 days',
      },
      {
        name: 'spi30d',
        description: 'Standardized Precipitation Index (SPI) where precipitation was aggregated\nfor the last 30 days',
      },
      {
        name: 'spi90d',
        description: 'Standardized Precipitation Index (SPI) where precipitation was aggregated\nfor the last 90 days',
      },
      {
        name: 'spi180d',
        description: 'Standardized Precipitation Index (SPI) where precipitation was aggregated\nfor the last 180 days',
      },
      {
        name: 'spi270d',
        description: 'Standardized Precipitation Index (SPI) where precipitation was aggregated\nfor the last 270 days',
      },
      {
        name: 'spi1y',
        description: 'Standardized Precipitation Index (SPI) where precipitation was aggregated\nfor the last 1 year',
      },
      {
        name: 'spi2y',
        description: 'Standardized Precipitation Index (SPI) where precipitation was aggregated\nfor the last 2 years',
      },
      {
        name: 'spi5y',
        description: 'Standardized Precipitation Index (SPI) where precipitation was aggregated\nfor the last 5 years',
      },
      {
        name: 'eddi14d',
        description: |||
          Evaporative Drought Demand Index (EDDI) where potential evapotranspiration
          was aggregated for the last 14 days
        |||,
      },
      {
        name: 'eddi30d',
        description: |||
          Evaporative Drought Demand Index (EDDI) where potential evapotranspiration
          was aggregated for the last 30 days
        |||,
      },
      {
        name: 'eddi90d',
        description: |||
          Evaporative Drought Demand Index (EDDI) where potential evapotranspiration
          was aggregated for the last 90 days
        |||,
      },
      {
        name: 'eddi180d',
        description: |||
          Evaporative Drought Demand Index (EDDI) where potential evapotranspiration
          was aggregated for the last 180 days
        |||,
      },
      {
        name: 'eddi270d',
        description: |||
          Evaporative Drought Demand Index (EDDI) where potential evapotranspiration
          was aggregated for the last 270 days
        |||,
      },
      {
        name: 'eddi1y',
        description: |||
          Evaporative Drought Demand Index (EDDI) where potential evapotranspiration
          was aggregated for the last 1 year
        |||,
      },
      {
        name: 'eddi2y',
        description: |||
          Evaporative Drought Demand Index (EDDI) where potential evapotranspiration
          was aggregated for the last 2 years
        |||,
      },
      {
        name: 'eddi5y',
        description: |||
          Evaporative Drought Demand Index (EDDI) where potential evapotranspiration
          was aggregated for the last 5 years
        |||,
      },
      {
        name: 'spei14d',
        description: |||
          Standardized Precipitation Evapotranspiration Index (SPEI) where
          climatic water balance was aggregated for the last 14 days
        |||,
      },
      {
        name: 'spei30d',
        description: |||
          Standardized Precipitation Evapotranspiration Index (SPEI) where
          climatic water balance was aggregated for the last 30 days
        |||,
      },
      {
        name: 'spei90d',
        description: |||
          Standardized Precipitation Evapotranspiration Index (SPEI) where
          climatic water balance was aggregated for the last 90 days
        |||,
      },
      {
        name: 'spei180d',
        description: |||
          Standardized Precipitation Evapotranspiration Index (SPEI) where
          climatic water balance was aggregated for the last 180 days
        |||,
      },
      {
        name: 'spei270d',
        description: |||
          Standardized Precipitation Evapotranspiration Index (SPEI) where
          climatic water balance was aggregated for the last 270 days
        |||,
      },
      {
        name: 'spei1y',
        description: |||
          Standardized Precipitation Evapotranspiration Index (SPEI) where
          climatic water balance was aggregated for the last 1 year
        |||,
      },
      {
        name: 'spei2y',
        description: |||
          Standardized Precipitation Evapotranspiration Index (SPEI) where
          climatic water balance was aggregated for the last 2 years
        |||,
      },
      {
        name: 'spei5y',
        description: |||
          Standardized Precipitation Evapotranspiration Index (SPEI) where
          climatic water balance was aggregated for the last 5 years
        |||,
      },
      {
        name: 'pdsi',
        description: 'Palmer Drought Severity Index',
      },
      {
        name: 'z',
        description: 'Palmer Z Index',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'PDSI',
        lookat: {
          lat: 38.686,
          lon: -115.356,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              -5.0,
            ],
            max: [
              10.0,
            ],
            palette: [
              'red',
              'yellow',
              'green',
              'cyan',
              'blue',
            ],
            bands: [
              'pdsi',
            ],
          },
        },
      },
    ],
    spi14d: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    spi30d: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    spi90d: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    spi180d: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    spi270d: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    spi1y: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    spi2y: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    spi5y: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    eddi14d: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    eddi30d: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    eddi90d: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    eddi180d: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    eddi270d: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    eddi1y: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    eddi2y: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    eddi5y: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    spei14d: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    spei30d: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    spei90d: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    spei180d: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    spei270d: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    spei1y: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    spei2y: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    spei5y: {
      minimum: -6.0,
      maximum: 6.0,
      'gee:estimated_range': true,
    },
    pdsi: {
      minimum: -15.0,
      maximum: 15.0,
      'gee:estimated_range': true,
    },
    z: {
      minimum: -15.0,
      maximum: 15.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Abatzoglou J. T., Development of gridded surface meteorological data for
    ecological applications and modelling, International Journal of
    Climatology. (2012)
    [doi:10.1002/joc.3413](https://doi.org/10.1002/joc.3413)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 5,
  },
  'gee:terms_of_use': |||
    This work (METDATA, by John Abatzoglou) is in the public
    domain and is free of known copyright restrictions. Users should
    properly cite the source used in the creation of any reports and
    publications resulting from the use of this dataset and note the
    date when the data was acquired.
  |||,
}
