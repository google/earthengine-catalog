local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local units = import 'units.libsonnet';

{
  multi_layer_bands:
  [
    {
      name: 'AIRDENS',
      description: 'Air density',
      units: units.density_si,
    },
    {
      name: 'SO2',
      description: 'Sulphur dioxide',
      units: units.mass_fraction,
    },
    {
      name: 'DELP',
      description: 'Pressure thickness',
      units: units.pascal,
    },
    {
      name: 'SS004',
      description: 'Sea Salt Mixing Ratio (bin 004)',
      units: units.mass_fraction,
    },
    {
      name: 'DU005',
      description: 'Dust Mixing Ratio (bin 005)',
      units: units.mass_fraction,
    },
    {
      name: 'DU004',
      description: 'Dust Mixing Ratio (bin 004)',
      units: units.mass_fraction,
    },
    {
      name: 'SS005',
      description: 'Sea Salt Mixing Ratio (bin 005)',
      units: units.mass_fraction,
    },
    {
      name: 'OCPHILIC',
      description: 'Hydrophilic Organic Carbon (Particulate Matter)',
      units: units.mass_fraction,
    },
    {
      name: 'BCPHOBIC',
      description: 'Hydrophobic Black Carbon',
      units: units.mass_fraction,
    },
    {
      name: 'SS002',
      description: 'Sea Salt Mixing Ratio (bin 002)',
      units: units.mass_fraction,
    },
    {
      name: 'DU003',
      description: 'Dust Mixing Ratio (bin 003)',
      units: units.mass_fraction,
    },
    {
      name: 'DMS',
      description: 'Dimethylsulphide',
      units: units.mass_fraction,
    },
    {
      name: 'SO4',
      description: 'Sulphate aerosol',
      units: units.mass_fraction,
    },
    {
      name: 'DU002',
      description: 'Dust Mixing Ratio (bin 002)',
      units: units.mass_fraction,
    },
    {
      name: 'PS',
      description: 'Surface Pressure',
      units: units.pascal,
    },
    {
      name: 'SS003',
      description: 'Sea Salt Mixing Ratio (bin 003)',
      units: units.mass_fraction,
    },
    {
      name: 'DU001',
      description: 'Dust Mixing Ratio (bin 001)',
      units: units.mass_fraction,
    },
    {
      name: 'OCPHOBIC',
      description: 'Hydrophobic Organic Carbon (Particulate Matter)',
      units: units.mass_fraction,
    },
    {
      name: 'BCPHILIC',
      description: 'Hydrophilic Black Carbon',
      units: units.mass_fraction,
    },
    {
      name: 'MSA',
      description: 'Methanesulphonic acid',
      units: units.mass_fraction,
    },
    {
      name: 'SS001',
      description: 'Sea Salt Mixing Ratio (bin 001)',
      units: units.mass_fraction,
    },
  ],
  single_layer_bands:
  [
    {
      name: 'LWI',
      description: 'land(1)_water(0)_ice(2)_flag',
    },
    {
      name: 'RH',
      description: 'relative_humidity_after_moist',
    },
  ],
}