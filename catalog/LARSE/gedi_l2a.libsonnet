local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

{
  description: |||
    GEDI's Level 2A Geolocated Elevation and Height Metrics Product (GEDI02_A)
    is primarily composed of 100 Relative Height (RH) metrics, which
    collectively describe the waveform collected by GEDI.

    The original GEDI02_A product is a table of point with a spatial resolution
    (average footprint) of 25 meters.
  |||,
  keywords: [
    'elevation',
    'gedi',
    'larse',
    'nasa',
    'tree_cover',
    'usgs',
  ],
  providers(name, catalog_url): [
    ee.producer_provider(
      name + 'USFS Laboratory for Applications of Remote Sensing in Ecology (LARSE)',
      'https://www.fs.usda.gov/'
    ),
    // LP DAAC is more of a host
    ee.processor_provider(
      'NASA GEDI mission, accessed through the USGS LP DAAC',
      'https://lpdaac.usgs.gov/products/gedi02_av002/'
    ),
    ee.host_provider(catalog_url),
  ],
  license: spdx.proprietary.id,
  extent: ee.extent(-180,
                    -51.6,
                    180,
                    51.6,
                    '2019-03-25T00:00:00Z',
                    null),
  citation: |||
    GEDI L2A Elevation and Height Metrics Data Global Footprint Level - GEDI02_A
    Dubayah, R., M. Hofton, J. Blair, J. Armston, H. Tang, S. Luthcke. GEDI L2A
    Elevation and Height Metrics Data Global Footprint Level V002. 2021,
    distributed by NASA EOSDIS Land Processes DAAC. Accessed YYYY-MM-DD.
  |||,
  regular_bands: [
    {
      name: 'beam',
      description: 'Beam identifier',
      type:: ee_const.var_type.int,
    },
    {
      name: 'degrade_flag',
      description: |||
        Flag indicating degraded state of pointing and/or
        positioning information.

        * 3X - ADF CHU solution unavailable (ST-2)
        * 4X - Platform attitude
        * 5X - Poor solution (filter covariance large)
        * 6X - Data outage (platform attitude gap also)
        * 7X - ST 1+2 unavailable (similar boresight FOV)
        * 8X - ST 1+2+3 unavailable
        * 9X - ST 1+2+3 and ISS unavailable
        * X1 - Maneuver
        * X2 - GPS data gap
        * X3 - ST blinding
        * X4 - Other
        * X5 - GPS receiver clock drift
        * X6 - Maneuver & GPS receiver clock drift
        * X7 - GPS data gap & GPS receiver clock drift
        * X8 - ST blinding & GPS receiver clock drift
        * X9 - Other & GPS receiver clock drift
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'delta_time',
      description: 'Time delta since Jan 1 00:00 2018',
      'gee:units': 'seconds',
      type:: ee_const.var_type.double,
    },
    {
      name: 'digital_elevation_model',
      description: 'TanDEM-X elevation at GEDI footprint location',
      'gee:units': units.meter,
      type:: ee_const.var_type.double,
    },
    {
      name: 'digital_elevation_model_srtm',
      description: 'SRTM elevation at GEDI footprint location',
      'gee:units': units.meter,
      type:: ee_const.var_type.double,
    },
    {
      name: 'elev_highestreturn',
      description: |||
        Elevation of highest detected return relative
        to reference ellipsoid
      |||,
      'gee:units': units.meter,
      type:: ee_const.var_type.double,
    },
    {
      name: 'elev_lowestmode',
      description: |||
        Elevation of center of lowest mode relative to reference ellipsoid
      |||,
      'gee:units': units.meter,
      type:: ee_const.var_type.double,
    },
    {
      name: 'elevation_bias_flag',
      description: |||
        Elevations potentially affected by 4bin (~60 cm) ranging error
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'energy_total',
      description: |||
        Integrated counts in the return waveform relative to the
        mean noise level
      |||,
      type:: ee_const.var_type.double,
    },
    {
      name: 'landsat_treecover',
      description: |||
        Tree cover in the year 2010, defined as canopy closure for all
        vegetation taller than 5 m in height as a percentage per
        output grid cell
      |||,
      'gee:units': units.percent,
      type:: ee_const.var_type.double,
    },
    {
      name: 'landsat_water_persistence',
      description: |||
        Percent UMD GLAD Landsat observations with classified surface water
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'lat_highestreturn',
      description: 'Latitude of highest detected return',
      'gee:units': units.degree,
      type:: ee_const.var_type.double,
    },
    {
      name: 'leaf_off_doy',
      description: 'GEDI 1 km EASE 2.0 grid leaf-off start day-of-year',
      type:: ee_const.var_type.int,
    },
    {
      name: 'leaf_off_flag',
      description: 'GEDI 1 km EASE 2.0 grid flag',
      type:: ee_const.var_type.int,
    },
    {
      name: 'leaf_on_cycle',
      description: |||
        Flag that indicates the vegetation growing cycle for leaf-on
        observations
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'leaf_on_doy',
      description: 'GEDI 1 km EASE 2.0 grid leaf-on start day-of-year',
      type:: ee_const.var_type.int,
    },
    {
      name: 'lon_highestreturn',
      description: 'Longitude of highest detected return',
      'gee:units': units.degree,
      type:: ee_const.var_type.double,
    },
    {
      name: 'modis_nonvegetated',
      description: 'Percent non-vegetated from MODIS MOD44B V6 data',
      'gee:units': units.percent,
      type:: ee_const.var_type.double,
    },
    {
      name: 'modis_nonvegetated_sd',
      description: |||
        Percent non-vegetated standard deviation from MODIS MOD44B V6 data
      |||,
      'gee:units': units.percent,
      type:: ee_const.var_type.double,
    },
    {
      name: 'modis_treecover',
      description: 'Percent tree cover from MODIS MOD44B V6 data',
      'gee:units': units.percent,
      type:: ee_const.var_type.double,
    },
    {
      name: 'modis_treecover_sd',
      description: |||
        Percent tree cover standard deviation from MODIS MOD44B V6 data
      |||,
      'gee:units': units.percent,
      type:: ee_const.var_type.double,
    },
    {
      name: 'num_detectedmodes',
      description: 'Number of detected modes in rxwaveform',
      type:: ee_const.var_type.int,
    },
    {
      name: 'pft_class',
      description: 'GEDI 1 km EASE 2.0 grid Plant Functional Type (PFT)',
      type:: ee_const.var_type.int,
    },
    {
      name: 'quality_flag',
      description: |||
        Flag indicating likely invalid waveform (1=valid, 0=invalid)
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'region_class',
      description: 'GEDI 1 km EASE 2.0 grid world continental regions',
      type:: ee_const.var_type.int,
    },
    {
      name: 'selected_algorithm',
      description: |||
        Identifier of algorithm selected as identifying the lowest
        non-noise mode
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'selected_mode',
      description: 'Identifier of mode selected as lowest non-noise mode',
      type:: ee_const.var_type.int,
    },
    {
      name: 'selected_mode_flag',
      description: 'Flag indicating status of selected_mode',
      type:: ee_const.var_type.int,
    },
    {
      name: 'sensitivity',
      description: |||
          Maxmimum canopy cover that can be penetrated. Valid range is [0, 1].
          Values outside of this range may be present but must be ignored.
          They represent noise and non-land surface waveforms.
      |||,
      type:: ee_const.var_type.double,
    },
    {
      name: 'solar_azimuth',
      description: |||
        The azimuth of the sun position vector from the laser bounce point
        position in the local ENU frame. The angle is measured from North and
        is positive towards East.
      |||,
      type:: ee_const.var_type.double,
    },
    {
      name: 'solar_elevation',
      description: |||
        The elevation of the sun position vector from the laser bounce point
        position in the local ENU frame. The angle is measured from the
        East-North plane and is positive Up.
      |||,
      type:: ee_const.var_type.double,
    },
    {
      name: 'surface_flag',
      description: |||
        Indicates elev_lowestmode is within 300m of Digital Elevation Model (DEM)
        or Mean Sea Surface (MSS) elevation
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'urban_focal_window_size',
      description: |||
        The focal window size used to calculate urban_proportion. Values are 3
        (3x3 pixel window size) or 5 (5x5 pixel window size).
      |||,
      'gee:units': units.pixel,
      type:: ee_const.var_type.int,
    },
    {
      name: 'urban_proportion',
      description: |||
        The percentage proportion of land area within a focal area
        surrounding each shot that is urban land cover.
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'orbit_number',
      description: 'Orbit number',
      type:: ee_const.var_type.int,
    },
    {
      name: 'minor_frame_number',
      description: 'Minor frame number 0-241()',
      type:: ee_const.var_type.int,
    },
    {
      name: 'shot_number_within_beam',
      description: 'Shot number within beam',
      type:: ee_const.var_type.int,
    },
    {
      name: 'local_beam_azimuth',
      description: |||
        Azimuth in radians of the unit pointing vector for the laser in the
        local ENU frame. The angle is measured from North and positive towards East.
      |||,
      'gee:units': units.radian,
      type:: ee_const.var_type.double,
    },
    {
      name: 'local_beam_elevation',
      description: |||
        Elevation in radians of the unit pointing vector for the laser in the
        local ENU frame. The angle is measured from North and positive towards East.
      |||,
      'gee:units': units.radian,
      type:: ee_const.var_type.double,
    },
  ],
  rh_bands: [
    {
      name: 'rh' + step,
      description: 'Relative height metrics at ' + step + units.percent,
      'gee:units': units.meter,
      type:: ee_const.var_type.double,
    }
    for step in std.range(0, 100)
  ],
  // A separate string property for tables that should not be included
  // into the bands list.
  shot_number: {
      name: 'shot_number',
      description: |||
        Shot number, a unique identifier.
        This field has the format of OOOOOBBRRGNNNNNNNN, where:

        * OOOOO: Orbit number
        * BB: Beam number
        * RR: Reserved for future use
        * G: Sub-orbit granule number
        * NNNNNNNN: Shot index
      |||,
      type:: ee_const.var_type.string,
  },
  terms_of_use: |||
    This dataset is in the public domain and is available
    without restriction on use and distribution. See [NASA's
    Earth Science Data & Information Policy]
    (https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
}
