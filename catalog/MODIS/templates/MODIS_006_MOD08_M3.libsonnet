{
  summaries: {
    gsd: [
      111320.0,
    ],
    instruments: [
      'MODIS',
    ],
    'eo:bands': [
      {
        name: 'Aerosol_Optical_Depth_Land_Ocean_Mean_Mean',
        description: |||
          Aerosol optical thickness at 0.55 microns for both
          ocean (best) and land (corrected): mean of daily mean
        |||,
        'gee:scale': 0.001,
      },
      {
        name: 'Aerosol_Optical_Depth_Land_Ocean_Std_Deviation_Mean',
        description: |||
          Aerosol optical thickness at 0.55 microns for both
          ocean (best) and land (corrected): mean of daily standard deviation
        |||,
        'gee:scale': 0.001,
      },
      {
        name: 'Aerosol_Optical_Depth_Land_QA_Mean_Mean_470',
        description: 'Corrected aerosol optical depth (land) at 0.47 microns:\nmean of level-3 QA weighted mean',
        'gee:scale': 0.001,
      },
      {
        name: 'Aerosol_Optical_Depth_Land_QA_Std_Deviation_Mean_470',
        description: 'Corrected aerosol optical depth (land) at 0.47 microns:\nmean of level-3 weighted QA standard deviation',
        'gee:scale': 0.001,
      },
      {
        name: 'Cirrus_Fraction_SWIR_FMean',
        description: 'Cirrus area fraction: mean of daily fraction',
        'gee:scale': 0.0001,
      },
      {
        name: 'Cirrus_Fraction_SWIR_FStd',
        description: 'Cirrus area fraction: standard deviation of daily fraction',
        'gee:scale': 0.0001,
      },
      {
        name: 'Cloud_Optical_Thickness_Liquid_Log_Mean_Mean',
        description: 'Liquid water cloud optical thickness: mean of daily log mean',
        'gee:scale': 0.001,
      },
      {
        name: 'Cloud_Optical_Thickness_Liquid_Log_Std_Deviation_Mean',
        description: 'Liquid water cloud optical thickness: mean of daily\nlog standard deviation',
        'gee:scale': 0.001,
      },
      {
        name: 'Cloud_Optical_Thickness_Liquid_Mean_Uncertainty',
        description: |||
          Liquid water cloud optical thickness: multi-day absolute
          uncertainty estimate derived from the daily absolute uncertainty
          estimate
        |||,
        'gee:scale': 0.01,
      },
      {
        name: 'Cloud_Optical_Thickness_Liquid_Log_Mean_Uncertainty',
        description: |||
          Liquid water cloud optical thickness: multi-day absolute
          log uncertainty estimate derived from the daily absolute log
          uncertainty estimate
        |||,
        'gee:scale': 0.001,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Aerosol Optical Depth',
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              3000.0,
            ],
            palette: [
              'ffffff',
              '1303ff',
              '01ff09',
              'ff2f00',
            ],
            bands: [
              'Aerosol_Optical_Depth_Land_Ocean_Mean_Mean',
            ],
          },
        },
      },
    ],
    Aerosol_Optical_Depth_Land_Ocean_Mean_Mean: {
      minimum: -100.0,
      maximum: 5000.0,
      'gee:estimated_range': false,
    },
    Aerosol_Optical_Depth_Land_Ocean_Std_Deviation_Mean: {
      minimum: -100.0,
      maximum: 5000.0,
      'gee:estimated_range': false,
    },
    Aerosol_Optical_Depth_Land_QA_Mean_Mean_470: {
      minimum: -100.0,
      maximum: 5000.0,
      'gee:estimated_range': false,
    },
    Aerosol_Optical_Depth_Land_QA_Std_Deviation_Mean_470: {
      minimum: -100.0,
      maximum: 5000.0,
      'gee:estimated_range': false,
    },
    Cirrus_Fraction_SWIR_FMean: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    Cirrus_Fraction_SWIR_FStd: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    Cloud_Optical_Thickness_Liquid_Log_Mean_Mean: {
      minimum: 0.0,
      maximum: 4176.0,
      'gee:estimated_range': false,
    },
    Cloud_Optical_Thickness_Liquid_Log_Std_Deviation_Mean: {
      minimum: 0.0,
      maximum: 4176.0,
      'gee:estimated_range': false,
    },
    Cloud_Optical_Thickness_Liquid_Mean_Uncertainty: {
      minimum: 0.0,
      maximum: 2000.0,
      'gee:estimated_range': false,
    },
    Cloud_Optical_Thickness_Liquid_Log_Mean_Uncertainty: {
      minimum: 0.0,
      maximum: 4477.0,
      'gee:estimated_range': false,
    },
  },
}
