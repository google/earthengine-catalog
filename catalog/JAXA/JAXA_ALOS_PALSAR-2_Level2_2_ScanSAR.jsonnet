local id = 'JAXA/ALOS/PALSAR-2/Level2_2/ScanSAR';
local subdir = 'JAXA';

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
  // TODO(simonf): consider adding https://github.com/stac-extensions/card4l
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sar,
    ee_const.ext_sci
  ],
  id: id,
  title: 'PALSAR-2 ScanSAR Level 2.2',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The 25 m PALSAR-2 ScanSAR is normalized backscatter data
    of PALSAR-2 broad area observation mode with observation width of 350 km.
    The SAR imagery was ortho-rectificatied and slope corrected
    using the ALOS World 3D - 30 m (AW3D30) Digital Surface Model.
    Polarization data are stored as 16-bit digital numbers (DN).
    The DN values can be converted to gamma naught values in decibel unit (dB)
    using the following equation:

    * &gamma;<sub>0</sub> = 10*log<sub>10</sub>(DN<sup>2</sup>) - 83.0 dB

    Level 2.2 data are ortho-rectified and radiometrically terrain-corrected.

    This dataset is compatible with the
    [Committee on Earth Observation (CEOS)](https://ceos.org/)
    [Analysis Ready Data for LAND (CARD4L)](https://ceos.org/ard/files/PFS/NRB/v5.5/CARD4L-PFS_NRB_v5.5.pdf) standard.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'alos2',
    // 'card4l',
    'eroc',
    'jaxa',
    'palsar2',
    'radar',
    'sar',
  ],
  providers: [
    ee.producer_provider(
        'JAXA EORC',
        'https://www.eorc.jaxa.jp/ALOS/en/dataset/palsar2_l22_e.htm'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2014-08-04T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'AntennaPointing',
        description: 'Antenna pointing direction ("Right" or "Left").',
        type: ee_const.var_type.string,
      },
      {
        name: 'AzimuthPixelSpacing',
        description: 'Azimuth pixel spacing.',
        type: ee_const.var_type.double,
        units: 'm',
      },
      {
        name: 'AzimuthResolution',
        description: 'Azimuth resolution.',
        type: ee_const.var_type.double,
        units: 'm',
      },
      {
        name: 'BeamID',
        description: 'Beam ID.',
        type: ee_const.var_type.string,
      },
      {
        name: 'DataAccess_ProcessingTime',
        description: 'Processing time of this product (ISO8601 string).',
        type: ee_const.var_type.string,
      },
      {
        name: 'DataAccess_SoftwareVersion',
        description: 'Software version of this product.',
        type: ee_const.var_type.string,
      },
      {
        name: 'DigitalElevationModel',
        description: 'Type of DEM used ("Elevation" or "Surface").',
        type: ee_const.var_type.string,
      },
      {
        name: 'EasternBias',
        description: 'Bias of easting error.',
        type: ee_const.var_type.double,
        units: 'degrees',
      },
      {
        name: 'EasternSTDev',
        description: 'Standard deviation of easting error.',
        type: ee_const.var_type.double,
        units: 'degree',
      },
      {
        name: 'Easting_LR',
        description: 'Easting of Lower Right of Product.',
        type: ee_const.var_type.double,
        units: 'm',
      },
      {
        name: 'Easting_UL',
        description: 'Easting of upper left of product.',
        type: ee_const.var_type.double,
        units: 'm',
      },
      {
        name: 'Estimates_HH',
        description: 'Estimated HH value in Noise Equivalent Intensity (NESZ).',
        type: ee_const.var_type.double,
      },
      {
        name: 'Estimates_HV',
        description: 'Estimated HV value in Noise Equivalent Intensity (NESZ).',
        type: ee_const.var_type.double,
      },
      {
        name: 'FilterApplied',
        description: 'Whether a filter was applied ("TRUE" or "FALSE").',
        type: ee_const.var_type.string,
      },
      {
        name: 'FilterType',
        description: 'Filter type (N/A if no filtering was applied).',
        type: ee_const.var_type.string,
      },
      {
        name: 'FirstAcquisitionDate',
        description: |||
          Observation date of the first acquisition (ISO8601 string).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'IDCMethod',
        description: |||
          Ionospheric delay correction ("TEC model" or "Coregistration").
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'IncAngleFarRange',
        description: 'Incident angle in far range.',
        type: ee_const.var_type.double,
        units: 'degree',
      },
      {
        name: 'IncAngleNearRange',
        description: 'Incident angle in near range.',
        type: ee_const.var_type.double,
        units: 'degree',
      },
      {
        name: 'IonosphericDelayCorrectionApplied',
        description: |||
          Whether ionospheric delay correction was applied ("TRUE" or "FALSE").
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'LastAcquisitionDate',
        description: |||
            Observation date of the last acquisition (ISO 8601 string).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'NRAlgorithm',
        description: 'Noise removal algorithm.',
        type: ee_const.var_type.string,
      },
      {
        name: 'NoiseRemovalApplied',
        description: |||
            Whether noise removal algorithm was applied ("TRUE" or "FALSE").
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'NorthernBias',
        description: 'Bias of northing error.',
        type: ee_const.var_type.double,
        units: 'degree',
      },
      {
        name: 'NorthernSTDev',
        description: 'Standard deviation of northing error.',
        type: ee_const.var_type.double,
        units: 'degree',
      },
      {
        name: 'Northing_LR',
        description: 'Northing of lower right of product.',
        type: ee_const.var_type.double,
        units: 'm',
      },
      {
        name: 'Northing_UL',
        description: 'Northing of upper left of product.',
        type: ee_const.var_type.double,
        units: 'm',
      },
      {
        name: 'ObservationMode',
        description: 'Observation mode.',
        type: ee_const.var_type.string,
      },
      {
        name: 'OrbitDataSource',
        description: |||
            Orbit data source (e.g., predicted, definite, precise, downlinked).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'PassDirection',
        description: 'Pass direction ("Ascending" or "Descending").',
        type: ee_const.var_type.string,
      },
      {
        name: 'Polarizations',
        description: |||
          Transmit/Receive polarisation for the data. There
          is one element for each Tx/Rx combination: ['VV'], ['HH'],
          ['VV', 'VH'], or ['HH', 'HV'].
        |||,

        type: ee_const.var_type.string_list,
      },
      {
        name: 'ProductColumnSpacing',
        description: 'Product column spacing.',
        type: ee_const.var_type.double,
        units: 'm',
      },
      {
        name: 'ProductRowSpacing',
        description: 'Product row spacing.',
        type: ee_const.var_type.double,
        units: 'm',
      },
      {
        name: 'Product_Version',
        description: 'Product version.',
        type: ee_const.var_type.double,
      },
      {
        name: 'RSP_Frame_Number',
        description: 'Scene frame number.',
        type: ee_const.var_type.int,
      },
      {
        name: 'RSP_Path_Number',
        description: 'Scene path number.',
        type: ee_const.var_type.int,
      },
      {
        name: 'RadarCenterFrequency',
        description: 'Center frequency.',
        type: ee_const.var_type.double,
        units: 'GHz',
      },
      {
        name: 'RangePixelSpacing',
        description: 'Range pixel spacing.',
        type: ee_const.var_type.double,
        units: 'm',
      },
      {
        name: 'RangeResolution',
        description: 'Range resolution.',
        type: ee_const.var_type.int,
        units: 'm',
      },
      {
        name: 'SlantRangeCorrection',
        description: |||
            The correction for each scan described from the first scan.
        |||,
        units: 'm',
        type: ee_const.var_type.int_list,
      },
      {
        name: 'SourceProcParam_ProcessingDate',
        description: 'Processing date of the source product (ISO8601 string).',
        type: ee_const.var_type.string,
      },
      {
        name: 'SourceProcParam_ProcessingFacility',
        description: 'Processing facility of the source product.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SourceProcParam_ProductID',
        description: 'Product ID of the source product.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SourceProcParam_SoftwareVersion',
        description: 'Software version of the source product.',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      25.0,
    ],
    'sar:instrument_mode': [
      'ScanSAR',
    ],
    'sar:frequency_band': [
      'L',
    ],
    'sar:center_frequency': [
      1.27,
    ],
    'sar:polarizations': [
      'HH',
      'HV',
      'VH',
      'VV',
    ],
    'sar:product_type': [
      'Normalised Radar Backscatter'
    ],
    'sar:resolution_range': [
      25,
    ],
    'sar:resolution_azimuth': [
      25,
    ],
    'eo:bands': [
      {
        name: 'HH',
        description: |||
            HH polarization Terrain-flattened Gamma-Nought backscatter
            coefficient.
        |||,
      },
      {
        name: 'HV',
        description: |||
            HV polarization Terrain-flattened Gamma-Nought backscatter
            coefficient.
        |||,
      },
      {
        name: 'LIN',
        description: |||
          Local incidence angle. The angle formed by the radar irradiation
          direction and the normal of the slope.
        |||,
        'gee:scale': 0.01,
        'gee:units': 'degree'
      },
      {
        // TODO(simonf): we should add some basic SAR guide that explains
        // things like layover and shadow. E.g., see
        // https://www.researchgate.net/figure/Illustrations-of-foreshortening-a-layover-b-and-shadow-c_fig1_328912058
        name: 'MSK',
        description: 'Data quality bitmask.',
        'gee:bitmask': {
          total_bit_count: 3,
          bitmask_parts: [
            {
              description: 'Data quality',
              first_bit: 0,
              bit_count: 3,
              values: [
                {
                  value: 1,
                  description: 'Valid data',
                },
                {
                  value: 2,
                  description: 'Layover',
                },
                {
                  value: 3,
                  description: 'Shadowing',
                },
                {
                  value: 4,
                  description: 'Ocean water',
                },
                {
                  value: 5,
                  description: 'Invalid data',
                },
              ]
            }
          ]
        }
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'HH polarization',
        lookat: {
          lat: -5,
          lon: 143,
          zoom: 8,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              8000.0,
            ],
            bands: [
              'HH',
            ],
          },
        },
      },
    ],
  },
  'gee:terms_of_use': |||
    JAXA retains ownership of the dataset and cannot guarantee
    any problem caused by or possibly caused by using the datasets.

    Anyone wishing to publish any results using the datasets should
    clearly acknowledge the ownership of the data in the publication.

    [Full terms of use](https://gportal.jaxa.jp/gpr/index/eula?lang=en)
  |||,
  'sci:citation': |||
    The data used for this paper have been provided by Earth Observation
    Research Center (EORC) of Japan Aerospace Exploration Agency (JAXA).
  |||,
}
