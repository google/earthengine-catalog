local id = 'OPERA/RTC/L2_V1/S1';
local subdir = 'OPERA';
local version = '1.0';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc0_1_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'OPERA Radiometric Terrain-Corrected SAR Backscatter from Sentinel-1 V1.0',
  version: version,

  description: |||
    This product consists of radar backscatter normalized with respect to the
    topography. It maps signals related to the physical properties of ground
    scattering objects, such as surface roughness and soil moisture and/or
    vegetation. The OPERA RTC-S1 product is derived from Copernicus Sentinel-1
    Interferometric Wide (IW) Single Look Complex (SLC) data with a near global
    scope and temporal sampling coincident with the availability of SLC data.

    Each OPERA RTC-S1 product corresponds to a single S1 burst projected onto
    a pre-defined UTM/Polar stereographic map projection system map grid with
    a 30-meter spacing. The Copernicus global 30 m (GLO-30) Digital Elevation
    Model (DEM) is the reference DEM used to correct for the impacts of
    topography and to geocode the product. The OPERA RTC-S1 product is
    normalized to the backscatter coefficient gamma0 obtained from the
    original radar brightness beta0 through radiometric terrain correction.

    Due to the S1 mission’s narrow orbital tube, radar-geometry layers such as
    incidence angle, local incidence angle, number of looks, and RTC Area
    Normalization Factor (ANF) vary slightly over time for each position on the
    ground, and therefore are considered static. These static layers are
    provided separately from the OPERA RTC-S1 product, as they are produced
    only once or a limited number of times, to account for changes in the DEM,
    in the S1 orbit, or in the static-layers generation algorithm. The static
    layers are available in the associated
    [OPERA Radiometric Terrain Corrected SAR Backscatter from Sentinel-1 Static Layers dataset](OPERA_RTC_L2_V1_S1_STATIC).
  |||,

  'gee:categories': ['satellite-imagery'],

  keywords: [
    'nasa',
    'jpl',
    'opera',
    'sentinel1-derived',
    'sar',
    'radar',
    'polarization',
    'backscatter',
  ],

  providers: [
    ee.producer_provider('NASA JPL', 'https://www.jpl.nasa.gov/go/opera'),
    ee.host_provider(self_ee_catalog_url),
  ],

  extent: ee.extent(-180.0, -60.0, 180.0, 90.0,
                    '2016-04-14T00:00:00Z', null),

  summaries: {
    gsd: [30],
    'eo:bands': [
      {
        name: 'VV',
        description: 'VV polarization radar backscatter normalized to gamma0.',
      },
      {
        name: 'VH',
        description: 'VH polarization radar backscatter normalized to gamma0.',
      },
      {
        name: 'mask',
        description: |||
          Mask layer containing valid/invalid, layover, and shadow
          classification computed using the RTC-S1 burst orbit,
          provided over the same geographic grid as the associated
          geocoded imagery.
        |||,
        'gee:classes': [
          {
            value: 0,
            color: '000000',
            description: 'Valid sample not affected by layover or shadow',
          },
          {
            value: 1,
            color: 'FF0000',
            description: 'Valid sample affected by shadow',
          },
          {
            value: 2,
            color: '00FF00',
            description: 'Valid sample affected by layover',
          },
          {
            value: 3,
            color: 'FFFF00',
            description: 'Valid sample affected by layover and shadow',
          },
          {
            value: 255,
            color: 'FFFFFF',
            description: 'Invalid sample',
          },
        ],
      },
    ],
    'gee:schema': [
      {
        name: 'ABSOLUTE_ORBIT_NUMBER',
        description: 'Absolute orbit number',
        type: ee_const.var_type.double,
      },
      {
        name: 'ACQUISITION_MODE',
        description: 'Acquisition mode',
        type: ee_const.var_type.string,
      },
      {
        name: 'BURST_ID',
        description: 'Burst identification string',
        type: ee_const.var_type.string,
      },
      {
        name: 'INPUT_L1_SLC_GRANULES',
        description: 'List of input L1 SLC granules',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'INPUT_ORBIT_FILES',
        description: 'List of input orbit files',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'INSTRUMENT_NAME',
        description: |||
          Name of the instrument used to collect the remote sensing
          data provided in this product
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'LOOK_DIRECTION',
        description: 'Look direction',
        type: ee_const.var_type.string,
      },
      {
        name: 'ORBIT_PASS_DIRECTION',
        description: 'Orbit pass direction',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROCESSING_DATETIME',
        description: |||
          Product generation time in UTC. Format: YYYY-MM-DDTHH:MM:SSZ
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'PROCESSING_TYPE',
        description: |||
          Processing type. One of: "NOMINAL", "URGENT", "CUSTOM", or
          "UNDEFINED"
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'PRODUCT_VERSION',
        description: 'Product version',
        type: ee_const.var_type.string,
      },
      {
        name: 'QA_GEOMETRIC_ACCURACY_BIAS_X',
        description: |||
          An estimate of the localization error bias in the easting direction'
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'QA_GEOMETRIC_ACCURACY_BIAS_Y',
        description: |||
          An estimate of the localization error bias in the northing direction'
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'QA_GEOMETRIC_ACCURACY_STDDEV_X',
        description: |||
          An estimate of the localization error standard deviation
          in the easting direction
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'QA_GEOMETRIC_ACCURACY_STDDEV_Y',
        description: |||
          An estimate of the localization error standard deviation
          in the northing direction
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SUB_SWATH_ID',
        description: 'Sub-swath identifier',
        type: ee_const.var_type.string,
      },
      {
        name: 'TRACK_NUMBER',
        description: 'Track number',
        type: ee_const.var_type.double,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'VV Polarization',
        lookat: {
          lat: 54.5,
          lon: -5,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              0.5,
            ],
            bands: [
              'VV',
            ],
          },
        },
      },
    ],
  },

  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },

  'sci:doi': '10.5067/SNWG/OPERA_L2_RTC-S1_V1',
  'sci:citation': |||
    NASA/JPL/OPERA. (2023). OPERA Radiometric Terrain Corrected SAR
    Backscatter from Sentinel-1 validated product (Version 1) [Data set].
    NASA Alaska Satellite Facility Distributed Active Archive Center.
    [doi:10.5067/SNWG/OPERA_L2_RTC-S1_V1](https://doi.org/10.5067/SNWG/OPERA_L2_RTC-S1_V1)
  |||,

  'gee:terms_of_use': |||
    This dataset is openly shared, without restriction, in accordance with the
    [EOSDIS Data Use and Citation Guidance](https://www.earthdata.nasa.gov/engage/open-data-services-software-policies/data-use-guidance)
  |||,

  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.image_collection,
  license: license.id,

  links: ee.standardLinks(subdir, id),

  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
