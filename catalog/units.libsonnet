// Units for numerical values.
//
// https://en.wikipedia.org/wiki/Unit_of_measurement
//
// Notes:
// - Use American English.  For example: use meter, not metre.
// - See these for units documentation and conversions:
//   - https://physics.nist.gov/cuu/Units/checklist.html
//   - https://www.unidata.ucar.edu/software/udunits/
//   - https://en.wikipedia.org/wiki/International_System_of_Units
//   - https://en.wikipedia.org/wiki/List_of_physical_quantities
//   - https://en.wikipedia.org/wiki/SI_derived_unit
//   - https://en.wikipedia.org/wiki/Template:SI_other_units
//   - https://www.iau.org/publications/proceedings_rules/units/
//   - https://www.nist.gov/pml/fundamental-physical-constants
//
// TODO(b/198646525): All bands and schema should have units fields.
// TODO(b/198646525): Flush out the rest of the units

{
  // https://en.wikipedia.org/wiki/Area_density
  area_density: 'kg/m^2',

  // Unitless fraction of area covering an area.
  // Example: m^2 / m^2
  area_fraction: '1 (area fraction)',

  // https://en.wikipedia.org/wiki/Bar_(unit)
  millibar: 'mbar',

  // https://en.wikipedia.org/wiki/Celsius
  celsius: '&deg;C',

  // A number of items.
  count: 'count',
  count_per_day: 'count/d',

  // https://en.wikipedia.org/wiki/Day
  day: 'd',

  // https://en.wikipedia.org/wiki/Decibel
  // For fixed reference value use, the reference needs to be known.
  decibel: 'dB',

  // https://en.wikipedia.org/wiki/Dimensionless_quantity
  dimensionless: '1 (dimensionless)',

  // https://en.wikipedia.org/wiki/Dobson_unit
  dobson: 'Dobson',

  // https://en.wikipedia.org/wiki/Degree_(angle)
  degree: 'deg',

  // https://en.wikipedia.org/wiki/Density
  density_si: 'kg/m^3',

  // https://en.wikipedia.org/wiki/Hertz
  giga_hertz: 'GHz',

  // https://en.wikipedia.org/wiki/Hour
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

  // https://simple.wikipedia.org/wiki/Knot_(speed)
  knot: 'kt',

  // https://en.wikipedia.org/wiki/Mass_fraction_(chemistry)
  mass_fraction: '1 (mass fraction)',
  // https://en.wikipedia.org/wiki/Mole_fraction
  // https://www.nist.gov/pml/special-publication-811/nist-guide-si-chapter-8
  // a.k.a. molar fraction
  // See also: https://en.wikipedia.org/wiki/Mixing_ratio
  mole_fraction: '1 (mol fraction)',

  // https://en.wikipedia.org/wiki/Metre
  meters: 'm',
  centimeter: 'cm',
  kilometer: 'km',
  micrometer: '&micro;m',
  millimeter: 'mm',

  // Typically used for evaporation.
  millimeter_per_day: 'mm/d',

  // https://en.wikipedia.org/wiki/Minute
  minute: 'min',

  // https://en.wikipedia.org/wiki/Nautical_mile
  nautical_mile: 'M (nautical mile)',

  // https://en.wikipedia.org/wiki/Percentage
  // https://en.wikipedia.org/wiki/Percent_sign
  percent: '%',

  // Number of pixels.
  // TODO(b/198646525): Should we distinguish between distance and area?
  pixel: 'pixel',

  // https://en.wikipedia.org/wiki/Salinity
  practical_salinity_unit: 'psu',

  // https://en.wikipedia.org/wiki/Radians
  radian: 'rad',

  // https://en.wikipedia.org/wiki/Precipitation#Measurement
  rainfall_rate_kg_per_m2_per_s: 'kg/m^2/s',

  // https://en.wikipedia.org/wiki/Velocity
  velocity_si: 'm/s',

  // https://en.wikipedia.org/wiki/Volume_fraction
  volume_fraction: '1 (volume fraction)',

  // https://en.wikipedia.org/wiki/Year
  year: 'a',
}
