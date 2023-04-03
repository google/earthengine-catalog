local id = 'COPERNICUS/S3/OLCI';
local subdir = 'COPERNICUS';

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
  ],
  id: id,
  title: 'Sentinel-3 OLCI EFR: Ocean and Land Color Instrument Earth Observation Full Resolution',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Ocean and Land Color Instrument (OLCI) Earth Observation
    Full Resolution (EFR) dataset contains top of atmosphere radiances
    at 21 spectral bands with center wavelengths ranging between
    0.4&micro;m and 1.02&micro;m at spatial resolution of 300m with
    worldwide coverage every ~2 days.

    OLCI is one of the instruments
    in the ESA/EUMETSAT Sentinel-3 mission for measuring sea-surface
    topography, sea- and land-surface temperature, ocean color and
    land color with high-end accuracy and reliability to support
    ocean forecasting systems, as well as environmental and climate
    monitoring.

    The Sentinel-3 OLCI instrument is based on the
    optomechanical and imaging design of ENVISAT's MERIS. It is designed
    to retrieve the spectral distribution of upwelling radiance just
    above the sea surface (the water-leaving radiance).

    OLCI observation is performed simultaneously in 21 spectral bands
    ranging from the visible to the near-infrared (400 to 1029nm).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'copernicus',
    'esa',
    'eu',
    'olci',
    'radiance',
    'sentinel',
    'toa',
  ],
  providers: [
    ee.producer_provider('European Union/ESA/Copernicus', 'https://sentinel.esa.int/web/sentinel/user-guides/sentinel-3-olci'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2016-10-18T19:25:42Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'SNAP_Graph_Processing_Framework_GPF_vers',
        description: 'Sentinel Application Platform (SNAP) version',
        type: ee_const.var_type.string,
      },
      {
        name: 'SNAP_Raster_Operators_vers',
        description: 'SNAP version',
        type: ee_const.var_type.string,
      },
      {
        name: 'processing_facility_country',
        description: 'Name of the country where the facility is located. This element is configurable within the IPF.',
        type: ee_const.var_type.string,
      },
      {
        name: 'processing_facility_name',
        description: |||
          Name of the facility where the processing step was
          performed. This element is configurable within the IPF.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'processing_facility_organisation',
        description: 'Name of the organisation responsible for the facility. This element is configurable within the IPF.',
        type: ee_const.var_type.string,
      },
      {
        name: 'processing_facility_site',
        description: 'Geographical location of the facility. This element is configurable within the IPF.',
        type: ee_const.var_type.string,
      },
      {
        name: 'processing_hardware',
        description: 'Name of the hardware in the facility used for the processing.',
        type: ee_const.var_type.string,
      },
      {
        name: 'processing_software_name',
        description: 'Name of the software component.',
        type: ee_const.var_type.string,
      },
      {
        name: 'processing_software_version',
        description: 'The version or release identifier of the software',
        type: ee_const.var_type.double,
      },
      {
        name: 'processing_time',
        description: "The time the product was processed in 'epoch' format",
        type: ee_const.var_type.double,
      },
      {
        name: 'product',
        description: 'This is always `OL_1_EFR__`',
        type: ee_const.var_type.string,
      },
      {
        name: 'PRODUCT_ID',
        description: 'The full id of the original Sentinel-3 product',
        type: ee_const.var_type.string,
      },
      {
        name: 'productQuality',
        description: 'PASSED or empty',
        type: ee_const.var_type.string,
      },
      {
        name: 'cycle_num',
        description: |||
          The cycle number is the number of times the satellite
          passed over the same geographical point on the ground. In the
          SENTINEL-3 operational phase (after launch and commissioning
          phases), the orbit cycle is 27 days.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'orbitNumber',
        description: |||
          The absolute orbit number considers the orbits elapsed
          since the first ascending node crossing after launch.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'relative_orbit_num',
        description: |||
          The relative orbit number is the orbit number within
          a cycle. Every time a cycle starts, the relative orbit number
          is reset to zero.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'groundTrackDirection',
        description: |||
          Direction of the trace made by the sub-satellite point
          on the surface of the Earth's reference ellipsoid due to the
          motion of the satellite along its orbit.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'spacecraft',
        description: 'Sentinel-3 spacecraft name: S3A, S3B',
        type: ee_const.var_type.string,
      },
      {
        name: 'status',
        description: 'Status of the file',
        type: ee_const.var_type.string,
      },
      {
        name: 'timeliness',
        description: 'Timeliness of processing being analysed',
        type: ee_const.var_type.string,
      },
      {
        name: 'salineWaterPixelsPercent',
        description: 'Pixel quality information',
        type: ee_const.var_type.double,
      },
      {
        name: 'coastalPixelsPercent',
        description: 'Pixel quality information',
        type: ee_const.var_type.double,
      },
      {
        name: 'freshInlandWaterPixelsPercent',
        description: 'Pixel quality information',
        type: ee_const.var_type.double,
      },
      {
        name: 'tidalRegionPixelsPercent',
        description: 'Pixel quality information',
        type: ee_const.var_type.double,
      },
      {
        name: 'brightPixelsPercent',
        description: 'Pixel quality information',
        type: ee_const.var_type.double,
      },
      {
        name: 'invalidPixelsPercent',
        description: 'Pixel quality information',
        type: ee_const.var_type.double,
      },
      {
        name: 'cosmeticPixelsPercent',
        description: 'Pixel quality information',
        type: ee_const.var_type.double,
      },
      {
        name: 'duplicatedPixelsPercent',
        description: 'Pixel quality information',
        type: ee_const.var_type.double,
      },
      {
        name: 'dubiousSamplesPercent',
        description: 'Pixel quality information',
        type: ee_const.var_type.double,
      },
      {
        name: 'saturatedPixelsPercent',
        description: 'Pixel quality information',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      300.0,
    ],
    platform: [
      'Sentinel-3A',
    ],
    instruments: [
      'OLCI',
    ],
    'eo:bands': [
      {
        name: 'Oa01_radiance',
        description: 'Aerosol correction, improved water constituent retrieval',
        'gee:units': 'W m^-2 sr^-1 &micro;m^-1',
        center_wavelength: 0.4,
        'gee:scale': 0.01394646,
        'gee:wavelength': '400nm/15nm',
      },
      {
        name: 'Oa02_radiance',
        description: 'Yellow substance and detrital pigments (turbidity)',
        'gee:units': 'W m^-2 sr^-1 &micro;m^-1',
        center_wavelength: 0.4125,
        'gee:scale': 0.01338726,
        'gee:wavelength': '412.5nm/10nm',
      },
      {
        name: 'Oa03_radiance',
        description: 'Chl absorption max., biogeochemistry, vegetation',
        'gee:units': 'W m^-2 sr^-1 &micro;m^-1',
        center_wavelength: 0.4425,
        'gee:scale': 0.01214812,
        'gee:wavelength': '442.5nm/10nm',
      },
      {
        name: 'Oa04_radiance',
        description: 'High Chl, other pigments',
        'gee:units': 'W m^-2 sr^-1 &micro;m^-1',
        center_wavelength: 0.49,
        'gee:scale': 0.01151982,
        'gee:wavelength': '490nm/10nm',
      },
      {
        name: 'Oa05_radiance',
        description: 'Chl, sediment, turbidity, red tide',
        'gee:units': 'W m^-2 sr^-1 &micro;m^-1',
        center_wavelength: 0.51,
        'gee:scale': 0.01009526,
        'gee:wavelength': '510nm/10nm',
      },
      {
        name: 'Oa06_radiance',
        description: 'Chlorophyll reference (Chl minimum)',
        'gee:units': 'W m^-2 sr^-1 &micro;m^-1',
        center_wavelength: 0.56,
        'gee:scale': 0.0123538,
        'gee:wavelength': '560nm/10nm',
      },
      {
        name: 'Oa07_radiance',
        description: 'Sediment loading',
        'gee:units': 'W m^-2 sr^-1 &micro;m^-1',
        center_wavelength: 0.62,
        'gee:scale': 0.00879161,
        'gee:wavelength': '620nm/10nm',
      },
      {
        name: 'Oa08_radiance',
        description: 'Chl (2^nd Chl abs. max.), sediment, yellow substance/vegetation',
        'gee:units': 'W m^-2 sr^-1 &micro;m^-1',
        center_wavelength: 0.665,
        'gee:scale': 0.00876539,
        'gee:wavelength': '665nm/10nm',
      },
      {
        name: 'Oa09_radiance',
        description: |||
          For improved fluorescence retrieval and to better
          account for [smile](https://sentinels.copernicus.eu/web/sentinel/technical-guides/sentinel-3-olci/level-2/smile-correction)
          together with the bands 665 and 680nm
        |||,
        'gee:units': 'W m^-2 sr^-1 &micro;m^-1',
        center_wavelength: 0.67375,
        'gee:scale': 0.0095103,
        'gee:wavelength': '673.75nm/7.5nm',
      },
      {
        name: 'Oa10_radiance',
        description: 'Chl fluorescence peak, red edge',
        'gee:units': 'W m^-2 sr^-1 &micro;m^-1',
        center_wavelength: 0.68125,
        'gee:scale': 0.00773378,
        'gee:wavelength': '681.25nm/7.5nm',
      },
      {
        name: 'Oa11_radiance',
        description: 'Chl fluorescence baseline, red edge transition',
        'gee:units': 'W m^-2 sr^-1 &micro;m^-1',
        center_wavelength: 0.70875,
        'gee:scale': 0.00675523,
        'gee:wavelength': '708.75nm/10nm',
      },
      {
        name: 'Oa12_radiance',
        description: 'O2 absorption/clouds, vegetation',
        'gee:units': 'W m^-2 sr^-1 &micro;m^-1',
        center_wavelength: 0.75375,
        'gee:scale': 0.0071996,
        'gee:wavelength': '753.75nm/7.5nm',
      },
      {
        name: 'Oa13_radiance',
        description: 'O2 absorption band/aerosol correction',
        'gee:units': 'W m^-2 sr^-1 &micro;m^-1',
        center_wavelength: 0.76125,
        'gee:scale': 0.00749684,
        'gee:wavelength': '761.25nm/7.5nm',
      },
      {
        name: 'Oa14_radiance',
        description: 'Atmospheric correction',
        'gee:units': 'W m^-2 sr^-1 &micro;m^-1',
        center_wavelength: 0.764375,
        'gee:scale': 0.0086512,
        'gee:wavelength': '764.375nm/3.75nm',
      },
      {
        name: 'Oa15_radiance',
        description: 'O2A used for cloud top pressure, fluorescence over land',
        'gee:units': 'W m^-2 sr^-1 &micro;m^-1',
        center_wavelength: 0.7675,
        'gee:scale': 0.00526779,
        'gee:wavelength': '767.5nm/2.5nm',
      },
      {
        name: 'Oa16_radiance',
        description: 'Atmospheric correction/aerosol correction',
        'gee:units': 'W m^-2 sr^-1 &micro;m^-1',
        center_wavelength: 0.77875,
        'gee:scale': 0.00530267,
        'gee:wavelength': '778.75nm/15nm',
      },
      {
        name: 'Oa17_radiance',
        description: 'Atmospheric correction/aerosol correction, clouds, pixel co-registration',
        'gee:units': 'W m^-2 sr^-1 &micro;m^-1',
        center_wavelength: 0.865,
        'gee:scale': 0.00493004,
        'gee:wavelength': '865nm/20nm',
      },
      {
        name: 'Oa18_radiance',
        description: |||
          Water vapor absorption reference band. Common reference
          band with SLSTR instrument. Vegetation monitoring
        |||,
        'gee:units': 'W m^-2 sr^-1 &micro;m^-1',
        center_wavelength: 0.885,
        'gee:scale': 0.00549962,
        'gee:wavelength': '885nm/10nm',
      },
      {
        name: 'Oa19_radiance',
        description: 'Water vapor absorption/vegetation monitoring (max. reflectance)',
        'gee:units': 'W m^-2 sr^-1 &micro;m^-1',
        center_wavelength: 0.9,
        'gee:scale': 0.00502847,
        'gee:wavelength': '900nm/10nm',
      },
      {
        name: 'Oa20_radiance',
        description: 'Water vapor absorption, atmospheric/aerosol correction',
        'gee:units': 'W m^-2 sr^-1 &micro;m^-1',
        center_wavelength: 0.94,
        'gee:scale': 0.00326378,
        'gee:wavelength': '940nm/20nm',
      },
      {
        name: 'Oa21_radiance',
        description: 'Atmospheric/aerosol correction',
        'gee:units': 'W m^-2 sr^-1 &micro;m^-1',
        center_wavelength: 1.029,
        'gee:scale': 0.00324118,
        'gee:wavelength': '1029nm/40nm',
      },
      {
        name: 'quality_flags',
        description: 'Quality flags',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Saturated at Oa21',
              first_bit: 0,
              bit_count: 1,
              values: [
                {
                  description: 'The sample of Oa21 is not saturated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The sample of Oa21 is saturated',
                },
              ],
            },
            {
              description: 'Saturated at Oa20',
              first_bit: 1,
              bit_count: 1,
              values: [
                {
                  description: 'The sample of Oa20 is not saturated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The sample of Oa20 is saturated',
                },
              ],
            },
            {
              description: 'Saturated at Oa19',
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  description: 'The sample of Oa19 is not saturated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The sample of Oa19 is saturated',
                },
              ],
            },
            {
              description: 'Saturated at Oa18',
              first_bit: 3,
              bit_count: 1,
              values: [
                {
                  description: 'The sample of Oa18 is not saturated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The sample of Oa18 is saturated',
                },
              ],
            },
            {
              description: 'Saturated at Oa17',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: 'The sample of Oa17 is not saturated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The sample of Oa17 is saturated',
                },
              ],
            },
            {
              description: 'Saturated at Oa16',
              first_bit: 5,
              bit_count: 1,
              values: [
                {
                  description: 'The sample of Oa16 is not saturated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The sample of Oa16 is saturated',
                },
              ],
            },
            {
              description: 'Saturated at Oa15',
              first_bit: 6,
              bit_count: 1,
              values: [
                {
                  description: 'The sample of Oa15 is not saturated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The sample of Oa15 is saturated',
                },
              ],
            },
            {
              description: 'Saturated at Oa14',
              first_bit: 7,
              bit_count: 1,
              values: [
                {
                  description: 'The sample of Oa14 is not saturated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The sample of Oa14 is saturated',
                },
              ],
            },
            {
              description: 'Saturated at Oa13',
              first_bit: 8,
              bit_count: 1,
              values: [
                {
                  description: 'The sample of Oa13 is not saturated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The sample of Oa13 is saturated',
                },
              ],
            },
            {
              description: 'Saturated at Oa12',
              first_bit: 9,
              bit_count: 1,
              values: [
                {
                  description: 'The sample of Oa12 is not saturated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The sample of Oa12 is saturated',
                },
              ],
            },
            {
              description: 'Saturated at Oa11',
              first_bit: 10,
              bit_count: 1,
              values: [
                {
                  description: 'The sample of Oa11 is not saturated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The sample of Oa11 is saturated',
                },
              ],
            },
            {
              description: 'Saturated at Oa10',
              first_bit: 11,
              bit_count: 1,
              values: [
                {
                  description: 'The sample of Oa10 is not saturated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The sample of Oa10 is saturated',
                },
              ],
            },
            {
              description: 'Saturated at Oa09',
              first_bit: 12,
              bit_count: 1,
              values: [
                {
                  description: 'The sample of Oa09 is not saturated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The sample of Oa09 is saturated',
                },
              ],
            },
            {
              description: 'Saturated at Oa08',
              first_bit: 13,
              bit_count: 1,
              values: [
                {
                  description: 'The sample of Oa08 is not saturated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The sample of Oa08 is saturated',
                },
              ],
            },
            {
              description: 'Saturated at Oa07',
              first_bit: 14,
              bit_count: 1,
              values: [
                {
                  description: 'The sample of Oa07 is not saturated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The sample of Oa07 is saturated',
                },
              ],
            },
            {
              description: 'Saturated at Oa06',
              first_bit: 15,
              bit_count: 1,
              values: [
                {
                  description: 'The sample of Oa06 is not saturated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The sample of Oa06 is saturated',
                },
              ],
            },
            {
              description: 'Saturated at Oa05',
              first_bit: 16,
              bit_count: 1,
              values: [
                {
                  description: 'The sample of Oa05 is not saturated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The sample of Oa05 is saturated',
                },
              ],
            },
            {
              description: 'Saturated at Oa04',
              first_bit: 17,
              bit_count: 1,
              values: [
                {
                  description: 'The sample of Oa04 is not saturated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The sample of Oa04 is saturated',
                },
              ],
            },
            {
              description: 'Saturated at Oa03',
              first_bit: 18,
              bit_count: 1,
              values: [
                {
                  description: 'The sample of Oa03 is not saturated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The sample of Oa03 is saturated',
                },
              ],
            },
            {
              description: 'Saturated at Oa02',
              first_bit: 19,
              bit_count: 1,
              values: [
                {
                  description: 'The sample of Oa02 is not saturated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The sample of Oa02 is saturated',
                },
              ],
            },
            {
              description: 'Saturated at Oa01',
              first_bit: 20,
              bit_count: 1,
              values: [
                {
                  description: 'The sample of Oa01 is not saturated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'The sample of Oa01 is saturated',
                },
              ],
            },
            {
              description: 'Dubious',
              first_bit: 21,
              bit_count: 1,
              values: [
                {
                  description: |||
                    Any pixel's sample is not contaminated
                    by a neighbor saturated sample or the Instrument Source
                    Packet it was extracted from is not corrupted
                  |||,
                  value: 0,
                },
                {
                  value: 1,
                  description: |||
                    Any pixel's sample is potentially contaminated
                    by a neighbor saturated sample or the Instrument Source
                    Packet it was extracted from is corrupted
                  |||,
                },
              ],
            },
            {
              description: 'Sun-glint risk',
              first_bit: 22,
              bit_count: 1,
              values: [
                {
                  description: |||
                    The viewing and wind conditions are such that
                    the Sun may not cause glint to occur on pixels over water
                    surfaces
                  |||,
                  value: 0,
                },
                {
                  value: 1,
                  description: |||
                    The viewing and wind conditions are such that
                    the Sun may cause glint to occur on pixels over water surfaces
                    (this flag is set only on the basis of sun and viewing
                    angles taking into account wind conditions, but it is not
                    set according to radiometric data)
                  |||,
                },
              ],
            },
            {
              description: 'Duplicate',
              first_bit: 23,
              bit_count: 1,
              values: [
                {
                  description: |||
                    Pixel is not derived from the same instrument
                    pixel as one of its neighbors during the re-sampling process
                  |||,
                  value: 0,
                },
                {
                  value: 1,
                  description: |||
                    Pixel is derived from the same instrument pixel
                    as one of its neighbors during the re-sampling process
                  |||,
                },
              ],
            },
            {
              description: 'Cosmetic',
              first_bit: 24,
              bit_count: 1,
              values: [
                {
                  description: 'Pixel has not been filled with cosmetic values',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Pixel has been filled with cosmetic values',
                },
              ],
            },
            {
              description: 'Invalid',
              first_bit: 25,
              bit_count: 1,
              values: [
                {
                  description: 'Pixel is valid',
                  value: 0,
                },
                {
                  value: 1,
                  description: |||
                    Pixel is invalid, i.e. its value is missing
                    either because it is out of the instrument swath or because
                    of missing or unusable Level 0 data
                  |||,
                },
              ],
            },
            {
              description: 'Straylight risk',
              first_bit: 26,
              bit_count: 1,
              values: [
                {
                  description: 'Stray light correction (of the Ground Imager) quality is not degraded',
                  value: 0,
                },
                {
                  value: 1,
                  description: |||
                    Stray light correction (of the Ground Imager)
                    quality is degraded because not enough neighbor pixels
                    were available for its estimation
                  |||,
                },
              ],
            },
            {
              description: 'Bright',
              first_bit: 27,
              bit_count: 1,
              values: [
                {
                  description: 'Pixel is not bright',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Pixel is bright',
                },
              ],
            },
            {
              description: 'Tidal region',
              first_bit: 28,
              bit_count: 1,
              values: [
                {
                  description: 'Pixel is not over a tidal region',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Pixel is over a tidal region',
                },
              ],
            },
            {
              description: 'Fresh inland water',
              first_bit: 29,
              bit_count: 1,
              values: [
                {
                  description: 'Pixel is not over fresh water, rivers, or lakes',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Pixel is over fresh water, rivers, or lakes',
                },
              ],
            },
            {
              description: 'Coastline',
              first_bit: 30,
              bit_count: 1,
              values: [
                {
                  description: 'Pixel is not on coastline',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Pixel is on coastline',
                },
              ],
            },
            {
              description: 'Land',
              first_bit: 31,
              bit_count: 1,
              values: [
                {
                  description: 'Pixel is over water',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Pixel is over land',
                },
              ],
            },
          ],
          total_bit_count: 32,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'RGB',
        lookat: {
          lat: 1.45,
          lon: 46.043,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              255.0,
            ],
            gamma: [
              1.5,
            ],
            bands: [
              'Oa08_radiance',
              'Oa06_radiance',
              'Oa04_radiance',
            ],
          },
        },
      },
    ],
  },
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 2,
  },
  'gee:terms_of_use': |||
    The use of Sentinel data is governed by the [Copernicus
    Sentinel Data Terms and Conditions.](https://sentinel.esa.int/documents/247904/690755/Sentinel_Data_Legal_Notice)
  |||,
}
