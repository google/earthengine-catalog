local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local units = import 'units.libsonnet';

{
  bands_common:
    [
      {
        name: 'ACET',
        description: 'Acetone (CH3C(O)CH3, MW=58.09 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'ALD2',
        description: 'Acetaldehyde (CH3CHO, MW=44.06 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'ALK4',
        description: 'Lumped >= C4 Alkanes (MW=58.12 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'AOD550_BC',
        description: 'Aerosol optical depth at 550 nm of black carbon aerosols',
        'gee:units': units.dimensionless,
      },
      {
        name: 'AOD550_DUST',
        description: 'Aerosol optical depth at 550 nm of dust aerosols',
        'gee:units': units.dimensionless,
      },
      {
        name: 'AOD550_OC',
        description: 'Aerosol optical depth at 550 nm of organic aerosols',
        'gee:units': units.dimensionless,
      },
      {
        name: 'AOD550_PSC',
        description: 'Aerosol optical depth at 550 nm of polar stratospheric cloud',
        'gee:units': units.dimensionless,
      },
      {
        name: 'AOD550_SLA',
        description: 'Aerosol optical depth at 550 nm of stratospheric liquid aerosols',
        'gee:units': units.dimensionless,
      },
      {
        name: 'AOD550_SNA',
        description: 'Aerosol optical depth at 550 nm of sulfate-nitrate-ammonium aerosols',
        'gee:units': units.dimensionless,
      },
      {
        name: 'AOD550_SS',
        description: 'Aerosol optical depth at 550 nm of sea salt aerosols',
        'gee:units': units.dimensionless,
      },
      {
        name: 'BCPI',
        description: 'Hydrophilic black carbon aerosol (C, MW=12.01 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'BCPO',
        description: 'Hydrophobic black carbon aerosol (C, MW=12.01 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'BENZ',
        description: 'Benzene (C6H6, MW=78.12 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'C2H6',
        description: 'Ethane (C2H6, MW=30.08 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'C3H8',
        description: 'Propane (C3H8, MW=44.11 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'CLDTT',
        description: 'Total cloud area fraction',
        'gee:units': units.dimensionless,
      },
      {
        name: 'CO',
        description: 'Carbon monoxide (CO, MW=28.01 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'COSZ',
        description: 'Cosine of the solar zenith angle',
        'gee:units': units.dimensionless,
      },
      {
        name: 'DST1',
        description: 'Dust aerosol; Reff = 0.7 microns (MW=29.0 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'DST2',
        description: 'Dust aerosol; Reff = 1.4 microns (MW=29.0 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'DST3',
        description: 'Dust aerosol; Reff = 2.4 microns (MW=29.0 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'DST4',
        description: 'Dust aerosol; Reff = 4.5 microns (MW=29.0 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'EMIS_ACET',
        description: 'Acetone total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_ACET_ANTH',
        description: 'Acetone industry emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_ACET_BB',
        description: 'Acetone biomass burning emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_ACET_BG',
        description: 'Acetone biogenic emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_ACET_OC',
        description: 'Acetone ocean emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_ALD2',
        description: 'Acetaldehyde total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_ALD2_ANTH',
        description: 'Acetaldehyde industry emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_ALD2_BB',
        description: 'Acetaldehyde biomass burning emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_ALD2_BG',
        description: 'Acetaldehyde biogenic emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_ALD2_OC',
        description: 'Acetaldehyde ocean emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_ALK4',
        description: 'Lumped alkanes c4 and higher total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_ALK4_ANTH',
        description: 'Lumped alkanes c4 and higher industry emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_ALK4_BB',
        description: 'Lumped alkanes c4 and higher biomass burning emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_BCPI',
        description: 'Hydrophilic black carbon total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_BCPI_ANTH',
        description: 'Hydrophilic black carbon industry emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_BCPI_BB',
        description: 'Hydrophilic black carbon biomass emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_BCPO',
        description: 'Hydrophobic black carbon total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_BCPO_ANTH',
        description: 'Hydrophobic black carbon industry emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_BCPO_BB',
        description: 'Hydrophobic black carbon biomass emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_BENZ',
        description: 'Benzene total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_C2H6',
        description: 'Ethane total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_C2H6_ANTH',
        description: 'Ethane industry emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_C2H6_BB',
        description: 'Ethane biomass burning emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_C3H8',
        description: 'Propane total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_C3H8_ANTH',
        description: 'Propane industry emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_C3H8_BB',
        description: 'Propane biomass burning emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_CH2Br2',
        description: 'Dibromomethane total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_CH2I2',
        description: 'Diiodomethane total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_CH2IBr',
        description: 'Bromoiodomethane total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_CH2ICl',
        description: 'Chloroiodomethane total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_CH3I',
        description: 'Methyl iodide total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_CHBr3',
        description: 'Bromoform total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_CO',
        description: 'Carbon monoxide total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_CO_AGR',
        description: 'Carbon monoxide agriculture emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_CO_ANTH',
        description: 'Carbon monoxide industry emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_CO_BB',
        description: 'Carbon monoxide biomass emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_CO_BG',
        description: 'Carbon monoxide biogenic emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_CO_SHIP',
        description: 'Carbon monoxide ship emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_DMS',
        description: 'Dimethyl sulfide total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_DST1',
        description: 'Dust aerosol 0.7 microns emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_DST2',
        description: 'Dust aerosol 1.4 microns emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_DST3',
        description: 'Dust aerosol 2.4 microns emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_DST4',
        description: 'Dust aerosol 4.5 microns emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_EOH',
        description: 'Ethanol total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_EOH_ANTH',
        description: 'Ethanol industry emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_EOH_BG',
        description: 'Ethanol biogenic emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_HCHO',
        description: 'Formaldehyde total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_HCHO_ANTH',
        description: 'Formaldehyde industry emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_HCHO_BB',
        description: 'Formaldehyde biomass burning emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_HCOOH',
        description: 'Formic acid total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_HNO2',
        description: 'Nitrous acid total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_HOI',
        description: 'Hypoiodous acid total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_I2',
        description: 'Molecular iodine total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_ISOP',
        description: 'Isoprene total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_LIMO_BG',
        description: 'LIMO biogenic emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_MEK',
        description: 'Methyl ethyl ketone total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_MEK_ANTH',
        description: 'Methyl ethyl ketone industry emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_MEK_BB',
        description: 'Methyl ethyl ketone biomass burning emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_MTPA_BG',
        description: 'MTPA biogenic emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_MTPO_BG',
        description: 'MTPO biogenic emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_NH3',
        description: 'Ammonia total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_NH3_AGR',
        description: 'Ammonia agriculture emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_NH3_ANTH',
        description: 'Ammonia industry emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_NH3_BB',
        description: 'Ammonia biomass burning emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_NO',
        description: 'Nitric oxide total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_NO2',
        description: 'Nitrogen dioxide total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_NO2_AGR',
        description: 'Nitrogen dioxide agriculture emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_NO2_ANTH',
        description: 'Nitrogen dioxide industry emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_NO2_BB',
        description: 'Nitrogen dioxide biomass emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_NO2_SHIP',
        description: 'Nitrogen dioxide ship emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_NO_AGR',
        description: 'Nitric oxide agriculture emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_NO_ANTH',
        description: 'Nitric oxide industry emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_NO_BB',
        description: 'Nitric oxide biomass emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_NO_LGHT',
        description: 'Nitric oxide lightning emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_NO_SHIP',
        description: 'Nitric oxide ship emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_NO_SOIL',
        description: 'Nitric oxide soil emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_OCPI',
        description: 'Hydrophilic organic carbon total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_OCPI_ANTH',
        description: 'Hydrophilic organic carbon industry emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_OCPI_BB',
        description: 'Hydrophilic organic carbon biomass emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_OCPO',
        description: 'Hydrophobic organic carbon total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_OCPO_ANTH',
        description: 'Hydrophobic organic carbon industry emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_OCPO_BB',
        description: 'Hydrophobic organic carbon biomass emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_PRPE',
        description: 'Lumped alkenes c3 and higher total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_PRPE_ANTH',
        description: 'Lumped alkenes c3 and higher industry emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_PRPE_BB',
        description: 'Lumped alkenes c3 and higher biomass burning emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_PRPE_BG',
        description: 'Lumped alkenes c3 and higher biogenic emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_SALA',
        description: 'Sea-salt aerosol accumulation mode 0.01-0.05 microns total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_SALC',
        description: 'Sea-salt aerosol coarse mode 0.5-8 microns total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_SESQ_BG',
        description: 'SESQ biogenic emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_SO2',
        description: 'Sulfur dioxide total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_SO2_ANTH',
        description: 'Sulfur dioxide industry emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_SO2_BB',
        description: 'Sulfur dioxide biomass emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_SO2_SHIP',
        description: 'Sulfur dioxide ship emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_SO2_VOLC',
        description: 'Sulfur dioxide eruptive volcano emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_SO4',
        description: 'Sulfate total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_SO4_ANTH',
        description: 'Sulfate industry emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_SO4_BB',
        description: 'Sulfate biomass emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_SO4_SHIP',
        description: 'Sulfate ship emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_SO4_VOLC',
        description: 'Sulfate eruptive volcano emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_SOAP',
        description: 'SOA precursor total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_SOAP_ANTH',
        description: 'SOA precursor industry emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_SOAP_BG',
        description: 'SOA precursor biogenic emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_SOAS',
        description: 'SOA simple total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_SOAS_BG',
        description: 'SOA simple biogenic emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_TOLU',
        description: 'Toluene total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_XYLE',
        description: 'Xylene total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EMIS_pFe',
        description: 'Anthropogenic iron total emission mass flux',
        'gee:units': units.mass_flux_kg_per_m2_per_s,
      },
      {
        name: 'EOH',
        description: 'Ethanol (C2H5OH, MW=46.07 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'FLASHRATE',
        description: 'Lightning flash rate for GEOS-Chem',
        'gee:units': units.flash_rate_km2_per_s,
      },
      {
        name: 'H2O2',
        description: 'Hydrogen peroxide (H2O2, MW=34.02 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'HCHO',
        description: 'Formaldehyde (CH2O, MW=30.03 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'HNO3',
        description: 'Nitric acid (HNO3, MW=63.01 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'HNO4',
        description: 'Peroxynitric acid (HNO4, MW=79.01 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'ISOP',
        description: 'Isoprene (CH2=C(CH3)CH=CH2, MW=68.13 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'MACR',
        description: 'Methacrolein (CH2=C(CH3)CHO, MW=70.1 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'MEK',
        description: 'Methyl Ethyl Ketone (RC(O)R, MW=72.11 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'MVK',
        description: 'Methyl vinyl ketone (CH2=CHC(=O)CH3, MW=70.09 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'N2O5',
        description: 'Dinitrogen pentoxide (N2O5, MW=108.02 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'NH3',
        description: 'Ammonia (NH3, MW=17.04 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'NH4',
        description: 'Ammonium (NH4, MW=18.05 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'NIT',
        description: 'Inorganic nitrates (MW=62.01 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'NO',
        description: 'Nitrogen oxide (NO, MW=30.01 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'NO2',
        description: 'Nitrogen dioxide (NO2, MW=46.01 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'NOy',
        description: 'Total reactive oxidized nitrogen (gas+aerosol) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'O3',
        description: 'Ozone (O3, MW=48.0 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'OCPI',
        description: 'Hydrophilic organic carbon aerosol (MW=12.01 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'OCPO',
        description: 'Hydrophobic organic carbon aerosol (MW=12.01 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'PAN',
        description: 'Peroxyacetyl nitrate (CH3C(O)OONO2, MW=121.06 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'PBLCol_NO2',
        description: 'Boundary layer column density of nitrogen dioxide (MW=46.01 g mol-1)',
        'gee:units': units.trace_gas_molecules_per_cm2,
      },
      {
        name: 'PBLCol_O3',
        description: 'Boundary layer column density of ozone (MW=48.0 g mol-1)',
        'gee:units': units.trace_gas_molecules_per_cm2,
      },
      {
        name: 'PBLCol_SO2',
        description: 'Boundary layer column density of sulfur dioxide (MW=64.04 g mol-1)',
        'gee:units': units.trace_gas_molecules_per_cm2,
      },
      {
        name: 'PHIS',
        description: 'Surface geopotential height',
        'gee:units': units.squared_meter_per_squared_second,
      },
      {
        name: 'PM10_RH35',
        description: 'Particulate matter with diameter less than 10 um mass at RH 35% (includes water) mass concentration in dry air',
        'gee:units': units.mg_per_sq_m,
      },
      {
        name: 'PM25_RH35',
        description: 'Particulate matter with diameter less than 2.5 um mass at RH 35% (includes water) mass concentration in dry air',
        'gee:units': units.mg_per_sq_m,
      },
      {
        name: 'PM25bc_RH35',
        description: 'PM2.5 mass at RH 35% from black carbon mass concentration in dry air',
        'gee:units': units.mg_per_sq_m,
      },
      {
        name: 'PM25du_RH35',
        description: 'PM2.5 mass at RH 35% from dust mass concentration in dry air',
        'gee:units': units.mg_per_sq_m,
      },
      {
        name: 'PM25nit_RH35',
        description: 'PM2.5 mass at RH 35% from nitrate (includes water) mass concentration in dry air',
        'gee:units': units.mg_per_sq_m,
      },
      {
        name: 'PM25nh4_RH35',
        description: 'PM2.5 mass at RH 35% from ammonium (includes water) mass concentration in dry air',
        'gee:units': units.mg_per_sq_m,
      },
      {
        name: 'PM25oc_RH35',
        description: 'PM2.5 mass at RH 35% from primary organic aerosols (includes water) mass concentration in dry air',
        'gee:units': units.mg_per_sq_m,
      },
      {
        name: 'PM25soa_RH35',
        description: 'PM2.5 mass at RH 35% from secondary organic aerosols (includes water) mass concentration in dry air',
        'gee:units': units.mg_per_sq_m,
      },
      {
        name: 'PM25ss_RH35',
        description: 'PM2.5 mass at RH 35% from sea salt aerosols (includes water) mass concentration in dry air',
        'gee:units': units.mg_per_sq_m,
      },
      {
        name: 'PM25su_RH35',
        description: 'PM2.5 mass at RH 35% from sulfates (includes water) mass concentration in dry air',
        'gee:units': units.mg_per_sq_m,
      },
      {
        name: 'PRPE',
        description: 'Lumped >= C3 alkenes (C3H6, MW=42.09 g mol-1) mole fraction in dry air',
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
        name: 'RCHO',
        description: 'Lumped aldehyde >= C3 (CH3CH2CHO, MW=58.09 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'RH',
        description: 'Relative humidity after moist',
        'gee:units': units.dimensionless,
      },
      {
        name: 'SALA',
        description: 'Fine (0.01-0.05 microns) sea salt aerosol (MW=31.4 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'SALC',
        description: 'Coarse (0.5-8 microns) sea salt aerosol (MW=31.4 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'SLP',
        description: 'Sea level pressure',
        'gee:units': units.pascal,
      },
      {
        name: 'SO2',
        description: 'Sulfur dioxide (SO2, MW=64.04 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'SOAP',
        description: 'SOA Precursor - lumped species for simplified SOA parameterization (MW=150.0 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'SOAS',
        description: 'SOA Simple - simplified non-volatile SOA parameterization (MW=150.0 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'T',
        description: 'Air temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'TOLU',
        description: 'Toluene (C7H8, MW=92.15 g mol-1) mole fraction in dry air',
        'gee:units': units.mole_fraction,
      },
      {
        name: 'TotCol_BrO',
        description: 'Total column density of bromine monoxide (MW=95.9 g mol-1)',
        'gee:units': units.trace_gas_molecules_per_cm2,
      },
      {
        name: 'TotCol_CO',
        description: 'Total column density of carbon monoxide (MW=28.01 g mol-1)',
        'gee:units': units.trace_gas_molecules_per_cm2,
      },
      {
        name: 'TotCol_IO',
        description: 'Total column density of iodine monoxide (MW=206.9 g mol-1)',
        'gee:units': units.trace_gas_molecules_per_cm2,
      },
      {
        name: 'TotCol_NO2',
        description: 'Total column density of nitrogen dioxide (MW=46.01 g mol-1)',
        'gee:units': units.trace_gas_molecules_per_cm2,
      },
      {
        name: 'TotCol_O3',
        description: 'Total column density of ozone (MW=48.0 g mol-1)',
        'gee:units': units.dobson,
      },
      {
        name: 'TotCol_SO2',
        description: 'Total column density of SO2 sulfur dioxide (MW=64.04 g mol-1)',
        'gee:units': units.trace_gas_molecules_per_cm2,
      },
      {
        name: 'TPREC',
        description: 'Total precipitation',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'TropCol_BrO',
        description: 'Tropospheric column density of bromine monoxide (MW=95.9 g mol-1)',
        'gee:units': units.trace_gas_molecules_per_cm2,
      },
      {
        name: 'TropCol_CO',
        description: 'Tropospheric column density of carbon monoxide (MW=28.01 g mol-1)',
        'gee:units': units.trace_gas_molecules_per_cm2,
      },
      {
        name: 'TropCol_GLYX',
        description: 'Tropospheric column density of glyoxal (MW=58.04 g mol-1)',
        'gee:units': units.trace_gas_molecules_per_cm2,
      },
      {
        name: 'TropCol_HCHO',
        description: 'Tropospheric column density of formaldehyde (MW=30.03 g mol-1)',
        'gee:units': units.trace_gas_molecules_per_cm2,
      },
      {
        name: 'TropCol_HCOOH',
        description: 'Tropospheric column density of formic acid (MW=46.03 g mol-1)',
        'gee:units': units.trace_gas_molecules_per_cm2,
      },
      {
        name: 'TropCol_IO',
        description: 'Tropospheric column density of iodine monoxide (MW=206.9 g mol-1)',
        'gee:units': units.trace_gas_molecules_per_cm2,
      },
      {
        name: 'TropCol_ISOP',
        description: 'Tropospheric column density of isoprene (MW=100.13 g mol-1)',
        'gee:units': units.trace_gas_molecules_per_cm2,
      },
      {
        name: 'TropCol_NH3',
        description: 'Tropospheric column density of ammonia (MW=17.04 g mol-1)',
        'gee:units': units.trace_gas_molecules_per_cm2,
      },
      {
        name: 'TropCol_NO2',
        description: 'Tropospheric column density of nitrogen dioxide (MW=46.01 g mol-1)',
        'gee:units': units.trace_gas_molecules_per_cm2,
      },
      {
        name: 'TropCol_O3',
        description: 'Tropospheric column density of ozone (MW=48.0 g mol-1)',
        'gee:units': units.dobson,
      },
      {
        name: 'TropCol_PAN',
        description: 'Tropospheric column density of peroxyacetyl nitrate (MW=121.06 g mol-1)',
        'gee:units': units.trace_gas_molecules_per_cm2,
      },
      {
        name: 'TropCol_SO2',
        description: 'Tropospheric column density of sulfur dioxide (MW=64.04 g mol-1)',
        'gee:units': units.trace_gas_molecules_per_cm2,
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
        name: 'V',
        description: 'Northward wind',
        'gee:units': units.velocity_si,
      },
      {
        name: 'XYLE',
        description: 'Xylene (C8H10, MW=106.18 g mol-1) mole fraction in dry air',
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
