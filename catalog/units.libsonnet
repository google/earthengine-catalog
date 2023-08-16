// Units for numerical values.
//
// https://en.wikipedia.org/wiki/Unit_of_measurement
//
// Notes:
// - Use American English.  For example: use meter, not metre.
// - See these for units documentation and conversions:
//   - https://en.wikipedia.org/wiki/International_System_of_Units
//   - https://en.wikipedia.org/wiki/List_of_physical_quantities
//   - https://en.wikipedia.org/wiki/SI_derived_unit
//   - https://en.wikipedia.org/wiki/Template:SI_other_units
//   - https://physics.nist.gov/cuu/Units/checklist.html
//
// TODO(b/198646525): All bands and schema should have units fields.
// TODO(b/198646525): Flush out the rest of the units

{
  // https://en.wikipedia.org/wiki/Acceleration
  acceleration_si: 'm/s^2',

  // https://en.wikipedia.org/wiki/Area_density
  area_density: 'kg/m^2',
  area_density_megagrams_per_hectare: 'Mg/ha',

  // Unitless fraction of area covering an area.
  // Example: m^2 / m^2
  area_fraction: 'Area fraction',

  // https://en.wikipedia.org/wiki/Bar_(unit)
  millibar: 'mbar',

  // https://en.wikipedia.org/wiki/Celsius
  celsius: '&deg;C',

  // A number of items.
  count: 'count',
  count_per_day: 'count/d',

  // http://www.iau.org/science/publications/proceedings_rules/units/
  day: 'd',

  // https://en.wikipedia.org/wiki/Decibel
  // For fixed reference value use, the reference needs to be known.
  decibel: 'dB',

  // https://en.wikipedia.org/wiki/Dimensionless_quantity
  dimensionless: 'Dimensionless',

  // https://en.wikipedia.org/wiki/Dobson_unit
  dobson: 'Dobson',

  // https://en.wikipedia.org/wiki/Degree_(angle)
  degree: 'deg',

  // https://en.wikipedia.org/wiki/Density
  density_si: 'kg/m^3',
  density_mg_per_m_cubed: 'mg/m^3',

  // Digital Number (DN) is an uncalibrated pixel value.
  // https://www.oxfordreference.com/display/10.1093/oi/authority.20110803095718218
  // https://en.wikipedia.org/wiki/DN
  // https://en.wikipedia.org/wiki/Analog-to-digital_converter
  dn: 'dn',

  // https://en.wikipedia.org/wiki/Hertz
  giga_hertz: 'GHz',

  // https://en.wikipedia.org/wiki/Hectare
  hectare: 'ha',
  square_m: 'm^2',
  square_km: 'km^2',

  // http://www.iau.org/science/publications/proceedings_rules/units/
  hour: 'h',

  // Time spent in an area.
  hour_per_square_km: 'h/km^2',

  // https://en.wikipedia.org/wiki/Joule
  // https://en.wikipedia.org/wiki/Flux
  // https://en.wikipedia.org/wiki/Radiant_exposure
  // Energy storage https://en.wikipedia.org/wiki/Units_of_energy
  joules_per_meter2: 'J/m^2',

  // https://en.wikipedia.org/wiki/Kelvin
  kelvin: 'K',

  // https://en.wikipedia.org/wiki/Kilogram
  // Unused: kilogram: 'kg',
  gigagrams: 'Gg',

  // https://en.wikipedia.org/wiki/Convective_available_potential_energy (CAPE)
  // https://en.wikipedia.org/wiki/Specific_energy
  joules_per_kg: 'J/kg',

  // https://simple.wikipedia.org/wiki/Knot_(speed)
  knot: 'kt',

  // https://en.wikipedia.org/wiki/Mass_fraction_(chemistry)
  mass_fraction: 'Mass fraction',
  // https://en.wikipedia.org/wiki/Mole_fraction
  // https://www.nist.gov/pml/special-publication-811/nist-guide-si-chapter-8
  // a.k.a. molar fraction
  // See also: https://en.wikipedia.org/wiki/Mixing_ratio
  mole_fraction: 'Mol fraction',

  // https://en.wikipedia.org/wiki/Metre
  meter: 'm',
  centimeter: 'cm',
  kilometer: 'km',
  micrometer: '&micro;m',
  millimeter: 'mm',

  // Typically used for evaporation.
  millimeter_per_day: 'mm/d',

  // http://www.iau.org/science/publications/proceedings_rules/units/
  minute: 'min',

  // https://usma.org/detailed-list-of-metric-system-units-and-symbols
  nautical_mile: 'nmi',

  // https://en.wikipedia.org/wiki/Pascal_(unit)
  pascal: 'Pa',
  hectopascal: 'hPa',
  kilopascal: 'kPa',

  // https://en.wikipedia.org/wiki/Percentage
  // https://en.wikipedia.org/wiki/Percent_sign
  percent: '%',
  percent_per_year: '%/y',

  // Number of pixels.
  // TODO(b/198646525): Should we distinguish between distance and area?
  pixel: 'pixel',

  // https://en.wikipedia.org/wiki/Salinity
  practical_salinity_unit: 'psu',

  // https://en.wikipedia.org/wiki/Pressure
  pressure_si: 'N/m^2',

  // https://en.wikipedia.org/wiki/Radians
  radian: 'rad',

  // https://en.wikipedia.org/wiki/Radiance
  // https://en.wikipedia.org/wiki/Steradian
  // radiance: 'Watts/sr/m^2',
  radiance_nanowatts_cm2: 'nanoWatts/sr/cm^2',

  // https://en.wikipedia.org/wiki/Precipitation#Measurement
  rainfall_rate_kg_per_m2_per_s: 'kg/m^2/s',

  // https://en.wikipedia.org/wiki/Fraction
  unspecified_fraction: 'Fraction',

  // https://en.wikipedia.org/wiki/Velocity
  velocity_si: 'm/s',

  // https://en.wikipedia.org/wiki/Volume_fraction
  volume_fraction: 'Volume fraction',

  // https://en.wikipedia.org/wiki/Watt
  // Unused: watt: 'w',
  megawatt: 'MW',

  // https://en.wikipedia.org/wiki/Irradiance
  // https://en.wikipedia.org/wiki/Flux
  watt_per_meter_squared: 'W/m^2',

  // 'Year' is controversial:
  // https://rock.geosociety.org/net/gsatoday/archive/22/2/pdf/i1052-5173-22-2-28.pdf
  // We pick 'y' for consistency with 'd' and 'h'
  year: 'y',
}
