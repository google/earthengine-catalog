local gedi_l2a = import 'gedi_l2a.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local units = import 'units.libsonnet';

{
  description: |||
    GEDI Level 2B Canopy Cover and Vertical Profile Metrics product (GEDI02_B)
    extracts biophysical metrics from each GEDI waveform. These metrics
    are based on the directional gap probability profile derived from the L1B
    waveform.

    The vertical step between foliage profile measurements
    (known as dZ in GEDI documentation) is always 5 meters.
  |||,
  citation: |||
    GEDI L2B Canopy Cover and Vertical Profile Metrics Data Global Footprint
    Level - GEDI02_B Dubayah, R., H. Tang, J. Armston, S. Luthcke, M. Hofton,
    J. Blair. GEDI L2B Canopy Cover and Vertical Profile Metrics Data Global
    Footprint Level V002. 2021, distributed by NASA EOSDIS Land Processes DAAC.
    Accessed YYYY-MM-DD.
  |||,
  regular_bands: [
    {
      name: 'algorithmrun_flag',
      description: |||
        The L2B algorithm is run if this flag is set to 1 indicating data have
        sufficient waveform fidelity for L2B to run.
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'beam',
      description: 'Beam number',
      type:: ee_const.var_type.int,
    },
    {
      name: 'cover',
      description: 'Total canopy cover',
      'gee:units': units.percent,
      type:: ee_const.var_type.int,
    },
    gedi_l2a.regular_bands[1],
    {
      name: 'delta_time',
      description: |||
        Transmit time of the shot, measured in seconds from the
        master_time_epoch since 2018-01-01
      |||,
      'gee:units': 'seconds',
      type:: ee_const.var_type.double,
    },
    {
      name: 'fhd_normal',
      description: 'Foliage Height Diversity',
      type:: ee_const.var_type.int,
    },
    {
      name: 'l2b_quality_flag',
      description: 'L2B quality flag',
      'gee:units': 'Quality Flag',
      type:: ee_const.var_type.int,
    },
    {
      name: 'local_beam_azimuth',
      description: |||
        Azimuth of the unit pointing vector for the laser in the local ENU
        frame measured from North and positive towards East.
      |||,
      'gee:units': units.radian,
      type:: ee_const.var_type.int,
    },
    {
      name: 'local_beam_elevation',
      description: |||
        Elevation of the unit pointing vector for the laser in the local ENU
        frame measured from East-North plane and positive towards Up.
      |||,
      'gee:units': units.radian,
      type:: ee_const.var_type.int,
    },
    {
      name: 'pai',
      description: 'Total Plant Area Index',
      'gee:units': units.area_fraction,
      type:: ee_const.var_type.int,
    },
    {
      name: 'pgap_theta',
      description: 'Total Gap Probability (theta)',
      type:: ee_const.var_type.int,
    },
    {
      name: 'selected_l2a_algorithm',
      description: 'Selected L2A algorithm setting',
      type:: ee_const.var_type.int,
    },
    {
      name: 'selected_rg_algorithm',
      description: 'Selected R (ground) algorithm',
      type:: ee_const.var_type.int,
    },
    {
      name: 'sensitivity',
      description: |||
          Maxmimum canopy cover that can be penetrated. Valid range is [0, 1].
          Values outside of this range may be present but must be ignored.
          They represent noise and non-land surface waveforms.
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'solar_azimuth',
      description: |||
        The azimuth of the sun position vector from the laser bounce point
        position in the local ENU frame measured from North and is positive
        towards East.
      |||,
      'gee:units': units.degree,
      type:: ee_const.var_type.int,
    },
    {
      name: 'solar_elevation',
      description: |||
        The elevation of the sun position vector from the laser bounce point
        position in the local ENU frame measured from the East-North plane and
        is positive Up.
      |||,
      'gee:units': units.degree,
      type:: ee_const.var_type.int,
    },
    gedi_l2a.shot_number,
    {
      name: 'shot_number_within_beam',
      description: 'Shot number within beam',
      type:: ee_const.var_type.int,
    },
  ],
  cover_bands: [
    {
      name: 'cover_z' + step,
      description: 'Cumulative canopy cover vertical profile at ' + step + units.percent,
      'gee:units': units.percent,
      type:: ee_const.var_type.int,
    }
    for step in std.range(0, 30)
  ],
  pai_bands: [
    {
      name: 'pai_z' + step,
      description: 'Plant Area Index profile in ' + step + ' m&sup2;/m&sup2;',
      'gee:units': units.area_fraction,
      type:: ee_const.var_type.int,
    }
    for step in std.range(0, 30)
  ],
  pavd_bands: [
    {
      name: 'pavd_z' + step,
      description: 'Plant Area Volume Density profile in '+
          step +' m&sup2;/m&sup3;',
      'gee:units': 'm^2/m^3',
      type:: ee_const.var_type.int,
    }
    for step in std.range(0, 30)
  ],
}
