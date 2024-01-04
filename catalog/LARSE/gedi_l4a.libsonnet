local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

{
  description: |||
    This dataset contains Global Ecosystem Dynamics Investigation (GEDI)
    Level 4A (L4A) Version 2 predictions of the aboveground biomass
    density (AGBD; in Mg/ha) and estimates of the prediction standard
    error within each sampled geolocated laser footprint. In this version,
    the granules are in sub-orbits.
    Height metrics from simulated waveforms associated with field estimates
    of AGBD from multiple regions and plant functional types (PFTs) were
    compiled to generate a calibration dataset for models representing
    the combinations of world regions and PFTs (i.e., deciduous broadleaf
    trees, evergreen broadleaf trees, evergreen needleleaf trees, deciduous
    needleleaf trees, and the combination of grasslands, shrubs, and
    woodlands).The algorithm setting group selection
    used for GEDI02_A Version 2 has been modified for evergreen broadleaf
    trees in South America to reduce false positive errors resulting from
    the selection of waveform modes above ground elevation as the lowest mode.
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
      'https://daac.ornl.gov/GEDI/guides/GEDI_L4A_AGB_Density_V2_1.html'
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
    GEDI L4A Footprint Level Aboveground Biomass Density, Version 2.1.
    Dubayah, R.O., J. Armston, J.R. Kellner, L. Duncanson, S.P. Healey,
    P.L. Patterson, S. Hancock, H. Tang, J. Bruening, M.A. Hofton, J.B. Blair,
    and S.B. Luthcke. 2022. ORNL DAAC, Oak Ridge, Tennessee, USA.
    [doi:10.3334/ORNLDAAC/2056](https://doi.org/10.3334/ORNLDAAC/2056)
  |||,
  regular_bands: [
    {
      name: 'agbd',
      description: 'Predicted aboveground biomass density',
      'gee:units': units.area_density_megagrams_per_hectare,
      type:: ee_const.var_type.int,
    },
    {
      name: 'agbd_pi_lower',
      description: |||
        Lower prediction interval (see "alpha" attribute for the level)
      |||,
      'gee:units': units.area_density_megagrams_per_hectare,
      type:: ee_const.var_type.int,
    },
    {
      name: 'agbd_pi_upper',
      description: |||
        Upper prediction interval (see "alpha" attribute for the level)
      |||,
      'gee:units': units.area_density_megagrams_per_hectare,
      type:: ee_const.var_type.int,
    },
    {
      name: 'agbd_se',
      description: |||
        Aboveground biomass density prediction standard error
      |||,
      'gee:units': units.area_density_megagrams_per_hectare,
      type:: ee_const.var_type.int,
    },
    {
      name: 'agbd_t',
      description: 'Model prediction in fit units',
      type:: ee_const.var_type.int,
    },
    {
      name: 'agbd_t_se',
      description: |||
        Model prediction standard error in fit units (needed for calculation of
        custom prediction intervals)
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'algorithm_run_flag',
      description: |||
        The L4A algorithm is run if this flag is set to 1. This flag selects
        data that have sufficient waveform fidelity for AGBD estimation.
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'beam',
      description: 'Beam identifier',
      type:: ee_const.var_type.int,
    },
    {
      name: 'channel',
      description: 'Channel identifier',
      type:: ee_const.var_type.int,
    },
    {
      name: 'degrade_flag',
      description: |||
        Flag indicating degraded state of pointing and/or positioning
        information
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'delta_time',
      description: 'Time since Jan 1 00:00 2018',
      'gee:units': 'seconds',
      type:: ee_const.var_type.int,
    },
    {
      name: 'elev_lowestmode',
      description: |||
        Elevation of center of lowest mode relative to reference ellipsoid
      |||,
      'gee:units': units.meter,
      type:: ee_const.var_type.int,
    },
    {
      name: 'l2_quality_flag',
      description: |||
        Flag identifying the most useful L2 data for biomass predictions
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'l4_quality_flag',
      description: |||
        Flag simplifying selection of most useful biomass predictions
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'lat_lowestmode',
      description: 'Latitude of center of lowest mode',
      'gee:units': units.degree,
      type:: ee_const.var_type.int,
    },
    {
      name: 'lon_lowestmode',
      description: 'Longitude of center of lowest mode',
      'gee:units': units.degree,
      type:: ee_const.var_type.int,
    },
    {
      name: 'master_frac',
      description: |||
        Master time, fractional part. master_int+master_frac is equivalent
        to /BEAMXXXX/delta_time
      |||,
      'gee:units': 'seconds',
      type:: ee_const.var_type.int,
    },
    {
      name: 'master_int',
      description: |||
        Master time, integer part. Seconds since master_time_epoch.
        master_int+master_frac is equivalent to /BEAMXXXX/delta_time',
      |||,
      'gee:units': 'seconds',
      type:: ee_const.var_type.int,
    },
    {
      name: 'predict_stratum',
      description: |||
        Prediction stratum identifier. Character ID of the prediction stratum
        name for the 1 km cell
      |||,
      type:: ee_const.var_type.string,
    },
    {
      name: 'predictor_limit_flag',
      description: |||
        Predictor value is outside the bounds of the training data
        (0=in bounds; 1=lower bound; 2=upper bound)
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'response_limit_flag',
      description: |||
        Prediction value is outside the bounds of the training data
        (0=in bounds; 1=lower bound; 2=upper bound)
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'selected_algorithm',
      description: 'Selected algorithm setting group',
      type:: ee_const.var_type.int,
    },
    {
      name: 'selected_mode',
      description: 'ID of mode selected as lowest non-noise mode',
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
        Beam sensitivity. Maximum canopy cover that can be penetrated
        considering the SNR of the waveform
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'solar_elevation',
      description: 'Solar elevation angle',
      'gee:units': units.degree,
      type:: ee_const.var_type.int,
    },
    {
      name: 'surface_flag',
      description: |||
        Indicates elev_lowestmode is within 300m of Digital Elevation
        Model (DEM) or Mean Sea Surface (MSS) elevation
      |||,
      type:: ee_const.var_type.int,
    },
    {
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
  {
      name: 'shot_number_within_beam',
      description: 'Shot number within beam',
      type:: ee_const.var_type.int,
    },
  ],

  group_bands:[
    {
      name: 'agbd_aN',
      description: |||
        Above ground biomass density; Geolocation latitude lowestmode
      |||,
      'gee:units': units.area_density_megagrams_per_hectare,
      type:: ee_const.var_type.int,
    },
    {
      name: 'agbd_pi_lower_aN',
      description: 'Above ground biomass density lower prediction interval',
      'gee:units': units.area_density_megagrams_per_hectare,
      type:: ee_const.var_type.int,
    },
    {
      name: 'agbd_pi_upper_aN',
      description: 'Above ground biomass density upper prediction interval',
      'gee:units': units.area_density_megagrams_per_hectare,
      type:: ee_const.var_type.int,
    },
    {
      name: 'agbd_se_aN',
      description: |||
        Aboveground biomass density prediction standard error
      |||,
      'gee:units': units.area_density_megagrams_per_hectare,
      type:: ee_const.var_type.int,
    },
    {
      name: 'agbd_t_aN',
      description: |||
        Aboveground biomass density model prediction in transform space
      |||,
      'gee:units': units.area_density_megagrams_per_hectare,
      type:: ee_const.var_type.int,
    },
    {
      name: 'agbd_t_pi_lower_aN',
      description: 'Lower prediction interval in transform space',
      'gee:units': units.area_density_megagrams_per_hectare,
      type:: ee_const.var_type.int,
    },
    {
      name: 'agbd_t_pi_upper_aN',
      description: 'Upper prediction interval in transform space',
      'gee:units': units.area_density_megagrams_per_hectare,
      type:: ee_const.var_type.int,
    },
    {
      name: 'agbd_t_se_aN',
      description: 'Model prediction standard error in fit units',
      type:: ee_const.var_type.int,
    },
    {
      name: 'algorithm_run_flag_aN',
      description: |||
        Algorithm run flag-this algorithm is run if this flag is set to 1.
        This flag selects data that have sufficient waveform fidelity for
        AGBD estimation
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'l2_quality_flag_aN',
      description: |||
        Flag identifying the most useful L2 data for biomass predictions'
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'l4_quality_flag_aN',
      description: |||
        Flag simplifying selection of most useful biomass predictions
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'predictor_limit_flag_aN',
      description: 'Predictor value is outside the bounds of the training data',
      type:: ee_const.var_type.int,
    },
    {
      name: 'response_limit_flag_aN',
      description: 'Prediction value is outside the bounds of the training data',
      type:: ee_const.var_type.int,
    },
    {
      name: 'selected_mode_aN',
      description: 'ID of mode selected as lowest non-noise mode',
      type:: ee_const.var_type.int,
    },
    {
      name: 'selected_mode_flag_aN',
      description: 'Flag indicating status of selected mode',
      type:: ee_const.var_type.int,
    },
    {
      name: 'elev_lowestmode_aN',
      description: |||
        Elevation of center of lowest mode relative to the reference ellipsoid
      |||,
      'gee:units': units.meter,
      type:: ee_const.var_type.int,
    },
    {
      name: 'lat_lowestmode_aN',
      description: 'Latitude of center of lowest mode',
      'gee:units': units.degree,
      type:: ee_const.var_type.int,
    },
    {
      name: 'lon_lowestmode_aN',
      description: 'Longitude of center of lowest mode',
      'gee:units': units.degree,
      type:: ee_const.var_type.int,
    },
    {
      name: 'sensitivity_aN',
      description: |||
        Maximum canopy cover that can be penetrated considering the SNR of
        the waveform
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'stale_return_flag',
      description: |||
        Flag from digitizer indicating the real-time pulse detection algorithm
        did not detect a return signal above its detection threshold within
        the entire 10 km search window. The pulse location of the previous
        shot was used to select the telemetered waveform.
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'landsat_treecover',
      description: |||
        Tree cover in the year 2010, defined as canopy closure for all
        vegetation taller than 5 m in height (Hansen et al., 2013) and
        encoded as a percentage per output grid cell.
      |||,
      'gee:units': units.percent,
      type:: ee_const.var_type.int,
    },
    {
      name: 'landsat_water_persistence',
      description: |||
        The percent UMD GLAD Landsat observations with classified surface water
        between 2018 and 2019. Values >80 usually represent permanent water
        while values <10 represent permanent land.
      |||,
      'gee:units': units.percent,
      type:: ee_const.var_type.int,
    },
    {
      name: 'leaf_off_doy',
      description: |||
        GEDI 1 km EASE 2.0 grid leaf-off start day-of-year derived from the
        NPP VIIRS Global Land Surface Phenology Product.
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'leaf_off_flag',
      description: |||
        GEDI 1 km EASE 2.0 grid flag derived from leaf_off_doy, leaf_on_doy,
        and pft_class, indicating if the observation was recorded during
        leaf-off conditions in deciduous needleleaf or broadleaf forests and
        woodlands. 1=leaf-off, 0=leaf-on.
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'leaf_on_cycle',
      description: |||
        Flag that indicates the vegetation growing cycle for leaf-on
        observations. Values are 0=leaf-off conditions, 1=cycle 1, 2=cycle 2.
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'leaf_on_doy',
      description: |||
        GEDI 1 km EASE 2.0 grid leaf-on start day- of-year derived from the
        NPP VIIRS Global Land Surface Phenology product.
      |||,
      type:: ee_const.var_type.int,
    },
    {
      name: 'pft_class',
      description: |||
        GEDI 1 km EASE 2.0 grid Plant Functional Type (PFT) derived from the
        MODIS MCD12Q1v006 product. Values follow the Land Cover Type 5
        Classification scheme.
      |||,
      // TODO(schwehr): Use gee:classes
      type:: ee_const.var_type.int,
    },
    {
      name: 'region_class',
      description: |||
        GEDI 1 km EASE 2.0 grid world continental regions (0=Water, 1=Europe,
        2=North Asia, 3=Australasia, 4=Africa, 5=South Asia, 6=South America,
        7=North America).
      |||,
      // TODO(schwehr): Use gee:classes
      type:: ee_const.var_type.int,
    },
    {
      name: 'urban_focal_window_size',
      description: |||
        The focal window size used to calculate urban_proportion.
        Values are 3 (3x3 pixel window size) or 5 (5x5 pixel window size).
      |||,
      'gee:units': units.pixel,
      type:: ee_const.var_type.int,
    },
    {
      name: 'urban_proportion',
      description: |||
        The percentage proportion of land area within a focal area surrounding
        each shot that is urban land cover. Urban land cover was derived from
        the DLR 12 m resolution TanDEM-X Global Urban Footprint Product.
      |||,
      'gee:units': units.percent,
      type:: ee_const.var_type.int,
    },
  ],

  terms_of_use: |||
    This dataset is in the public domain and is available
    without restriction on use and distribution. See [NASA's
    Earth Science Data & Information Policy]
    (https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
}
