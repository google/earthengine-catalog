local cds_notice = import 'cds_notice.libsonnet';
local units = import 'units.libsonnet';

local meters = 'm';
local meters_eq = 'm of water equivalent';
local flux = 'J/m^2';

{
  description: cds_notice.body + |||

    ERA5-Land is a reanalysis dataset providing a consistent view of the
    evolution of land variables over several decades at an enhanced resolution
    compared to ERA5. ERA5-Land has been produced by replaying the land
    component of the ECMWF ERA5 climate reanalysis. Reanalysis combines model
    data with observations from across the world into a globally complete and
    consistent dataset using the laws of physics. Reanalysis produces data that
    goes several decades back in time, providing an accurate description of the
    climate of the past. This dataset includes all 50 variables as available on
    CDS.
  |||,
  min_max: [{key:'min', value:'minimum'}, {key:'max', value:'maximum'}],
  keywords: [
    'cds',
    'climate',
    'copernicus',
    'ecmwf',
    'era5_land',
    'evaporation',
    'heat',
    'lakes',
    'precipitation',
    'pressure',
    'radiation',
    'reanalysis',
    'runoff',
    'snow',
    'soil_water',
    'temperature',
    'vegetation',
    'wind',
  ],
  // this means bands describing quantities descried via continuous accumulation
  flow_bands: [
    'snowfall',
    'snowmelt',
    'surface_latent_heat_flux',
    'surface_net_solar_radiation',
    'surface_net_thermal_radiation',
    'surface_sensible_heat_flux',
    'surface_solar_radiation_downwards',
    'surface_thermal_radiation_downwards',
    'evaporation_from_bare_soil',
    'evaporation_from_open_water_surfaces_excluding_oceans',
    'evaporation_from_the_top_of_canopy',
    'evaporation_from_vegetation_transpiration',
    'potential_evaporation',
    'runoff',
    'snow_evaporation',
    'sub_surface_runoff',
    'surface_runoff',
    'total_evaporation',
    'total_precipitation',
  ],
  flow_bands_unit: [
    meters_eq,
    meters_eq,
    flux,
    flux,
    flux,
    flux,
    flux,
    flux,
    meters_eq,
    meters_eq,
    meters_eq,
    meters_eq,
    meters,
    meters,
    meters_eq,
    meters,
    meters,
    meters_eq,
    meters,
  ],
  bands: [
    {
      name: 'dewpoint_temperature_2m',
      description: |||
        Temperature to which the air, at 2 meters above the surface of the
        Earth, would have to be cooled for saturation to occur. It is a
        measure of the humidity of the air. Combined with temperature and
        pressure, it can be used to calculate the relative humidity. 2m dew
        point temperature is calculated by interpolating between the lowest
        model level and the Earth's surface, taking account of the atmospheric
        conditions.
      |||,
      units: units.kelvin,
    },
    {
      name: 'temperature_2m',
      description: |||
        Temperature of air at 2m above the surface of land, sea or in-land
        waters. 2m temperature is calculated by interpolating between the
        lowest model level and the Earth's surface, taking account of the
        atmospheric conditions.
      |||,
      units: units.kelvin,
    },
    {
      name: 'skin_temperature',
      description: |||
        Temperature of the surface of the Earth. The skin temperature is the
        theoretical temperature that is required to satisfy the surface energy
        balance. It represents the temperature of the uppermost surface layer,
        which has no heat capacity and so can respond instantaneously to
        changes in surface fluxes. Skin temperature is calculated differently
        over land and sea.
      |||,
      units: units.kelvin,
    },
    {
      name: 'soil_temperature_level_1',
      description: |||
        Temperature of the soil in layer 1 (0 - 7 cm) of the ECMWF Integrated
        Forecasting System. The surface is at 0 cm. Soil temperature is set at
        the middle of each layer, and heat transfer is calculated at the
        interfaces between them. It is assumed that there is no heat transfer
        out of the bottom of the lowest layer.
      |||,
      units: units.kelvin,
    },
    {
      name: 'soil_temperature_level_2',
      description: |||
        Temperature of the soil in layer 2 (7-28 cm) of the ECMWF Integrated
        Forecasting System.
      |||,
      units: units.kelvin,
    },
    {
      name: 'soil_temperature_level_3',
      description: |||
        Temperature of the soil in layer 3 (28-100 cm) of the ECMWF Integrated
        Forecasting System.
      |||,
      units: units.kelvin,
    },
    {
      name: 'soil_temperature_level_4',
      description: |||
        Temperature of the soil in layer 4 (100-289 cm) of the ECMWF
        Integrated Forecasting System.
      |||,
      units: units.kelvin,
    },
    {
      name: 'lake_bottom_temperature',
      description: |||
        Temperature of water at the bottom of inland water bodies (lakes,
        reservoirs, rivers) and coastal waters. ECMWF implemented a lake model
        in May 2015 to represent the water temperature and lake ice of all the
        world's major inland water bodies in the Integrated Forecasting
        System. The model keeps lake depth and surface area (or fractional
        cover) constant in time.
      |||,
      units: units.kelvin,
    },
    {
      name: 'lake_ice_depth',
      description: |||
        The thickness of ice on inland water bodies (lakes, reservoirs and
        rivers) and coastal waters. The ECMWF Integrated Forecasting System
        (IFS) represents the formation and melting of ice on inland water
        bodies (lakes, reservoirs and rivers) and coastal water. A single ice
        layer is represented. This parameter is the thickness of that ice
        layer.
      |||,
      units: meters,
    },
    {
      name: 'lake_ice_temperature',
      description: |||
        The temperature of the uppermost surface of ice on inland water bodies
        (lakes, reservoirs, rivers) and coastal waters. The ECMWF Integrated
        Forecasting System represents the formation and melting of ice on
        lakes. A single ice layer is represented.
      |||,
      units: units.kelvin,
    },
    {
      name: 'lake_mix_layer_depth',
      description: |||
        The thickness of the upper most layer of an inland water body (lake,
        reservoirs, and rivers) or coastal waters that is well mixed and has
        a near constant temperature with depth (uniform distribution of
        temperature). The ECMWF Integrated Forecasting System represents
        inland water bodies with two layers in the vertical, the mixed layer
        above and the thermocline below. Thermoclines upper boundary is
        located at the mixed layer bottom, and the lower boundary at the
        lake bottom. Mixing within the mixed layer can occur when the density
        of the surface (and near-surface) water is greater than that of the
        water below. Mixing can also occur through the action of wind on the
        surface of the lake.
      |||,
      units: meters,
    },
    {
      name: 'lake_mix_layer_temperature',
      description: |||
        The temperature of the upper most layer of inland water bodies (lakes,
        reservoirs and rivers) or coastal waters) that is well mixed.
        The ECMWF Integrated Forecasting System represents inland water bodies
        with two layers in the vertical, the mixed layer above and the
        thermocline below. Thermoclines upper boundary is located at the mixed
        layer bottom, and the lower boundary at the lake bottom. Mixing within
        the mixed layer can occur when the density of the surface (and
        near-surface) water is greater than that of the water below. Mixing
        can also occur through the action of wind on the surface of the lake.
      |||,
      units: units.kelvin,
    },
    {
      name: 'lake_shape_factor',
      description: |||
        This parameter describes the way that temperature changes with depth
        in the thermocline layer of inland water bodies (lakes, reservoirs
        and rivers) and coastal waters. It is used to calculate the lake
        bottom temperature and other lake-related parameters. The ECMWF
        Integrated Forecasting System represents inland and coastal water
        bodies with two layers in the vertical, the mixed layer above and the
        thermocline below where temperature changes with depth.
      |||,
    },
    {
      name: 'lake_total_layer_temperature',
      description: |||
        The mean temperature of total water column in inland water bodies
        (lakes, reservoirs and rivers) and coastal waters. The ECMWF
        Integrated Forecasting System represents inland water
        bodies with two layers in the vertical, the mixed layer above and the
        thermocline below where temperature changes with depth. This parameter
        is the mean over the two layers.
      |||,
      units: units.kelvin,
    },
    {
      name: 'snow_albedo',
      description: |||
        It is defined as the fraction of solar (shortwave) radiation reflected
        by the snow, across the solar spectrum, for both direct and diffuse
        radiation. It is a measure of the reflectivity of the snow covered
        grid cells. Values vary between 0 and 1. Typically, snow and ice have
        high reflectivity with albedo values of 0.8 and above.
      |||,
    },
    {
      name: 'snow_cover',
      description: |||
        It represents the fraction (0-1) of the cell / grid-box occupied by
        snow (similar to the cloud cover fields of ERA5).
      |||,
      units: units.percent,
    },
    {
      name: 'snow_density',
      description: |||
        Mass of snow per cubic meter in the snow layer. The ECMWF Integrated
        Forecast System (IFS) model represents snow as a single additional
        layer over the uppermost soil level. The snow may cover all or part of
        the grid box.
      |||,
      units: units.density_si,
    },
    {
      name: 'snow_depth',
      description: 'Instantaneous grib-box average of the snow thickness on\n          the ground (excluding snow on canopy).',
      units: meters,
    },
    {
      name: 'snow_depth_water_equivalent',
      description: |||
        Depth of snow from the snow-covered area of a grid box. Its units are
        meters of water equivalent, so it is the depth the water would have if
        the snow melted and was spread evenly over the whole grid box.
        The ECMWF Integrated Forecast System represents snow as a single
        additional layer over the uppermost soil level. The snow may cover all
        or part of the grid box.
      |||,
      units: meters_eq,
    },
    {
      name: 'snowfall',
      description: |||
        Accumulated total snow that has fallen to the Earth's surface. It
        consists of snow due to the large-scale atmospheric flow (horizontal
        scales greater than around a few hundred meters) and convection where
        smaller scale areas (around 5km to a few hundred kilometers) of warm
        air rise. If snow has melted during the period over which this
        variable was accumulated, then it will be higher than the snow depth.
        This variable is the total amount of water accumulated from the
        beginning of the forecast time to the end of the forecast step. The
        units given measure the depth the water would have if the snow melted
        and was spread evenly over the grid box. Care should be taken when
        comparing model variables with observations, because observations are
        often local to a particular point in space and time, rather than
        representing averages over a model grid box and model time step.
      |||,
      units: meters_eq,
    },
    {
      name: 'snowmelt',
      description: |||
        Melting of snow averaged over the grid box (to find melt over snow,
        divide by snow fraction). This variable is accumulated from the
        beginning of the forecast time to the end of the forecast
        step.
      |||,
      units: meters_eq,
    },
    {
      name: 'temperature_of_snow_layer',
      description: |||
        This variable gives the temperature of the snow layer from the ground
        to the snow-air interface. The ECMWF Integrated Forecast System (IFS)
        model represents snow as a single additional layer over the uppermost
        soil level. The snow may cover all or part of the grid box.
      |||,
      units: units.kelvin,
    },
    {
      name: 'skin_reservoir_content',
      description: |||
        Amount of water in the vegetation canopy and/or in a thin layer on the
        soil. It represents the amount of rain intercepted by foliage, and
        water from dew. The maximum amount of 'skin reservoir content' a grid
        box can hold depends on the type of vegetation, and may be zero.
        Water leaves the 'skin reservoir' by evaporation.
      |||,
      units: meters_eq,
    },
    {
      name: 'volumetric_soil_water_layer_1',
      description: |||
        Volume of water in soil layer 1 (0 - 7 cm) of the ECMWF Integrated
        Forecasting System. The surface is at 0 cm. The volumetric soil water
        is associated with the soil texture (or classification), soil depth,
        and the underlying groundwater level.
      |||,
      units: units.volume_fraction,
    },
    {
      name: 'volumetric_soil_water_layer_2',
      description: |||
        Volume of water in soil layer 2 (7 -28 cm) of the ECMWF Integrated
        Forecasting System.
      |||,
      units: units.volume_fraction,
    },
    {
      name: 'volumetric_soil_water_layer_3',
      description: |||
        Volume of water in soil layer 3 (28-100 cm) of the ECMWF Integrated
        Forecasting System.
      |||,
      units: units.volume_fraction,
    },
    {
      name: 'volumetric_soil_water_layer_4',
      description: |||
        Volume of water in soil layer 4 (100-289 cm) of the ECMWF Integrated
        Forecasting System.
      |||,
      units: units.volume_fraction,
    },
    {
      name: 'forecast_albedo',
      description: |||
        Is a measure of the reflectivity of the Earth's surface. It is the
        fraction of solar (shortwave) radiation reflected by Earth's surface,
        across the solar spectrum, for both direct and diffuse radiation.
        Values are between 0 and 1. Typically, snow and ice have high
        reflectivity with albedo values of 0.8 and above, land has
        intermediate values between about 0.1 and 0.4 and the ocean has low
        values of 0.1 or less. Radiation from the Sun (solar, or shortwave,
        radiation) is partly reflected back to space by clouds and particles
        in the atmosphere (aerosols) and some of it is absorbed. The rest is
        incident on the Earth's surface, where some of it is reflected. The
        portion that is reflected by the Earth's surface depends on the
        albedo. In the ECMWF Integrated Forecasting System (IFS), a
        climatological background albedo (observed values averaged over a
        period of several years) is used, modified by the model
        over water, ice and snow. Albedo is often shown as a percentage (%).
      |||,
    },
    {
      name: 'surface_latent_heat_flux',
      description: |||
        Exchange of latent heat with the surface through turbulent diffusion.
        This variables is accumulated from the beginning of the forecast time
        to the end of the forecast step. By model convention, downward fluxes
        are positive.
      |||,
      units: flux,
    },
    {
      name: 'surface_net_solar_radiation',
      description: |||
        Amount of solar radiation (also known as shortwave radiation) reaching
        the surface of the Earth (both direct and diffuse) minus the amount
        reflected by the Earth's surface (which is governed by the albedo).
        Radiation from the Sun (solar, or shortwave, radiation) is partly
        reflected back to space by clouds and particles in the atmosphere
        (aerosols) and some of it is absorbed. The rest is incident on the
        Earth's surface, where some of it is reflected. The difference between
        downward and reflected solar radiation is the surface net solar
        radiation. This variable is accumulated from the beginning of the
        forecast time to the end of the forecast step. The units are joules
        per square meter (J m-2). To convert to watts per square meter
        (W m-2), the accumulated values should be divided by the accumulation
        period expressed in seconds. The ECMWF convention for vertical fluxes
        is positive downwards.
      |||,
      units: flux,
    },
    {
      name: 'surface_net_thermal_radiation',
      description: |||
        Net thermal radiation at the surface. Accumulated field from the
        beginning of the forecast time to the end of the forecast step.
        By model convention downward fluxes are positive.
      |||,
      units: flux,
    },
    {
      name: 'surface_sensible_heat_flux',
      description: |||
        Transfer of heat between the Earth's surface and the atmosphere
        through the effects of turbulent air motion (but excluding any heat
        transfer resulting from condensation or evaporation). The magnitude
        of the sensible heat flux is governed by the difference in temperature
        between the surface and the overlying atmosphere, wind speed and the
        surface roughness. For example, cold air overlying a warm surface
        would produce a sensible heat flux from the land (or ocean) into the
        atmosphere. This is a single level variable and it is accumulated from
        the beginning of the forecast time to the end of the forecast step.
        The units are joules per square meter (J m-2). To convert to watts per
        square meter (W m-2), the accumulated values should be divided by the
        accumulation period expressed in seconds. The ECMWF convention for
        vertical fluxes is positive downwards.
      |||,
      units: flux,
    },
    {
      name: 'surface_solar_radiation_downwards',
      description: |||
        Amount of solar radiation (also known as shortwave radiation) reaching
        the surface of the Earth. This variable comprises both direct and
        diffuse solar radiation. Radiation from the Sun (solar, or shortwave,
        radiation) is partly reflected back to space by clouds and particles
        in the atmosphere (aerosols) and some of it is absorbed. The rest is
        incident on the Earth's surface (represented by this variable). To a
        reasonably good approximation, this variable is the model equivalent
        of what would be measured by a pyranometer (an instrument used for
        measuring solar radiation) at the surface. However, care should be
        taken when comparing model variables with observations, because
        observations are often local to a particular point in space and time,
        rather than representing averages over a model grid box and model time
        step. This variable is accumulated from the beginning of the forecast
        time to the end of the forecast step. The units are joules per square
        meter (J m-2). To convert to watts per square meter (W m-2), the
        accumulated values should be divided by the accumulation period
        expressed in seconds. The ECMWF convention for vertical fluxes is
        positive downwards.
      |||,
      units: flux,
    },
    {
      name: 'surface_thermal_radiation_downwards',
      description: |||
        Amount of thermal (also known as longwave or terrestrial) radiation
        emitted by the atmosphere and clouds that reaches the Earth's surface.
        The surface of the Earth emits thermal radiation, some of which is
        absorbed by the atmosphere and clouds. The atmosphere and clouds
        likewise emit thermal radiation in all directions, some of which
        reaches the surface (represented by this variable). This variable is
        accumulated from the beginning of the forecast time to the end of
        the forecast step. The units are joules per square meter (J m-2).
        To convert to watts per square meter (W m-2), the accumulated values
        should be divided by the accumulation period expressed in seconds.
        The ECMWF convention for vertical fluxes is positive downwards.
      |||,
      units: flux,
    },
    {
      name: 'evaporation_from_bare_soil',
      description: |||
        The amount of evaporation from bare soil at the top of the land
        surface. This variable is accumulated from the beginning of the
        forecast time to the end of the forecast step.
      |||,
      units: meters_eq,
    },
    {
      name: 'evaporation_from_open_water_surfaces_excluding_oceans',
      description: |||
        Amount of evaporation from surface water storage like lakes and
        inundated areas but excluding oceans. This variable is accumulated
        from the beginning of the forecast time to the end of the
        forecast step.
      |||,
      units: meters_eq,
    },
    {
      name: 'evaporation_from_the_top_of_canopy',
      description: |||
        The amount of evaporation from the canopy interception reservoir at
        the top of the canopy. This variable is accumulated from the beginning
        of the forecast time to the end of the forecast
        step.
      |||,
      units: meters_eq,
    },
    {
      name: 'evaporation_from_vegetation_transpiration',
      description: |||
        Amount of evaporation from vegetation transpiration. This has the same
        meaning as root extraction i.e. the amount of water extracted from the
        different soil layers. This variable is
        accumulated from the beginning of the forecast time to the end of the
        forecast step.
      |||,
      units: meters_eq,
    },
    {
      name: 'potential_evaporation',
      description: |||
        Potential evaporation (pev) in the current ECMWF model is computed,
        by making a second call to the surface energy balance routine with the
        vegetation variables set to "crops/mixed farming" and assuming no
        stress from soil moisture. In other words, evaporation is computed for
        agricultural land as if it is well watered and assuming that the
        atmosphere is not affected by this artificial surface condition.
        The latter may not always be realistic. Although pev is meant to
        provide an estimate of irrigation requirements, the method can give
        unrealistic results in arid conditions due to too strong evaporation
        forced by dry air. This variable is accumulated from the beginning of
        the forecast time to the end of the forecast step.
      |||,
      units: meters,
    },
    {
      name: 'runoff',
      description: |||
        Some water from rainfall, melting snow, or deep in the soil, stays
        stored in the soil. Otherwise, the water drains away, either over the
        surface (surface runoff), or under the ground (sub-surface runoff) and
        the sum of these two is simply called 'runoff'. This variable is the
        total amount of water accumulated from the beginning of the forecast
        time to the end of the forecast step. The units of runoff are depth in
        meters. This is the depth the water would have if it were spread
        evenly over the grid box. Care should be taken when comparing model
        variables with observations, because observations are often local to a
        particular point rather than averaged over a grid square area.
        Observations are also often taken in different units, such as mm/day,
        rather than the accumulated meters produced here. Runoff is a measure
        of the availability of water in the soil, and can, for example, be
        used as an indicator of drought or flood. More information about how
        runoff is calculated is given in the IFS Physical Processes
        documentation.
      |||,
      units: meters,
    },
    {
      name: 'snow_evaporation',
      description: |||
        Evaporation from snow averaged over the grid box (to find flux over
        snow, divide by snow fraction). This variable is accumulated from the
        beginning of the forecast time to the end of the forecast step.
      |||,
      units: meters_eq,
    },
    {
      name: 'sub_surface_runoff',
      description: |||
        Some water from rainfall, melting snow, or deep in the soil, stays
        stored in the soil. Otherwise, the water drains away, either over the
        surface (surface runoff), or under the ground(sub-surface runoff) and
        the sum of these two is simply called 'runoff'. This variable is
        accumulated from the beginning of the forecast time to the end of the
        forecast step. The units of runoff are depth in meters. This is the
        depth the water would have if it were spread evenly over the grid box.
        Care should be taken when comparing model variables with observations,
        because observations are often local to a particular point rather than
        averaged over a grid square area. Observations are also often taken in
        different units, such as mm/day, rather than the accumulated meters
        produced here. Runoff is a measure of the availability of water in the
        soil, and can, for example, be used as an indicator of drought or
        flood. More information about how runoff is calculated is given in the
        IFS Physical Processes documentation.
      |||,
      units: meters,
    },
    {
      name: 'surface_runoff',
      description: |||
        Some water from rainfall, melting snow, or deep in the soil, stays
        stored in the soil. Otherwise, the water drains away, either over the
        surface (surface runoff), or under the ground (sub-surface runoff) and
        the sum of these two is simply called 'runoff'. This variable is the
        total amount of water accumulated from the beginning of the forecast
        time to the end of the forecast step. The units of runoff are depth
        in meters. This is the depth the water would have if it were spread
        evenly over the grid box. Care should be taken when comparing model
        variables with observations, because observations are often local to
        a particular point rather than averaged over a grid square area.
        Observations are also often taken in different units, such as mm/day,
        rather than the accumulated meters produced here. Runoff is a measure
        of the availability of water in the soil, and can, for example, be
        used as an indicator of drought or flood. More information about how
        runoff is calculated is given in the IFS Physical Processes
        documentation.
      |||,
      units: meters,
    },
    {
      name: 'total_evaporation',
      description: |||
        Accumulated amount of water that has evaporated from the Earth's
        surface, including a simplified representation of transpiration
        (from vegetation), into vapor in the air above. This variable is
        accumulated from the beginning of the forecast to the end of the
        forecast step. The ECMWF Integrated Forecasting System convention is
        that downward fluxes are positive. Therefore, negative values indicate
        evaporation and positive values indicate condensation.
      |||,
      units: meters_eq,
    },
    {
      name: 'u_component_of_wind_10m',
      description: |||
        Eastward component of the 10m wind. It is the horizontal speed of air
        moving towards the east, at a height of ten meters above the surface
        of the Earth, in meters per second. Care should be taken when
        comparing this variable with observations, because wind observations
        vary on small space and time scales and are affected by the local
        terrain, vegetation and buildings that are represented only on average
        in the ECMWF Integrated Forecasting System. This variable can be
        combined with the V component of 10m wind to give the speed and
        direction of the horizontal 10m
        wind.
      |||,
      units: units.velocity_si,
    },
    {
      name: 'v_component_of_wind_10m',
      description: |||
        Northward component of the 10m wind. It is the horizontal speed of air
        moving towards the north, at a height of ten meters above the surface
        of the Earth, in meters per second. Care should be taken when
        comparing this variable with observations, because wind observations
        vary on small space and time scales and are affected by the local
        terrain, vegetation and buildings that are represented only on average
        in the ECMWF Integrated Forecasting System. This variable can be
        combined with the U component of 10m wind to give the speed and
        direction of the horizontal 10m wind.
      |||,
      units: units.velocity_si,
    },
    {
      name: 'surface_pressure',
      description: |||
        Pressure (force per unit area) of the atmosphere on the surface of
        land, sea and in-land water. It is a measure of the weight of all the
        air in a column vertically above the area of the Earth's surface
        represented at a fixed point. Surface pressure is often used in
        combination with temperature to calculate air density. The strong
        variation of pressure with altitude makes it difficult to see the low
        and high pressure systems over mountainous areas, so mean sea level
        pressure, rather than surface pressure, is normally used for this
        purpose. The units of this variable are Pascals (Pa). Surface
        pressure is often measured in hPa and sometimes is presented
        in the old units of millibars, mb (1 hPa = 1 mb = 100 Pa).
      |||,
      units: units.pascal,
    },
    {
      name: 'total_precipitation',
      description: |||
        Accumulated liquid and frozen water, including rain and snow, that
        falls to the Earth's surface. It is the sum of large-scale
        precipitation (that precipitation which is generated by large-scale
        weather patterns, such as troughs and cold fronts) and convective
        precipitation (generated by convection which occurs when air at lower
        levels in the atmosphere is warmer and less dense than the air above,
        so it rises). Precipitation variables do not include fog, dew or
        the precipitation that evaporates in the atmosphere before it lands at
        the surface of the Earth. This variable is accumulated from the
        beginning of the forecast time to the end of the forecast step. The
        units of precipitation are depth in meters. It is the depth the water
        would have if it were spread evenly over the grid box. Care should be
        taken when comparing model variables with observations, because
        observations are often local to a particular point in space and time,
        rather than representing averages over a model grid box and model time
        step.
      |||,
      units: meters,
    },
    {
      name: 'leaf_area_index_high_vegetation',
      description: |||
        One-half of the total green leaf area per unit horizontal ground
        surface area for high vegetation type.
      |||,
      units: units.area_fraction,
    },
    {
      name: 'leaf_area_index_low_vegetation',
      description: |||
        One-half of the total green leaf area per unit horizontal ground
        surface area for low vegetation type.
      |||,
      units: units.area_fraction,
    },
  ],
  visualizations: [
    {
      display_name: 'Air temperature [K] at 2m height',
      lookat: {
        lat: 21.2,
        lon: 22.2,
        zoom: 1,
      },
      image_visualization: {
        band_vis: {
          min: [
            250.0,
          ],
          max: [
            320.0,
          ],
          palette: [
            '000080',
            '0000d9',
            '4000ff',
            '8000ff',
            '0080ff',
            '00ffff',
            '00ff80',
            '80ff00',
            'daff00',
            'ffff00',
            'fff500',
            'ffda00',
            'ffb000',
            'ffa400',
            'ff4f00',
            'ff2500',
            'ff0a00',
            'ff00ff',
          ],
          bands: [
            'temperature_2m',
          ],
        },
      },
    },
    {
      display_name: 'Surface pressure',
      lookat: {
        lat: 21.2,
        lon: 22.2,
        zoom: 1,
      },
      image_visualization: {
        band_vis: {
          min: [
            500.0,
          ],
          max: [
            1150.0,
          ],
          palette: [
            '01ffff',
            '058bff',
            '0600ff',
            'df00ff',
            'ff00ff',
            'ff8c00',
            'ff8c00',
          ],
          bands: [
            'surface_pressure',
          ],
        },
      },
    },
    {
      display_name: 'u-component of wind at 10m',
      lookat: {
        lat: 21.2,
        lon: 22.2,
        zoom: 1,
      },
      image_visualization: {
        band_vis: {
          min: [
            0.0,
          ],
          max: [
            30.0,
          ],
          palette: [
            'ffffff',
            'ffff71',
            'deff00',
            '9eff00',
            '77b038',
            '007e55',
            '005f51',
            '004b51',
            '013a7b',
            '023aad',
          ],
          bands: [
            'u_component_of_wind_10m',
          ],
        },
      },
    },
  ],
  citation: |||
    Mu&ntilde;oz Sabater, J., (2019): ERA5-Land monthly averaged data from 1981
    to present. Copernicus Climate Change Service (C3S) Climate Data Store
    (CDS). (&lt;date of access&gt;),
    [doi:10.24381/cds.68d2bb30](https://doi.org/10.24381/cds.68d2bb30)
  |||,
  terms_of_use: |||
    Please acknowledge the use of ERA5-Land as stated in the
    [Copernicus C3S/CAMS License agreement](https://apps.ecmwf.int/datasets/licences/copernicus/):

    - 5.1.1 Where the Licensee communicates or distributes Copernicus Products
    to the public, the Licensee shall inform the recipients of the source by
    using the following or any similar notice:
    'Generated using Copernicus Climate Change Service Information [Year]'.

    - 5.1.2 Where the Licensee makes or contributes to a publication or
    distribution containing adapted or modified Copernicus Products, the
    Licensee shall provide the following or any similar notice:
    'Contains modified Copernicus Climate Change Service Information [Year]';

    Any such publication or distribution covered by clauses 5.1.1 and 5.1.2
    shall state that neither the European Commission nor ECMWF is responsible
    for any use that may be made of the Copernicus Information or Data it
    contains.
  |||,
}
