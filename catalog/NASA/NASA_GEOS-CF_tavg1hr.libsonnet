local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local units = import 'units.libsonnet';

{
  bands_common:
    [
      {
        name: 'ACET',
        description: 'Acetone (CH3C(O)CH3, MW = 58.08 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'ALD2',
        description: 'Acetaldehyde (CH3CHO, MW = 44.05 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'ALK4',
        description: 'Lumped >= C4 Alkanes (MW = 58.12 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'AOD550_BC',
        description: 'Black carbon optical depth at 550nm',
      },
      {
        name: 'AOD550_CLOUD',
        description: 'Cloud optical depth',
      },
      {
        name: 'AOD550_DST1',
        description: 'Dust bin1 optical depth at 550nm',
      },
      {
        name: 'AOD550_DST2',
        description: 'Dust bin2 optical depth at 550nm',
      },
      {
        name: 'AOD550_DST3',
        description: 'Dust bin3 optical depth at 550nm',
      },
      {
        name: 'AOD550_DST4',
        description: 'Dust bin4 optical depth at 550nm',
      },
      {
        name: 'AOD550_DST5',
        description: 'Dust bin5 optical depth at 550nm',
      },
      {
        name: 'AOD550_DST6',
        description: 'Dust bin6 optical depth at 550nm',
      },
      {
        name: 'AOD550_DST7',
        description: 'Dust bin7 optical depth at 550nm',
      },
      {
        name: 'AOD550_DUST',
        description: 'Dust optical depth at 550nm',
      },
      {
        name: 'AOD550_OC',
        description: 'Organic carbon optical depth at 550nm',
      },
      {
        name: 'AOD550_SALA',
        description: 'Accumulation mode sea salt optical depth at 550nm',
      },
      {
        name: 'AOD550_SALC',
        description: 'Coarse mode sea salt optical depth at 550nm',
      },
      {
        name: 'AOD550_SULFATE',
        description: 'Sulfate optical depth at 550nm',
      },
      {
        name: 'BCPI',
        description: 'Hydrophilic black carbon aerosol (MW = 12.01 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'BCPO',
        description: 'Hydrophobic black carbon aerosol (MW = 12.01 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'BENZ',
        description: 'Benzene (C6H6, MW = 78.11 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'C2H6',
        description: 'Ethane (C2H6, MW = 30.07 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'C3H8',
        description: 'Propane (C3H8, MW = 44.10 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'CH4',
        description: 'Methane (CH4, MW = 16.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'CLDTT',
        description: 'Total cloud area fraction',
      },
      {
        name: 'CO',
        description: 'Carbon monoxide (CO, MW = 28.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'DRYDEPFLX_BCPI',
        description: 'Hydrophilic black carbon aerosol (MW = 12.01 g mol-1) dry deposition flux',
        'gee:units': 'molec cm-2 s-1',
      },
      {
        name: 'DRYDEPFLX_BCPO',
        description: 'Hydrophobic black carbon aerosol (MW = 12.01 g mol-1) dry deposition flux',
        'gee:units': 'molec cm-2 s-1',
      },
      {
        name: 'DRYDEPFLX_DST1',
        description: 'Dust aerosol, Reff = 0.7 microns (MW = 29.00 g mol-1) dry deposition flux',
        'gee:units': 'molec cm-2 s-1',
      },
      {
        name: 'DRYDEPFLX_DST2',
        description: 'Dust aerosol, Reff = 1.4 microns (MW = 29.00 g mol-1) dry deposition flux',
        'gee:units': 'molec cm-2 s-1',
      },
      {
        name: 'DRYDEPFLX_DST3',
        description: 'Dust aerosol, Reff = 2.4 microns (MW = 29.00 g mol-1) dry deposition flux',
        'gee:units': 'molec cm-2 s-1',
      },
      {
        name: 'DRYDEPFLX_DST4',
        description: 'Dust aerosol, Reff = 4.5 microns (MW = 29.00 g mol-1) dry deposition flux',
        'gee:units': 'molec cm-2 s-1',
      },
      {
        name: 'DRYDEPFLX_HCHO',
        description: 'Formaldehyde (CH2O, MW = 30.00 g mol-1) dry deposition flux',
        'gee:units': 'molec cm-2 s-1',
      },
      {
        name: 'DRYDEPFLX_HNO3',
        description: 'Nitric acid (HNO3, MW = 63.00 g mol-1) dry deposition flux',
        'gee:units': 'molec cm-2 s-1',
      },
      {
        name: 'DRYDEPFLX_NH3',
        description: 'Ammonia (NH3, MW = 17.00 g mol-1) dry deposition flux',
        'gee:units': 'molec cm-2 s-1',
      },
      {
        name: 'DRYDEPFLX_NH4',
        description: 'Ammonium (NH4, MW = 18.00 g mol-1) dry deposition flux',
        'gee:units': 'molec cm-2 s-1',
      },
      {
        name: 'DRYDEPFLX_NIT',
        description: 'Inorganic nitrates (MW = 62.00 g mol-1) dry deposition flux',
        'gee:units': 'molec cm-2 s-1',
      },
      {
        name: 'DRYDEPFLX_NO2',
        description: 'Nitrogen dioxide (NO2, MW = 46.00 g mol-1) dry deposition flux',
        'gee:units': 'molec cm-2 s-1',
      },
      {
        name: 'DRYDEPFLX_O3',
        description: 'Ozone (O3, MW = 48.00 g mol-1) dry deposition flux',
        'gee:units': 'molec cm-2 s-1',
      },
      {
        name: 'DRYDEPFLX_OCPI',
        description: 'Hydrophilic organic carbon aerosol (MW = 12.01 g mol-1) dry deposition flux',
        'gee:units': 'molec cm-2 s-1',
      },
      {
        name: 'DRYDEPFLX_OCPO',
        description: 'Hydrophobic organic carbon aerosol (MW = 12.01 g mol-1) dry deposition flux',
        'gee:units': 'molec cm-2 s-1',
      },
      {
        name: 'DRYDEPFLX_SALA',
        description: 'Fine (0.01-0.05 microns) sea salt aerosol (MW = 31.40 g mol-1) dry deposition flux',
        'gee:units': 'molec cm-2 s-1',
      },
      {
        name: 'DRYDEPFLX_SALC',
        description: 'Coarse (0.5-8 microns) sea salt aerosol (MW = 31.40 g mol-1) dry deposition flux',
        'gee:units': 'molec cm-2 s-1',
      },
      {
        name: 'DST1',
        description: 'Dust aerosol, Reff = 0.7 microns (MW = 29.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'DST2',
        description: 'Dust aerosol, Reff = 1.4 microns (MW = 29.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'DST3',
        description: 'Dust aerosol, Reff = 2.4 microns (MW = 29.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'DST4',
        description: 'Dust aerosol, Reff = 4.5 microns (MW = 29.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'EOH',
        description: 'Ethanol (C2H5OH, MW = 46.07 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'H2O2',
        description: 'Hydrogen peroxide (H2O2, MW = 34.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'HCHO',
        description: 'Formaldehyde (CH2O, MW = 30.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'HNO3',
        description: 'Nitric acid (HNO3, MW = 63.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'HNO4',
        description: 'Peroxynitric acid (HNO4, MW = 79.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'ISOP',
        description: 'Isoprene (CH2=C(CH3)CH=CH2, MW = 68.12 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'MACR',
        description: 'Methacrolein (CH2=C(CH3)CHO, MW = 70.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'MEK',
        description: 'Methyl Ethyl Ketone (RC(O)R, MW = 72.11 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'MVK',
        description: 'Methyl vinyl ketone (CH2=CHC(=O)CH3, MW = 70.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'N2O5',
        description: 'Dinitrogen pentoxide (N2O5, MW = 108.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'NH3',
        description: 'Ammonia (NH3, MW = 17.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'NH4',
        description: 'Ammonium (NH4, MW = 18.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'NIT',
        description: 'Inorganic nitrates (MW = 62.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'NO',
        description: 'Nitrogen oxide (NO, MW = 30.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'NO2',
        description: 'Nitrogen dioxide (NO2, MW = 46.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'NOy',
        description: 'Reactive nitrogen = NO NO2 HNO3 HNO4 HONO 2xN2O5 PAN OrganicNitrates AerosolNitrates',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'O3',
        description: 'Ozone (O3, MW = 48.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'OCPI',
        description: 'Hydrophilic organic carbon aerosol (MW = 12.01 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'OCPO',
        description: 'Hydrophobic organic carbon aerosol (MW = 12.01 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'PAN',
        description: 'Peroxyacetyl nitrate (CH3C(O)OONO2, MW = 121.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'PHIS',
        description: 'Surface geopotential height',
        'gee:units': 'm^2 s-2',
      },
      {
        name: 'PM25_RH35_GCC',
        description: 'Particulate matter with diameter below 2.5 um RH 35',
        'gee:units': 'ug m-3',
      },
      {
        name: 'PM25_RH35_GOCART',
        description: 'Total reconstructed PM2.5 RH 35',
        'gee:units': units.density_si,
      },
      {
        name: 'PM25bc_RH35_GCC',
        description: 'Black carbon particulate matter with diameter below 2.5 um RH 35',
        'gee:units': 'ug m-3',
      },
      {
        name: 'PM25du_RH35_GCC',
        description: 'Dust particulate matter with diameter below 2.5 um RH 35',
        'gee:units': 'ug m-3',
      },
      {
        name: 'PM25ni_RH35_GCC',
        description: 'Nitrate particulate matter with diameter below 2.5 um RH 35',
        'gee:units': 'ug m-3',
      },
      {
        name: 'PM25oc_RH35_GCC',
        description: 'Organic carbon particulate matter with diameter below 2.5 um RH 35',
        'gee:units': 'ug m-3',
      },
      {
        name: 'PM25soa_RH35_GCC',
        description: 'Secondary organic aerosol particulate matter with diameter below 2.5 um RH 35',
        'gee:units': 'ug m-3',
      },
      {
        name: 'PM25ss_RH35_GCC',
        description: 'Seasalt particulate matter with diameter below 2.5 um RH 35',
        'gee:units': 'ug m-3',
      },
      {
        name: 'PM25su_RH35_GCC',
        description: 'Sulfate particulate matter with diameter below 2.5 um RH 35',
        'gee:units': 'ug m-3',
      },
      {
        name: 'PRPE',
        description: 'Lumped >= C3 alkenes (C3H6, MW = 42.08 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'PS',
        description: 'Surface pressure',
        'gee:units': units.pascal,
      },
      {
        name: 'Q',
        description: 'Specific humidity',
        'gee:units': units.mass_fraction,
      },
      {
        name: 'Q10M',
        description: '10-meter specific humidity',
        'gee:units': units.mass_fraction,
      },
      {
        name: 'Q2M',
        description: '2-meter specific humidity',
        'gee:units': units.mass_fraction,
      },
      {
        name: 'RCHO',
        description: 'Lumped aldehyde >= C3 (CH3CH2CHO, MW = 58.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'RH',
        description: 'Relative humidity after moist',
      },
      {
        name: 'SALA',
        description: 'Fine (0.01-0.05 microns) sea salt aerosol (MW = 31.40 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'SALC',
        description: 'Coarse (0.5-8 microns) sea salt aerosol (MW = 31.40 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'SLP',
        description: 'Sea level pressure',
        'gee:units': units.pascal,
      },
      {
        name: 'SO2',
        description: 'Sulfur dioxide (SO2, MW = 64.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'SOAP',
        description: 'SOA Precursor - lumped species for simplified SOA parameterization (MW = 150.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'SOAS',
        description: 'SOA Simple - simplified non-volatile SOA parameterization (MW = 150.00 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'T',
        description: 'Air temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'T10M',
        description: '10-meter air temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'T2M',
        description: '2-meter air temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'TOLU',
        description: 'Toluene (C7H8, MW = 92.14 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'TOTCOL_BrO',
        description: 'Bromine monoxide (BrO, MW = 96.00 g mol-1) total column density',
        'gee:units': '1.0e15 molec cm-2',
      },
      {
        name: 'TOTCOL_CO',
        description: 'Carbon monoxide (CO, MW = 28.00 g mol-1) total column density',
        'gee:units': '1.0e15 molec cm-2',
      },
      {
        name: 'TOTCOL_HCHO',
        description: 'Formaldehyde (CH2O, MW = 30.00 g mol-1) total column density',
        'gee:units': '1.0e15 molec cm-2',
      },
      {
        name: 'TOTCOL_IO',
        description: 'Iodine monoxide (IO, MW = 143.00 g mol-1) total column density',
        'gee:units': '1.0e15 molec cm-2',
      },
      {
        name: 'TOTCOL_NO2',
        description: 'Nitrogen dioxide (NO2, MW = 46.00 g mol-1) total column density',
        'gee:units': '1.0e15 molec cm-2',
      },
      {
        name: 'TOTCOL_O3',
        description: 'Ozone (O3, MW = 48.00 g mol-1) total column density',
        'gee:units': units.dobson,
      },
      {
        name: 'TOTCOL_SO2',
        description: 'Sulfur dioxide (SO2, MW = 64.00 g mol-1) total column density',
        'gee:units': '1.0e15 molec cm-2',
      },
      {
        name: 'TPREC',
        description: 'Total precipitation',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'TROPCOL_BrO',
        description: 'Bromine monoxide (BrO, MW = 96.00 g mol-1) tropospheric column density',
        'gee:units': '1.0e15 molec cm-2',
      },
      {
        name: 'TROPCOL_CO',
        description: 'Carbon monoxide (CO, MW = 28.00 g mol-1) tropospheric column density',
        'gee:units': '1.0e15 molec cm-2',
      },
      {
        name: 'TROPCOL_HCHO',
        description: 'Formaldehyde (CH2O, MW = 30.00 g mol-1) tropospheric column density',
        'gee:units': '1.0e15 molec cm-2',
      },
      {
        name: 'TROPCOL_IO',
        description: 'Iodine monoxide (IO, MW = 143.00 g mol-1) tropospheric column density',
        'gee:units': '1.0e15 molec cm-2',
      },
      {
        name: 'TROPCOL_NO2',
        description: 'Nitrogen dioxide (NO2, MW = 46.00 g mol-1) tropospheric column density',
        'gee:units': '1.0e15 molec cm-2',
      },
      {
        name: 'TROPCOL_O3',
        description: 'Ozone (O3, MW = 48.00 g mol-1) tropospheric column density',
        'gee:units': units.dobson,
      },
      {
        name: 'TROPCOL_SO2',
        description: 'Sulfur dioxide (SO2, MW = 64.00 g mol-1) tropospheric column density',
        'gee:units': '1.0e15 molec cm-2',
      },
      {
        name: 'TROPPB',
        description: 'Tropopause pressure based on blended estimate',
        'gee:units': units.pascal,
      },
      {
        name: 'TS',
        description: 'Surface skin temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'U',
        description: 'Eastward wind',
        'gee:units': units.velocity_si,
      },
      {
        name: 'U10M',
        description: '10-meter eastward wind',
        'gee:units': units.velocity_si,
      },
      {
        name: 'U2M',
        description: '2-meter eastward wind',
        'gee:units': units.velocity_si,
      },
      {
        name: 'V',
        description: 'Northward wind',
        'gee:units': units.velocity_si,
      },
      {
        name: 'V10M',
        description: '10-meter northward wind',
        'gee:units': units.velocity_si,
      },
      {
        name: 'V2M',
        description: '2-meter northward wind',
        'gee:units': units.velocity_si,
      },
      {
        name: 'WETDEPFLX_BCPI',
        description: 'Hydrophilic black carbon aerosol (MW = 12.01 g mol-1) vertical integrated loss due to wet scavenging',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'WETDEPFLX_BCPO',
        description: 'Hydrophobic black carbon aerosol (MW = 12.01 g mol-1) vertical integrated loss due to wet scavenging',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'WETDEPFLX_DST1',
        description: 'Dust aerosol, Reff = 0.7 microns (MW = 29.00 g mol-1) vertical integrated loss due to wet scavenging',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'WETDEPFLX_DST2',
        description: 'Dust aerosol, Reff = 1.4 microns (MW = 29.00 g mol-1) vertical integrated loss due to wet scavenging',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'WETDEPFLX_DST3',
        description: 'Dust aerosol, Reff = 2.4 microns (MW = 29.00 g mol-1) vertical integrated loss due to wet scavenging',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'WETDEPFLX_DST4',
        description: 'Dust aerosol, Reff = 4.5 microns (MW = 29.00 g mol-1) vertical integrated loss due to wet scavenging',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'WETDEPFLX_HCHO',
        description: 'Formaldehyde (CH2O, MW = 30.00 g mol-1) vertical integrated loss due to wet scavenging',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'WETDEPFLX_HNO3',
        description: 'Nitric acid (HNO3, MW = 63.00 g mol-1) vertical integrated loss due to wet scavenging',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'WETDEPFLX_NH3',
        description: 'Ammonia (NH3, MW = 17.00 g mol-1) vertical integrated loss due to wet scavenging',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'WETDEPFLX_NH4',
        description: 'Ammonium (NH4, MW = 18.00 g mol-1) vertical integrated loss due to wet scavenging',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'WETDEPFLX_NIT',
        description: 'Inorganic nitrates (MW = 62.00 g mol-1) vertical integrated loss due to wet scavenging',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'WETDEPFLX_OCPI',
        description: 'Hydrophilic organic carbon aerosol (MW = 12.01 g mol-1) vertical integrated loss due to wet scavenging',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'WETDEPFLX_OCPO',
        description: 'Hydrophobic organic carbon aerosol (MW = 12.01 g mol-1) vertical integrated loss due to wet scavenging',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'WETDEPFLX_SALA',
        description: 'Fine (0.01-0.05 microns) sea salt aerosol (MW = 31.40 g mol-1) vertical integrated loss due to wet scavenging',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'WETDEPFLX_SALC',
        description: 'Coarse (0.5-8 microns) sea salt aerosol (MW = 31.40 g mol-1) vertical integrated loss due to wet scavenging',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'WETDEPFLX_SO2',
        description: 'Sulfur dioxide (SO2, MW = 64.00 g mol-1) vertical integrated loss due to wet scavenging',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'WETDEPFLX_SO4',
        description: 'Sulfate (SO4, MW = 96.00 g mol-1) vertical integrated loss due to wet scavenging',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'XYLE',
        description: 'Xylene (C8H10, MW = 106.16 g mol-1) volume mixing ratio dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'ZL',
        description: 'Mid layer heights',
        'gee:units': units.meter,
      },
      {
        name: 'ZPBL',
        description: 'Planetary boundary layer height',
        'gee:units': units.meter,
      },
    ],
}