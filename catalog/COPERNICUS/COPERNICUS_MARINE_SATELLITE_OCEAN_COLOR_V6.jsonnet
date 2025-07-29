local id = 'COPERNICUS/MARINE/SATELLITE_OCEAN_COLOR/V6';
local subdir = 'COPERNICUS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';

local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci
  ],
  id: id,
  title: 'Copernicus Satellite Ocean Color Daily Data',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset provides global daily estimates of ocean surface chlorophyll-a
    concentration and remote sensing reflectance derived from multiple satellite
    sensors.

    Remote-sensing reflectance (or Rrs) is defined as the ratio of water-leaving
    radiance to downwelling irradiance and serves as the main input to
    algorithms used to derive other ocean colour products. Chlorophyll-a (Chl-a)
    is the main photosynthetic pigment found in phytoplankton, which form the
    base of the marine food-web and are responsible for approximately half of
    the global photosynthesis. Chl-a can be estimated from Rrs data using
    different algorithms (see details in the Documentation). Here, we provide a
    blended Chl-a estimate from multiple algorithms, where blending is based on
    the suitability of each candidate algorithm to the optical typology of a
    given pixel. This approach provides the best estimates of global Chl-a
    across a range of water types.

    The files from this dataset contain global daily composites of merged sensor
    products: SeaWiFS, MERIS, MODIS Aqua, VIIRS, and (from version 5.0 onward)
    OLCI. Note that Rrs and Chl-a data are only available over cloud- and
    ice-free areas. As a result, more complete spatial coverage (as shown in the
    map in the upper-right corner) can be achieved by aggregating data over
    longer time periods.

    This dataset is produced using the processing chain software developed by
    the Ocean Colour component of the European Space Agency Climate Change
    Initiative project (ESA OC-CCI). More details are available in the dataset
    [documentation](https://dast.copernicus-climate.eu/documents/satellite-ocean-colour/v6.0/WP2-FDDP-2022-04_C3S2-Lot3_PUGS-of-v6.0-OceanColour-product_v1.1_FINAL.pdf).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['oceans'],
  keywords: [
    'chlorophyll_a',
    'copernicus',
    'daily',
    'marine',
  ],
  providers: [
    ee.producer_provider('Copernicus', 'https://doi.org/10.24381/cds.f85b319d '),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1997-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      4000.0,
    ],
    'eo:bands': [
      {
        name: 'MERIS_nobs',
        description: 'Number of observations from MERIS sensor',
      },
      {
        name: 'MODISA_nobs',
        description: 'Number of observations from MODIS-A sensor',
      },
      {
        name: 'OLCI-A_nobs',
        description: 'Number of observations from OLCI-A sensor',
      },
      {
        name: 'OLCI-B_nobs',
        description: 'Number of observations from OLCI-B sensor',
      },
      {
        name: 'SeaWiFS_nobs',
        description: 'Number of observations from SeaWiFS sensor',
      },
      {
        name: 'VIIRS_nobs',
        description: 'Number of observations from VIIRS sensor',
      },
      {
        name: 'chlor_a',
        description: 'Chlorophyll-a concentration',
        'gee:units': units.density_mg_per_m_cubed,
      },
      {
        name: 'total_nobs',
        description: 'Total number of observations',
      },
      {
        name: 'Rrs_412',
        description: 'Remote sensing reflectance at 412 nm',
        'gee:units': units.per_steradian,
      },
      {
        name: 'Rrs_443',
        description: 'Remote sensing reflectance at 443 nm',
        'gee:units': units.per_steradian,
      },
      {
        name: 'Rrs_490',
        description: 'Remote sensing reflectance at 490 nm',
        'gee:units': units.per_steradian,
      },
      {
        name: 'Rrs_510',
        description: 'Remote sensing reflectance at 510 nm',
        'gee:units': units.per_steradian,
      },
      {
        name: 'Rrs_560',
        description: 'Remote sensing reflectance at 560 nm',
        'gee:units': units.per_steradian,
      },
      {
        name: 'Rrs_665',
        description: 'Remote sensing reflectance at 665 nm',
        'gee:units': units.per_steradian,
      },
      {
        name: 'Rrs_MERIS_nobs',
        description: 'Number of observations from MERIS sensor',
      },
      {
        name: 'Rrs_MODISA_nobs',
        description: 'Number of observations from MODIS-A sensor',
      },
      {
        name: 'Rrs_OLCI-A_nobs',
        description: 'Number of observations from OLCI-A sensor',
      },
      {
        name: 'Rrs_OLCI-B_nobs',
        description: 'Number of observations from OLCI-B sensor',
      },
      {
        name: 'Rrs_SeaWiFS_nobs',
        description: 'Number of observations from SeaWiFS sensor',
      },
      {
        name: 'Rrs_VIIRS_nobs',
        description: 'Number of observations from VIIRS sensor',
      },
      {
        name: 'Rrs_total_nobs',
        description: 'Total number of observations from RRS sensors',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Chlorophyll-a concentration',
        lookat: {
          lat: 52.0,
          lon: 71.0,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              1.0,
            ],
            palette: [
              'blue',
              'purple',
              'cyan',
              'green',
              'yellow',
              'red'
            ],
            bands: [
              'chlor_a',
            ],
          },
        },
      },
    ],
    MERIS_nobs: {
      minimum: 0.11,
      maximum: 135.55,
      'gee:estimated_range': false,
    },
    MODISA_nobs: {
      minimum: 0.11,
      maximum: 126.33,
      'gee:estimated_range': false,
    },
    'OLCI-A_nobs': {
      minimum: 0.11,
      maximum: 121,
      'gee:estimated_range': false,
    },
    'OLCI-B_nobs': {
      minimum: 0.11,
      maximum: 121,
      'gee:estimated_range': false,
    },
    SeaWiFS_nobs: {
      minimum: 0.11,
      maximum: 61.77,
      'gee:estimated_range': false,
    },
    VIIRS_nobs: {
      minimum: 0.11,
      maximum: 236.44,
      'gee:estimated_range': false,
    },
    chlor_a: {
      minimum: 0,
      maximum: 99.9,
      'gee:estimated_range': false,
    },
    total_nobs: {
      minimum: 0.11,
      maximum: 329.77,
      'gee:estimated_range': false,
    },
    Rrs_412: {
      minimum: 0,
      maximum: 0.26,
      'gee:estimated_range': false,
    },
    Rrs_443: {
      minimum: 0,
      maximum: 0.28,
      'gee:estimated_range': false,
    },
    Rrs_490: {
      minimum: 0,
      maximum: 0.38,
      'gee:estimated_range': false,
    },
    Rrs_510: {
      minimum: 0,
      maximum: 0.39,
      'gee:estimated_range': false,
    },
    Rrs_560: {
      minimum: 0,
      maximum: 0.402,
      'gee:estimated_range': false,
    },
    Rrs_665: {
      minimum: 0,
      maximum: 0.21,
      'gee:estimated_range': false,
    },
    Rrs_MERIS_nobs: {
      minimum: 0.11,
      maximum: 135.55,
      'gee:estimated_range': false,
    },
    Rrs_MODISA_nobs: {
      minimum: 0.11,
      maximum: 126.33,
      'gee:estimated_range': false,
    },
    'Rrs_OLCI-A_nobs': {
      minimum: 0.11,
      maximum: 121,
      'gee:estimated_range': false,
    },
    'Rrs_OLCI-B_nobs': {
      minimum: 0.11,
      maximum: 121,
      'gee:estimated_range': false,
    },
    Rrs_SeaWiFS_nobs: {
      minimum: 0.11,
      maximum: 61.77,
      'gee:estimated_range': false,
    },
    Rrs_VIIRS_nobs: {
      minimum: 0.11,
      maximum: 236.44,
      'gee:estimated_range': false,
    },
    Rrs_total_nobs: {
      minimum: 0.11,
      maximum: 329.77,
      'gee:estimated_range': false,
    }
  },
  'sci:citation': |||
    Copernicus Climate Change Service (2019): Ocean colour daily data from 1997
    to present derived from satellite observations. Copernicus Climate Change
    Service (C3S) Climate Data Store (CDS). 
    [doi:10.24381/cds.f85b319d](https://doi.org/10.24381/cds.f85b319d)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    This dataset is released for use under the CC-BY licence. Highlights and
    key features of the licence are provided in this document. [License](https://creativecommons.org/licenses/by/4.0/).
  |||,
}
