local units = import 'units.libsonnet';

{
  summaries: {
    gsd: [
      111320.0,
    ],
    instruments: [
      'VIIRS',
    ],
    'eo:bands': [
      {
        name: 'Aerosol_Optical_Thickness_550_Land_Count',
        description: 'Count of aerosol optical thickness retrievals at 550 nm over land',
        'gee:units': units.count,
      },
      {
        name: 'Aerosol_Optical_Thickness_550_Land_Maximum',
        description: 'Maximum aerosol optical thickness at 550 nm over land',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Aerosol_Optical_Thickness_550_Land_Mean',
        description: 'Mean aerosol optical thickness at 550 nm over land',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Aerosol_Optical_Thickness_550_Land_Minimum',
        description: 'Minimum aerosol optical thickness at 550 nm over land',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Aerosol_Optical_Thickness_550_Land_Ocean_Count',
        description: 'Total count of aerosol optical thickness retrievals at 550 nm over land and ocean',
        'gee:units': units.count,
      },
      {
        name: 'Aerosol_Optical_Thickness_550_Land_Ocean_Maximum',
        description: 'Maximum aerosol optical thickness at 550 nm over land and ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Aerosol_Optical_Thickness_550_Land_Ocean_Mean',
        description: 'Mean aerosol optical thickness at 550 nm over land and ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Aerosol_Optical_Thickness_550_Land_Ocean_Minimum',
        description: 'Minimum aerosol optical thickness at 550 nm over land and ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Aerosol_Optical_Thickness_550_Land_Ocean_Standard_Deviation',
        description: 'Standard deviation of aerosol optical thickness at 550 nm over land and ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Aerosol_Optical_Thickness_550_Land_Standard_Deviation',
        description: 'Standard deviation of aerosol optical thickness at 550 nm over land',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Aerosol_Optical_Thickness_550_Ocean_Count',
        description: 'Count of aerosol optical thickness retrievals at 550 nm over ocean',
        'gee:units': units.count,
      },
      {
        name: 'Aerosol_Optical_Thickness_550_Ocean_Maximum',
        description: 'Maximum aerosol optical thickness at 550 nm over ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Aerosol_Optical_Thickness_550_Ocean_Mean',
        description: 'Mean aerosol optical thickness at 550 nm over ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Aerosol_Optical_Thickness_550_Ocean_Minimum',
        description: 'Minimum aerosol optical thickness at 550 nm over ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Aerosol_Optical_Thickness_550_Ocean_Standard_Deviation',
        description: 'Standard deviation of aerosol optical thickness at 550 nm over ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Aerosol_Type_Land_Ocean_Histogram',
        description: 'Aerosol type classification histogram over land and ocean',
        'gee:units': units.count,
      },
      {
        name: 'Aerosol_Type_Land_Ocean_Mode',
        description: 'Mode of aerosol type classification over land and ocean',
        'gee:classes': [
          {
            value: 0,
            description: 'Mixed / Clean',
          },
          {
            value: 1,
            description: 'Dust',
          },
          {
            value: 2,
            description: 'Smoke',
          },
          {
            value: 3,
            description: 'Non-absorbing / Urban / Industrial / Marine',
          },
        ],
      },
      {
        name: 'Angstrom_Exponent_Land_Maximum',
        description: 'Maximum Angstrom exponent over land',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Angstrom_Exponent_Land_Mean',
        description: 'Mean Angstrom exponent over land',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Angstrom_Exponent_Land_Minimum',
        description: 'Minimum Angstrom exponent over land',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Angstrom_Exponent_Land_Ocean_Maximum',
        description: 'Maximum Angstrom exponent over land and ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Angstrom_Exponent_Land_Ocean_Mean',
        description: 'Mean Angstrom exponent over land and ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Angstrom_Exponent_Land_Ocean_Minimum',
        description: 'Minimum Angstrom exponent over land and ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Angstrom_Exponent_Land_Ocean_Standard_Deviation',
        description: 'Standard deviation of Angstrom exponent over land and ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Angstrom_Exponent_Land_Standard_Deviation',
        description: 'Standard deviation of Angstrom exponent over land',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Angstrom_Exponent_Ocean_Maximum',
        description: 'Maximum Angstrom exponent over ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Angstrom_Exponent_Ocean_Mean',
        description: 'Mean Angstrom exponent over ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Angstrom_Exponent_Ocean_Minimum',
        description: 'Minimum Angstrom exponent over ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Angstrom_Exponent_Ocean_Standard_Deviation',
        description: 'Standard deviation of Angstrom exponent over ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Fine_Mode_Fraction_550_Ocean_Mean',
        description: 'Mean fine-mode aerosol volume/optical fraction at 550 nm over ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Fine_Mode_Fraction_550_Ocean_Standard_Deviation',
        description: 'Standard deviation of fine-mode aerosol fraction at 550 nm over ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Spectral_Aerosol_Optical_Thickness_Land_Count',
        description: 'Count of spectral aerosol optical thickness retrievals over land',
        'gee:units': units.count,
      },
      {
        name: 'Spectral_Aerosol_Optical_Thickness_Land_Mean',
        description: 'Mean spectral aerosol optical thickness over land',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Spectral_Aerosol_Optical_Thickness_Land_Standard_Deviation',
        description: 'Standard deviation of spectral aerosol optical thickness over land',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Spectral_Aerosol_Optical_Thickness_Ocean_Count',
        description: 'Count of spectral aerosol optical thickness retrievals over ocean',
        'gee:units': units.count,
      },
      {
        name: 'Spectral_Aerosol_Optical_Thickness_Ocean_Mean',
        description: 'Mean spectral aerosol optical thickness over ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Spectral_Aerosol_Optical_Thickness_Ocean_Standard_Deviation',
        description: 'Standard deviation of spectral aerosol optical thickness over ocean',
        'gee:units': units.dimensionless,
      },
      {
        name: 'Unsuitable_Pixel_Fraction_Land_Ocean',
        description: 'Fraction of pixels within grid cell deemed unsuitable for aerosol retrieval',
        'gee:units': units.dimensionless,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Aerosol Optical Thickness at 550nm (Land and Ocean)',
        lookat: {
          lat: 20.0,
          lon: 0.0,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'Aerosol_Optical_Thickness_550_Land_Ocean_Mean',
            ],
            min: [
              0.0,
            ],
            max: [
              1.0,
            ],
            palette: [
              '0000ff',
              '00ffff',
              '00ff00',
              'ffff00',
              'ff0000',
            ],
          },
        },
      },
    ],
  },
}
