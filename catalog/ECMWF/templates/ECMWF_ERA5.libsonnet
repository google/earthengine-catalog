local units = import 'units.libsonnet';

{
  description: |||
    ERA5 is the fifth generation ECMWF atmospheric reanalysis of the global
    climate. It is produced by the Copernicus Climate Change Service (C3S)
    at ECMWF. Reanalysis combines model data with observations from across the
    world into a globally complete and consistent dataset using the laws of
    physics. ERA5 provides hourly estimates for a large number of
    atmospheric, ocean-wave and land-surface quantities. The data
    cover the Earth on a roughly 31 km grid and resolve the atmosphere using
    137 levels from the surface up to a height of 80km. This dataset
    represents the 'single levels' data, containing 2D parameters.
    Data is available from 1940 to the present.
  |||,
  keywords: [
    'climate',
    'copernicus',
    'ecmwf',
    'era5',
    'atmosphere',
    'reanalysis',
    'weather',
    'pressure',
    'temperature',
    'wind',
    'precipitation',
    'radiation',
    'hourly',
  ],
  bands: [
    {
      name: 'dewpoint_temperature_2m',
      units: units.kelvin,
      description: |||
        This parameter is the temperature to which the air, at 2
        metres above the surface of the Earth, would have to be
        cooled for saturation to occur. It is a measure of the
        humidity of the air. Combined with temperature, it can be
        used to calculate the relative humidity. 2m dew point
        temperature is calculated by interpolating between the
        lowest model level and the Earth's surface, taking account
        of the atmospheric conditions.
      |||,
    },
    {
      name: 'temperature_2m',
      units: units.kelvin,
      description: |||
        This parameter is the temperature of air at 2m above the
        surface of land, sea or inland waters. 2m temperature is
        calculated by interpolating between the lowest model level
        and the Earth's surface, taking account of the atmospheric
        conditions.
      |||,
    },
    {
      name: 'ice_temperature_layer_1',
      units: units.kelvin,
      description: |||
        This parameter is the sea-ice temperature in layer 1 (0 to
        7cm). The ECMWF Integrated Forecasting System (IFS) has a
        four-layer sea-ice slab: Layer 1: 0-7cm, Layer 2: 7-28cm,
        Layer 3: 28-100cm, Layer 4: 100-150cm. The temperature of
        the sea-ice in each layer changes as heat is transferred
        between the sea-ice layers and the atmosphere above and
        ocean below. This parameter is defined over the whole globe,
        even where there is no ocean or sea ice. Regions without sea
        ice can be masked out by only considering grid points where
        the sea-ice cover does not have a missing value and is
        greater than 0.0.
      |||,
    },
    {
      name: 'ice_temperature_layer_2',
      units: units.kelvin,
      description: |||
        This parameter is the sea-ice temperature in layer 2 (7 to
        28cm). The ECMWF Integrated Forecasting System (IFS) has a
        four-layer sea-ice slab: Layer 1: 0-7cm, Layer 2: 7-28cm,
        Layer 3: 28-100cm, Layer 4: 100-150cm. The temperature of
        the sea-ice in each layer changes as heat is transferred
        between the sea-ice layers and the atmosphere above and
        ocean below. This parameter is defined over the whole globe,
        even where there is no ocean or sea ice. Regions without sea
        ice can be masked out by only considering grid points where
        the sea-ice cover does not have a missing value and is
        greater than 0.0.
      |||,
    },
    {
      name: 'ice_temperature_layer_3',
      units: units.kelvin,
      description: |||
        This parameter is the sea-ice temperature in layer 3 (28 to
        100cm). The ECMWF Integrated Forecasting System (IFS) has a
        four-layer sea-ice slab: Layer 1: 0-7cm, Layer 2: 7-28cm,
        Layer 3: 28-100cm, Layer 4: 100-150cm. The temperature of
        the sea-ice in each layer changes as heat is transferred
        between the sea-ice layers and the atmosphere above and
        ocean below. This parameter is defined over the whole globe,
        even where there is no ocean or sea ice. Regions without sea
        ice can be masked out by only considering grid points where
        the sea-ice cover does not have a missing value and is
        greater than 0.0.
      |||,
    },
    {
      name: 'ice_temperature_layer_4',
      units: units.kelvin,
      description: |||
        This parameter is the sea-ice temperature in layer 4 (100 to
        150cm). The ECMWF Integrated Forecasting System (IFS) has a
        four-layer sea-ice slab: Layer 1: 0-7cm, Layer 2: 7-28cm,
        Layer 3: 28-100cm, Layer 4: 100-150cm. The temperature of
        the sea-ice in each layer changes as heat is transferred
        between the sea-ice layers and the atmosphere above and
        ocean below. This parameter is defined over the whole globe,
        even where there is no ocean or sea ice. Regions without sea
        ice can be masked out by only considering grid points where
        the sea-ice cover does not have a missing value and is
        greater than 0.0.
      |||,
    },
    {
      name: 'mean_sea_level_pressure',
      units: units.pascal,
      description: |||
        This parameter is the pressure (force per unit area) of the
        atmosphere at the surface of the Earth, adjusted to the
        height of mean sea level. It is a measure of the weight that
        all the air in a column vertically above a point on the
        Earth's surface would have, if the point were located at
        mean sea level. It is calculated over all surfaces - land,
        sea and inland water. Maps of mean sea level pressure are
        used to identify the locations of low and high pressure
        weather systems, often referred to as cyclones and
        anticyclones. Contours of mean sea level pressure also
        indicate the strength of the wind. Tightly packed contours
        show stronger winds.
      |||,
    },
    {
      name: 'sea_surface_temperature',
      units: units.kelvin,
      description: |||
        This parameter (SST) is the temperature of sea water near
        the surface. In ERA5, this parameter is a foundation SST,
        which means there are no variations due to the daily cycle
        of the sun (diurnal variations). SST, in ERA5, is given by
        two external providers. Before September 2007, SST from the
        HadISST2 dataset is used and from September 2007 onwards,
        the OSTIA dataset is used.
      |||,
    },
    {
      name: 'skin_temperature',
      units: units.kelvin,
      description: |||
        This parameter is the temperature of the surface of the
        Earth. The skin temperature is the theoretical temperature
        that is required to satisfy the surface energy balance. It
        represents the temperature of the uppermost surface layer,
        which has no heat capacity and so can respond
        instantaneously to changes in surface fluxes. Skin
        temperature is calculated differently over land and sea.
      |||,
    },
    {
      name: 'surface_pressure',
      units: units.pascal,
      description: |||
        This parameter is the pressure (force per unit area) of the
        atmosphere at the surface of land, sea and inland water. It
        is a measure of the weight of all the air in a column
        vertically above a point on the Earth's surface. Surface
        pressure is often used in combination with temperature to
        calculate air density. The strong variation of pressure with
        altitude makes it difficult to see the low and high pressure
        weather systems over mountainous areas, so mean sea level
        pressure, rather than surface pressure, is normally used for
        this purpose.
      |||,
    },
    {
      name: 'u_component_of_wind_100m',
      units: units.velocity_si,
      description: |||
        This parameter is the eastward component of the 100 m wind.
        It is the horizontal speed of air moving towards the east,
        at a height of 100 metres above the surface of the Earth, in
        metres per second. Care should be taken when comparing model
        parameters with observations, because observations are often
        local to a particular point in space and time, rather than
        representing averages over a model grid box. This parameter
        can be combined with the northward component to give the
        speed and direction of the horizontal 100 m wind.
      |||,
    },
    {
      name: 'v_component_of_wind_100m',
      units: units.velocity_si,
      description: |||
        This parameter is the northward component of the 100 m wind.
        It is the horizontal speed of air moving towards the north,
        at a height of 100 metres above the surface of the Earth, in
        metres per second. Care should be taken when comparing model
        parameters with observations, because observations are often
        local to a particular point in space and time, rather than
        representing averages over a model grid box. This parameter
        can be combined with the eastward component to give the
        speed and direction of the horizontal 100 m wind.
      |||,
    },
    {
      name: 'u_component_of_neutral_wind_10m',
      units: units.velocity_si,
      description: |||
        This parameter is the eastward component of the "neutral
        wind", at a height of 10 metres above the surface of the
        Earth. The neutral wind is calculated from the surface
        stress and the corresponding roughness length by assuming
        that the air is neutrally stratified. The neutral wind is
        slower than the actual wind in stable conditions, and faster
        in unstable conditions. The neutral wind is, by definition,
        in the direction of the surface stress. The size of the
        roughness length depends on land surface properties or the
        sea state.
      |||,
    },
    {
      name: 'u_component_of_wind_10m',
      units: units.velocity_si,
      description: |||
        This parameter is the eastward component of the 10m wind. It
        is the horizontal speed of air moving towards the east, at a
        height of ten metres above the surface of the Earth, in
        metres per second. Care should be taken when comparing this
        parameter with observations, because wind observations vary
        on small space and time scales and are affected by the local
        terrain, vegetation and buildings that are represented only
        on average in the ECMWF Integrated Forecasting System (IFS).
        This parameter can be combined with the V component of 10m
        wind to give the speed and direction of the horizontal 10m
        wind.
      |||,
    },
    {
      name: 'v_component_of_neutral_wind_10m',
      units: units.velocity_si,
      description: |||
        This parameter is the northward component of the "neutral
        wind", at a height of 10 metres above the surface of the
        Earth. The neutral wind is calculated from the surface
        stress and the corresponding roughness length by assuming
        that the air is neutrally stratified. The neutral wind is
        slower than the actual wind in stable conditions, and faster
        in unstable conditions. The neutral wind is, by definition,
        in the direction of the surface stress. The size of the
        roughness length depends on land surface properties or the
        sea state.
      |||,
    },
    {
      name: 'v_component_of_wind_10m',
      units: units.velocity_si,
      description: |||
        This parameter is the northward component of the 10m wind.
        It is the horizontal speed of air moving towards the north,
        at a height of ten metres above the surface of the Earth, in
        metres per second. Care should be taken when comparing this
        parameter with observations, because wind observations vary
        on small space and time scales and are affected by the local
        terrain, vegetation and buildings that are represented only
        on average in the ECMWF Integrated Forecasting System (IFS).
        This parameter can be combined with the U component of 10m
        wind to give the speed and direction of the horizontal 10m
        wind.
      |||,
    },
    {
      name: 'instantaneous_10m_wind_gust',
      units: units.velocity_si,
      description: |||
        This parameter is the maximum wind gust at the specified
        time, at a height of ten metres above the surface of the
        Earth. The WMO defines a wind gust as the maximum of the
        wind averaged over 3 second intervals. This duration is
        shorter than a model time step, and so the ECMWF Integrated
        Forecasting System (IFS) deduces the magnitude of a gust
        within each time step from the time-step-averaged surface
        stress, surface friction, wind shear and stability. Care
        should be taken when comparing model parameters with
        observations, because observations are often local to a
        particular point in space and time, rather than representing
        averages over a model grid box.
      |||,
    },
    {
      name: 'mean_boundary_layer_dissipation',
      units: units.watt_per_meter_squared,
      description: |||
        This parameter is the mean rate of conversion of kinetic
        energy in the mean flow into heat, over the whole
        atmospheric column, per unit area, that is due to the
        effects of stress associated with turbulent eddies near the
        surface and turbulent orographic form drag. It is calculated
        by the ECMWF Integrated Forecasting System's turbulent
        diffusion and turbulent orographic form drag schemes. The
        turbulent eddies near the surface are related to the
        roughness of the surface. The turbulent orographic form drag
        is the stress due to the valleys, hills and mountains on
        horizontal scales below 5km, which are specified from land
        surface data at about 1 km resolution. (The dissipation
        associated with orographic features with horizontal scales
        between 5 km and the model grid-scale is accounted for by
        the sub-grid orographic scheme.) This parameter is a mean
        over a particular time period (the processing period) which
        depends on the data extracted. For the reanalysis, the
        processing period is over the 1 hour ending at the validity
        date and time. For the ensemble members, ensemble mean and
        ensemble spread, the processing period is over the 3 hours
        ending at the validity date and time.
      |||,
    },
    {
      name: 'mean_convective_precipitation_rate',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        This parameter is the rate of precipitation at the Earth's
        surface, which is generated by the convection scheme in the
        ECMWF Integrated Forecasting System (IFS). The convection
        scheme represents convection at spatial scales smaller than
        the grid box. Precipitation can also be generated by the
        cloud scheme in the IFS, which represents the formation and
        dissipation of clouds and large-scale precipitation due to
        changes in atmospheric quantities (such as pressure,
        temperature and moisture) predicted directly at spatial
        scales of the grid box or larger. In the IFS, precipitation
        is comprised of rain and snow. This parameter is a mean over
        a particular time period (the processing period) which
        depends on the data extracted. For the reanalysis, the
        processing period is over the 1 hour ending at the validity
        date and time. For the ensemble members, ensemble mean and
        ensemble spread, the processing period is over the 3 hours
        ending at the validity date and time. It is the rate the
        precipitation would have if it were spread evenly over the
        grid box. 1 kg of water spread over 1 square metre of
        surface is 1 mm deep (neglecting the effects of temperature
        on the density of water), therefore the units are equivalent
        to mm (of liquid water) per second. Care should be taken
        when comparing model parameters with observations, because
        observations are often local to a particular point in space
        and time, rather than representing averages over a model
        grid box.
      |||,
    },
    {
      name: 'mean_convective_snowfall_rate',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        This parameter is the rate of snowfall (snowfall intensity)
        at the Earth's surface, which is generated by the convection
        scheme in the ECMWF Integrated Forecasting System (IFS). The
        convection scheme represents convection at spatial scales
        smaller than the grid box. Snowfall can also be generated by
        the cloud scheme in the IFS, which represents the formation
        and dissipation of clouds and large-scale precipitation due
        to changes in atmospheric quantities (such as pressure,
        temperature and moisture) predicted directly at spatial
        scales of the grid box or larger. In the IFS, precipitation
        is comprised of rain and snow. This parameter is a mean over
        a particular time period (the processing period) which
        depends on the data extracted. For the reanalysis, the
        processing period is over the 1 hour ending at the validity
        date and time. For the ensemble members, ensemble mean and
        ensemble spread, the processing period is over the 3 hours
        ending at the validity date and time. It is the rate the
        snowfall would have if it were spread evenly over the grid
        box. Since 1 kg of water spread over 1 square metre of
        surface is 1 mm thick (neglecting the effects of temperature
        on the density of water), the units are equivalent to mm (of
        liquid water) per second. Care should be taken when
        comparing model parameters with observations, because
        observations are often local to a particular point in space
        and time, rather than representing averages over a model
        grid box.
      |||,
    },
    {
      name: 'mean_eastward_gravity_wave_surface_stress',
      units: units.pressure_si,
      description: |||
        Air flowing over a surface exerts a stress (drag) that
        transfers momentum to the surface and slows the wind. This
        parameter is the component of the mean surface stress in an
        eastward direction, associated with low-level, orographic
        blocking and orographic gravity waves. It is calculated by
        the ECMWF Integrated Forecasting System's sub-grid orography
        scheme, which represents stress due to unresolved valleys,
        hills and mountains with horizontal scales between 5 km and
        the model grid-scale. (The stress associated with orographic
        features with horizontal scales smaller than 5 km is
        accounted for by the turbulent orographic form drag scheme).
        Orographic gravity waves are oscillations in the flow
        maintained by the buoyancy of displaced air parcels,
        produced when air is deflected upwards by hills and
        mountains. This process can create stress on the atmosphere
        at the Earth's surface and at other levels in the
        atmosphere. Positive (negative) values indicate stress on
        the surface of the Earth in an eastward (westward)
        direction. This parameter is a mean over a particular time
        period (the processing period) which depends on the data
        extracted. For the reanalysis, the processing period is over
        the 1 hour ending at the validity date and time. For the
        ensemble members, ensemble mean and ensemble spread, the
        processing period is over the 3 hours ending at the validity
        date and time.
      |||,
    },
    {
      name: 'mean_eastward_turbulent_surface_stress',
      units: units.pressure_si,
      description: |||
        Air flowing over a surface exerts a stress (drag) that
        transfers momentum to the surface and slows the wind. This
        parameter is the component of the mean surface stress in an
        eastward direction, associated with turbulent eddies near
        the surface and turbulent orographic form drag. It is
        calculated by the ECMWF Integrated Forecasting System's
        turbulent diffusion and turbulent orographic form drag
        schemes. The turbulent eddies near the surface are related
        to the roughness of the surface. The turbulent orographic
        form drag is the stress due to the valleys, hills and
        mountains on horizontal scales below 5km, which are
        specified from land surface data at about 1 km resolution.
        (The stress associated with orographic features with
        horizontal scales between 5 km and the model grid-scale is
        accounted for by the sub-grid orographic scheme.) Positive
        (negative) values indicate stress on the surface of the
        Earth in an eastward (westward) direction. This parameter is
        a mean over a particular time period (the processing period)
        which depends on the data extracted. For the reanalysis, the
        processing period is over the 1 hour ending at the validity
        date and time. For the ensemble members, ensemble mean and
        ensemble spread, the processing period is over the 3 hours
        ending at the validity date and time.
      |||,
    },
    {
      name: 'mean_evaporation_rate',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        This parameter is the amount of water that has evaporated
        from the Earth's surface, including a simplified
        representation of transpiration (from vegetation), into
        vapour in the air above. This parameter is a mean over a
        particular time period (the processing period) which depends
        on the data extracted. For the reanalysis, the processing
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the processing period is over the 3 hours ending at
        the validity date and time. The ECMWF Integrated Forecasting
        System (IFS) convention is that downward fluxes are
        positive. Therefore, negative values indicate evaporation
        and positive values indicate condensation.
      |||,
    },
    {
      name: 'mean_gravity_wave_dissipation',
      units: units.watt_per_meter_squared,
      description: |||
        This parameter is the mean rate of conversion of kinetic
        energy in the mean flow into heat, over the whole
        atmospheric column, per unit area, that is due to the
        effects of stress associated with low-level, orographic
        blocking and orographic gravity waves. It is calculated by
        the ECMWF Integrated Forecasting System's sub-grid orography
        scheme, which represents stress due to unresolved valleys,
        hills and mountains with horizontal scales between 5 km and
        the model grid-scale. (The dissipation associated with
        orographic features with horizontal scales smaller than 5 km
        is accounted for by the turbulent orographic form drag
        scheme). Orographic gravity waves are oscillations in the
        flow maintained by the buoyancy of displaced air parcels,
        produced when air is deflected upwards by hills and
        mountains. This process can create stress on the atmosphere
        at the Earth's surface and at other levels in the
        atmosphere. This parameter is a mean over a particular time
        period (the processing period) which depends on the data
        extracted. For the reanalysis, the processing period is over
        the 1 hour ending at the validity date and time. For the
        ensemble members, ensemble mean and ensemble spread, the
        processing period is over the 3 hours ending at the validity
        date and time.
      |||,
    },
    {
      name: 'mean_large_scale_precipitation_fraction',
      units: units.dimensionless,
      description: |||
        This parameter is the mean of the fraction of the grid box
        (0-1) that is covered by large-scale precipitation. This
        parameter is a mean over a particular time period (the
        processing period) which depends on the data extracted. For
        the reanalysis, the processing period is over the 1 hour
        ending at the validity date and time. For the ensemble
        members, ensemble mean and ensemble spread, the processing
        period is over the 3 hours ending at the validity date and
        time.
      |||,
    },
    {
      name: 'mean_large_scale_precipitation_rate',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        This parameter is the rate of precipitation at the Earth's
        surface, which is generated by the cloud scheme in the ECMWF
        Integrated Forecasting System (IFS). The cloud scheme
        represents the formation and dissipation of clouds and
        large-scale precipitation due to changes in atmospheric
        quantities (such as pressure, temperature and moisture)
        predicted directly at spatial scales of the grid box or
        larger. Precipitation can also be generated by the
        convection scheme in the IFS, which represents convection at
        spatial scales smaller than the grid box. In the IFS,
        precipitation is comprised of rain and snow. This parameter
        is a mean over a particular time period (the processing
        period) which depends on the data extracted. For the
        reanalysis, the processing period is over the 1 hour ending
        at the validity date and time. For the ensemble members,
        ensemble mean and ensemble spread, the processing period is
        over the 3 hours ending at the validity date and time. It is
        the rate the precipitation would have if it were spread
        evenly over the grid box. Since 1 kg of water spread over 1
        square metre of surface is 1 mm deep (neglecting the effects
        of temperature on the density of water), the units are
        equivalent to mm (of liquid water) per second. Care should
        be taken when comparing model parameters with observations,
        because observations are often local to a particular point
        in space and time, rather than representing averages over a
        model grid box.
      |||,
    },
    {
      name: 'mean_large_scale_snowfall_rate',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        This parameter is the rate of snowfall (snowfall intensity)
        at the Earth's surface, which is generated by the cloud
        scheme in the ECMWF Integrated Forecasting System (IFS). The
        cloud scheme represents the formation and dissipation of
        clouds and large-scale precipitation due to changes in
        atmospheric quantities (such as pressure, temperature and
        moisture) predicted directly at spatial scales of the grid
        box or larger. Snowfall can also be generated by the
        convection scheme in the IFS, which represents convection at
        spatial scales smaller than the grid box. In the IFS,
        precipitation is comprised of rain and snow. This parameter
        is a mean over a particular time period (the processing
        period) which depends on the data extracted. For the
        reanalysis, the processing period is over the 1 hour ending
        at the validity date and time. For the ensemble members,
        ensemble mean and ensemble spread, the processing period is
        over the 3 hours ending at the validity date and time. It is
        the rate the snowfall would have if it were spread evenly
        over the grid box. Since 1 kg of water spread over 1 square
        metre of surface is 1 mm deep (neglecting the effects of
        temperature on the density of water), the units are
        equivalent to mm (of liquid water) per second. Care should
        be taken when comparing model parameters with observations,
        because observations are often local to a particular point
        in space and time, rather than representing averages over a
        model grid box.
      |||,
    },
    {
      name: 'mean_northward_gravity_wave_surface_stress',
      units: units.pressure_si,
      description: |||
        Air flowing over a surface exerts a stress (drag) that
        transfers momentum to the surface and slows the wind. This
        parameter is the component of the mean surface stress in a
        northward direction, associated with low-level, orographic
        blocking and orographic gravity waves. It is calculated by
        the ECMWF Integrated Forecasting System's sub-grid orography
        scheme, which represents stress due to unresolved valleys,
        hills and mountains with horizontal scales between 5 km and
        the model grid-scale. (The stress associated with orographic
        features with horizontal scales smaller than 5 km is
        accounted for by the turbulent orographic form drag scheme).
        Orographic gravity waves are oscillations in the flow
        maintained by the buoyancy of displaced air parcels,
        produced when air is deflected upwards by hills and
        mountains. This process can create stress on the atmosphere
        at the Earth's surface and at other levels in the
        atmosphere. Positive (negative) values indicate stress on
        the surface of the Earth in a northward (southward)
        direction. This parameter is a mean over a particular time
        period (the processing period) which depends on the data
        extracted. For the reanalysis, the processing period is over
        the 1 hour ending at the validity date and time. For the
        ensemble members, ensemble mean and ensemble spread, the
        processing period is over the 3 hours ending at the validity
        date and time.
      |||,
    },
    {
      name: 'mean_northward_turbulent_surface_stress',
      units: units.pressure_si,
      description: |||
        Air flowing over a surface exerts a stress (drag) that
        transfers momentum to the surface and slows the wind. This
        parameter is the component of the mean surface stress in a
        northward direction, associated with turbulent eddies near
        the surface and turbulent orographic form drag. It is
        calculated by the ECMWF Integrated Forecasting System's
        turbulent diffusion and turbulent orographic form drag
        schemes. The turbulent eddies near the surface are related
        to the roughness of the surface. The turbulent orographic
        form drag is the stress due to the valleys, hills and
        mountains on horizontal scales below 5km, which are
        specified from land surface data at about 1 km resolution.
        (The stress associated with orographic features with
        horizontal scales between 5 km and the model grid-scale is
        accounted for by the sub-grid orographic scheme.) Positive
        (negative) values indicate stress on the surface of the
        Earth in a northward (southward) direction. This parameter
        is a mean over a particular time period (the processing
        period) which depends on the data extracted. For the
        reanalysis, the processing period is over the 1 hour ending
        at the validity date and time. For the ensemble members,
        ensemble mean and ensemble spread, the processing period is
        over the 3 hours ending at the validity date and time.
      |||,
    },
    {
      name: 'mean_potential_evaporation_rate',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        This parameter is a measure of the extent to which
        near-surface atmospheric conditions are conducive to the
        process of evaporation. It is usually considered to be the
        amount of evaporation, under existing atmospheric
        conditions, from a surface of pure water which has the
        temperature of the lowest layer of the atmosphere and gives
        an indication of the maximum possible evaporation. Potential
        evaporation in the current ECMWF Integrated Forecasting
        System (IFS) is based on surface energy balance calculations
        with the vegetation parameters set to "crops/mixed farming"
        and assuming "no stress from soil moisture". In other words,
        evaporation is computed for agricultural land as if it is
        well watered and assuming that the atmosphere is not
        affected by this artificial surface condition. The latter
        may not always be realistic. Although potential evaporation
        is meant to provide an estimate of irrigation requirements,
        the method can give unrealistic results in arid conditions
        due to too strong evaporation forced by dry air. This
        parameter is a mean over a particular time period (the
        processing period) which depends on the data extracted. For
        the reanalysis, the processing period is over the 1 hour
        ending at the validity date and time. For the ensemble
        members, ensemble mean and ensemble spread, the processing
        period is over the 3 hours ending at the validity date and
        time.
      |||,
    },
    {
      name: 'mean_runoff_rate',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        Some water from rainfall, melting snow, or deep in the soil,
        stays stored in the soil. Otherwise, the water drains away,
        either over the surface (surface runoff), or under the
        ground (sub-surface runoff) and the sum of these two is
        called runoff. This parameter is a mean over a particular
        time period (the processing period) which depends on the
        data extracted. For the reanalysis, the processing period is
        over the 1 hour ending at the validity date and time. For
        the ensemble members, ensemble mean and ensemble spread, the
        processing period is over the 3 hours ending at the validity
        date and time. It is the rate the runoff would have if it
        were spread evenly over the grid box. Care should be taken
        when comparing model parameters with observations, because
        observations are often local to a particular point rather
        than averaged over a grid box. Runoff is a measure of the
        availability of water in the soil, and can, for example, be
        used as an indicator of drought or flood.
      |||,
    },
    {
      name: 'mean_snow_evaporation_rate',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        This parameter is the average rate of snow evaporation from
        the snow-covered area of a grid box into vapour in the air
        above. The ECMWF Integrated Forecasting System (IFS)
        represents snow as a single additional layer over the
        uppermost soil level. The snow may cover all or part of the
        grid box. This parameter is a mean over a particular time
        period (the processing period) which depends on the data
        extracted. For the reanalysis, the processing period is over
        the 1 hour ending at the validity date and time. For the
        ensemble members, ensemble mean and ensemble spread, the
        processing period is over the 3 hours ending at the validity
        date and time. It is the rate the snow evaporation would
        have if it were spread evenly over the grid box. 1 kg of
        water spread over 1 square metre of surface is 1 mm deep
        (neglecting the effects of temperature on the density of
        water), therefore the units are equivalent to mm (of liquid
        water) per second. The IFS convention is that downward
        fluxes are positive. Therefore, negative values indicate
        evaporation and positive values indicate deposition.
      |||,
    },
    {
      name: 'mean_snowfall_rate',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        This parameter is the rate of snowfall at the Earth's
        surface. It is the sum of large-scale and convective
        snowfall. Large-scale snowfall is generated by the cloud
        scheme in the ECMWF Integrated Forecasting System (IFS). The
        cloud scheme represents the formation and dissipation of
        clouds and large-scale precipitation due to changes in
        atmospheric quantities (such as pressure, temperature and
        moisture) predicted directly at spatial scales of the grid
        box or larger. Convective snowfall is generated by the
        convection scheme in the IFS, which represents convection at
        spatial scales smaller than the grid box. In the IFS,
        precipitation is comprised of rain and snow. This parameter
        is a mean over a particular time period (the processing
        period) which depends on the data extracted. For the
        reanalysis, the processing period is over the 1 hour ending
        at the validity date and time. For the ensemble members,
        ensemble mean and ensemble spread, the processing period is
        over the 3 hours ending at the validity date and time. It is
        the rate the snowfall would have if it were spread evenly
        over the grid box. 1 kg of water spread over 1 square metre
        of surface is 1 mm deep (neglecting the effects of
        temperature on the density of water), therefore the units
        are equivalent to mm (of liquid water) per second. Care
        should be taken when comparing model parameters with
        observations, because observations are often local to a
        particular point in space and time, rather than representing
        averages over a model grid box.
      |||,
    },
    {
      name: 'mean_snowmelt_rate',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        This parameter is the rate of snow melt in the snow-covered
        area of a grid box. The ECMWF Integrated Forecasting System
        (IFS) represents snow as a single additional layer over the
        uppermost soil level. The snow may cover all or part of the
        grid box. This parameter is a mean over a particular time
        period (the processing period) which depends on the data
        extracted. For the reanalysis, the processing period is over
        the 1 hour ending at the validity date and time. For the
        ensemble members, ensemble mean and ensemble spread, the
        processing period is over the 3 hours ending at the validity
        date and time. It is the rate the melting would have if it
        were spread evenly over the grid box. 1 kg of water spread
        over 1 square metre of surface is 1 mm deep (neglecting the
        effects of temperature on the density of water), therefore
        the units are equivalent to mm (of liquid water) per second.
      |||,
    },
    {
      name: 'mean_sub_surface_runoff_rate',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        Some water from rainfall, melting snow, or deep in the soil,
        stays stored in the soil. Otherwise, the water drains away,
        either over the surface (surface runoff), or under the
        ground (sub-surface runoff) and the sum of these two is
        called runoff. This parameter is a mean over a particular
        time period (the processing period) which depends on the
        data extracted. For the reanalysis, the processing period is
        over the 1 hour ending at the validity date and time. For
        the ensemble members, ensemble mean and ensemble spread, the
        processing period is over the 3 hours ending at the validity
        date and time. It is the rate the runoff would have if it
        were spread evenly over the grid box. Care should be taken
        when comparing model parameters with observations, because
        observations are often local to a particular point rather
        than averaged over a grid box. Runoff is a measure of the
        availability of water in the soil, and can, for example, be
        used as an indicator of drought or flood.
      |||,
    },
    {
      name: 'mean_surface_direct_short_wave_radiation_flux',
      units: units.watt_per_meter_squared,
      description: |||
        This parameter is the amount of direct solar radiation (also
        known as shortwave radiation) reaching the surface of the
        Earth. It is the amount of radiation passing through a
        horizontal plane. Solar radiation at the surface can be
        direct or diffuse. Solar radiation can be scattered in all
        directions by particles in the atmosphere, some of which
        reaches the surface (diffuse solar radiation). Some solar
        radiation reaches the surface without being scattered
        (direct solar radiation). This parameter is a mean over a
        particular time period (the processing period) which depends
        on the data extracted. For the reanalysis, the processing
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the processing period is over the 3 hours ending at
        the validity date and time. The ECMWF convention for
        vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'mean_surface_direct_short_wave_radiation_flux_clear_sky',
      units: units.watt_per_meter_squared,
      description: |||
        This parameter is the amount of direct radiation from the
        Sun (also known as solar or shortwave radiation) reaching
        the surface of the Earth, assuming clear-sky (cloudless)
        conditions. It is the amount of radiation passing through a
        horizontal plane. Solar radiation at the surface can be
        direct or diffuse. Solar radiation can be scattered in all
        directions by particles in the atmosphere, some of which
        reaches the surface (diffuse solar radiation). Some solar
        radiation reaches the surface without being scattered
        (direct solar radiation). Clear-sky radiation quantities are
        computed for exactly the same atmospheric conditions of
        temperature, humidity, ozone, trace gases and aerosol as the
        corresponding total-sky quantities (clouds included), but
        assuming that the clouds are not there. This parameter is a
        mean over a particular time period (the processing period)
        which depends on the data extracted. For the reanalysis, the
        processing period is over the 1 hour ending at the validity
        date and time. For the ensemble members, ensemble mean and
        ensemble spread, the processing period is over the 3 hours
        ending at the validity date and time. The ECMWF convention
        for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'mean_surface_downward_long_wave_radiation_flux',
      units: units.watt_per_meter_squared,
      description: |||
        This parameter is the amount of thermal (also known as
        longwave or terrestrial) radiation emitted by the atmosphere
        and clouds that reaches a horizontal plane at the surface of
        the Earth. The surface of the Earth emits thermal radiation,
        some of which is absorbed by the atmosphere and clouds. The
        atmosphere and clouds likewise emit thermal radiation in all
        directions, some of which reaches the surface (represented
        by this parameter). This parameter is a mean over a
        particular time period (the processing period) which depends
        on the data extracted. For the reanalysis, the processing
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the processing period is over the 3 hours ending at
        the validity date and time. The ECMWF convention for
        vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'mean_surface_downward_long_wave_radiation_flux_clear_sky',
      units: units.watt_per_meter_squared,
      description: |||
        This parameter is the amount of thermal (also known as
        longwave or terrestrial) radiation emitted by the atmosphere
        that reaches a horizontal plane at the surface of the Earth,
        assuming clear-sky (cloudless) conditions. The surface of
        the Earth emits thermal radiation, some of which is absorbed
        by the atmosphere and clouds. The atmosphere and clouds
        likewise emit thermal radiation in all directions, some of
        which reaches the surface. Clear-sky radiation quantities
        are computed for exactly the same atmospheric conditions of
        temperature, humidity, ozone, trace gases and aerosol as the
        corresponding total-sky quantities (clouds included), but
        assuming that the clouds are not there. This parameter is a
        mean over a particular time period (the processing period)
        which depends on the data extracted. For the reanalysis, the
        processing period is over the 1 hour ending at the validity
        date and time. For the ensemble members, ensemble mean and
        ensemble spread, the processing period is over the 3 hours
        ending at the validity date and time. The ECMWF convention
        for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'mean_surface_downward_short_wave_radiation_flux',
      units: units.watt_per_meter_squared,
      description: |||
        This parameter is the amount of solar radiation (also known
        as shortwave radiation) that reaches a horizontal plane at
        the surface of the Earth. This parameter comprises both
        direct and diffuse solar radiation. Radiation from the Sun
        (solar, or shortwave, radiation) is partly reflected back to
        space by clouds and particles in the atmosphere (aerosols)
        and some of it is absorbed. The rest is incident on the
        Earth's surface (represented by this parameter). To a
        reasonably good approximation, this parameter is the model
        equivalent of what would be measured by a pyranometer (an
        instrument used for measuring solar radiation) at the
        surface. However, care should be taken when comparing model
        parameters with observations, because observations are often
        local to a particular point in space and time, rather than
        representing averages over a model grid box. This parameter
        is a mean over a particular time period (the processing
        period) which depends on the data extracted. For the
        reanalysis, the processing period is over the 1 hour ending
        at the validity date and time. For the ensemble members,
        ensemble mean and ensemble spread, the processing period is
        over the 3 hours ending at the validity date and time. The
        ECMWF convention for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'mean_surface_downward_short_wave_radiation_flux_clear_sky',
      units: units.watt_per_meter_squared,
      description: |||
        This parameter is the amount of solar radiation (also known
        as shortwave radiation) that reaches a horizontal plane at
        the surface of the Earth, assuming clear-sky (cloudless)
        conditions. This parameter comprises both direct and diffuse
        solar radiation. Radiation from the Sun (solar, or
        shortwave, radiation) is partly reflected back to space by
        clouds and particles in the atmosphere (aerosols) and some
        of it is absorbed. The rest is incident on the Earth's
        surface. Clear-sky radiation quantities are computed for
        exactly the same atmospheric conditions of temperature,
        humidity, ozone, trace gases and aerosol as the
        corresponding total-sky quantities (clouds included), but
        assuming that the clouds are not there. This parameter is a
        mean over a particular time period (the processing period)
        which depends on the data extracted. For the reanalysis, the
        processing period is over the 1 hour ending at the validity
        date and time. For the ensemble members, ensemble mean and
        ensemble spread, the processing period is over the 3 hours
        ending at the validity date and time. The ECMWF convention
        for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'mean_surface_downward_uv_radiation_flux',
      units: units.watt_per_meter_squared,
      description: |||
        This parameter is the amount of ultraviolet (UV) radiation
        reaching the surface. It is the amount of radiation passing
        through a horizontal plane. UV radiation is part of the
        electromagnetic spectrum emitted by the Sun that has
        wavelengths shorter than visible light. In the ECMWF
        Integrated Forecasting system (IFS) it is defined as
        radiation with a wavelength of 0.20-0.44 &micro;m (microns, 1
        millionth of a metre). Small amounts of UV are essential for
        living organisms, but overexposure may result in cell
        damage; in humans this includes acute and chronic health
        effects on the skin, eyes and immune system. UV radiation is
        absorbed by the ozone layer, but some reaches the surface.
        The depletion of the ozone layer is causing concern over an
        increase in the damaging effects of UV. This parameter is a
        mean over a particular time period (the processing period)
        which depends on the data extracted. For the reanalysis, the
        processing period is over the 1 hour ending at the validity
        date and time. For the ensemble members, ensemble mean and
        ensemble spread, the processing period is over the 3 hours
        ending at the validity date and time. The ECMWF convention
        for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'mean_surface_latent_heat_flux',
      units: units.watt_per_meter_squared,
      description: |||
        This parameter is the transfer of latent heat (resulting
        from water phase changes, such as evaporation or
        condensation) between the Earth's surface and the atmosphere
        through the effects of turbulent air motion. Evaporation
        from the Earth's surface represents a transfer of energy
        from the surface to the atmosphere. This parameter is a mean
        over a particular time period (the processing period) which
        depends on the data extracted. For the reanalysis, the
        processing period is over the 1 hour ending at the validity
        date and time. For the ensemble members, ensemble mean and
        ensemble spread, the processing period is over the 3 hours
        ending at the validity date and time. The ECMWF convention
        for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'mean_surface_net_long_wave_radiation_flux',
      units: units.watt_per_meter_squared,
      description: |||
        Thermal radiation (also known as longwave or terrestrial
        radiation) refers to radiation emitted by the atmosphere,
        clouds and the surface of the Earth. This parameter is the
        difference between downward and upward thermal radiation at
        the surface of the Earth. It is the amount of radiation
        passing through a horizontal plane. The atmosphere and
        clouds emit thermal radiation in all directions, some of
        which reaches the surface as downward thermal radiation. The
        upward thermal radiation at the surface consists of thermal
        radiation emitted by the surface plus the fraction of
        downwards thermal radiation reflected upward by the surface.
        This parameter is a mean over a particular time period (the
        processing period) which depends on the data extracted. For
        the reanalysis, the processing period is over the 1 hour
        ending at the validity date and time. For the ensemble
        members, ensemble mean and ensemble spread, the processing
        period is over the 3 hours ending at the validity date and
        time. The ECMWF convention for vertical fluxes is positive
        downwards.
      |||,
    },
    {
      name: 'mean_surface_net_long_wave_radiation_flux_clear_sky',
      units: units.watt_per_meter_squared,
      description: |||
        Thermal radiation (also known as longwave or terrestrial
        radiation) refers to radiation emitted by the atmosphere,
        clouds and the surface of the Earth. This parameter is the
        difference between downward and upward thermal radiation at
        the surface of the Earth, assuming clear-sky (cloudless)
        conditions. It is the amount of radiation passing through a
        horizontal plane. Clear-sky radiation quantities are
        computed for exactly the same atmospheric conditions of
        temperature, humidity, ozone, trace gases and aerosol as the
        corresponding total-sky quantities (clouds included), but
        assuming that the clouds are not there. The atmosphere and
        clouds emit thermal radiation in all directions, some of
        which reaches the surface as downward thermal radiation. The
        upward thermal radiation at the surface consists of thermal
        radiation emitted by the surface plus the fraction of
        downwards thermal radiation reflected upward by the surface.
        This parameter is a mean over a particular time period (the
        processing period) which depends on the data extracted. For
        the reanalysis, the processing period is over the 1 hour
        ending at the validity date and time. For the ensemble
        members, ensemble mean and ensemble spread, the processing
        period is over the 3 hours ending at the validity date and
        time. The ECMWF convention for vertical fluxes is positive
        downwards.
      |||,
    },
    {
      name: 'mean_surface_net_short_wave_radiation_flux',
      units: units.watt_per_meter_squared,
      description: |||
        This parameter is the amount of solar radiation (also known
        as shortwave radiation) that reaches a horizontal plane at
        the surface of the Earth (both direct and diffuse) minus the
        amount reflected by the Earth's surface (which is governed
        by the albedo). Radiation from the Sun (solar, or shortwave,
        radiation) is partly reflected back to space by clouds and
        particles in the atmosphere (aerosols) and some of it is
        absorbed. The remainder is incident on the Earth's surface,
        where some of it is reflected. This parameter is a mean over
        a particular time period (the processing period) which
        depends on the data extracted. For the reanalysis, the
        processing period is over the 1 hour ending at the validity
        date and time. For the ensemble members, ensemble mean and
        ensemble spread, the processing period is over the 3 hours
        ending at the validity date and time. The ECMWF convention
        for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'mean_surface_net_short_wave_radiation_flux_clear_sky',
      units: units.watt_per_meter_squared,
      description: |||
        This parameter is the amount of solar (shortwave) radiation
        reaching the surface of the Earth (both direct and diffuse)
        minus the amount reflected by the Earth's surface (which is
        governed by the albedo), assuming clear-sky (cloudless)
        conditions. It is the amount of radiation passing through a
        horizontal plane. Clear-sky radiation quantities are
        computed for exactly the same atmospheric conditions of
        temperature, humidity, ozone, trace gases and aerosol as the
        corresponding total-sky quantities (clouds included), but
        assuming that the clouds are not there. Radiation from the
        Sun (solar, or shortwave, radiation) is partly reflected
        back to space by clouds and particles in the atmosphere
        (aerosols) and some of it is absorbed. The rest is incident
        on the Earth's surface, where some of it is reflected. The
        difference between downward and reflected solar radiation is
        the surface net solar radiation. This parameter is a mean
        over a particular time period (the processing period) which
        depends on the data extracted. For the reanalysis, the
        processing period is over the 1 hour ending at the validity
        date and time. For the ensemble members, ensemble mean and
        ensemble spread, the processing period is over the 3 hours
        ending at the validity date and time. The ECMWF convention
        for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'mean_surface_runoff_rate',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        Some water from rainfall, melting snow, or deep in the soil,
        stays stored in the soil. Otherwise, the water drains away,
        either over the surface (surface runoff), or under the
        ground (sub-surface runoff) and the sum of these two is
        called runoff. This parameter is a mean over a particular
        time period (the processing period) which depends on the
        data extracted. For the reanalysis, the processing period is
        over the 1 hour ending at the validity date and time. For
        the ensemble members, ensemble mean and ensemble spread, the
        processing period is over the 3 hours ending at the validity
        date and time. It is the rate the runoff would have if it
        were spread evenly over the grid box. Care should be taken
        when comparing model parameters with observations, because
        observations are often local to a particular point rather
        than averaged over a grid box. Runoff is a measure of the
        availability of water in the soil, and can, for example, be
        used as an indicator of drought or flood.
      |||,
    },
    {
      name: 'mean_surface_sensible_heat_flux',
      units: units.watt_per_meter_squared,
      description: |||
        This parameter is the transfer of heat between the Earth's
        surface and the atmosphere through the effects of turbulent
        air motion (but excluding any heat transfer resulting from
        condensation or evaporation). The magnitude of the sensible
        heat flux is governed by the difference in temperature
        between the surface and the overlying atmosphere, wind speed
        and the surface roughness. For example, cold air overlying a
        warm surface would produce a sensible heat flux from the
        land (or ocean) into the atmosphere. This parameter is a
        mean over a particular time period (the processing period)
        which depends on the data extracted. For the reanalysis, the
        processing period is over the 1 hour ending at the validity
        date and time. For the ensemble members, ensemble mean and
        ensemble spread, the processing period is over the 3 hours
        ending at the validity date and time. The ECMWF convention
        for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'mean_top_downward_short_wave_radiation_flux',
      units: units.watt_per_meter_squared,
      description: |||
        This parameter is the incoming solar radiation (also known
        as shortwave radiation), received from the Sun, at the top
        of the atmosphere. It is the amount of radiation passing
        through a horizontal plane. This parameter is a mean over a
        particular time period (the processing period) which depends
        on the data extracted. For the reanalysis, the processing
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the processing period is over the 3 hours ending at
        the validity date and time. The ECMWF convention for
        vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'mean_top_net_long_wave_radiation_flux',
      units: units.watt_per_meter_squared,
      description: |||
        The thermal (also known as terrestrial or longwave)
        radiation emitted to space at the top of the atmosphere is
        commonly known as the Outgoing Longwave Radiation (OLR). The
        top net thermal radiation (this parameter) is equal to the
        negative of OLR. This parameter is a mean over a particular
        time period (the processing period) which depends on the
        data extracted. For the reanalysis, the processing period is
        over the 1 hour ending at the validity date and time. For
        the ensemble members, ensemble mean and ensemble spread, the
        processing period is over the 3 hours ending at the validity
        date and time. The ECMWF convention for vertical fluxes is
        positive downwards.
      |||,
    },
    {
      name: 'mean_top_net_long_wave_radiation_flux_clear_sky',
      units: units.watt_per_meter_squared,
      description: |||
        This parameter is the thermal (also known as terrestrial or
        longwave) radiation emitted to space at the top of the
        atmosphere, assuming clear-sky (cloudless) conditions. It is
        the amount passing through a horizontal plane. Note that the
        ECMWF convention for vertical fluxes is positive downwards,
        so a flux from the atmosphere to space will be negative.
        Clear-sky radiation quantities are computed for exactly the
        same atmospheric conditions of temperature, humidity, ozone,
        trace gases and aerosol as total-sky quantities (clouds
        included), but assuming that the clouds are not there. The
        thermal radiation emitted to space at the top of the
        atmosphere is commonly known as the Outgoing Longwave
        Radiation (OLR) (i.e., taking a flux from the atmosphere to
        space as positive). This parameter is a mean over a
        particular time period (the processing period) which depends
        on the data extracted. For the reanalysis, the processing
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the processing period is over the 3 hours ending at
        the validity date and time.
      |||,
    },
    {
      name: 'mean_top_net_short_wave_radiation_flux',
      units: units.watt_per_meter_squared,
      description: |||
        This parameter is the incoming solar radiation (also known
        as shortwave radiation) minus the outgoing solar radiation
        at the top of the atmosphere. It is the amount of radiation
        passing through a horizontal plane. The incoming solar
        radiation is the amount received from the Sun. The outgoing
        solar radiation is the amount reflected and scattered by the
        Earth's atmosphere and surface. This parameter is a mean
        over a particular time period (the processing period) which
        depends on the data extracted. For the reanalysis, the
        processing period is over the 1 hour ending at the validity
        date and time. For the ensemble members, ensemble mean and
        ensemble spread, the processing period is over the 3 hours
        ending at the validity date and time. The ECMWF convention
        for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'mean_top_net_short_wave_radiation_flux_clear_sky',
      units: units.watt_per_meter_squared,
      description: |||
        This parameter is the incoming solar radiation (also known
        as shortwave radiation) minus the outgoing solar radiation
        at the top of the atmosphere, assuming clear-sky (cloudless)
        conditions. It is the amount of radiation passing through a
        horizontal plane. The incoming solar radiation is the amount
        received from the Sun. The outgoing solar radiation is the
        amount reflected and scattered by the Earth's atmosphere and
        surface, assuming clear-sky (cloudless) conditions.
        Clear-sky radiation quantities are computed for exactly the
        same atmospheric conditions of temperature, humidity, ozone,
        trace gases and aerosol as the total-sky (clouds included)
        quantities, but assuming that the clouds are not there. This
        parameter is a mean over a particular time period (the
        processing period) which depends on the data extracted. For
        the reanalysis, the processing period is over the 1 hour
        ending at the validity date and time. For the ensemble
        members, ensemble mean and ensemble spread, the processing
        period is over the 3 hours ending at the validity date and
        time. The ECMWF convention for vertical fluxes is positive
        downwards.
      |||,
    },
    {
      name: 'mean_total_precipitation_rate',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        This parameter is the rate of precipitation at the Earth's
        surface. It is the sum of the rates due to large-scale
        precipitation and convective precipitation. Large-scale
        precipitation is generated by the cloud scheme in the ECMWF
        Integrated Forecasting System (IFS). The cloud scheme
        represents the formation and dissipation of clouds and
        large-scale precipitation due to changes in atmospheric
        quantities (such as pressure, temperature and moisture)
        predicted directly at spatial scales of the grid box or
        larger. Convective precipitation is generated by the
        convection scheme in the IFS, which represents convection at
        spatial scales smaller than the grid box. In the IFS,
        precipitation is comprised of rain and snow. This parameter
        is a mean over a particular time period (the processing
        period) which depends on the data extracted. For the
        reanalysis, the processing period is over the 1 hour ending
        at the validity date and time. For the ensemble members,
        ensemble mean and ensemble spread, the processing period is
        over the 3 hours ending at the validity date and time. It is
        the rate the precipitation would have if it were spread
        evenly over the grid box. 1 kg of water spread over 1 square
        metre of surface is 1 mm deep (neglecting the effects of
        temperature on the density of water), therefore the units
        are equivalent to mm (of liquid water) per second. Care
        should be taken when comparing model parameters with
        observations, because observations are often local to a
        particular point in space and time, rather than representing
        averages over a model grid box.
      |||,
    },
    {
      name: 'mean_vertically_integrated_moisture_divergence',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        The vertical integral of the moisture flux is the horizontal
        rate of flow of moisture (water vapour, cloud liquid and
        cloud ice), per metre across the flow, for a column of air
        extending from the surface of the Earth to the top of the
        atmosphere. Its horizontal divergence is the rate of
        moisture spreading outward from a point, per square metre.
        This parameter is a mean over a particular time period (the
        processing period) which depends on the data extracted. For
        the reanalysis, the processing period is over the 1 hour
        ending at the validity date and time. For the ensemble
        members, ensemble mean and ensemble spread, the processing
        period is over the 3 hours ending at the validity date and
        time. This parameter is positive for moisture that is
        spreading out, or diverging, and negative for the opposite,
        for moisture that is concentrating, or converging
        (convergence). This parameter thus indicates whether
        atmospheric motions act to decrease (for divergence) or
        increase (for convergence) the vertical integral of
        moisture, over the time period. High negative values of this
        parameter (i.e. large moisture convergence) can be related
        to precipitation intensification and floods. 1 kg of water
        spread over 1 square metre of surface is 1 mm deep
        (neglecting the effects of temperature on the density of
        water), therefore the units are equivalent to mm (of liquid
        water) per second.
      |||,
    },
    {
      name: 'clear_sky_direct_solar_radiation_at_surface',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the amount of direct radiation from the
        Sun (also known as solar or shortwave radiation) reaching
        the surface of the Earth, assuming clear-sky (cloudless)
        conditions. It is the amount of radiation passing through a
        horizontal plane. Solar radiation at the surface can be
        direct or diffuse. Solar radiation can be scattered in all
        directions by particles in the atmosphere, some of which
        reaches the surface (diffuse solar radiation). Some solar
        radiation reaches the surface without being scattered
        (direct solar radiation). Clear-sky radiation quantities are
        computed for exactly the same atmospheric conditions of
        temperature, humidity, ozone, trace gases and aerosol as the
        corresponding total-sky quantities (clouds included), but
        assuming that the clouds are not there. This parameter is
        accumulated over a particular time period which depends on
        the data extracted. For the reanalysis, the accumulation
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the accumulation period is over the 3 hours ending
        at the validity date and time. The units are joules per
        square metre (J m^-2 ). To convert to watts per square metre
        (W m^-2 ), the accumulated values should be divided by the
        accumulation period expressed in seconds. The ECMWF
        convention for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'downward_uv_radiation_at_the_surface',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the amount of ultraviolet (UV) radiation
        reaching the surface. It is the amount of radiation passing
        through a horizontal plane. UV radiation is part of the
        electromagnetic spectrum emitted by the Sun that has
        wavelengths shorter than visible light. In the ECMWF
        Integrated Forecasting system (IFS) it is defined as
        radiation with a wavelength of 0.20-0.44 &micro;m (microns, 1
        millionth of a metre). Small amounts of UV are essential for
        living organisms, but overexposure may result in cell
        damage; in humans this includes acute and chronic health
        effects on the skin, eyes and immune system. UV radiation is
        absorbed by the ozone layer, but some reaches the surface.
        The depletion of the ozone layer is causing concern over an
        increase in the damaging effects of UV. This parameter is
        accumulated over a particular time period which depends on
        the data extracted. For the reanalysis, the accumulation
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the accumulation period is over the 3 hours ending
        at the validity date and time. The units are joules per
        square metre (J m^-2 ). To convert to watts per square metre
        (W m^-2 ), the accumulated values should be divided by the
        accumulation period expressed in seconds. The ECMWF
        convention for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'forecast_logarithm_of_surface_roughness_for_heat',
      units: units.dimensionless,
      description: |||
        This parameter is the natural logarithm of the roughness
        length for heat. The surface roughness for heat is a measure
        of the surface resistance to heat transfer. This parameter
        is used to determine the air to surface transfer of heat.
        For given atmospheric conditions, a higher surface roughness
        for heat means that it is more difficult for the air to
        exchange heat with the surface. A lower surface roughness
        for heat means that it is easier for the air to exchange
        heat with the surface. Over the ocean, surface roughness for
        heat depends on the waves. Over sea-ice, it has a constant
        value of 0.001 m. Over land, it is derived from the
        vegetation type and snow cover.
      |||,
    },
    {
      name: 'instantaneous_surface_sensible_heat_flux',
      units: units.watt_per_meter_squared,
      description: |||
        This parameter is the transfer of heat between the Earth's
        surface and the atmosphere, at the specified time, through
        the effects of turbulent air motion (but excluding any heat
        transfer resulting from condensation or evaporation). The
        magnitude of the sensible heat flux is governed by the
        difference in temperature between the surface and the
        overlying atmosphere, wind speed and the surface roughness.
        For example, cold air overlying a warm surface would produce
        a sensible heat flux from the land (or ocean) into the
        atmosphere. The ECMWF convention for vertical fluxes is
        positive downwards.
      |||,
    },
    {
      name: 'near_ir_albedo_for_diffuse_radiation',
      units: units.dimensionless,
      description: |||
        Albedo is a measure of the reflectivity of the Earth's
        surface. This parameter is the fraction of diffuse solar
        (shortwave) radiation with wavelengths between 0.7 and 4 &micro;m
        (microns, 1 millionth of a metre) reflected by the Earth's
        surface (for snow-free land surfaces only). Values of this
        parameter vary between 0 and 1. In the ECMWF Integrated
        Forecasting System (IFS) albedo is dealt with separately for
        solar radiation with wavelengths greater/less than 0.7&micro;m and
        for direct and diffuse solar radiation (giving 4 components
        to albedo). Solar radiation at the surface can be direct or
        diffuse. Solar radiation can be scattered in all directions
        by particles in the atmosphere, some of which reaches the
        surface (diffuse solar radiation). Some solar radiation
        reaches the surface without being scattered (direct solar
        radiation). In the IFS, a climatological (observed values
        averaged over a period of several years) background albedo
        is used which varies from month to month through the year,
        modified by the model over water, ice and snow.
      |||,
    },
    {
      name: 'near_ir_albedo_for_direct_radiation',
      units: units.dimensionless,
      description: |||
        Albedo is a measure of the reflectivity of the Earth's
        surface. This parameter is the fraction of direct solar
        (shortwave) radiation with wavelengths between 0.7 and 4 &micro;m
        (microns, 1 millionth of a metre) reflected by the Earth's
        surface (for snow-free land surfaces only). Values of this
        parameter vary between 0 and 1. In the ECMWF Integrated
        Forecasting System (IFS) albedo is dealt with separately for
        solar radiation with wavelengths greater/less than 0.7&micro;m and
        for direct and diffuse solar radiation (giving 4 components
        to albedo). Solar radiation at the surface can be direct or
        diffuse. Solar radiation can be scattered in all directions
        by particles in the atmosphere, some of which reaches the
        surface (diffuse solar radiation). Some solar radiation
        reaches the surface without being scattered (direct solar
        radiation). In the IFS, a climatological (observed values
        averaged over a period of several years) background albedo
        is used which varies from month to month through the year,
        modified by the model over water, ice and snow.
      |||,
    },
    {
      name: 'surface_latent_heat_flux',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the transfer of latent heat (resulting
        from water phase changes, such as evaporation or
        condensation) between the Earth's surface and the atmosphere
        through the effects of turbulent air motion. Evaporation
        from the Earth's surface represents a transfer of energy
        from the surface to the atmosphere. This parameter is
        accumulated over a particular time period which depends on
        the data extracted. For the reanalysis, the accumulation
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the accumulation period is over the 3 hours ending
        at the validity date and time. The units are joules per
        square metre (J m^-2 ). To convert to watts per square metre
        (W m^-2 ), the accumulated values should be divided by the
        accumulation period expressed in seconds. The ECMWF
        convention for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'surface_net_solar_radiation',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the amount of solar radiation (also known
        as shortwave radiation) that reaches a horizontal plane at
        the surface of the Earth (both direct and diffuse) minus the
        amount reflected by the Earth's surface (which is governed
        by the albedo). Radiation from the Sun (solar, or shortwave,
        radiation) is partly reflected back to space by clouds and
        particles in the atmosphere (aerosols) and some of it is
        absorbed. The remainder is incident on the Earth's surface,
        where some of it is reflected. This parameter is accumulated
        over a particular time period which depends on the data
        extracted. For the reanalysis, the accumulation period is
        over the 1 hour ending at the validity date and time. For
        the ensemble members, ensemble mean and ensemble spread, the
        accumulation period is over the 3 hours ending at the
        validity date and time. The units are joules per square
        metre (J m^-2 ). To convert to watts per square metre (W
        m^-2 ), the accumulated values should be divided by the
        accumulation period expressed in seconds. The ECMWF
        convention for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'surface_net_solar_radiation_clear_sky',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the amount of solar (shortwave) radiation
        reaching the surface of the Earth (both direct and diffuse)
        minus the amount reflected by the Earth's surface (which is
        governed by the albedo), assuming clear-sky (cloudless)
        conditions. It is the amount of radiation passing through a
        horizontal plane. Clear-sky radiation quantities are
        computed for exactly the same atmospheric conditions of
        temperature, humidity, ozone, trace gases and aerosol as the
        corresponding total-sky quantities (clouds included), but
        assuming that the clouds are not there. Radiation from the
        Sun (solar, or shortwave, radiation) is partly reflected
        back to space by clouds and particles in the atmosphere
        (aerosols) and some of it is absorbed. The rest is incident
        on the Earth's surface, where some of it is reflected. The
        difference between downward and reflected solar radiation is
        the surface net solar radiation. This parameter is
        accumulated over a particular time period which depends on
        the data extracted. For the reanalysis, the accumulation
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the accumulation period is over the 3 hours ending
        at the validity date and time. The units are joules per
        square metre (J m^-2 ). To convert to watts per square metre
        (W m^-2 ), the accumulated values should be divided by the
        accumulation period expressed in seconds. The ECMWF
        convention for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'surface_net_thermal_radiation',
      units: units.joules_per_meter2,
      description: |||
        Thermal radiation (also known as longwave or terrestrial
        radiation) refers to radiation emitted by the atmosphere,
        clouds and the surface of the Earth. This parameter is the
        difference between downward and upward thermal radiation at
        the surface of the Earth. It is the amount of radiation
        passing through a horizontal plane. The atmosphere and
        clouds emit thermal radiation in all directions, some of
        which reaches the surface as downward thermal radiation. The
        upward thermal radiation at the surface consists of thermal
        radiation emitted by the surface plus the fraction of
        downwards thermal radiation reflected upward by the surface.
        This parameter is accumulated over a particular time period
        which depends on the data extracted. For the reanalysis, the
        accumulation period is over the 1 hour ending at the
        validity date and time. For the ensemble members, ensemble
        mean and ensemble spread, the accumulation period is over
        the 3 hours ending at the validity date and time. The units
        are joules per square metre (J m^-2 ). To convert to watts
        per square metre (W m^-2 ), the accumulated values should be
        divided by the accumulation period expressed in seconds. The
        ECMWF convention for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'surface_net_thermal_radiation_clear_sky',
      units: units.joules_per_meter2,
      description: |||
        Thermal radiation (also known as longwave or terrestrial
        radiation) refers to radiation emitted by the atmosphere,
        clouds and the surface of the Earth. This parameter is the
        difference between downward and upward thermal radiation at
        the surface of the Earth, assuming clear-sky (cloudless)
        conditions. It is the amount of radiation passing through a
        horizontal plane. Clear-sky radiation quantities are
        computed for exactly the same atmospheric conditions of
        temperature, humidity, ozone, trace gases and aerosol as the
        corresponding total-sky quantities (clouds included), but
        assuming that the clouds are not there. The atmosphere and
        clouds emit thermal radiation in all directions, some of
        which reaches the surface as downward thermal radiation. The
        upward thermal radiation at the surface consists of thermal
        radiation emitted by the surface plus the fraction of
        downwards thermal radiation reflected upward by the surface.
        This parameter is accumulated over a particular time period
        which depends on the data extracted. For the reanalysis, the
        accumulation period is over the 1 hour ending at the
        validity date and time. For the ensemble members, ensemble
        mean and ensemble spread, the accumulation period is over
        the 3 hours ending at the validity date and time. The units
        are joules per square metre (J m^-2 ). To convert to watts
        per square metre (W m^-2 ), the accumulated values should be
        divided by the accumulation period expressed in seconds. The
        ECMWF convention for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'surface_sensible_heat_flux',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the transfer of heat between the Earth's
        surface and the atmosphere through the effects of turbulent
        air motion (but excluding any heat transfer resulting from
        condensation or evaporation). The magnitude of the sensible
        heat flux is governed by the difference in temperature
        between the surface and the overlying atmosphere, wind speed
        and the surface roughness. For example, cold air overlying a
        warm surface would produce a sensible heat flux from the
        land (or ocean) into the atmosphere. This parameter is
        accumulated over a particular time period which depends on
        the data extracted. For the reanalysis, the accumulation
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the accumulation period is over the 3 hours ending
        at the validity date and time. The units are joules per
        square metre (J m^-2 ). To convert to watts per square metre
        (W m^-2 ), the accumulated values should be divided by the
        accumulation period expressed in seconds. The ECMWF
        convention for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'surface_solar_radiation_downward_clear_sky',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the amount of solar radiation (also known
        as shortwave radiation) that reaches a horizontal plane at
        the surface of the Earth, assuming clear-sky (cloudless)
        conditions. This parameter comprises both direct and diffuse
        solar radiation. Radiation from the Sun (solar, or
        shortwave, radiation) is partly reflected back to space by
        clouds and particles in the atmosphere (aerosols) and some
        of it is absorbed. The rest is incident on the Earth's
        surface. Clear-sky radiation quantities are computed for
        exactly the same atmospheric conditions of temperature,
        humidity, ozone, trace gases and aerosol as the
        corresponding total-sky quantities (clouds included), but
        assuming that the clouds are not there. This parameter is
        accumulated over a particular time period which depends on
        the data extracted. For the reanalysis, the accumulation
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the accumulation period is over the 3 hours ending
        at the validity date and time. The units are joules per
        square metre (J m^-2 ). To convert to watts per square metre
        (W m^-2 ), the accumulated values should be divided by the
        accumulation period expressed in seconds. The ECMWF
        convention for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'surface_solar_radiation_downwards',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the amount of solar radiation (also known
        as shortwave radiation) that reaches a horizontal plane at
        the surface of the Earth. This parameter comprises both
        direct and diffuse solar radiation. Radiation from the Sun
        (solar, or shortwave, radiation) is partly reflected back to
        space by clouds and particles in the atmosphere (aerosols)
        and some of it is absorbed. The rest is incident on the
        Earth's surface (represented by this parameter). To a
        reasonably good approximation, this parameter is the model
        equivalent of what would be measured by a pyranometer (an
        instrument used for measuring solar radiation) at the
        surface. However, care should be taken when comparing model
        parameters with observations, because observations are often
        local to a particular point in space and time, rather than
        representing averages over a model grid box. This parameter
        is accumulated over a particular time period which depends
        on the data extracted. For the reanalysis, the accumulation
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the accumulation period is over the 3 hours ending
        at the validity date and time. The units are joules per
        square metre (J m^-2 ). To convert to watts per square metre
        (W m^-2 ), the accumulated values should be divided by the
        accumulation period expressed in seconds. The ECMWF
        convention for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'surface_thermal_radiation_downward_clear_sky',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the amount of thermal (also known as
        longwave or terrestrial) radiation emitted by the atmosphere
        that reaches a horizontal plane at the surface of the Earth,
        assuming clear-sky (cloudless) conditions. The surface of
        the Earth emits thermal radiation, some of which is absorbed
        by the atmosphere and clouds. The atmosphere and clouds
        likewise emit thermal radiation in all directions, some of
        which reaches the surface. Clear-sky radiation quantities
        are computed for exactly the same atmospheric conditions of
        temperature, humidity, ozone, trace gases and aerosol as the
        corresponding total-sky quantities (clouds included), but
        assuming that the clouds are not there. This parameter is
        accumulated over a particular time period which depends on
        the data extracted. For the reanalysis, the accumulation
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the accumulation period is over the 3 hours ending
        at the validity date and time. The units are joules per
        square metre (J m^-2 ). To convert to watts per square metre
        (W m^-2 ), the accumulated values should be divided by the
        accumulation period expressed in seconds. The ECMWF
        convention for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'surface_thermal_radiation_downwards',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the amount of thermal (also known as
        longwave or terrestrial) radiation emitted by the atmosphere
        and clouds that reaches a horizontal plane at the surface of
        the Earth. The surface of the Earth emits thermal radiation,
        some of which is absorbed by the atmosphere and clouds. The
        atmosphere and clouds likewise emit thermal radiation in all
        directions, some of which reaches the surface (represented
        by this parameter). This parameter is accumulated over a
        particular time period which depends on the data extracted.
        For the reanalysis, the accumulation period is over the 1
        hour ending at the validity date and time. For the ensemble
        members, ensemble mean and ensemble spread, the accumulation
        period is over the 3 hours ending at the validity date and
        time. The units are joules per square metre (J m^-2 ). To
        convert to watts per square metre (W m^-2 ), the accumulated
        values should be divided by the accumulation period
        expressed in seconds. The ECMWF convention for vertical
        fluxes is positive downwards.
      |||,
    },
    {
      name: 'toa_incident_solar_radiation',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the incoming solar radiation (also known
        as shortwave radiation), received from the Sun, at the top
        of the atmosphere. It is the amount of radiation passing
        through a horizontal plane. This parameter is accumulated
        over a particular time period which depends on the data
        extracted. For the reanalysis, the accumulation period is
        over the 1 hour ending at the validity date and time. For
        the ensemble members, ensemble mean and ensemble spread, the
        accumulation period is over the 3 hours ending at the
        validity date and time. The units are joules per square
        metre (J m^-2 ). To convert to watts per square metre (W
        m^-2 ), the accumulated values should be divided by the
        accumulation period expressed in seconds. The ECMWF
        convention for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'top_net_solar_radiation',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the incoming solar radiation (also known
        as shortwave radiation) minus the outgoing solar radiation
        at the top of the atmosphere. It is the amount of radiation
        passing through a horizontal plane. The incoming solar
        radiation is the amount received from the Sun. The outgoing
        solar radiation is the amount reflected and scattered by the
        Earth's atmosphere and surface. This parameter is
        accumulated over a particular time period which depends on
        the data extracted. For the reanalysis, the accumulation
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the accumulation period is over the 3 hours ending
        at the validity date and time. The units are joules per
        square metre (J m^-2 ). To convert to watts per square metre
        (W m^-2 ), the accumulated values should be divided by the
        accumulation period expressed in seconds. The ECMWF
        convention for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'top_net_solar_radiation_clear_sky',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the incoming solar radiation (also known
        as shortwave radiation) minus the outgoing solar radiation
        at the top of the atmosphere, assuming clear-sky (cloudless)
        conditions. It is the amount of radiation passing through a
        horizontal plane. The incoming solar radiation is the amount
        received from the Sun. The outgoing solar radiation is the
        amount reflected and scattered by the Earth's atmosphere and
        surface, assuming clear-sky (cloudless) conditions.
        Clear-sky radiation quantities are computed for exactly the
        same atmospheric conditions of temperature, humidity, ozone,
        trace gases and aerosol as the total-sky (clouds included)
        quantities, but assuming that the clouds are not there. This
        parameter is accumulated over a particular time period which
        depends on the data extracted. For the reanalysis, the
        accumulation period is over the 1 hour ending at the
        validity date and time. For the ensemble members, ensemble
        mean and ensemble spread, the accumulation period is over
        the 3 hours ending at the validity date and time. The units
        are joules per square metre (J m^-2 ). To convert to watts
        per square metre (W m^-2 ), the accumulated values should be
        divided by the accumulation period expressed in seconds. The
        ECMWF convention for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'top_net_thermal_radiation',
      units: units.joules_per_meter2,
      description: |||
        The thermal (also known as terrestrial or longwave)
        radiation emitted to space at the top of the atmosphere is
        commonly known as the Outgoing Longwave Radiation (OLR). The
        top net thermal radiation (this parameter) is equal to the
        negative of OLR. This parameter is accumulated over a
        particular time period which depends on the data extracted.
        For the reanalysis, the accumulation period is over the 1
        hour ending at the validity date and time. For the ensemble
        members, ensemble mean and ensemble spread, the accumulation
        period is over the 3 hours ending at the validity date and
        time. The units are joules per square metre (J m^-2 ). To
        convert to watts per square metre (W m^-2 ), the accumulated
        values should be divided by the accumulation period
        expressed in seconds. The ECMWF convention for vertical
        fluxes is positive downwards.
      |||,
    },
    {
      name: 'top_net_thermal_radiation_clear_sky',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the thermal (also known as terrestrial or
        longwave) radiation emitted to space at the top of the
        atmosphere, assuming clear-sky (cloudless) conditions. It is
        the amount passing through a horizontal plane. Note that the
        ECMWF convention for vertical fluxes is positive downwards,
        so a flux from the atmosphere to space will be negative.
        Clear-sky radiation quantities are computed for exactly the
        same atmospheric conditions of temperature, humidity, ozone,
        trace gases and aerosol as total-sky quantities (clouds
        included), but assuming that the clouds are not there. The
        thermal radiation emitted to space at the top of the
        atmosphere is commonly known as the Outgoing Longwave
        Radiation (OLR) (i.e., taking a flux from the atmosphere to
        space as positive). Note that OLR is typically shown in
        units of watts per square metre (W m^-2 ). This parameter is
        accumulated over a particular time period which depends on
        the data extracted. For the reanalysis, the accumulation
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the accumulation period is over the 3 hours ending
        at the validity date and time. The units are joules per
        square metre (J m^-2 ). To convert to watts per square metre
        (W m^-2 ), the accumulated values should be divided by the
        accumulation period expressed in seconds.
      |||,
    },
    {
      name: 'total_sky_direct_solar_radiation_at_surface',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the amount of direct solar radiation (also
        known as shortwave radiation) reaching the surface of the
        Earth. It is the amount of radiation passing through a
        horizontal plane. Solar radiation at the surface can be
        direct or diffuse. Solar radiation can be scattered in all
        directions by particles in the atmosphere, some of which
        reaches the surface (diffuse solar radiation). Some solar
        radiation reaches the surface without being scattered
        (direct solar radiation). This parameter is accumulated over
        a particular time period which depends on the data
        extracted. For the reanalysis, the accumulation period is
        over the 1 hour ending at the validity date and time. For
        the ensemble members, ensemble mean and ensemble spread, the
        accumulation period is over the 3 hours ending at the
        validity date and time. The units are joules per square
        metre (J m^-2 ). To convert to watts per square metre (W
        m^-2 ), the accumulated values should be divided by the
        accumulation period expressed in seconds. The ECMWF
        convention for vertical fluxes is positive downwards.
      |||,
    },
    {
      name: 'uv_visible_albedo_for_diffuse_radiation',
      units: units.dimensionless,
      description: |||
        Albedo is a measure of the reflectivity of the Earth's
        surface. This parameter is the fraction of diffuse solar
        (shortwave) radiation with wavelengths between 0.3 and 0.7
        &micro;m (microns, 1 millionth of a metre) reflected by the
        Earth's surface (for snow-free land surfaces only). In the
        ECMWF Integrated Forecasting System (IFS) albedo is dealt
        with separately for solar radiation with wavelengths
        greater/less than 0.7&micro;m and for direct and diffuse solar
        radiation (giving 4 components to albedo). Solar radiation
        at the surface can be direct or diffuse. Solar radiation can
        be scattered in all directions by particles in the
        atmosphere, some of which reaches the surface (diffuse solar
        radiation). Some solar radiation reaches the surface without
        being scattered (direct solar radiation). In the IFS, a
        climatological (observed values averaged over a period of
        several years) background albedo is used which varies from
        month to month through the year, modified by the model over
        water, ice and snow. This parameter varies between 0 and 1.
      |||,
    },
    {
      name: 'uv_visible_albedo_for_direct_radiation',
      units: units.dimensionless,
      description: |||
        Albedo is a measure of the reflectivity of the Earth's
        surface. This parameter is the fraction of direct solar
        (shortwave) radiation with wavelengths between 0.3 and 0.7
        &micro;m (microns, 1 millionth of a metre) reflected by the
        Earth's surface (for snow-free land surfaces only). In the
        ECMWF Integrated Forecasting System (IFS) albedo is dealt
        with separately for solar radiation with wavelengths
        greater/less than 0.7&micro;m and for direct and diffuse solar
        radiation (giving 4 components to albedo). Solar radiation
        at the surface can be direct or diffuse. Solar radiation can
        be scattered in all directions by particles in the
        atmosphere, some of which reaches the surface (diffuse solar
        radiation). Some solar radiation reaches the surface without
        being scattered (direct solar radiation). In the IFS, a
        climatological (observed values averaged over a period of
        several years) background albedo is used which varies from
        month to month through the year, modified by the model over
        water, ice and snow.
      |||,
    },
    {
      name: 'cloud_base_height',
      units: units.meter,
      description: |||
        The height above the Earth's surface of the base of the
        lowest cloud layer, at the specified time. This parameter is
        calculated by searching from the second lowest model level
        upwards, to the height of the level where cloud fraction
        becomes greater than 1% and condensate content greater than
        1.E-6 kg kg^-1. Fog (i.e., cloud in the lowest model layer)
        is not considered when defining cloud base height.
      |||,
    },
    {
      name: 'high_cloud_cover',
      units: units.dimensionless,
      description: |||
        The proportion of a grid box covered by cloud occurring in
        the high levels of the troposphere. High cloud is a single
        level field calculated from cloud occurring on model levels
        with a pressure less than 0.45 times the surface pressure.
        So, if the surface pressure is 1000 hPa (hectopascal), high
        cloud would be calculated using levels with a pressure of
        less than 450 hPa (approximately 6km and above (assuming a
        "standard atmosphere")). The high cloud cover parameter is
        calculated from cloud for the appropriate model levels as
        described above. Assumptions are made about the degree of
        overlap/randomness between clouds in different model levels.
        Cloud fractions vary from 0 to 1.
      |||,
    },
    {
      name: 'low_cloud_cover',
      units: units.dimensionless,
      description: |||
        This parameter is the proportion of a grid box covered by
        cloud occurring in the lower levels of the troposphere. Low
        cloud is a single level field calculated from cloud
        occurring on model levels with a pressure greater than 0.8
        times the surface pressure. So, if the surface pressure is
        1000 hPa (hectopascal), low cloud would be calculated using
        levels with a pressure greater than 800 hPa (below
        approximately 2km (assuming a "standard atmosphere")).
        Assumptions are made about the degree of overlap/randomness
        between clouds in different model levels. This parameter has
        values from 0 to 1.
      |||,
    },
    {
      name: 'medium_cloud_cover',
      units: units.dimensionless,
      description: |||
        This parameter is the proportion of a grid box covered by
        cloud occurring in the middle levels of the troposphere.
        Medium cloud is a single level field calculated from cloud
        occurring on model levels with a pressure between 0.45 and
        0.8 times the surface pressure. So, if the surface pressure
        is 1000 hPa (hectopascal), medium cloud would be calculated
        using levels with a pressure of less than or equal to 800
        hPa and greater than or equal to 450 hPa (between
        approximately 2km and 6km (assuming a "standard
        atmosphere")). The medium cloud parameter is calculated from
        cloud cover for the appropriate model levels as described
        above. Assumptions are made about the degree of
        overlap/randomness between clouds in different model levels.
        Cloud fractions vary from 0 to 1.
      |||,
    },
    {
      name: 'total_cloud_cover',
      units: units.dimensionless,
      description: |||
        This parameter is the proportion of a grid box covered by
        cloud. Total cloud cover is a single level field calculated
        from the cloud occurring at different model levels through
        the atmosphere. Assumptions are made about the degree of
        overlap/randomness between clouds at different heights.
        Cloud fractions vary from 0 to 1.
      |||,
    },
    {
      name: 'total_column_cloud_ice_water',
      units: units.area_density,
      description: |||
        This parameter is the amount of ice contained within clouds
        in a column extending from the surface of the Earth to the
        top of the atmosphere. Snow (aggregated ice crystals) is not
        included in this parameter. This parameter represents the
        area averaged value for a model grid box. Clouds contain a
        continuum of different sized water droplets and ice
        particles. The ECMWF Integrated Forecasting System (IFS)
        cloud scheme simplifies this to represent a number of
        discrete cloud droplets/particles including: cloud water
        droplets, raindrops, ice crystals and snow (aggregated ice
        crystals). The processes of droplet formation, phase
        transition and aggregation are also highly simplified in the
        IFS.
      |||,
    },
    {
      name: 'total_column_cloud_liquid_water',
      units: units.area_density,
      description: |||
        This parameter is the amount of liquid water contained
        within cloud droplets in a column extending from the surface
        of the Earth to the top of the atmosphere. Rain water
        droplets, which are much larger in size (and mass), are not
        included in this parameter. This parameter represents the
        area averaged value for a model grid box. Clouds contain a
        continuum of different sized water droplets and ice
        particles. The ECMWF Integrated Forecasting System (IFS)
        cloud scheme simplifies this to represent a number of
        discrete cloud droplets/particles including: cloud water
        droplets, raindrops, ice crystals and snow (aggregated ice
        crystals). The processes of droplet formation, phase
        transition and aggregation are also highly simplified in the
        IFS.
      |||,
    },
    {
      name: 'lake_bottom_temperature',
      units: units.kelvin,
      description: |||
        This parameter is the temperature of water at the bottom of
        inland water bodies (lakes, reservoirs, rivers and coastal
        waters). This parameter is defined over the whole globe,
        even where there is no inland water. Regions without inland
        water can be masked out by only considering grid points
        where the lake cover is greater than 0.0. In May 2015, a
        lake model was implemented in the ECMWF Integrated
        Forecasting System (IFS) to represent the water temperature
        and lake ice of all the world's major inland water bodies.
        Lake depth and area fraction (cover) are kept constant in
        time.
      |||,
    },
    {
      name: 'lake_cover',
      units: units.dimensionless,
      description: |||
        This parameter is the proportion of a grid box covered by
        inland water bodies (lakes, reservoirs, rivers and coastal
        waters). Values vary between 0: no inland water, and 1: grid
        box is fully covered with inland water. This parameter is
        specified from observations and does not vary in time. In
        May 2015, a lake model was implemented in the ECMWF
        Integrated Forecasting System (IFS) to represent the water
        temperature and lake ice of all the world's major inland
        water bodies.
      |||,
    },
    {
      name: 'lake_depth',
      units: units.meter,
      description: |||
        This parameter is the mean depth of inland water bodies
        (lakes, reservoirs, rivers and coastal waters). This
        parameter is specified from in-situ measurements and
        indirect estimates and does not vary in time. This parameter
        is defined over the whole globe, even where there is no
        inland water. Regions without inland water can be masked out
        by only considering grid points where the lake cover is
        greater than 0.0. In May 2015, a lake model was implemented
        in the ECMWF Integrated Forecasting System (IFS) to
        represent the water temperature and lake ice of all the
        world's major inland water bodies.
      |||,
    },
    {
      name: 'lake_ice_depth',
      units: units.meter,
      description: |||
        This parameter is the thickness of ice on inland water
        bodies (lakes, reservoirs, rivers and coastal waters). This
        parameter is defined over the whole globe, even where there
        is no inland water. Regions without inland water can be
        masked out by only considering grid points where the lake
        cover is greater than 0.0. In May 2015, a lake model was
        implemented in the ECMWF Integrated Forecasting System (IFS)
        to represent the water temperature and lake ice of all the
        world's major inland water bodies. Lake depth and area
        fraction (cover) are kept constant in time. A single ice
        layer is used to represent the formation and melting of ice
        on inland water bodies. This parameter is the thickness of
        that ice layer.
      |||,
    },
    {
      name: 'lake_ice_temperature',
      units: units.kelvin,
      description: |||
        This parameter is the temperature of the uppermost surface
        of ice on inland water bodies (lakes, reservoirs, rivers and
        coastal waters). It is the temperature at the ice/atmosphere
        or ice/snow interface. This parameter is defined over the
        whole globe, even where there is no inland water. Regions
        without inland water can be masked out by only considering
        grid points where the lake cover is greater than 0.0. In May
        2015, a lake model was implemented in the ECMWF Integrated
        Forecasting System (IFS) to represent the water temperature
        and lake ice of all the world's major inland water bodies.
        Lake depth and area fraction (cover) are kept constant in
        time. A single ice layer is used to represent the formation
        and melting of ice on inland water bodies.
      |||,
    },
    {
      name: 'lake_mix_layer_depth',
      units: units.meter,
      description: |||
        This parameter is the thickness of the uppermost layer of
        inland water bodies (lakes, reservoirs, rivers and coastal
        waters) that is well mixed and has a near constant
        temperature with depth (i.e., a uniform distribution of
        temperature with depth). Mixing can occur when the density
        of the surface (and near-surface) water is greater than that
        of the water below. Mixing can also occur through the action
        of wind on the surface of the water. This parameter is
        defined over the whole globe, even where there is no inland
        water. Regions without inland water can be masked out by
        only considering grid points where the lake cover is greater
        than 0.0. In May 2015, a lake model was implemented in the
        ECMWF Integrated Forecasting System (IFS) to represent the
        water temperature and lake ice of all the world's major
        inland water bodies. Lake depth and area fraction (cover)
        are kept constant in time. Inland water bodies are
        represented with two layers in the vertical, the mixed layer
        above and the thermocline below, where temperature changes
        with depth. The upper boundary of the thermocline is located
        at the mixed layer bottom, and the lower boundary of the
        thermocline at the lake bottom. A single ice layer is used
        to represent the formation and melting of ice on inland
        water bodies.
      |||,
    },
    {
      name: 'lake_mix_layer_temperature',
      units: units.kelvin,
      description: |||
        This parameter is the temperature of the uppermost layer of
        inland water bodies (lakes, reservoirs, rivers and coastal
        waters) that is well mixed and has a near constant
        temperature with depth (i.e., a uniform distribution of
        temperature with depth). Mixing can occur when the density
        of the surface (and near-surface) water is greater than that
        of the water below. Mixing can also occur through the action
        of wind on the surface of the water. This parameter is
        defined over the whole globe, even where there is no inland
        water. Regions without inland water can be masked out by
        only considering grid points where the lake cover is greater
        than 0.0. In May 2015, a lake model was implemented in the
        ECMWF Integrated Forecasting System (IFS) to represent the
        water temperature and lake ice of all the world's major
        inland water bodies. Lake depth and area fraction (cover)
        are kept constant in time. Inland water bodies are
        represented with two layers in the vertical, the mixed layer
        above and the thermocline below, where temperature changes
        with depth. The upper boundary of the thermocline is located
        at the mixed layer bottom, and the lower boundary of the
        thermocline at the lake bottom. A single ice layer is used
        to represent the formation and melting of ice on inland
        water bodies.
      |||,
    },
    {
      name: 'lake_shape_factor',
      units: units.dimensionless,
      description: |||
        This parameter describes the way that temperature changes
        with depth in the thermocline layer of inland water bodies
        (lakes, reservoirs, rivers and coastal waters) i.e., it
        describes the shape of the vertical temperature profile. It
        is used to calculate the lake bottom temperature and other
        lake-related parameters. This parameter is defined over the
        whole globe, even where there is no inland water. Regions
        without inland water can be masked out by only considering
        grid points where the lake cover is greater than 0.0. In May
        2015, a lake model was implemented in the ECMWF Integrated
        Forecasting System (IFS) to represent the water temperature
        and lake ice of all the world's major inland water bodies.
        Lake depth and area fraction (cover) are kept constant in
        time. Inland water bodies are represented with two layers in
        the vertical, the mixed layer above and the thermocline
        below, where temperature changes with depth. The upper
        boundary of the thermocline is located at the mixed layer
        bottom, and the lower boundary of the thermocline at the
        lake bottom. A single ice layer is used to represent the
        formation and melting of ice on inland water bodies.
      |||,
    },
    {
      name: 'lake_total_layer_temperature',
      units: units.kelvin,
      description: |||
        This parameter is the mean temperature of the total water
        column in inland water bodies (lakes, reservoirs, rivers and
        coastal waters). This parameter is defined over the whole
        globe, even where there is no inland water. Regions without
        inland water can be masked out by only considering grid
        points where the lake cover is greater than 0.0. In May
        2015, a lake model was implemented in the ECMWF Integrated
        Forecasting System (IFS) to represent the water temperature
        and lake ice of all the world's major inland water bodies.
        Lake depth and area fraction (cover) are kept constant in
        time. Inland water bodies are represented with two layers in
        the vertical, the mixed layer above and the thermocline
        below, where temperature changes with depth. This parameter
        is the mean temperature over the two layers. The upper
        boundary of the thermocline is located at the mixed layer
        bottom, and the lower boundary of the thermocline at the
        lake bottom. A single ice layer is used to represent the
        formation and melting of ice on inland water bodies.
      |||,
    },
    {
      name: 'evaporation',
      units: units.meter,
      description: |||
        This parameter is the accumulated amount of water that has
        evaporated from the Earth's surface, including a simplified
        representation of transpiration (from vegetation), into
        vapour in the air above. This parameter is accumulated over
        a particular time period which depends on the data
        extracted. For the reanalysis, the accumulation period is
        over the 1 hour ending at the validity date and time. For
        the ensemble members, ensemble mean and ensemble spread, the
        accumulation period is over the 3 hours ending at the
        validity date and time. The ECMWF Integrated Forecasting
        System (IFS) convention is that downward fluxes are
        positive. Therefore, negative values indicate evaporation
        and positive values indicate condensation.
      |||,
    },
    {
      name: 'potential_evaporation',
      units: units.meter,
      description: |||
        This parameter is a measure of the extent to which
        near-surface atmospheric conditions are conducive to the
        process of evaporation. It is usually considered to be the
        amount of evaporation, under existing atmospheric
        conditions, from a surface of pure water which has the
        temperature of the lowest layer of the atmosphere and gives
        an indication of the maximum possible evaporation. Potential
        evaporation in the current ECMWF Integrated Forecasting
        System (IFS) is based on surface energy balance calculations
        with the vegetation parameters set to "crops/mixed farming"
        and assuming "no stress from soil moisture". In other words,
        evaporation is computed for agricultural land as if it is
        well watered and assuming that the atmosphere is not
        affected by this artificial surface condition. The latter
        may not always be realistic. Although potential evaporation
        is meant to provide an estimate of irrigation requirements,
        the method can give unrealistic results in arid conditions
        due to too strong evaporation forced by dry air. This
        parameter is accumulated over a particular time period which
        depends on the data extracted. For the reanalysis, the
        accumulation period is over the 1 hour ending at the
        validity date and time. For the ensemble members, ensemble
        mean and ensemble spread, the accumulation period is over
        the 3 hours ending at the validity date and time.
      |||,
    },
    {
      name: 'runoff',
      units: units.meter,
      description: |||
        Some water from rainfall, melting snow, or deep in the soil,
        stays stored in the soil. Otherwise, the water drains away,
        either over the surface (surface runoff), or under the
        ground (sub-surface runoff) and the sum of these two is
        called runoff. This parameter is accumulated over a
        particular time period which depends on the data extracted.
        For the reanalysis, the accumulation period is over the 1
        hour ending at the validity date and time. For the ensemble
        members, ensemble mean and ensemble spread, the accumulation
        period is over the 3 hours ending at the validity date and
        time. The units of runoff are depth in metres of water. This
        is the depth the water would have if it were spread evenly
        over the grid box. Care should be taken when comparing model
        parameters with observations, because observations are often
        local to a particular point rather than averaged over a grid
        box. Observations are also often taken in different units,
        such as mm/day, rather than the accumulated metres produced
        here. Runoff is a measure of the availability of water in
        the soil, and can, for example, be used as an indicator of
        drought or flood.
      |||,
    },
    {
      name: 'sub_surface_runoff',
      units: units.meter,
      description: |||
        Some water from rainfall, melting snow, or deep in the soil,
        stays stored in the soil. Otherwise, the water drains away,
        either over the surface (surface runoff), or under the
        ground (sub-surface runoff) and the sum of these two is
        called runoff. This parameter is accumulated over a
        particular time period which depends on the data extracted.
        For the reanalysis, the accumulation period is over the 1
        hour ending at the validity date and time. For the ensemble
        members, ensemble mean and ensemble spread, the accumulation
        period is over the 3 hours ending at the validity date and
        time. The units of runoff are depth in metres of water. This
        is the depth the water would have if it were spread evenly
        over the grid box. Care should be taken when comparing model
        parameters with observations, because observations are often
        local to a particular point rather than averaged over a grid
        box. Observations are also often taken in different units,
        such as mm/day, rather than the accumulated metres produced
        here. Runoff is a measure of the availability of water in
        the soil, and can, for example, be used as an indicator of
        drought or flood.
      |||,
    },
    {
      name: 'surface_runoff',
      units: units.meter,
      description: |||
        Some water from rainfall, melting snow, or deep in the soil,
        stays stored in the soil. Otherwise, the water drains away,
        either over the surface (surface runoff), or under the
        ground (sub-surface runoff) and the sum of these two is
        called runoff. This parameter is accumulated over a
        particular time period which depends on the data extracted.
        For the reanalysis, the accumulation period is over the 1
        hour ending at the validity date and time. For the ensemble
        members, ensemble mean and ensemble spread, the accumulation
        period is over the 3 hours ending at the validity date and
        time. The units of runoff are depth in metres of water. This
        is the depth the water would have if it were spread evenly
        over the grid box. Care should be taken when comparing model
        parameters with observations, because observations are often
        local to a particular point rather than averaged over a grid
        box. Observations are also often taken in different units,
        such as mm/day, rather than the accumulated metres produced
        here. Runoff is a measure of the availability of water in
        the soil, and can, for example, be used as an indicator of
        drought or flood.
      |||,
    },
    {
      name: 'convective_precipitation',
      units: units.meter,
      description: |||
        This parameter is the accumulated precipitation that falls
        to the Earth's surface, which is generated by the convection
        scheme in the ECMWF Integrated Forecasting System (IFS). The
        convection scheme represents convection at spatial scales
        smaller than the grid box. Precipitation can also be
        generated by the cloud scheme in the IFS, which represents
        the formation and dissipation of clouds and large-scale
        precipitation due to changes in atmospheric quantities (such
        as pressure, temperature and moisture) predicted directly at
        spatial scales of the grid box or larger. In the IFS,
        precipitation is comprised of rain and snow. In the IFS,
        precipitation is comprised of rain and snow. This parameter
        is accumulated over a particular time period which depends
        on the data extracted. For the reanalysis, the accumulation
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the accumulation period is over the 3 hours ending
        at the validity date and time. The units of this parameter
        are depth in metres of water equivalent. It is the depth the
        water would have if it were spread evenly over the grid box.
        Care should be taken when comparing model parameters with
        observations, because observations are often local to a
        particular point in space and time, rather than representing
        averages over a model grid box.
      |||,
    },
    {
      name: 'convective_rain_rate',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        This parameter is the rate of rainfall (rainfall intensity),
        at the Earth's surface and at the specified time, which is
        generated by the convection scheme in the ECMWF Integrated
        Forecasting System (IFS). The convection scheme represents
        convection at spatial scales smaller than the grid box.
        Rainfall can also be generated by the cloud scheme in the
        IFS, which represents the formation and dissipation of
        clouds and large-scale precipitation due to changes in
        atmospheric quantities (such as pressure, temperature and
        moisture) predicted directly at spatial scales of the grid
        box or larger. In the IFS, precipitation is comprised of
        rain and snow. This parameter is the rate the rainfall would
        have if it were spread evenly over the grid box. 1 kg of
        water spread over 1 square metre of surface is 1 mm deep
        (neglecting the effects of temperature on the density of
        water), therefore the units are equivalent to mm per second.
        Care should be taken when comparing model parameters with
        observations, because observations are often local to a
        particular point in space and time, rather than representing
        averages over a model grid box.
      |||,
    },
    {
      name: 'instantaneous_large_scale_surface_precipitation_fraction',
      units: units.dimensionless,
      description: |||
        This parameter is the fraction of the grid box (0-1) covered
        by large-scale precipitation at the specified time.
        Large-scale precipitation is rain and snow that falls to the
        Earth's surface, and is generated by the cloud scheme in the
        ECMWF Integrated Forecasting System (IFS). The cloud scheme
        represents the formation and dissipation of clouds and
        large-scale precipitation due to changes in atmospheric
        quantities (such as pressure, temperature and moisture)
        predicted directly by the IFS at spatial scales of a grid
        box or larger. Precipitation can also be due to convection
        generated by the convection scheme in the IFS. The
        convection scheme represents convection at spatial scales
        smaller than the grid box.
      |||,
    },
    {
      name: 'large_scale_precipitation',
      units: units.meter,
      description: |||
        This parameter is the accumulated precipitation that falls
        to the Earth's surface, which is generated by the cloud
        scheme in the ECMWF Integrated Forecasting System (IFS). The
        cloud scheme represents the formation and dissipation of
        clouds and large-scale precipitation due to changes in
        atmospheric quantities (such as pressure, temperature and
        moisture) predicted directly at spatial scales of the grid
        box or larger. Precipitation can also be generated by the
        convection scheme in the IFS, which represents convection at
        spatial scales smaller than the grid box. In the IFS,
        precipitation is comprised of rain and snow. This parameter
        is accumulated over a particular time period which depends
        on the data extracted. For the reanalysis, the accumulation
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the accumulation period is over the 3 hours ending
        at the validity date and time. The units of this parameter
        are depth in metres of water equivalent. It is the depth the
        water would have if it were spread evenly over the grid box.
        Care should be taken when comparing model parameters with
        observations, because observations are often local to a
        particular point in space and time, rather than representing
        averages over a model grid box.
      |||,
    },
    {
      name: 'large_scale_precipitation_fraction',
      units: units.seconds,
      description: |||
        This parameter is the accumulation of the fraction of the
        grid box (0-1) that is covered by large-scale precipitation.
        This parameter is accumulated over a particular time period
        which depends on the data extracted. For the reanalysis, the
        accumulation period is over the 1 hour ending at the
        validity date and time. For the ensemble members, ensemble
        mean and ensemble spread, the accumulation period is over
        the 3 hours ending at the validity date and time.
      |||,
    },
    {
      name: 'large_scale_rain_rate',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        This parameter is the rate of rainfall (rainfall intensity),
        at the Earth's surface and at the specified time, which is
        generated by the cloud scheme in the ECMWF Integrated
        Forecasting System (IFS). The cloud scheme represents the
        formation and dissipation of clouds and large-scale
        precipitation due to changes in atmospheric quantities (such
        as pressure, temperature and moisture) predicted directly at
        spatial scales of the grid box or larger. Rainfall can also
        be generated by the convection scheme in the IFS, which
        represents convection at spatial scales smaller than the
        grid box. In the IFS, precipitation is comprised of rain and
        snow. This parameter is the rate the rainfall would have if
        it were spread evenly over the grid box. Since 1 kg of water
        spread over 1 square metre of surface is 1 mm deep
        (neglecting the effects of temperature on the density of
        water), the units are equivalent to mm per second. Care
        should be taken when comparing model parameters with
        observations, because observations are often local to a
        particular point in space and time, rather than representing
        averages over a model grid box.
      |||,
    },
    {
      name: 'precipitation_type',
      units: units.dimensionless,
      description: |||
        This parameter describes the type of precipitation at the
        surface, at the specified time. A precipitation type is
        assigned wherever there is a non-zero value of
        precipitation. In the ECMWF Integrated Forecasting System
        (IFS) there are only two predicted precipitation variables:
        rain and snow. Precipitation type is derived from these two
        predicted variables in combination with atmospheric
        conditions, such as temperature. Values of precipitation
        type defined in the IFS: 0: No precipitation, 1: Rain, 3:
        Freezing rain (i.e. supercooled raindrops which freeze on
        contact with the ground and other surfaces), 5: Snow, 6: Wet
        snow (i.e. snow particles which are starting to melt); 7:
        Mixture of rain and snow, 8: Ice pellets. These
        precipitation types are consistent with WMO Code Table
        4.201. Other types in this WMO table are not defined in the
        IFS.
      |||,
    },
    {
      name: 'total_column_rain_water',
      units: units.area_density,
      description: |||
        This parameter is the total amount of water in droplets of
        raindrop size (which can fall to the surface as
        precipitation) in a column extending from the surface of the
        Earth to the top of the atmosphere. This parameter
        represents the area averaged value for a grid box. Clouds
        contain a continuum of different sized water droplets and
        ice particles. The ECMWF Integrated Forecasting System (IFS)
        cloud scheme simplifies this to represent a number of
        discrete cloud droplets/particles including: cloud water
        droplets, raindrops, ice crystals and snow (aggregated ice
        crystals). The processes of droplet formation, conversion
        and aggregation are also highly simplified in the IFS.
      |||,
    },
    {
      name: 'total_precipitation',
      units: units.meter,
      description: |||
        This parameter is the accumulated liquid and frozen water,
        comprising rain and snow, that falls to the Earth's surface.
        It is the sum of large-scale precipitation and convective
        precipitation. Large-scale precipitation is generated by the
        cloud scheme in the ECMWF Integrated Forecasting System
        (IFS). The cloud scheme represents the formation and
        dissipation of clouds and large-scale precipitation due to
        changes in atmospheric quantities (such as pressure,
        temperature and moisture) predicted directly by the IFS at
        spatial scales of the grid box or larger. Convective
        precipitation is generated by the convection scheme in the
        IFS, which represents convection at spatial scales smaller
        than the grid box. This parameter does not include fog, dew
        or the precipitation that evaporates in the atmosphere
        before it lands at the surface of the Earth. This parameter
        is accumulated over a particular time period which depends
        on the data extracted. For the reanalysis, the accumulation
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the accumulation period is over the 3 hours ending
        at the validity date and time. The units of this parameter
        are depth in metres of water equivalent. It is the depth the
        water would have if it were spread evenly over the grid box.
        Care should be taken when comparing model parameters with
        observations, because observations are often local to a
        particular point in space and time, rather than representing
        averages over a model grid box.
      |||,
    },
    {
      name: 'convective_snowfall',
      units: units.meter,
      description: |||
        This parameter is the accumulated snow that falls to the
        Earth's surface, which is generated by the convection scheme
        in the ECMWF Integrated Forecasting System (IFS). The
        convection scheme represents convection at spatial scales
        smaller than the grid box. Snowfall can also be generated by
        the cloud scheme in the IFS, which represents the formation
        and dissipation of clouds and large-scale precipitation due
        to changes in atmospheric quantities (such as pressure,
        temperature and moisture) predicted directly at spatial
        scales of the grid box or larger. In the IFS, precipitation
        is comprised of rain and snow. This parameter is accumulated
        over a particular time period which depends on the data
        extracted. For the reanalysis, the accumulation period is
        over the 1 hour ending at the validity date and time. For
        the ensemble members, ensemble mean and ensemble spread, the
        accumulation period is over the 3 hours ending at the
        validity date and time. The units of this parameter are
        depth in metres of water equivalent. It is the depth the
        water would have if it were spread evenly over the grid box.
        Care should be taken when comparing model parameters with
        observations, because observations are often local to a
        particular point in space and time, rather than representing
        averages over a model grid box.
      |||,
    },
    {
      name: 'convective_snowfall_rate_water_equivalent',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        This parameter is the rate of snowfall (snowfall intensity),
        at the Earth's surface and at the specified time, which is
        generated by the convection scheme in the ECMWF Integrated
        Forecasting System (IFS). The convection scheme represents
        convection at spatial scales smaller than the grid box.
        Snowfall can also be generated by the cloud scheme in the
        IFS, which represents the formation and dissipation of
        clouds and large-scale precipitation due to changes in
        atmospheric quantities (such as pressure, temperature and
        moisture) predicted directly at spatial scales of the grid
        box or larger. In the IFS, precipitation is comprised of
        rain and snow. This parameter is the rate the snowfall would
        have if it were spread evenly over the grid box. Since 1 kg
        of water spread over 1 square metre of surface is 1 mm thick
        (neglecting the effects of temperature on the density of
        water), the units are equivalent to mm (of liquid water) per
        second. Care should be taken when comparing model parameters
        with observations, because observations are often local to a
        particular point in space and time, rather than representing
        averages over a model grid box.
      |||,
    },
    {
      name: 'large_scale_snowfall',
      units: units.meter,
      description: |||
        This parameter is the accumulated snow that falls to the
        Earth's surface, which is generated by the cloud scheme in
        the ECMWF Integrated Forecasting System (IFS). The cloud
        scheme represents the formation and dissipation of clouds
        and large-scale precipitation due to changes in atmospheric
        quantities (such as pressure, temperature and moisture)
        predicted directly at spatial scales of the grid box or
        larger. Snowfall can also be generated by the convection
        scheme in the IFS, which represents convection at spatial
        scales smaller than the grid box. In the IFS, precipitation
        is comprised of rain and snow. This parameter is accumulated
        over a particular time period which depends on the data
        extracted. For the reanalysis, the accumulation period is
        over the 1 hour ending at the validity date and time. For
        the ensemble members, ensemble mean and ensemble spread, the
        accumulation period is over the 3 hours ending at the
        validity date and time. The units of this parameter are
        depth in metres of water equivalent. It is the depth the
        water would have if it were spread evenly over the grid box.
        Care should be taken when comparing model parameters with
        observations, because observations are often local to a
        particular point in space and time, rather than representing
        averages over a model grid box.
      |||,
    },
    {
      name: 'large_scale_snowfall_rate_water_equivalent',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        This parameter is the rate of snowfall (snowfall intensity),
        at the Earth's surface and at the specified time, which is
        generated by the cloud scheme in the ECMWF Integrated
        Forecasting System (IFS). The cloud scheme represents the
        formation and dissipation of clouds and large-scale
        precipitation due to changes in atmospheric quantities (such
        as pressure, temperature and moisture) predicted directly at
        spatial scales of the grid box or larger. Snowfall can also
        be generated by the convection scheme in the IFS, which
        represents convection at spatial scales smaller than the
        grid box. In the IFS, precipitation is comprised of rain and
        snow. This parameter is the rate the snowfall would have if
        it were spread evenly over the grid box. Since 1 kg of water
        spread over 1 square metre of surface is 1 mm deep
        (neglecting the effects of temperature on the density of
        water), the units are equivalent to mm (of liquid water) per
        second. Care should be taken when comparing model parameters
        with observations, because observations are often local to a
        particular point in space and time, rather than representing
        averages over a model grid box.
      |||,
    },
    {
      name: 'snow_albedo',
      units: units.dimensionless,
      description: |||
        This parameter is a measure of the reflectivity of the
        snow-covered part of the grid box. It is the fraction of
        solar (shortwave) radiation reflected by snow across the
        solar spectrum. The ECMWF Integrated Forecasting System
        (IFS) represents snow as a single additional layer over the
        uppermost soil level. The snow may cover all or part of the
        grid box. This parameter changes with snow age and also
        depends on vegetation height. It has a range of values
        between 0 and 1. For low vegetation, it ranges between 0.52
        for old snow and 0.88 for fresh snow. For high vegetation
        with snow underneath, it depends on vegetation type and has
        values between 0.27 and 0.38. This parameter is defined over
        the whole globe, even where there is no snow. Regions
        without snow can be masked out by only considering grid
        points where the snow depth (m of water equivalent) is
        greater than 0.0.
      |||,
    },
    {
      name: 'snow_density',
      units: units.density_si,
      description: |||
        This parameter is the mass of snow per cubic metre in the
        snow layer. The ECMWF Integrated Forecasting System (IFS)
        represents snow as a single additional layer over the
        uppermost soil level. The snow may cover all or part of the
        grid box. This parameter is defined over the whole globe,
        even where there is no snow. Regions without snow can be
        masked out by only considering grid points where the snow
        depth (m of water equivalent) is greater than 0.0.
      |||,
    },
    {
      name: 'snow_depth',
      units: units.meter,
      description: |||
        This parameter is the amount of snow from the snow-covered
        area of a grid box. Its units are metres of water
        equivalent, so it is the depth the water would have if the
        snow melted and was spread evenly over the whole grid box.
        The ECMWF Integrated Forecasting System (IFS) represents
        snow as a single additional layer over the uppermost soil
        level. The snow may cover all or part of the grid box.
      |||,
    },
    {
      name: 'snow_evaporation',
      units: units.meter,
      description: |||
        This parameter is the accumulated amount of water that has
        evaporated from snow from the snow-covered area of a grid
        box into vapour in the air above. The ECMWF Integrated
        Forecasting System (IFS) represents snow as a single
        additional layer over the uppermost soil level. The snow may
        cover all or part of the grid box. This parameter is the
        depth of water there would be if the evaporated snow (from
        the snow-covered area of a grid box) were liquid and were
        spread evenly over the whole grid box. This parameter is
        accumulated over a particular time period which depends on
        the data extracted. For the reanalysis, the accumulation
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the accumulation period is over the 3 hours ending
        at the validity date and time. The IFS convention is that
        downward fluxes are positive. Therefore, negative values
        indicate evaporation and positive values indicate
        deposition.
      |||,
    },
    {
      name: 'snowfall',
      units: units.meter,
      description: |||
        This parameter is the accumulated snow that falls to the
        Earth's surface. It is the sum of large-scale snowfall and
        convective snowfall. Large-scale snowfall is generated by
        the cloud scheme in the ECMWF Integrated Forecasting System
        (IFS). The cloud scheme represents the formation and
        dissipation of clouds and large-scale precipitation due to
        changes in atmospheric quantities (such as pressure,
        temperature and moisture) predicted directly at spatial
        scales of the grid box or larger. Convective snowfall is
        generated by the convection scheme in the IFS, which
        represents convection at spatial scales smaller than the
        grid box. In the IFS, precipitation is comprised of rain and
        snow. This parameter is accumulated over a particular time
        period which depends on the data extracted. For the
        reanalysis, the accumulation period is over the 1 hour
        ending at the validity date and time. For the ensemble
        members, ensemble mean and ensemble spread, the accumulation
        period is over the 3 hours ending at the validity date and
        time. The units of this parameter are depth in metres of
        water equivalent. It is the depth the water would have if it
        were spread evenly over the grid box. Care should be taken
        when comparing model parameters with observations, because
        observations are often local to a particular point in space
        and time, rather than representing averages over a model
        grid box.
      |||,
    },
    {
      name: 'snowmelt',
      units: units.meter,
      description: |||
        This parameter is the accumulated amount of water that has
        melted from snow in the snow-covered area of a grid box. The
        ECMWF Integrated Forecasting System (IFS) represents snow as
        a single additional layer over the uppermost soil level. The
        snow may cover all or part of the grid box. This parameter
        is the depth of water there would be if the melted snow
        (from the snow-covered area of a grid box) were spread
        evenly over the whole grid box. For example, if half the
        grid box were covered in snow with a water equivalent depth
        of 0.02m, this parameter would have a value of 0.01m. This
        parameter is accumulated over a particular time period which
        depends on the data extracted. For the reanalysis, the
        accumulation period is over the 1 hour ending at the
        validity date and time. For the ensemble members, ensemble
        mean and ensemble spread, the accumulation period is over
        the 3 hours ending at the validity date and time.
      |||,
    },
    {
      name: 'temperature_of_snow_layer',
      units: units.kelvin,
      description: |||
        This parameter gives the temperature of the snow layer from
        the ground to the snow-air interface. The ECMWF Integrated
        Forecasting System (IFS) represents snow as a single
        additional layer over the uppermost soil level. The snow may
        cover all or part of the grid box. This parameter is defined
        over the whole globe, even where there is no snow. Regions
        without snow can be masked out by only considering grid
        points where the snow depth (m of water equivalent) is
        greater than 0.0.
      |||,
    },
    {
      name: 'total_column_snow_water',
      units: units.area_density,
      description: |||
        This parameter is the total amount of water in the form of
        snow (aggregated ice crystals which can fall to the surface
        as precipitation) in a column extending from the surface of
        the Earth to the top of the atmosphere. This parameter
        represents the area averaged value for a grid box. Clouds
        contain a continuum of different sized water droplets and
        ice particles. The ECMWF Integrated Forecasting System (IFS)
        cloud scheme simplifies this to represent a number of
        discrete cloud droplets/particles including: cloud water
        droplets, raindrops, ice crystals and snow (aggregated ice
        crystals). The processes of droplet formation, conversion
        and aggregation are also highly simplified in the IFS.
      |||,
    },
    {
      name: 'soil_temperature_level_1',
      units: units.kelvin,
      description: |||
        This parameter is the temperature of the soil at level 1 (in
        the middle of layer 1). The ECMWF Integrated Forecasting
        System (IFS) has a four-layer representation of soil, where
        the surface is at 0cm: Layer 1: 0 - 7cm, Layer 2: 7 - 28cm,
        Layer 3: 28 - 100cm, Layer 4: 100 - 289cm. Soil temperature
        is set at the middle of each layer, and heat transfer is
        calculated at the interfaces between them. It is assumed
        that there is no heat transfer out of the bottom of the
        lowest layer. Soil temperature is defined over the whole
        globe, even over ocean. Regions with a water surface can be
        masked out by only considering grid points where the
        land-sea mask has a value greater than 0.5.
      |||,
    },
    {
      name: 'soil_temperature_level_2',
      units: units.kelvin,
      description: |||
        This parameter is the temperature of the soil at level 2 (in
        the middle of layer 2). The ECMWF Integrated Forecasting
        System (IFS) has a four-layer representation of soil, where
        the surface is at 0cm: Layer 1: 0 - 7cm, Layer 2: 7 - 28cm,
        Layer 3: 28 - 100cm, Layer 4: 100 - 289cm. Soil temperature
        is set at the middle of each layer, and heat transfer is
        calculated at the interfaces between them. It is assumed
        that there is no heat transfer out of the bottom of the
        lowest layer. Soil temperature is defined over the whole
        globe, even over ocean. Regions with a water surface can be
        masked out by only considering grid points where the
        land-sea mask has a value greater than 0.5.
      |||,
    },
    {
      name: 'soil_temperature_level_3',
      units: units.kelvin,
      description: |||
        This parameter is the temperature of the soil at level 3 (in
        the middle of layer 3). The ECMWF Integrated Forecasting
        System (IFS) has a four-layer representation of soil, where
        the surface is at 0cm: Layer 1: 0 - 7cm, Layer 2: 7 - 28cm,
        Layer 3: 28 - 100cm, Layer 4: 100 - 289cm. Soil temperature
        is set at the middle of each layer, and heat transfer is
        calculated at the interfaces between them. It is assumed
        that there is no heat transfer out of the bottom of the
        lowest layer. Soil temperature is defined over the whole
        globe, even over ocean. Regions with a water surface can be
        masked out by only considering grid points where the
        land-sea mask has a value greater than 0.5.
      |||,
    },
    {
      name: 'soil_temperature_level_4',
      units: units.kelvin,
      description: |||
        This parameter is the temperature of the soil at level 4 (in
        the middle of layer 4). The ECMWF Integrated Forecasting
        System (IFS) has a four-layer representation of soil, where
        the surface is at 0cm: Layer 1: 0 - 7cm, Layer 2: 7 - 28cm,
        Layer 3: 28 - 100cm, Layer 4: 100 - 289cm. Soil temperature
        is set at the middle of each layer, and heat transfer is
        calculated at the interfaces between them. It is assumed
        that there is no heat transfer out of the bottom of the
        lowest layer. Soil temperature is defined over the whole
        globe, even over ocean. Regions with a water surface can be
        masked out by only considering grid points where the
        land-sea mask has a value greater than 0.5.
      |||,
    },
    {
      name: 'soil_type',
      units: units.dimensionless,
      description: |||
        This parameter is the texture (or classification) of soil
        used by the land surface scheme of the ECMWF Integrated
        Forecasting System (IFS) to predict the water holding
        capacity of soil in soil moisture and runoff calculations.
        It is derived from the root zone data (30-100 cm below the
        surface) of the FAO/UNESCO Digital Soil Map of the World,
        DSMW (FAO, 2003), which exists at a resolution of 5' X 5'
        (about 10 km). The seven soil types are: 1: Coarse, 2:
        Medium, 3: Medium fine, 4: Fine, 5: Very fine, 6: Organic,
        7: Tropical organic. A value of 0 indicates a non-land
        point. This parameter does not vary in time.
      |||,
    },
    {
      name: 'vertical_integral_of_divergence_of_cloud_frozen_water_flux',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        The vertical integral of the cloud frozen water flux is the
        horizontal rate of flow of cloud frozen water, per metre
        across the flow, for a column of air extending from the
        surface of the Earth to the top of the atmosphere. Its
        horizontal divergence is the rate of cloud frozen water
        spreading outward from a point, per square metre. This
        parameter is positive for cloud frozen water that is
        spreading out, or diverging, and negative for the opposite,
        for cloud frozen water that is concentrating, or converging
        (convergence). This parameter thus indicates whether
        atmospheric motions act to decrease (for divergence) or
        increase (for convergence) the vertical integral of cloud
        frozen water. Note that "cloud frozen water" is the same as
        "cloud ice water".
      |||,
    },
    {
      name: 'vertical_integral_of_divergence_of_cloud_liquid_water_flux',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        The vertical integral of the cloud liquid water flux is the
        horizontal rate of flow of cloud liquid water, per metre
        across the flow, for a column of air extending from the
        surface of the Earth to the top of the atmosphere. Its
        horizontal divergence is the rate of cloud liquid water
        spreading outward from a point, per square metre. This
        parameter is positive for cloud liquid water that is
        spreading out, or diverging, and negative for the opposite,
        for cloud liquid water that is concentrating, or converging
        (convergence). This parameter thus indicates whether
        atmospheric motions act to decrease (for divergence) or
        increase (for convergence) the vertical integral of cloud
        liquid water.
      |||,
    },
    {
      name: 'vertical_integral_of_divergence_of_geopotential_flux',
      units: units.watt_per_meter_squared,
      description: |||
        The vertical integral of the geopotential flux is the
        horizontal rate of flow of geopotential, per metre across
        the flow, for a column of air extending from the surface of
        the Earth to the top of the atmosphere. Its horizontal
        divergence is the rate of geopotential spreading outward
        from a point, per square metre. This parameter is positive
        for geopotential that is spreading out, or diverging, and
        negative for the opposite, for geopotential that is
        concentrating, or converging (convergence). This parameter
        thus indicates whether atmospheric motions act to decrease
        (for divergence) or increase (for convergence) the vertical
        integral of geopotential. Geopotential is the gravitational
        potential energy of a unit mass, at a particular location,
        relative to mean sea level. It is also the amount of work
        that would have to be done, against the force of gravity, to
        lift a unit mass to that location from mean sea level. This
        parameter can be used to study the atmospheric energy
        budget.
      |||,
    },
    {
      name: 'vertical_integral_of_divergence_of_kinetic_energy_flux',
      units: units.watt_per_meter_squared,
      description: |||
        The vertical integral of the kinetic energy flux is the
        horizontal rate of flow of kinetic energy, per metre across
        the flow, for a column of air extending from the surface of
        the Earth to the top of the atmosphere. Its horizontal
        divergence is the rate of kinetic energy spreading outward
        from a point, per square metre. This parameter is positive
        for kinetic energy that is spreading out, or diverging, and
        negative for the opposite, for kinetic energy that is
        concentrating, or converging (convergence). This parameter
        thus indicates whether atmospheric motions act to decrease
        (for divergence) or increase (for convergence) the vertical
        integral of kinetic energy. Atmospheric kinetic energy is
        the energy of the atmosphere due to its motion. Only
        horizontal motion is considered in the calculation of this
        parameter. This parameter can be used to study the
        atmospheric energy budget.
      |||,
    },
    {
      name: 'vertical_integral_of_divergence_of_mass_flux',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        The vertical integral of the mass flux is the horizontal
        rate of flow of mass, per metre across the flow, for a
        column of air extending from the surface of the Earth to the
        top of the atmosphere. Its horizontal divergence is the rate
        of mass spreading outward from a point, per square metre.
        This parameter is positive for mass that is spreading out,
        or diverging, and negative for the opposite, for mass that
        is concentrating, or converging (convergence). This
        parameter thus indicates whether atmospheric motions act to
        decrease (for divergence) or increase (for convergence) the
        vertical integral of mass. This parameter can be used to
        study the atmospheric mass and energy budgets.
      |||,
    },
    {
      name: 'vertical_integral_of_divergence_of_moisture_flux',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        The vertical integral of the moisture flux is the horizontal
        rate of flow of moisture, per metre across the flow, for a
        column of air extending from the surface of the Earth to the
        top of the atmosphere. Its horizontal divergence is the rate
        of moisture spreading outward from a point, per square
        metre. This parameter is positive for moisture that is
        spreading out, or diverging, and negative for the opposite,
        for moisture that is concentrating, or converging
        (convergence). This parameter thus indicates whether
        atmospheric motions act to decrease (for divergence) or
        increase (for convergence) the vertical integral of
        moisture. 1 kg of water spread over 1 square metre of
        surface is 1 mm deep (neglecting the effects of temperature
        on the density of water), therefore the units are equivalent
        to mm (of liquid water) per second.
      |||,
    },
    {
      name: 'vertical_integral_of_divergence_of_ozone_flux',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        The vertical integral of the ozone flux is the horizontal
        rate of flow of ozone, per metre across the flow, for a
        column of air extending from the surface of the Earth to the
        top of the atmosphere. Its horizontal divergence is the rate
        of ozone spreading outward from a point, per square metre.
        This parameter is positive for ozone that is spreading out,
        or diverging, and negative for the opposite, for ozone that
        is concentrating, or converging (convergence). This
        parameter thus indicates whether atmospheric motions act to
        decrease (for divergence) or increase (for convergence) the
        vertical integral of ozone. In the ECMWF Integrated
        Forecasting System (IFS), there is a simplified
        representation of ozone chemistry (including a
        representation of the chemistry which has caused the ozone
        hole). Ozone is also transported around in the atmosphere
        through the motion of air.
      |||,
    },
    {
      name: 'vertical_integral_of_divergence_of_thermal_energy_flux',
      units: units.watt_per_meter_squared,
      description: |||
        The vertical integral of the thermal energy flux is the
        horizontal rate of flow of thermal energy, per metre across
        the flow, for a column of air extending from the surface of
        the Earth to the top of the atmosphere. Its horizontal
        divergence is the rate of thermal energy spreading outward
        from a point, per square metre. This parameter is positive
        for thermal energy that is spreading out, or diverging, and
        negative for the opposite, for thermal energy that is
        concentrating, or converging (convergence). This parameter
        thus indicates whether atmospheric motions act to decrease
        (for divergence) or increase (for convergence) the vertical
        integral of thermal energy. The thermal energy is equal to
        enthalpy, which is the sum of the internal energy and the
        energy associated with the pressure of the air on its
        surroundings. Internal energy is the energy contained within
        a system i.e., the microscopic energy of the air molecules,
        rather than the macroscopic energy associated with, for
        example, wind, or gravitational potential energy. The energy
        associated with the pressure of the air on its surroundings
        is the energy required to make room for the system by
        displacing its surroundings and is calculated from the
        product of pressure and volume. This parameter can be used
        to study the flow of thermal energy through the climate
        system and to investigate the atmospheric energy budget.
      |||,
    },
    {
      name: 'vertical_integral_of_divergence_of_total_energy_flux',
      units: units.watt_per_meter_squared,
      description: |||
        The vertical integral of the total energy flux is the
        horizontal rate of flow of total energy, per metre across
        the flow, for a column of air extending from the surface of
        the Earth to the top of the atmosphere. Its horizontal
        divergence is the rate of total energy spreading outward
        from a point, per square metre. This parameter is positive
        for total energy that is spreading out, or diverging, and
        negative for the opposite, for total energy that is
        concentrating, or converging (convergence). This parameter
        thus indicates whether atmospheric motions act to decrease
        (for divergence) or increase (for convergence) the vertical
        integral of total energy. Total atmospheric energy is made
        up of internal, potential, kinetic and latent energy. This
        parameter can be used to study the atmospheric energy
        budget.
      |||,
    },
    {
      name: 'vertical_integral_of_eastward_cloud_frozen_water_flux',
      units: units.rainfall_rate_kg_per_m_per_s,
      description: |||
        This parameter is the horizontal rate of flow of cloud
        frozen water, in the eastward direction, per metre across
        the flow, for a column of air extending from the surface of
        the Earth to the top of the atmosphere. Positive values
        indicate a flux from west to east. Note that "cloud frozen
        water" is the same as "cloud ice water".
      |||,
    },
    {
      name: 'vertical_integral_of_eastward_cloud_liquid_water_flux',
      units: units.rainfall_rate_kg_per_m_per_s,
      description: |||
        This parameter is the horizontal rate of flow of cloud
        liquid water, in the eastward direction, per metre across
        the flow, for a column of air extending from the surface of
        the Earth to the top of the atmosphere. Positive values
        indicate a flux from west to east.
      |||,
    },
    {
      name: 'vertical_integral_of_eastward_geopotential_flux',
      units: units.watt_per_meter,
      description: |||
        This parameter is the horizontal rate of flow of
        geopotential, in the eastward direction, per metre across
        the flow, for a column of air extending from the surface of
        the Earth to the top of the atmosphere. Positive values
        indicate a flux from west to east. Geopotential is the
        gravitational potential energy of a unit mass, at a
        particular location, relative to mean sea level. It is also
        the amount of work that would have to be done, against the
        force of gravity, to lift a unit mass to that location from
        mean sea level. This parameter can be used to study the
        atmospheric energy budget.
      |||,
    },
    {
      name: 'vertical_integral_of_eastward_heat_flux',
      units: units.watt_per_meter,
      description: |||
        This parameter is the horizontal rate of flow of heat in the
        eastward direction, per meter across the flow, for a column
        of air extending from the surface of the Earth to the top of
        the atmosphere. Positive values indicate a flux from west to
        east. Heat (or thermal energy) is equal to enthalpy, which
        is the sum of the internal energy and the energy associated
        with the pressure of the air on its surroundings. Internal
        energy is the energy contained within a system i.e., the
        microscopic energy of the air molecules, rather than the
        macroscopic energy associated with, for example, wind, or
        gravitational potential energy. The energy associated with
        the pressure of the air on its surroundings is the energy
        required to make room for the system by displacing its
        surroundings and is calculated from the product of pressure
        and volume. This parameter can be used to study the
        atmospheric energy budget.
      |||,
    },
    {
      name: 'vertical_integral_of_eastward_kinetic_energy_flux',
      units: units.watt_per_meter,
      description: |||
        This parameter is the horizontal rate of flow of kinetic
        energy, in the eastward direction, per metre across the
        flow, for a column of air extending from the surface of the
        Earth to the top of the atmosphere. Positive values indicate
        a flux from west to east. Atmospheric kinetic energy is the
        energy of the atmosphere due to its motion. Only horizontal
        motion is considered in the calculation of this parameter.
        This parameter can be used to study the atmospheric energy
        budget.
      |||,
    },
    {
      name: 'vertical_integral_of_eastward_mass_flux',
      units: units.rainfall_rate_kg_per_m_per_s,
      description: |||
        This parameter is the horizontal rate of flow of mass, in
        the eastward direction, per metre across the flow, for a
        column of air extending from the surface of the Earth to the
        top of the atmosphere. Positive values indicate a flux from
        west to east. This parameter can be used to study the
        atmospheric mass and energy budgets.
      |||,
    },
    {
      name: 'vertical_integral_of_eastward_ozone_flux',
      units: units.rainfall_rate_kg_per_m_per_s,
      description: |||
        This parameter is the horizontal rate of flow of ozone in
        the eastward direction, per metre across the flow, for a
        column of air extending from the surface of the Earth to the
        top of the atmosphere. Positive values denote a flux from
        west to east. In the ECMWF Integrated Forecasting System
        (IFS), there is a simplified representation of ozone
        chemistry (including a representation of the chemistry which
        has caused the ozone hole). Ozone is also transported around
        in the atmosphere through the motion of air.
      |||,
    },
    {
      name: 'vertical_integral_of_eastward_total_energy_flux',
      units: units.watt_per_meter,
      description: |||
        This parameter is the horizontal rate of flow of total
        energy in the eastward direction, per metre across the flow,
        for a column of air extending from the surface of the Earth
        to the top of the atmosphere. Positive values indicate a
        flux from west to east. Total atmospheric energy is made up
        of internal, potential, kinetic and latent energy. This
        parameter can be used to study the atmospheric energy
        budget.
      |||,
    },
    {
      name: 'vertical_integral_of_eastward_water_vapour_flux',
      units: units.rainfall_rate_kg_per_m_per_s,
      description: |||
        This parameter is the horizontal rate of flow of water
        vapour, in the eastward direction, per metre across the
        flow, for a column of air extending from the surface of the
        Earth to the top of the atmosphere. Positive values indicate
        a flux from west to east.
      |||,
    },
    {
      name: 'vertical_integral_of_energy_conversion',
      units: units.watt_per_meter_squared,
      description: |||
        This parameter is one contribution to the amount of energy
        being converted between kinetic energy, and internal plus
        potential energy, for a column of air extending from the
        surface of the Earth to the top of the atmosphere. Negative
        values indicate a conversion to kinetic energy from
        potential plus internal energy. This parameter can be used
        to study the atmospheric energy budget. The circulation of
        the atmosphere can also be considered in terms of energy
        conversions.
      |||,
    },
    {
      name: 'vertical_integral_of_kinetic_energy',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the vertical integral of kinetic energy
        for a column of air extending from the surface of the Earth
        to the top of the atmosphere. Atmospheric kinetic energy is
        the energy of the atmosphere due to its motion. Only
        horizontal motion is considered in the calculation of this
        parameter. This parameter can be used to study the
        atmospheric energy budget.
      |||,
    },
    {
      name: 'vertical_integral_of_mass_of_atmosphere',
      units: units.area_density,
      description: |||
        This parameter is the total mass of air for a column
        extending from the surface of the Earth to the top of the
        atmosphere, per square metre. This parameter is calculated
        by dividing surface pressure by the Earth's gravitational
        acceleration, g (=9.80665 m s^-2 ), and has units of
        kilograms per square metre. This parameter can be used to
        study the atmospheric mass budget.
      |||,
    },
    {
      name: 'vertical_integral_of_mass_tendency',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        This parameter is the rate of change of the mass of a column
        of air extending from the Earth's surface to the top of the
        atmosphere. An increasing mass of the column indicates
        rising surface pressure. In contrast, a decrease indicates a
        falling surface pressure. The mass of the column is
        calculated by dividing pressure at the Earth's surface by
        the gravitational acceleration, g (=9.80665 m s^-2 ). This
        parameter can be used to study the atmospheric mass and
        energy budgets.
      |||,
    },
    {
      name: 'vertical_integral_of_northward_cloud_frozen_water_flux',
      units: units.rainfall_rate_kg_per_m_per_s,
      description: |||
        This parameter is the horizontal rate of flow of cloud
        frozen water, in the northward direction, per metre across
        the flow, for a column of air extending from the surface of
        the Earth to the top of the atmosphere. Positive values
        indicate a flux from south to north. Note that "cloud frozen
        water" is the same as "cloud ice water".
      |||,
    },
    {
      name: 'vertical_integral_of_northward_cloud_liquid_water_flux',
      units: units.rainfall_rate_kg_per_m_per_s,
      description: |||
        This parameter is the horizontal rate of flow of cloud
        liquid water, in the northward direction, per metre across
        the flow, for a column of air extending from the surface of
        the Earth to the top of the atmosphere. Positive values
        indicate a flux from south to north.
      |||,
    },
    {
      name: 'vertical_integral_of_northward_geopotential_flux',
      units: units.watt_per_meter,
      description: |||
        This parameter is the horizontal rate of flow of
        geopotential in the northward direction, per metre across
        the flow, for a column of air extending from the surface of
        the Earth to the top of the atmosphere. Positive values
        indicate a flux from south to north. Geopotential is the
        gravitational potential energy of a unit mass, at a
        particular location, relative to mean sea level. It is also
        the amount of work that would have to be done, against the
        force of gravity, to lift a unit mass to that location from
        mean sea level. This parameter can be used to study the
        atmospheric energy budget.
      |||,
    },
    {
      name: 'vertical_integral_of_northward_heat_flux',
      units: units.watt_per_meter,
      description: |||
        This parameter is the horizontal rate of flow of heat in the
        northward direction, per metre across the flow, for a column
        of air extending from the surface of the Earth to the top of
        the atmosphere. Positive values indicate a flux from south
        to north. Heat (or thermal energy) is equal to enthalpy,
        which is the sum of the internal energy and the energy
        associated with the pressure of the air on its surroundings.
        Internal energy is the energy contained within a system
        i.e., the microscopic energy of the air molecules, rather
        than the macroscopic energy associated with, for example,
        wind, or gravitational potential energy. The energy
        associated with the pressure of the air on its surroundings
        is the energy required to make room for the system by
        displacing its surroundings and is calculated from the
        product of pressure and volume. This parameter can be used
        to study the atmospheric energy budget.
      |||,
    },
    {
      name: 'vertical_integral_of_northward_kinetic_energy_flux',
      units: units.watt_per_meter,
      description: |||
        This parameter is the horizontal rate of flow of kinetic
        energy, in the northward direction, per metre across the
        flow, for a column of air extending from the surface of the
        Earth to the top of the atmosphere. Positive values indicate
        a flux from south to north. Atmospheric kinetic energy is
        the energy of the atmosphere due to its motion. Only
        horizontal motion is considered in the calculation of this
        parameter. This parameter can be used to study the
        atmospheric energy budget.
      |||,
    },
    {
      name: 'vertical_integral_of_northward_mass_flux',
      units: units.rainfall_rate_kg_per_m_per_s,
      description: |||
        This parameter is the horizontal rate of flow of mass, in
        the northward direction, per metre across the flow, for a
        column of air extending from the surface of the Earth to the
        top of the atmosphere. Positive values indicate a flux from
        south to north. This parameter can be used to study the
        atmospheric mass and energy budgets.
      |||,
    },
    {
      name: 'vertical_integral_of_northward_ozone_flux',
      units: units.rainfall_rate_kg_per_m_per_s,
      description: |||
        This parameter is the horizontal rate of flow of ozone in
        the northward direction, per metre across the flow, for a
        column of air extending from the surface of the Earth to the
        top of the atmosphere. Positive values denote a flux from
        south to north. In the ECMWF Integrated Forecasting System
        (IFS), there is a simplified representation of ozone
        chemistry (including a representation of the chemistry which
        has caused the ozone hole). Ozone is also transported around
        in the atmosphere through the motion of air.
      |||,
    },
    {
      name: 'high_vegetation_cover',
      units: units.dimensionless,
      description: |||
        This parameter is the fraction of the grid box that is
        covered with vegetation that is classified as "high". The
        values vary between 0 and 1 but do not vary in time. This is
        one of the parameters in the model that describes land
        surface vegetation. "High vegetation" consists of evergreen
        trees, deciduous trees, mixed forest/woodland, and
        interrupted forest.
      |||,
    },
    {
      name: 'leaf_area_index_high_vegetation',
      units: units.dimensionless,
      description: |||
        This parameter is the surface area of one side of all the
        leaves found over an area of land for vegetation classified
        as "high". This parameter has a value of 0 over bare ground
        or where there are no leaves. It can be calculated daily
        from satellite data. It is important for forecasting, for
        example, how much rainwater will be intercepted by the
        vegetative canopy, rather than falling to the ground. This
        is one of the parameters in the model that describes land
        surface vegetation. "High vegetation" consists of evergreen
        trees, deciduous trees, mixed forest/woodland, and
        interrupted forest.
      |||,
    },
    {
      name: 'leaf_area_index_low_vegetation',
      units: units.dimensionless,
      description: |||
        This parameter is the surface area of one side of all the
        leaves found over an area of land for vegetation classified
        as "low". This parameter has a value of 0 over bare ground
        or where there are no leaves. It can be calculated daily
        from satellite data. It is important for forecasting, for
        example, how much rainwater will be intercepted by the
        vegetative canopy, rather than falling to the ground. This
        is one of the parameters in the model that describes land
        surface vegetation. "Low vegetation" consists of crops and
        mixed farming, irrigated crops, short grass, tall grass,
        tundra, semidesert, bogs and marshes, evergreen shrubs,
        deciduous shrubs, and water and land mixtures.
      |||,
    },
    {
      name: 'low_vegetation_cover',
      units: units.dimensionless,
      description: |||
        This parameter is the fraction of the grid box that is
        covered with vegetation that is classified as "low". The
        values vary between 0 and 1 but do not vary in time. This is
        one of the parameters in the model that describes land
        surface vegetation. "Low vegetation" consists of crops and
        mixed farming, irrigated crops, short grass, tall grass,
        tundra, semidesert, bogs and marshes, evergreen shrubs,
        deciduous shrubs, and water and land mixtures.
      |||,
    },
    {
      name: 'type_of_high_vegetation',
      units: units.dimensionless,
      description: |||
        This parameter indicates the 6 types of high vegetation
        recognised by the ECMWF Integrated Forecasting System: 3 =
        Evergreen needleleaf trees, 4 = Deciduous needleleaf trees,
        5 = Deciduous broadleaf trees, 6 = Evergreen broadleaf
        trees, 18 = Mixed forest/woodland, 19 = Interrupted forest.
        A value of 0 indicates a point without high vegetation,
        including an oceanic or inland water location. Vegetation
        types are used to calculate the surface energy balance and
        snow albedo. This parameter does not vary in time.
      |||,
    },
    {
      name: 'type_of_low_vegetation',
      units: units.dimensionless,
      description: |||
        This parameter indicates the 10 types of low vegetation
        recognised by the ECMWF Integrated Forecasting System: 1 =
        Crops, Mixed farming, 2 = Grass, 7 = Tall grass, 9 = Tundra,
        10 = Irrigated crops, 11 = Semidesert, 13 = Bogs and
        marshes, 16 = Evergreen shrubs, 17 = Deciduous shrubs, 20 =
        Water and land mixtures. A value of 0 indicates a point
        without low vegetation, including an oceanic or inland water
        location. Vegetation types are used to calculate the surface
        energy balance and snow albedo. This parameter does not vary
        in time.
      |||,
    },
    {
      name: 'air_density_over_the_oceans',
      units: units.density_si,
      description: |||
        This parameter is the mass of air per cubic metre over the
        oceans, derived from the temperature, specific humidity and
        pressure at the lowest model level in the atmospheric model.
        This parameter is one of the parameters used to force the
        wave model, therefore it is only calculated over water
        bodies represented in the ocean wave model. It is
        interpolated from the atmospheric model horizontal grid onto
        the horizontal grid used by the ocean wave model.
      |||,
    },
    {
      name: 'coefficient_of_drag_with_waves',
      units: units.dimensionless,
      description: |||
        This parameter is the resistance that ocean waves exert on
        the atmosphere. It is sometimes also called a "friction
        coefficient". It is calculated by the wave model as the
        ratio of the square of the friction velocity, to the square
        of the neutral wind speed at a height of 10 metres above the
        surface of the Earth. The neutral wind is calculated from
        the surface stress and the corresponding roughness length by
        assuming that the air is neutrally stratified. The neutral
        wind is, by definition, in the direction of the surface
        stress. The size of the roughness length depends on the sea
        state.
      |||,
    },
    {
      name: 'free_convective_velocity_over_the_oceans',
      units: units.velocity_si,
      description: |||
        This parameter is an estimate of the vertical velocity of
        updraughts generated by free convection. Free convection is
        fluid motion induced by buoyancy forces, which are driven by
        density gradients. The free convective velocity is used to
        estimate the impact of wind gusts on ocean wave growth. It
        is calculated at the height of the lowest temperature
        inversion (the height above the surface of the Earth where
        the temperature increases with height). This parameter is
        one of the parameters used to force the wave model,
        therefore it is only calculated over water bodies
        represented in the ocean wave model. It is interpolated from
        the atmospheric model horizontal grid onto the horizontal
        grid used by the ocean wave model.
      |||,
    },
    {
      name: 'maximum_individual_wave_height',
      units: units.meter,
      description: |||
        This parameter is an estimate of the height of the expected
        highest individual wave within a 20 minute time window. It
        can be used as a guide to the likelihood of extreme or freak
        waves. The interactions between waves are non-linear and
        occasionally concentrate wave energy giving a wave height
        considerably larger than the significant wave height. If the
        maximum individual wave height is more than twice the
        significant wave height, then the wave is considered as a
        freak wave. The significant wave height represents the
        average height of the highest third of surface ocean/sea
        waves, generated by local winds and associated with swell.
        The ocean/sea surface wave field consists of a combination
        of waves with different heights, lengths and directions
        (known as the two-dimensional wave spectrum). This parameter
        is derived statistically from the two-dimensional wave
        spectrum. The wave spectrum can be decomposed into wind-sea
        waves, which are directly affected by local winds, and
        swell, the waves that were generated by the wind at a
        different location and time. This parameter takes account of
        both.
      |||,
    },
    {
      name: 'mean_direction_of_total_swell',
      units: units.degree,
      description: |||
        This parameter is the mean direction of waves associated
        with swell. The ocean/sea surface wave field consists of a
        combination of waves with different heights, lengths and
        directions (known as the two-dimensional wave spectrum). The
        wave spectrum can be decomposed into wind-sea waves, which
        are directly affected by local winds, and swell, the waves
        that were generated by the wind at a different location and
        time. This parameter takes account of all swell only. It is
        the mean over all frequencies and directions of the total
        swell spectrum. The units are degrees true, which means the
        direction relative to the geographic location of the north
        pole. It is the direction that waves are coming from, so 0
        degrees means "coming from the north" and 90 degrees means
        "coming from the east".
      |||,
    },
    {
      name: 'mean_direction_of_wind_waves',
      units: units.degree,
      description: |||
        The mean direction of waves generated by local winds. The
        ocean/sea surface wave field consists of a combination of
        waves with different heights, lengths and directions (known
        as the two-dimensional wave spectrum). The wave spectrum can
        be decomposed into wind-sea waves, which are directly
        affected by local winds, and swell, the waves that were
        generated by the wind at a different location and time. This
        parameter takes account of wind-sea waves only. It is the
        mean over all frequencies and directions of the total
        wind-sea wave spectrum. The units are degrees true, which
        means the direction relative to the geographic location of
        the north pole. It is the direction that waves are coming
        from, so 0 degrees means "coming from the north" and 90
        degrees means "coming from the east".
      |||,
    },
    {
      name: 'mean_period_of_total_swell',
      units: units.seconds,
      description: |||
        This parameter is the average time it takes for two
        consecutive wave crests, on the surface of the ocean/sea
        associated with swell, to pass through a fixed point. The
        ocean/sea surface wave field consists of a combination of
        waves with different heights, lengths and directions (known
        as the two-dimensional wave spectrum). The wave spectrum can
        be decomposed into wind-sea waves, which are directly
        affected by local winds, and swell, the waves that were
        generated by the wind at a different location and time. This
        parameter takes account of all swell only. It is the mean
        over all frequencies and directions of the total swell
        spectrum.
      |||,
    },
    {
      name: 'mean_period_of_wind_waves',
      units: units.seconds,
      description: |||
        This parameter is the average time it takes for two
        consecutive wave crests, on the surface of the ocean/sea
        generated by local winds, to pass through a fixed point. The
        ocean/sea surface wave field consists of a combination of
        waves with different heights, lengths and directions (known
        as the two-dimensional wave spectrum). The wave spectrum can
        be decomposed into wind-sea waves, which are directly
        affected by local winds, and swell, the waves that were
        generated by the wind at a different location and time. This
        parameter takes account of wind-sea waves only. It is the
        mean over all frequencies and directions of the total
        wind-sea spectrum.
      |||,
    },
    {
      name: 'mean_square_slope_of_waves',
      units: units.dimensionless,
      description: |||
        This parameter can be related analytically to the average
        slope of combined wind-sea and swell waves. It can also be
        expressed as a function of wind speed under some statistical
        assumptions. The higher the slope, the steeper the waves.
        This parameter indicates the roughness of the sea/ocean
        surface which affects the interaction between ocean and
        atmosphere. The ocean/sea surface wave field consists of a
        combination of waves with different heights, lengths and
        directions (known as the two-dimensional wave spectrum).
        This parameter is derived statistically from the
        two-dimensional wave spectrum.
      |||,
    },
    {
      name: 'mean_wave_direction',
      units: units.degree,
      description: |||
        This parameter is the mean direction of ocean/sea surface
        waves. The ocean/sea surface wave field consists of a
        combination of waves with different heights, lengths and
        directions (known as the two-dimensional wave spectrum).
        This parameter is a mean over all frequencies and directions
        of the two-dimensional wave spectrum. The wave spectrum can
        be decomposed into wind-sea waves, which are directly
        affected by local winds, and swell, the waves that were
        generated by the wind at a different location and time. This
        parameter takes account of both. This parameter can be used
        to assess sea state and swell. For example, engineers use
        this type of wave information when designing structures in
        the open ocean, such as oil platforms, or in coastal
        applications. The units are degrees true, which means the
        direction relative to the geographic location of the north
        pole. It is the direction that waves are coming from, so 0
        degrees means "coming from the north" and 90 degrees means
        "coming from the east".
      |||,
    },
    {
      name: 'mean_wave_direction_of_first_swell_partition',
      units: units.degree,
      description: |||
        This parameter is the mean direction of waves in the first
        swell partition. The ocean/sea surface wave field consists
        of a combination of waves with different heights, lengths
        and directions (known as the two-dimensional wave spectrum).
        The wave spectrum can be decomposed into wind-sea waves,
        which are directly affected by local winds, and swell, the
        waves that were generated by the wind at a different
        location and time. In many situations, swell can be made up
        of different swell systems, for example, from two distant
        and separate storms. To account for this, the swell spectrum
        is partitioned into up to three parts. The swell partitions
        are labelled first, second and third based on their
        respective wave height. Therefore, there is no guarantee of
        spatial coherence (the first swell partition might be from
        one system at one location and a different system at the
        neighbouring location). The units are degrees true, which
        means the direction relative to the geographic location of
        the north pole. It is the direction that waves are coming
        from, so 0 degrees means "coming from the north" and 90
        degrees means "coming from the east".
      |||,
    },
    {
      name: 'mean_wave_direction_of_second_swell_partition',
      units: units.degree,
      description: |||
        This parameter is the mean direction of waves in the second
        swell partition. The ocean/sea surface wave field consists
        of a combination of waves with different heights, lengths
        and directions (known as the two-dimensional wave spectrum).
        The wave spectrum can be decomposed into wind-sea waves,
        which are directly affected by local winds, and swell, the
        waves that were generated by the wind at a different
        location and time. In many situations, swell can be made up
        of different swell systems, for example, from two distant
        and separate storms. To account for this, the swell spectrum
        is partitioned into up to three parts. The swell partitions
        are labelled first, second and third based on their
        respective wave height. Therefore, there is no guarantee of
        spatial coherence (the first swell partition might be from
        one system at one location and a different system at the
        neighbouring location). The units are degrees true, which
        means the direction relative to the geographic location of
        the north pole. It is the direction that waves are coming
        from, so 0 degrees means "coming from the north" and 90
        degrees means "coming from the east".
      |||,
    },
    {
      name: 'mean_wave_direction_of_third_swell_partition',
      units: units.degree,
      description: |||
        This parameter is the mean direction of waves in the third
        swell partition. The ocean/sea surface wave field consists
        of a combination of waves with different heights, lengths
        and directions (known as the two-dimensional wave spectrum).
        The wave spectrum can be decomposed into wind-sea waves,
        which are directly affected by local winds, and swell, the
        waves that were generated by the wind at a different
        location and time. In many situations, swell can be made up
        of different swell systems, for example, from two distant
        and separate storms. To account for this, the swell spectrum
        is partitioned into up to three parts. The swell partitions
        are labelled first, second and third based on their
        respective wave height. Therefore, there is no guarantee of
        spatial coherence (the first swell partition might be from
        one system at one location and a different system at the
        neighbouring location). The units are degrees true, which
        means the direction relative to the geographic location of
        the north pole. It is the direction that waves are coming
        from, so 0 degrees means "coming from the north" and 90
        degrees means "coming from the east".
      |||,
    },
    {
      name: 'mean_wave_period',
      units: units.seconds,
      description: |||
        This parameter is the average time it takes for two
        consecutive wave crests, on the surface of the ocean/sea, to
        pass through a fixed point. The ocean/sea surface wave field
        consists of a combination of waves with different heights,
        lengths and directions (known as the two-dimensional wave
        spectrum). This parameter is a mean over all frequencies and
        directions of the two-dimensional wave spectrum. The wave
        spectrum can be decomposed into wind-sea waves, which are
        directly affected by local winds, and swell, the waves that
        were generated by the wind at a different location and time.
        This parameter takes account of both. This parameter can be
        used to assess sea state and swell. For example, engineers
        use such wave information when designing structures in the
        open ocean, such as oil platforms, or in coastal
        applications.
      |||,
    },
    {
      name: 'mean_wave_period_based_on_first_moment',
      units: units.seconds,
      description: |||
        This parameter is the reciprocal of the mean frequency of
        the wave components that represent the sea state. All wave
        components have been averaged proportionally to their
        respective amplitude. This parameter can be used to estimate
        the magnitude of Stokes drift transport in deep water. The
        ocean/sea surface wave field consists of a combination of
        waves with different heights, lengths and directions (known
        as the two-dimensional wave spectrum). Moments are
        statistical quantities derived from the two-dimensional wave
        spectrum.
      |||,
    },
    {
      name: 'mean_wave_period_based_on_first_moment_for_swell',
      units: units.seconds,
      description: |||
        This parameter is the reciprocal of the mean frequency of
        the wave components associated with swell. All wave
        components have been averaged proportionally to their
        respective amplitude. This parameter can be used to estimate
        the magnitude of Stokes drift transport in deep water
        associated with swell. The ocean/sea surface wave field
        consists of a combination of waves with different heights,
        lengths and directions (known as the two-dimensional wave
        spectrum). The wave spectrum can be decomposed into wind-sea
        waves, which are directly affected by local winds, and
        swell, the waves that were generated by the wind at a
        different location and time. This parameter takes account of
        all swell only. Moments are statistical quantities derived
        from the two-dimensional wave spectrum.
      |||,
    },
    {
      name: 'mean_wave_period_based_on_first_moment_for_wind_waves',
      units: units.seconds,
      description: |||
        This parameter is the reciprocal of the mean frequency of
        the wave components generated by local winds. All wave
        components have been averaged proportionally to their
        respective amplitude. This parameter can be used to estimate
        the magnitude of Stokes drift transport in deep water
        associated with wind waves. The ocean/sea surface wave field
        consists of a combination of waves with different heights,
        lengths and directions (known as the two-dimensional wave
        spectrum). The wave spectrum can be decomposed into wind-sea
        waves, which are directly affected by local winds, and
        swell, the waves that were generated by the wind at a
        different location and time. This parameter takes account of
        wind-sea waves only. Moments are statistical quantities
        derived from the two-dimensional wave spectrum.
      |||,
    },
    {
      name: 'mean_wave_period_based_on_second_moment_for_swell',
      units: units.seconds,
      description: |||
        This parameter is equivalent to the zero-crossing mean wave
        period for swell. The zero-crossing mean wave period
        represents the mean length of time between occasions where
        the sea/ocean surface crosses a defined zeroth level (such
        as mean sea level). The ocean/sea surface wave field
        consists of a combination of waves with different heights,
        lengths and directions (known as the two-dimensional wave
        spectrum). The wave spectrum can be decomposed into wind-sea
        waves, which are directly affected by local winds, and
        swell, the waves that were generated by the wind at a
        different location and time. Moments are statistical
        quantities derived from the two-dimensional wave spectrum.
      |||,
    },
    {
      name: 'mean_wave_period_based_on_second_moment_for_wind_waves',
      units: units.seconds,
      description: |||
        This parameter is equivalent to the zero-crossing mean wave
        period for waves generated by local winds. The zero-crossing
        mean wave period represents the mean length of time between
        occasions where the sea/ocean surface crosses a defined
        zeroth level (such as mean sea level). The ocean/sea surface
        wave field consists of a combination of waves with different
        heights, lengths and directions (known as the
        two-dimensional wave spectrum). The wave spectrum can be
        decomposed into wind-sea waves, which are directly affected
        by local winds, and swell, the waves that were generated by
        the wind at a different location and time. Moments are
        statistical quantities derived from the two-dimensional wave
        spectrum.
      |||,
    },
    {
      name: 'mean_wave_period_of_first_swell_partition',
      units: units.seconds,
      description: |||
        This parameter is the mean period of waves in the first
        swell partition. The wave period is the average time it
        takes for two consecutive wave crests, on the surface of the
        ocean/sea, to pass through a fixed point. The ocean/sea
        surface wave field consists of a combination of waves with
        different heights, lengths and directions (known as the
        two-dimensional wave spectrum). The wave spectrum can be
        decomposed into wind-sea waves, which are directly affected
        by local winds, and swell, the waves that were generated by
        the wind at a different location and time. In many
        situations, swell can be made up of different swell systems,
        for example, from two distant and separate storms. To
        account for this, the swell spectrum is partitioned into up
        to three parts. The swell partitions are labelled first,
        second and third based on their respective wave height.
        Therefore, there is no guarantee of spatial coherence (the
        first swell partition might be from one system at one
        location and a different system at the neighbouring
        location).
      |||,
    },
    {
      name: 'mean_wave_period_of_second_swell_partition',
      units: units.seconds,
      description: |||
        This parameter is the mean period of waves in the second
        swell partition. The wave period is the average time it
        takes for two consecutive wave crests, on the surface of the
        ocean/sea, to pass through a fixed point. The ocean/sea
        surface wave field consists of a combination of waves with
        different heights, lengths and directions (known as the
        two-dimensional wave spectrum). The wave spectrum can be
        decomposed into wind-sea waves, which are directly affected
        by local winds, and swell, the waves that were generated by
        the wind at a different location and time. In many
        situations, swell can be made up of different swell systems,
        for example, from two distant and separate storms. To
        account for this, the swell spectrum is partitioned into up
        to three parts. The swell partitions are labelled first,
        second and third based on their respective wave height.
        Therefore, there is no guarantee of spatial coherence (the
        second swell partition might be from one system at one
        location and a different system at the neighbouring
        location).
      |||,
    },
    {
      name: 'mean_wave_period_of_third_swell_partition',
      units: units.seconds,
      description: |||
        This parameter is the mean period of waves in the third
        swell partition. The wave period is the average time it
        takes for two consecutive wave crests, on the surface of the
        ocean/sea, to pass through a fixed point. The ocean/sea
        surface wave field consists of a combination of waves with
        different heights, lengths and directions (known as the
        two-dimensional wave spectrum). The wave spectrum can be
        decomposed into wind-sea waves, which are directly affected
        by local winds, and swell, the waves that were generated by
        the wind at a different location and time. In many
        situations, swell can be made up of different swell systems,
        for example, from two distant and separate storms. To
        account for this, the swell spectrum is partitioned into up
        to three parts. The swell partitions are labelled first,
        second and third based on their respective wave height.
        Therefore, there is no guarantee of spatial coherence (the
        third swell partition might be from one system at one
        location and a different system at the neighbouring
        location).
      |||,
    },
    {
      name: 'mean_zero_crossing_wave_period',
      units: units.seconds,
      description: |||
        This parameter represents the mean length of time between
        occasions where the sea/ocean surface crosses mean sea
        level. In combination with wave height information, it could
        be used to assess the length of time that a coastal
        structure might be under water, for example. The ocean/sea
        surface wave field consists of a combination of waves with
        different heights, lengths and directions (known as the
        two-dimensional wave spectrum). In the ECMWF Integrated
        Forecasting System (IFS) this parameter is calculated from
        the characteristics of the two-dimensional wave spectrum.
      |||,
    },
    {
      name: 'model_bathymetry',
      units: units.meter,
      description: |||
        This parameter is the depth of water from the surface to the
        bottom of the ocean. It is used by the ocean wave model to
        specify the propagation properties of the different waves
        that could be present. Note that the ocean wave model grid
        is too coarse to resolve some small islands and mountains on
        the bottom of the ocean, but they can have an impact on
        surface ocean waves. The ocean wave model has been modified
        to reduce the wave energy flowing around or over features at
        spatial scales smaller than the grid box.
      |||,
    },
    {
      name: 'normalized_energy_flux_into_ocean',
      units: units.dimensionless,
      description: |||
        This parameter is the normalised vertical flux of turbulent
        kinetic energy from ocean waves into the ocean. The energy
        flux is calculated from an estimation of the loss of wave
        energy due to white capping waves. A white capping wave is
        one that appears white at its crest as it breaks, due to air
        being mixed into the water. When waves break in this way,
        there is a transfer of energy from the waves to the ocean.
        Such a flux is defined to be negative. The energy flux has
        units of Watts per metre squared, and this is normalised by
        being divided by the product of air density and the cube of
        the friction velocity.
      |||,
    },
    {
      name: 'normalized_energy_flux_into_waves',
      units: units.dimensionless,
      description: |||
        This parameter is the normalised vertical flux of energy
        from wind into the ocean waves. A positive flux implies a
        flux into the waves. The energy flux has units of Watts per
        metre squared, and this is normalised by being divided by
        the product of air density and the cube of the friction
        velocity.
      |||,
    },
    {
      name: 'normalized_stress_into_ocean',
      units: units.dimensionless,
      description: |||
        This parameter is the normalised surface stress, or momentum
        flux, from the air into the ocean due to turbulence at the
        air-sea interface and breaking waves. It does not include
        the flux used to generate waves. The ECMWF convention for
        vertical fluxes is positive downwards. The stress has units
        of Newtons per metre squared, and this is normalised by
        being divided by the product of air density and the square
        of the friction velocity.
      |||,
    },
    {
      name: 'ocean_surface_stress_equivalent_10m_neutral_wind_direction',
      units: units.degree,
      description: |||
        This parameter is the direction from which the "neutral
        wind" blows, in degrees clockwise from true north, at a
        height of ten metres above the surface of the Earth. The
        neutral wind is calculated from the surface stress and
        roughness length by assuming that the air is neutrally
        stratified. The neutral wind is, by definition, in the
        direction of the surface stress. The size of the roughness
        length depends on the sea state. This parameter is the wind
        direction used to force the wave model, therefore it is only
        calculated over water bodies represented in the ocean wave
        model. It is interpolated from the atmospheric model's
        horizontal grid onto the horizontal grid used by the ocean
        wave model.
      |||,
    },
    {
      name: 'ocean_surface_stress_equivalent_10m_neutral_wind_speed',
      units: units.velocity_si,
      description: |||
        This parameter is the horizontal speed of the "neutral
        wind", at a height of ten metres above the surface of the
        Earth. The units of this parameter are metres per second.
        The neutral wind is calculated from the surface stress and
        roughness length by assuming that the air is neutrally
        stratified. The neutral wind is, by definition, in the
        direction of the surface stress. The size of the roughness
        length depends on the sea state. This parameter is the wind
        speed used to force the wave model, therefore it is only
        calculated over water bodies represented in the ocean wave
        model. It is interpolated from the atmospheric model's
        horizontal grid onto the horizontal grid used by the ocean
        wave model.
      |||,
    },
    {
      name: 'peak_wave_period',
      units: units.seconds,
      description: |||
        This parameter represents the period of the most energetic
        ocean waves generated by local winds and associated with
        swell. The wave period is the average time it takes for two
        consecutive wave crests, on the surface of the ocean/sea, to
        pass through a fixed point. The ocean/sea surface wave field
        consists of a combination of waves with different heights,
        lengths and directions (known as the two-dimensional wave
        spectrum). This parameter is calculated from the reciprocal
        of the frequency corresponding to the largest value (peak)
        of the frequency wave spectrum. The frequency wave spectrum
        is obtained by integrating the two-dimensional wave spectrum
        over all directions. The wave spectrum can be decomposed
        into wind-sea waves, which are directly affected by local
        winds, and swell, the waves that were generated by the wind
        at a different location and time. This parameter takes
        account of both.
      |||,
    },
    {
      name: 'period_corresponding_to_maximum_individual_wave_height',
      units: units.seconds,
      description: |||
        This parameter is the period of the expected highest
        individual wave within a 20-minute time window. It can be
        used as a guide to the characteristics of extreme or freak
        waves. Wave period is the average time it takes for two
        consecutive wave crests, on the surface of the ocean/sea, to
        pass through a fixed point. Occasionally waves of different
        periods reinforce and interact non-linearly giving a wave
        height considerably larger than the significant wave height.
        If the maximum individual wave height is more than twice the
        significant wave height, then the wave is considered to be a
        freak wave. The significant wave height represents the
        average height of the highest third of surface ocean/sea
        waves, generated by local winds and associated with swell.
        The ocean/sea surface wave field consists of a combination
        of waves with different heights, lengths and directions
        (known as the two-dimensional wave spectrum). This parameter
        is derived statistically from the two-dimensional wave
        spectrum. The wave spectrum can be decomposed into wind-sea
        waves, which are directly affected by local winds, and
        swell, the waves that were generated by the wind at a
        different location and time. This parameter takes account of
        both.
      |||,
    },
    {
      name: 'significant_height_of_combined_wind_waves_and_swell',
      units: units.meter,
      description: |||
        This parameter represents the average height of the highest
        third of surface ocean/sea waves generated by wind and
        swell. It represents the vertical distance between the wave
        crest and the wave trough. The ocean/sea surface wave field
        consists of a combination of waves with different heights,
        lengths and directions (known as the two-dimensional wave
        spectrum). The wave spectrum can be decomposed into wind-sea
        waves, which are directly affected by local winds, and
        swell, the waves that were generated by the wind at a
        different location and time. This parameter takes account of
        both. More strictly, this parameter is four times the square
        root of the integral over all directions and all frequencies
        of the two-dimensional wave spectrum. This parameter can be
        used to assess sea state and swell. For example, engineers
        use significant wave height to calculate the load on
        structures in the open ocean, such as oil platforms, or in
        coastal applications.
      |||,
    },
    {
      name: 'significant_height_of_total_swell',
      units: units.meter,
      description: |||
        This parameter represents the average height of the highest
        third of surface ocean/sea waves associated with swell. It
        represents the vertical distance between the wave crest and
        the wave trough. The ocean/sea surface wave field consists
        of a combination of waves with different heights, lengths
        and directions (known as the two-dimensional wave spectrum).
        The wave spectrum can be decomposed into wind-sea waves,
        which are directly affected by local winds, and swell, the
        waves that were generated by the wind at a different
        location and time. This parameter takes account of total
        swell only. More strictly, this parameter is four times the
        square root of the integral over all directions and all
        frequencies of the two-dimensional total swell spectrum. The
        total swell spectrum is obtained by only considering the
        components of the two-dimensional wave spectrum that are not
        under the influence of the local wind. This parameter can be
        used to assess swell. For example, engineers use significant
        wave height to calculate the load on structures in the open
        ocean, such as oil platforms, or in coastal applications.
      |||,
    },
    {
      name: 'significant_height_of_wind_waves',
      units: units.meter,
      description: |||
        This parameter represents the average height of the highest
        third of surface ocean/sea waves generated by the local
        wind. It represents the vertical distance between the wave
        crest and the wave trough. The ocean/sea surface wave field
        consists of a combination of waves with different heights,
        lengths and directions (known as the two-dimensional wave
        spectrum). The wave spectrum can be decomposed into wind-sea
        waves, which are directly affected by local winds, and
        swell, the waves that were generated by the wind at a
        different location and time. This parameter takes account of
        wind-sea waves only. More strictly, this parameter is four
        times the square root of the integral over all directions
        and all frequencies of the two-dimensional wind-sea wave
        spectrum. The wind-sea wave spectrum is obtained by only
        considering the components of the two-dimensional wave
        spectrum that are still under the influence of the local
        wind. This parameter can be used to assess wind-sea waves.
        For example, engineers use significant wave height to
        calculate the load on structures in the open ocean, such as
        oil platforms, or in coastal applications.
      |||,
    },
    {
      name: 'significant_wave_height_of_first_swell_partition',
      units: units.meter,
      description: |||
        This parameter represents the average height of the highest
        third of surface ocean/sea waves associated with the first
        swell partition. Wave height represents the vertical
        distance between the wave crest and the wave trough. The
        ocean/sea surface wave field consists of a combination of
        waves with different heights, lengths and directions (known
        as the two-dimensional wave spectrum). The wave spectrum can
        be decomposed into wind-sea waves, which are directly
        affected by local winds, and swell, the waves that were
        generated by the wind at a different location and time. In
        many situations, swell can be made up of different swell
        systems, for example, from two distant and separate storms.
        To account for this, the swell spectrum is partitioned into
        up to three parts. The swell partitions are labelled first,
        second and third based on their respective wave height.
        Therefore, there is no guarantee of spatial coherence (the
        first might be from one system at one location and another
        system at the neighbouring location). More strictly, this
        parameter is four times the square root of the integral over
        all directions and all frequencies of the first swell
        partition of the two-dimensional swell spectrum. The swell
        spectrum is obtained by only considering the components of
        the two-dimensional wave spectrum that are not under the
        influence of the local wind. This parameter can be used to
        assess swell. For example, engineers use significant wave
        height to calculate the load on structures in the open
        ocean, such as oil platforms, or in coastal applications.
      |||,
    },
    {
      name: 'significant_wave_height_of_second_swell_partition',
      units: units.meter,
      description: |||
        This parameter represents the average height of the highest
        third of surface ocean/sea waves associated with the second
        swell partition. Wave height represents the vertical
        distance between the wave crest and the wave trough. The
        ocean/sea surface wave field consists of a combination of
        waves with different heights, lengths and directions (known
        as the two-dimensional wave spectrum). The wave spectrum can
        be decomposed into wind-sea waves, which are directly
        affected by local winds, and swell, the waves that were
        generated by the wind at a different location and time. In
        many situations, swell can be made up of different swell
        systems, for example, from two distant and separate storms.
        To account for this, the swell spectrum is partitioned into
        up to three parts. The swell partitions are labelled first,
        second and third based on their respective wave height.
        Therefore, there is no guarantee of spatial coherence (the
        second might be from one system at one location and another
        system at the neighbouring location). More strictly, this
        parameter is four times the square root of the integral over
        all directions and all frequencies of the first swell
        partition of the two-dimensional swell spectrum. The swell
        spectrum is obtained by only considering the components of
        the two-dimensional wave spectrum that are not under the
        influence of the local wind. This parameter can be used to
        assess swell. For example, engineers use significant wave
        height to calculate the load on structures in the open
        ocean, such as oil platforms, or in coastal applications.
      |||,
    },
    {
      name: 'significant_wave_height_of_third_swell_partition',
      units: units.meter,
      description: |||
        This parameter represents the average height of the highest
        third of surface ocean/sea waves associated with the third
        swell partition. Wave height represents the vertical
        distance between the wave crest and the wave trough. The
        ocean/sea surface wave field consists of a combination of
        waves with different heights, lengths and directions (known
        as the two-dimensional wave spectrum). The wave spectrum can
        be decomposed into wind-sea waves, which are directly
        affected by local winds, and swell, the waves that were
        generated by the wind at a different location and time. In
        many situations, swell can be made up of different swell
        systems, for example, from two distant and separate storms.
        To account for this, the swell spectrum is partitioned into
        up to three parts. The swell partitions are labelled first,
        second and third based on their respective wave height.
        Therefore, there is no guarantee of spatial coherence (the
        third might be from one system at one location and another
        system at the neighbouring location). More strictly, this
        parameter is four times the square root of the integral over
        all directions and all frequencies of the first swell
        partition of the two-dimensional swell spectrum. The swell
        spectrum is obtained by only considering the components of
        the two-dimensional wave spectrum that are not under the
        influence of the local wind. This parameter can be used to
        assess swell. For example, engineers use significant wave
        height to calculate the load on structures in the open
        ocean, such as oil platforms, or in coastal applications.
      |||,
    },
    {
      name: 'angle_of_sub_gridscale_orography',
      units: units.radian,
      description: |||
        This parameter is one of four parameters (the others being
        standard deviation, slope and anisotropy) that describe the
        features of the orography that are too small to be resolved
        by the model grid. These four parameters are calculated for
        orographic features with horizontal scales comprised between
        5 km and the model grid resolution, being derived from the
        height of valleys, hills and mountains at about 1 km
        resolution. They are used as input for the sub-grid
        orography scheme which represents low-level blocking and
        orographic gravity wave effects. The angle of the sub-grid
        scale orography characterises the geographical orientation
        of the terrain in the horizontal plane (from a bird's-eye
        view) relative to an eastwards axis. This parameter does not
        vary in time.
      |||,
    },
    {
      name: 'anisotropy_of_sub_gridscale_orography',
      units: units.dimensionless,
      description: |||
        This parameter is one of four parameters (the others being
        standard deviation, slope and angle of sub-gridscale
        orography) that describe the features of the orography that
        are too small to be resolved by the model grid. These four
        parameters are calculated for orographic features with
        horizontal scales comprised between 5 km and the model grid
        resolution, being derived from the height of valleys, hills
        and mountains at about 1 km resolution. They are used as
        input for the sub-grid orography scheme which represents
        low-level blocking and orographic gravity wave effects. This
        parameter is a measure of how much the shape of the terrain
        in the horizontal plane (from a bird's-eye view) is
        distorted from a circle. A value of one is a circle, less
        than one an ellipse, and 0 is a ridge. In the case of a
        ridge, wind blowing parallel to it does not exert any drag
        on the flow, but wind blowing perpendicular to it exerts the
        maximum drag. This parameter does not vary in time.
      |||,
    },
    {
      name: 'benjamin_feir_index',
      units: units.dimensionless,
      description: |||
        This parameter is used to calculate the likelihood of freak
        ocean waves, which are waves that are higher than twice the
        mean height of the highest third of waves. Large values of
        this parameter (in practice of the order 1) indicate
        increased probability of the occurrence of freak waves. The
        ocean/sea surface wave field consists of a combination of
        waves with different heights, lengths and directions (known
        as the two-dimensional wave spectrum). This parameter is
        derived from the statistics of the two-dimensional wave
        spectrum. More precisely, it is the square of the ratio of
        the integral ocean wave steepness and the relative width of
        the frequency spectrum of the waves. Further information on
        the calculation of this parameter is given in Section 10.6
        of the ECMWF Wave Model documentation.
      |||,
    },
    {
      name: 'boundary_layer_dissipation',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the accumulated conversion of kinetic
        energy in the mean flow into heat, over the whole
        atmospheric column, per unit area, that is due to the
        effects of stress associated with turbulent eddies near the
        surface and turbulent orographic form drag. It is calculated
        by the ECMWF Integrated Forecasting System's turbulent
        diffusion and turbulent orographic form drag schemes. The
        turbulent eddies near the surface are related to the
        roughness of the surface. The turbulent orographic form drag
        is the stress due to the valleys, hills and mountains on
        horizontal scales below 5km, which are specified from land
        surface data at about 1 km resolution. (The dissipation
        associated with orographic features with horizontal scales
        between 5 km and the model grid-scale is accounted for by
        the sub-grid orographic scheme.) This parameter is
        accumulated over a particular time period which depends on
        the data extracted. For the reanalysis, the accumulation
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the accumulation period is over the 3 hours ending
        at the validity date and time.
      |||,
    },
    {
      name: 'boundary_layer_height',
      units: units.meter,
      description: |||
        This parameter is the depth of air next to the Earth's
        surface which is most affected by the resistance to the
        transfer of momentum, heat or moisture across the surface.
        The boundary layer height can be as low as a few tens of
        metres, such as in cooling air at night, or as high as
        several kilometres over the desert in the middle of a hot
        sunny day. When the boundary layer height is low, higher
        concentrations of pollutants (emitted from the Earth's
        surface) can develop. The boundary layer height calculation
        is based on the bulk Richardson number (a measure of the
        atmospheric conditions) following the conclusions of a 2012
        review.
      |||,
    },
    {
      name: 'charnock',
      units: units.dimensionless,
      description: |||
        This parameter accounts for increased aerodynamic roughness
        as wave heights grow due to increasing surface stress. It
        depends on the wind speed, wave age and other aspects of the
        sea state and is used to calculate how much the waves slow
        down the wind. When the atmospheric model is run without the
        ocean model, this parameter has a constant value of 0.018.
        When the atmospheric model is coupled to the ocean model,
        this parameter is calculated by the ECMWF Wave Model.
      |||,
    },
    {
      name: 'convective_available_potential_energy',
      units: units.joules_per_kg,
      description: |||
        This is an indication of the instability (or stability) of
        the atmosphere and can be used to assess the potential for
        the development of convection, which can lead to heavy
        rainfall, thunderstorms and other severe weather. In the
        ECMWF Integrated Forecasting System (IFS), CAPE is
        calculated by considering parcels of air departing at
        different model levels below the 350 hPa level. If a parcel
        of air is more buoyant (warmer and/or with more moisture)
        than its surrounding environment, it will continue to rise
        (cooling as it rises) until it reaches a point where it no
        longer has positive buoyancy. CAPE is the potential energy
        represented by the total excess buoyancy. The maximum CAPE
        produced by the different parcels is the value retained.
        Large positive values of CAPE indicate that an air parcel
        would be much warmer than its surrounding environment and
        therefore, very buoyant. CAPE is related to the maximum
        potential vertical velocity of air within an updraft; thus,
        higher values indicate greater potential for severe weather.
        Observed values in thunderstorm environments often may
        exceed 1000 joules per kilogram (J kg^-1), and in extreme
        cases may exceed 5000 J kg^-1. The calculation of this
        parameter assumes: (i) the parcel of air does not mix with
        surrounding air; (ii) ascent is pseudo-adiabatic (all
        condensed water falls out) and (iii) other simplifications
        related to the mixed-phase condensational heating.
      |||,
    },
    {
      name: 'convective_inhibition',
      units: units.joules_per_kg,
      description: |||
        This parameter is a measure of the amount of energy required
        for convection to commence. If the value of this parameter
        is too high, then deep, moist convection is unlikely to
        occur even if the convective available potential energy or
        convective available potential energy shear are large. CIN
        values greater than 200 J kg^-1 would be considered high. An
        atmospheric layer where temperature increases with height
        (known as a temperature inversion) would inhibit convective
        uplift and is a situation in which convective inhibition
        would be large.
      |||,
    },
    {
      name: 'duct_base_height',
      units: units.meter,
      description: |||
        Duct base height as diagnosed from the vertical gradient of
        atmospheric refractivity.
      |||,
    },
    {
      name: 'eastward_gravity_wave_surface_stress',
      units: units.pressure_per_second,
      description: |||
        Air flowing over a surface exerts a stress (drag) that
        transfers momentum to the surface and slows the wind. This
        parameter is the component of the accumulated surface stress
        in an eastward direction, associated with low-level,
        orographic blocking and orographic gravity waves. It is
        calculated by the ECMWF Integrated Forecasting System's
        sub-grid orography scheme, which represents stress due to
        unresolved valleys, hills and mountains with horizontal
        scales between 5 km and the model grid-scale. (The stress
        associated with orographic features with horizontal scales
        smaller than 5 km is accounted for by the turbulent
        orographic form drag scheme). Orographic gravity waves are
        oscillations in the flow maintained by the buoyancy of
        displaced air parcels, produced when air is deflected
        upwards by hills and mountains. This process can create
        stress on the atmosphere at the Earth's surface and at other
        levels in the atmosphere. Positive (negative) values
        indicate stress on the surface of the Earth in an eastward
        (westward) direction. This parameter is accumulated over a
        particular time period which depends on the data extracted.
        For the reanalysis, the accumulation period is over the 1
        hour ending at the validity date and time. For the ensemble
        members, ensemble mean and ensemble spread, the accumulation
        period is over the 3 hours ending at the validity date and
        time.
      |||,
    },
    {
      name: 'eastward_turbulent_surface_stress',
      units: units.pressure_per_second,
      description: |||
        Air flowing over a surface exerts a stress (drag) that
        transfers momentum to the surface and slows the wind. This
        parameter is the component of the accumulated surface stress
        in an eastward direction, associated with turbulent eddies
        near the surface and turbulent orographic form drag. It is
        calculated by the ECMWF Integrated Forecasting System's
        turbulent diffusion and turbulent orographic form drag
        schemes. The turbulent eddies near the surface are related
        to the roughness of the surface. The turbulent orographic
        form drag is the stress due to the valleys, hills and
        mountains on horizontal scales below 5km, which are
        specified from land surface data at about 1 km resolution.
        (The stress associated with orographic features with
        horizontal scales between 5 km and the model grid-scale is
        accounted for by the sub-grid orographic scheme.) Positive
        (negative) values indicate stress on the surface of the
        Earth in an eastward (westward) direction. This parameter is
        accumulated over a particular time period which depends on
        the data extracted. For the reanalysis, the accumulation
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the accumulation period is over the 3 hours ending
        at the validity date and time.
      |||,
    },
    {
      name: 'forecast_albedo',
      units: units.dimensionless,
      description: |||
        This parameter is a measure of the reflectivity of the
        Earth's surface. It is the fraction of short-wave (solar)
        radiation reflected by the Earth's surface, for diffuse
        radiation, assuming a fixed spectrum of downward short-wave
        radiation at the surface. The values of this parameter vary
        between zero and one. Typically, snow and ice have high
        reflectivity with albedo values of 0.8 and above, land has
        intermediate values between about 0.1 and 0.4 and the ocean
        has low values of 0.1 or less. Short-wave radiation from the
        Sun is partly reflected back to space by clouds and
        particles in the atmosphere (aerosols) and some of it is
        absorbed. The remainder is incident on the Earth's surface,
        where some of it is reflected. The portion that is reflected
        by the Earth's surface depends on the albedo. In the ECMWF
        Integrated Forecasting System (IFS), a climatological
        background albedo (observed values averaged over a period of
        several years) is used, modified by the model over water,
        ice and snow. Albedo is often shown as a percentage (%).
      |||,
    },
    {
      name: 'forecast_surface_roughness',
      units: units.meter,
      description: |||
        This parameter is the aerodynamic roughness length in
        metres. It is a measure of the surface resistance. This
        parameter is used to determine the air to surface transfer
        of momentum. For given atmospheric conditions, a higher
        surface roughness causes a slower near-surface wind speed.
        Over ocean, surface roughness depends on the waves. Over
        land, surface roughness is derived from the vegetation type
        and snow cover.
      |||,
    },
    {
      name: 'friction_velocity',
      units: units.velocity_si,
      description: |||
        Air flowing over a surface exerts a stress that transfers
        momentum to the surface and slows the wind. This parameter
        is a theoretical wind speed at the Earth's surface that
        expresses the magnitude of stress. It is calculated by
        dividing the surface stress by air density and taking its
        square root. For turbulent flow, the friction velocity is
        approximately constant in the lowest few metres of the
        atmosphere. This parameter increases with the roughness of
        the surface. It is used to calculate the way wind changes
        with height in the lowest levels of the atmosphere.
      |||,
    },
    {
      name: 'gravity_wave_dissipation',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the accumulated conversion of kinetic
        energy in the mean flow into heat, over the whole
        atmospheric column, per unit area, that is due to the
        effects of stress associated with low-level, orographic
        blocking and orographic gravity waves. It is calculated by
        the ECMWF Integrated Forecasting System's sub-grid orography
        scheme, which represents stress due to unresolved valleys,
        hills and mountains with horizontal scales between 5 km and
        the model grid-scale. (The dissipation associated with
        orographic features with horizontal scales smaller than 5 km
        is accounted for by the turbulent orographic form drag
        scheme). Orographic gravity waves are oscillations in the
        flow maintained by the buoyancy of displaced air parcels,
        produced when air is deflected upwards by hills and
        mountains. This process can create stress on the atmosphere
        at the Earth's surface and at other levels in the
        atmosphere. This parameter is accumulated over a particular
        time period which depends on the data extracted. For the
        reanalysis, the accumulation period is over the 1 hour
        ending at the validity date and time. For the ensemble
        members, ensemble mean and ensemble spread, the accumulation
        period is over the 3 hours ending at the validity date and
        time.
      |||,
    },
    {
      name: 'instantaneous_eastward_turbulent_surface_stress',
      units: units.pressure_si,
      description: |||
        Air flowing over a surface exerts a stress (drag) that
        transfers momentum to the surface and slows the wind. This
        parameter is the component of the surface stress at the
        specified time, in an eastward direction, associated with
        turbulent eddies near the surface and turbulent orographic
        form drag. It is calculated by the ECMWF Integrated
        Forecasting System's turbulent diffusion and turbulent
        orographic form drag schemes. The turbulent eddies near the
        surface are related to the roughness of the surface. The
        turbulent orographic form drag is the stress due to the
        valleys, hills and mountains on horizontal scales below 5km,
        which are specified from land surface data at about 1 km
        resolution. (The stress associated with orographic features
        with horizontal scales between 5 km and the model grid-scale
        is accounted for by the sub-grid orographic scheme.)
        Positive (negative) values indicate stress on the surface of
        the Earth in an eastward (westward) direction.
      |||,
    },
    {
      name: 'instantaneous_moisture_flux',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        This parameter is the net rate of moisture exchange between
        the land/ocean surface and the atmosphere, due to the
        processes of evaporation (including evapotranspiration) and
        condensation, at the specified time. By convention, downward
        fluxes are positive, which means that evaporation is
        represented by negative values and condensation by positive
        values.
      |||,
    },
    {
      name: 'instantaneous_northward_turbulent_surface_stress',
      units: units.pressure_si,
      description: |||
        Air flowing over a surface exerts a stress (drag) that
        transfers momentum to the surface and slows the wind. This
        parameter is the component of the surface stress at the
        specified time, in a northward direction, associated with
        turbulent eddies near the surface and turbulent orographic
        form drag. It is calculated by the ECMWF Integrated
        Forecasting System's turbulent diffusion and turbulent
        orographic form drag schemes. The turbulent eddies near the
        surface are related to the roughness of the surface. The
        turbulent orographic form drag is the stress due to the
        valleys, hills and mountains on horizontal scales below 5km,
        which are specified from land surface data at about 1 km
        resolution. (The stress associated with orographic features
        with horizontal scales between 5 km and the model grid-scale
        is accounted for by the sub-grid orographic scheme.)
        Positive (negative) values indicate stress on the surface of
        the Earth in a northward (southward) direction.
      |||,
    },
    {
      name: 'k_index',
      units: units.kelvin,
      description: |||
        This parameter is a measure of the potential for a
        thunderstorm to develop, calculated from the temperature and
        dew point temperature in the lower part of the atmosphere.
        The calculation uses the temperature at 850, 700 and 500 hPa
        and dewpoint temperature at 850 and 700 hPa. Higher values
        of K indicate a higher potential for the development of
        thunderstorms. This parameter is related to the probability
        of occurrence of a thunderstorm: <20 K No thunderstorm,
        20-25 K Isolated thunderstorms, 26-30 K Widely scattered
        thunderstorms, 31-35 K Scattered thunderstorms, >35 K
        Numerous thunderstorms.
      |||,
    },
    {
      name: 'land_sea_mask',
      units: units.dimensionless,
      description: |||
        This parameter is the proportion of land, as opposed to
        ocean or inland waters (lakes, reservoirs, rivers and
        coastal waters), in a grid box. This parameter has values
        ranging between zero and one and is dimensionless. In cycles
        of the ECMWF Integrated Forecasting System (IFS) from CY41R1
        (introduced in May 2015) onwards, grid boxes where this
        parameter has a value above 0.5 can be comprised of a
        mixture of land and inland water but not ocean. Grid boxes
        with a value of 0.5 and below can only be comprised of a
        water surface. In the latter case, the lake cover is used to
        determine how much of the water surface is ocean or inland
        water. In cycles of the IFS before CY41R1, grid boxes where
        this parameter has a value above 0.5 can only be comprised
        of land and those grid boxes with a value of 0.5 and below
        can only be comprised of ocean. In these older model cycles,
        there is no differentiation between ocean and inland water.
        This parameter does not vary in time.
      |||,
    },
    {
      name: 'mean_vertical_gradient_of_refractivity_inside_trapping_layer',
      units: units.reciprocal_metre,
      description: |||
        Mean vertical gradient of atmospheric refractivity inside
        the trapping layer.
      |||,
    },
    {
      name: 'minimum_vertical_gradient_of_refractivity_inside_trapping_layer',
      units: units.reciprocal_metre,
      description: |||
        Minimum vertical gradient of atmospheric refractivity inside
        the trapping layer.
      |||,
    },
    {
      name: 'northward_gravity_wave_surface_stress',
      units: units.pressure_per_second,
      description: |||
        Air flowing over a surface exerts a stress (drag) that
        transfers momentum to the surface and slows the wind. This
        parameter is the component of the accumulated surface stress
        in a northward direction, associated with low-level,
        orographic blocking and orographic gravity waves. It is
        calculated by the ECMWF Integrated Forecasting System's
        sub-grid orography scheme, which represents stress due to
        unresolved valleys, hills and mountains with horizontal
        scales between 5 km and the model grid-scale. (The stress
        associated with orographic features with horizontal scales
        smaller than 5 km is accounted for by the turbulent
        orographic form drag scheme). Orographic gravity waves are
        oscillations in the flow maintained by the buoyancy of
        displaced air parcels, produced when air is deflected
        upwards by hills and mountains. This process can create
        stress on the atmosphere at the Earth's surface and at other
        levels in the atmosphere. Positive (negative) values
        indicate stress on the surface of the Earth in a northward
        (southward) direction. This parameter is accumulated over a
        particular time period which depends on the data extracted.
        For the reanalysis, the accumulation period is over the 1
        hour ending at the validity date and time. For the ensemble
        members, ensemble mean and ensemble spread, the accumulation
        period is over the 3 hours ending at the validity date and
        time.
      |||,
    },
    {
      name: 'northward_turbulent_surface_stress',
      units: units.pressure_per_second,
      description: |||
        Air flowing over a surface exerts a stress (drag) that
        transfers momentum to the surface and slows the wind. This
        parameter is the component of the accumulated surface stress
        in a northward direction, associated with turbulent eddies
        near the surface and turbulent orographic form drag. It is
        calculated by the ECMWF Integrated Forecasting System's
        turbulent diffusion and turbulent orographic form drag
        schemes. The turbulent eddies near the surface are related
        to the roughness of the surface. The turbulent orographic
        form drag is the stress due to the valleys, hills and
        mountains on horizontal scales below 5km, which are
        specified from land surface data at about 1 km resolution.
        (The stress associated with orographic features with
        horizontal scales between 5 km and the model grid-scale is
        accounted for by the sub-grid orographic scheme.) Positive
        (negative) values indicate stress on the surface of the
        Earth in a northward (southward) direction. This parameter
        is accumulated over a particular time period which depends
        on the data extracted. For the reanalysis, the accumulation
        period is over the 1 hour ending at the validity date and
        time. For the ensemble members, ensemble mean and ensemble
        spread, the accumulation period is over the 3 hours ending
        at the validity date and time.
      |||,
    },
    {
      name: 'sea_ice_cover',
      units: units.dimensionless,
      description: |||
        This parameter is the fraction of a grid box which is
        covered by sea ice. Sea ice can only occur in a grid box
        which includes ocean or inland water according to the
        land-sea mask and lake cover, at the resolution being used.
        This parameter can be known as sea-ice (area) fraction,
        sea-ice concentration and more generally as sea-ice cover.
        In ERA5, sea-ice cover is given by two external providers.
        Before 1979 the HadISST2 dataset is used. From 1979 to
        August 2007 the OSI SAF (409a) dataset is used and from
        September 2007 the OSI SAF oper dataset is used. Sea ice is
        frozen sea water which floats on the surface of the ocean.
        Sea ice does not include ice which forms on land such as
        glaciers, icebergs and ice-sheets. It also excludes ice
        shelves which are anchored on land, but protrude out over
        the surface of the ocean. These phenomena are not modelled
        by the IFS. Long-term monitoring of sea ice is important for
        understanding climate change. Sea ice also affects shipping
        routes through the polar regions.
      |||,
    },
    {
      name: 'skin_reservoir_content',
      units: units.meter,
      description: |||
        This parameter is the amount of water in the vegetation
        canopy and/or in a thin layer on the soil. It represents the
        amount of rain intercepted by foliage, and water from dew.
        The maximum amount of "skin reservoir content" a grid box
        can hold depends on the type of vegetation, and may be zero.
        Water leaves the "skin reservoir" by evaporation.
      |||,
    },
    {
      name: 'slope_of_sub_gridscale_orography',
      units: units.dimensionless,
      description: |||
        This parameter is one of four parameters (the others being
        standard deviation, angle and anisotropy) that describe the
        features of the orography that are too small to be resolved
        by the model grid. These four parameters are calculated for
        orographic features with horizontal scales comprised between
        5 km and the model grid resolution, being derived from the
        height of valleys, hills and mountains at about 1 km
        resolution. They are used as input for the sub-grid
        orography scheme which represents low-level blocking and
        orographic gravity wave effects. This parameter represents
        the slope of the sub-grid valleys, hills and mountains. A
        flat surface has a value of 0, and a 45 degree slope has a
        value of 0.5. This parameter does not vary in time.
      |||,
    },
    {
      name: 'standard_deviation_of_filtered_subgrid_orography',
      units: units.meter,
      description: |||
        Climatological parameter (scales between approximately 3 and
        22 km are included). This parameter does not vary in time.
      |||,
    },
    {
      name: 'standard_deviation_of_orography',
      units: units.dimensionless,
      description: |||
        This parameter is one of four parameters (the others being
        angle of sub-gridscale orography, slope and anisotropy) that
        describe the features of the orography that are too small to
        be resolved by the model grid. These four parameters are
        calculated for orographic features with horizontal scales
        comprised between 5 km and the model grid resolution, being
        derived from the height of valleys, hills and mountains at
        about 1 km resolution. They are used as input for the
        sub-grid orography scheme which represents low-level
        blocking and orographic gravity wave effects. This parameter
        represents the standard deviation of the height of the
        sub-grid valleys, hills and mountains within a grid box.
        This parameter does not vary in time.
      |||,
    },
    {
      name: 'total_column_ozone',
      units: units.area_density,
      description: |||
        This parameter is the total amount of ozone in a column of
        air extending from the surface of the Earth to the top of
        the atmosphere. This parameter can also be referred to as
        total ozone, or vertically integrated ozone. The values are
        dominated by ozone within the stratosphere. In the ECMWF
        Integrated Forecasting System (IFS), there is a simplified
        representation of ozone chemistry (including representation
        of the chemistry which has caused the ozone hole). Ozone is
        also transported around in the atmosphere through the motion
        of air. Naturally occurring ozone in the stratosphere helps
        protect organisms at the surface of the Earth from the
        harmful effects of ultraviolet (UV) radiation from the Sun.
        Ozone near the surface, often produced because of pollution,
        is harmful to organisms. In the IFS, the units for total
        ozone are kilograms per square metre, but before 12/06/2001
        dobson units were used. Dobson units (DU) are still used
        extensively for total column ozone. 1 DU = 2.1415E-5 kg m^-2
      |||,
    },
    {
      name: 'total_column_supercooled_liquid_water',
      units: units.area_density,
      description: |||
        This parameter is the total amount of supercooled water in a
        column extending from the surface of the Earth to the top of
        the atmosphere. Supercooled water is water that exists in
        liquid form below 0oC. It is common in cold clouds and is
        important in the formation of precipitation. Also,
        supercooled water in clouds extending to the surface (i.e.,
        fog) can cause icing/riming of various structures. This
        parameter represents the area averaged value for a grid box.
        Clouds contain a continuum of different sized water droplets
        and ice particles. The ECMWF Integrated Forecasting System
        (IFS) cloud scheme simplifies this to represent a number of
        discrete cloud droplets/particles including: cloud water
        droplets, raindrops, ice crystals and snow (aggregated ice
        crystals). The processes of droplet formation, conversion
        and aggregation are also highly simplified in the IFS.
      |||,
    },
    {
      name: 'total_column_water',
      units: units.area_density,
      description: |||
        This parameter is the sum of water vapour, liquid water,
        cloud ice, rain and snow in a column extending from the
        surface of the Earth to the top of the atmosphere. In old
        versions of the ECMWF model (IFS), rain and snow were not
        accounted for.
      |||,
    },
    {
      name: 'total_column_water_vapour',
      units: units.area_density,
      description: |||
        This parameter is the total amount of water vapour in a
        column extending from the surface of the Earth to the top of
        the atmosphere. This parameter represents the area averaged
        value for a grid box.
      |||,
    },
    {
      name: 'total_totals_index',
      units: units.kelvin,
      description: |||
        This parameter gives an indication of the probability of
        occurrence of a thunderstorm and its severity by using the
        vertical gradient of temperature and humidity. The values of
        this index indicate the following: <44 Thunderstorms not
        likely, 44-50 Thunderstorms likely, 51-52 Isolated severe
        thunderstorms, 53-56 Widely scattered severe thunderstorms,
        56-60 Scattered severe thunderstorms more likely. The total
        totals index is the temperature difference between 850 hPa
        (near surface) and 500 hPa (mid-troposphere) (lapse rate)
        plus a measure of the moisture content between 850 hPa and
        500 hPa. The probability of deep convection tends to
        increase with increasing lapse rate and atmospheric moisture
        content. There are a number of limitations to this index.
        Also, the interpretation of the index value varies with
        season and location.
      |||,
    },
    {
      name: 'trapping_layer_base_height',
      units: units.meter,
      description: |||
        Trapping layer base height as diagnosed from the vertical
        gradient of atmospheric refractivity.
      |||,
    },
    {
      name: 'trapping_layer_top_height',
      units: units.meter,
      description: |||
        Trapping layer top height as diagnosed from the vertical
        gradient of atmospheric refractivity.
      |||,
    },
    {
      name: 'u_component_stokes_drift',
      units: units.velocity_si,
      description: |||
        This parameter is the eastward component of the surface
        Stokes drift. The Stokes drift is the net drift velocity due
        to surface wind waves. It is confined to the upper few
        metres of the ocean water column, with the largest value at
        the surface. For example, a fluid particle near the surface
        will slowly move in the direction of wave propagation.
      |||,
    },
    {
      name: 'v_component_stokes_drift',
      units: units.velocity_si,
      description: |||
        This parameter is the northward component of the surface
        Stokes drift. The Stokes drift is the net drift velocity due
        to surface wind waves. It is confined to the upper few
        metres of the ocean water column, with the largest value at
        the surface. For example, a fluid particle near the surface
        will slowly move in the direction of wave propagation.
      |||,
    },
    {
      name: 'vertical_integral_of_northward_total_energy_flux',
      units: units.watt_per_meter,
      description: |||
        This parameter is the horizontal rate of flow of total
        energy in the northward direction, per metre across the
        flow, for a column of air extending from the surface of the
        Earth to the top of the atmosphere. Positive values indicate
        a flux from south to north. Total atmospheric energy is made
        up of internal, potential, kinetic and latent energy. This
        parameter can be used to study the atmospheric energy
        budget.
      |||,
    },
    {
      name: 'vertical_integral_of_northward_water_vapour_flux',
      units: units.rainfall_rate_kg_per_m_per_s,
      description: |||
        This parameter is the horizontal rate of flow of water
        vapour, in the northward direction, per metre across the
        flow, for a column of air extending from the surface of the
        Earth to the top of the atmosphere. Positive values indicate
        a flux from south to north.
      |||,
    },
    {
      name: 'vertical_integral_of_potential_and_internal_energy',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the mass weighted vertical integral of
        potential and internal energy for a column of air extending
        from the surface of the Earth to the top of the atmosphere.
        The potential energy of an air parcel is the amount of work
        that would have to be done, against the force of gravity, to
        lift the air to that location from mean sea level. Internal
        energy is the energy contained within a system i.e., the
        microscopic energy of the air molecules, rather than the
        macroscopic energy associated with, for example, wind, or
        gravitational potential energy. This parameter can be used
        to study the atmospheric energy budget. Total atmospheric
        energy is made up of internal, potential, kinetic and latent
        energy.
      |||,
    },
    {
      name: 'vertical_integral_of_potential_internal_and_latent_energy',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the mass weighted vertical integral of
        potential, internal and latent energy for a column of air
        extending from the surface of the Earth to the top of the
        atmosphere. The potential energy of an air parcel is the
        amount of work that would have to be done, against the force
        of gravity, to lift the air to that location from mean sea
        level. Internal energy is the energy contained within a
        system i.e., the microscopic energy of the air molecules,
        rather than the macroscopic energy associated with, for
        example, wind, or gravitational potential energy. The latent
        energy refers to the energy associated with the water vapour
        in the atmosphere and is equal to the energy required to
        convert liquid water into water vapour. This parameter can
        be used to study the atmospheric energy budget. Total
        atmospheric energy is made up of internal, potential,
        kinetic and latent energy.
      |||,
    },
    {
      name: 'vertical_integral_of_temperature',
      units: units.kilo_kelvin,
      description: |||
        This parameter is the mass-weighted vertical integral of
        temperature for a column of air extending from the surface
        of the Earth to the top of the atmosphere. This parameter
        can be used to study the atmospheric energy budget.
      |||,
    },
    {
      name: 'vertical_integral_of_thermal_energy',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the mass-weighted vertical integral of
        thermal energy for a column of air extending from the
        surface of the Earth to the top of the atmosphere. Thermal
        energy is calculated from the product of temperature and the
        specific heat capacity of air at constant pressure. The
        thermal energy is equal to enthalpy, which is the sum of the
        internal energy and the energy associated with the pressure
        of the air on its surroundings. Internal energy is the
        energy contained within a system i.e., the microscopic
        energy of the air molecules, rather than the macroscopic
        energy associated with, for example, wind, or gravitational
        potential energy. The energy associated with the pressure of
        the air on its surroundings is the energy required to make
        room for the system by displacing its surroundings and is
        calculated from the product of pressure and volume. This
        parameter can be used to study the atmospheric energy
        budget. Total atmospheric energy is made up of internal,
        potential, kinetic and latent energy.
      |||,
    },
    {
      name: 'vertical_integral_of_total_energy',
      units: units.joules_per_meter2,
      description: |||
        This parameter is the vertical integral of total energy for
        a column of air extending from the surface of the Earth to
        the top of the atmosphere. Total atmospheric energy is made
        up of internal, potential, kinetic and latent energy. This
        parameter can be used to study the atmospheric energy
        budget.
      |||,
    },
    {
      name: 'vertically_integrated_moisture_divergence',
      units: units.area_density,
      description: |||
        The vertical integral of the moisture flux is the horizontal
        rate of flow of moisture (water vapour, cloud liquid and
        cloud ice), per metre across the flow, for a column of air
        extending from the surface of the Earth to the top of the
        atmosphere. Its horizontal divergence is the rate of
        moisture spreading outward from a point, per square metre.
        This parameter is accumulated over a particular time period
        which depends on the data extracted. For the reanalysis, the
        accumulation period is over the 1 hour ending at the
        validity date and time. For the ensemble members, ensemble
        mean and ensemble spread, the accumulation period is over
        the 3 hours ending at the validity date and time. This
        parameter is positive for moisture that is spreading out, or
        diverging, and negative for the opposite, for moisture that
        is concentrating, or converging (convergence). This
        parameter thus indicates whether atmospheric motions act to
        decrease (for divergence) or increase (for convergence) the
        vertical integral of moisture, over the time period. High
        negative values of this parameter (i.e. large moisture
        convergence) can be related to precipitation intensification
        and floods. 1 kg of water spread over 1 square metre of
        surface is 1 mm deep (neglecting the effects of temperature
        on the density of water), therefore the units are equivalent
        to mm.
      |||,
    },
    {
      name: 'volumetric_soil_water_layer_1',
      units: units.dimensionless,
      description: |||
        This parameter is the volume of water in soil layer 1 (0 -
        7cm, the surface is at 0cm). The ECMWF Integrated
        Forecasting System (IFS) has a four-layer representation of
        soil: Layer 1: 0 - 7cm, Layer 2: 7 - 28cm, Layer 3: 28 -
        100cm, Layer 4: 100 - 289cm. Soil water is defined over the
        whole globe, even over ocean. Regions with a water surface
        can be masked out by only considering grid points where the
        land-sea mask has a value greater than 0.5. The volumetric
        soil water is associated with the soil texture (or
        classification), soil depth, and the underlying groundwater
        level.
      |||,
    },
    {
      name: 'volumetric_soil_water_layer_2',
      units: units.dimensionless,
      description: |||
        This parameter is the volume of water in soil layer 2 (7 -
        28cm, the surface is at 0cm). The ECMWF Integrated
        Forecasting System (IFS) has a four-layer representation of
        soil: Layer 1: 0 - 7cm, Layer 2: 7 - 28cm, Layer 3: 28 -
        100cm, Layer 4: 100 - 289cm. Soil water is defined over the
        whole globe, even over ocean. Regions with a water surface
        can be masked out by only considering grid points where the
        land-sea mask has a value greater than 0.5. The volumetric
        soil water is associated with the soil texture (or
        classification), soil depth, and the underlying groundwater
        level.
      |||,
    },
    {
      name: 'volumetric_soil_water_layer_3',
      units: units.dimensionless,
      description: |||
        This parameter is the volume of water in soil layer 3 (28 -
        100cm, the surface is at 0cm). The ECMWF Integrated
        Forecasting System (IFS) has a four-layer representation of
        soil: Layer 1: 0 - 7cm, Layer 2: 7 - 28cm, Layer 3: 28 -
        100cm, Layer 4: 100 - 289cm. Soil water is defined over the
        whole globe, even over ocean. Regions with a water surface
        can be masked out by only considering grid points where the
        land-sea mask has a value greater than 0.5. The volumetric
        soil water is associated with the soil texture (or
        classification), soil depth, and the underlying groundwater
        level.
      |||,
    },
    {
      name: 'volumetric_soil_water_layer_4',
      units: units.dimensionless,
      description: |||
        This parameter is the volume of water in soil layer 4 (100 -
        289cm, the surface is at 0cm). The ECMWF Integrated
        Forecasting System (IFS) has a four-layer representation of
        soil: Layer 1: 0 - 7cm, Layer 2: 7 - 28cm, Layer 3: 28 -
        100cm, Layer 4: 100 - 289cm. Soil water is defined over the
        whole globe, even over ocean. Regions with a water surface
        can be masked out by only considering grid points where the
        land-sea mask has a value greater than 0.5. The volumetric
        soil water is associated with the soil texture (or
        classification), soil depth, and the underlying groundwater
        level.
      |||,
    },
    {
      name: 'wave_spectral_directional_width',
      units: units.radian,
      description: |||
        This parameter indicates whether waves (generated by local
        winds and associated with swell) are coming from similar
        directions or from a wide range of directions. The ocean/sea
        surface wave field consists of a combination of waves with
        different heights, lengths and directions (known as the
        two-dimensional wave spectrum). Many ECMWF wave parameters
        (such as the mean wave period) give information averaged
        over all wave frequencies and directions, so do not give any
        information about the distribution of wave energy across
        frequencies and directions. This parameter gives more
        information about the nature of the two-dimensional wave
        spectrum. This parameter is a measure of the range of wave
        directions for each frequency integrated across the
        two-dimensional spectrum. This parameter takes values
        between 0 and the square root of 2. Where 0 corresponds to a
        uni-directional spectrum (i.e., all wave frequencies from
        the same direction) and the square root of 2 indicates a
        uniform spectrum (i.e., all wave frequencies from a
        different direction).
      |||,
    },
    {
      name: 'wave_spectral_directional_width_for_swell',
      units: units.radian,
      description: |||
        This parameter indicates whether waves associated with swell
        are coming from similar directions or from a wide range of
        directions. The ocean/sea surface wave field consists of a
        combination of waves with different heights, lengths and
        directions (known as the two-dimensional wave spectrum). The
        wave spectrum can be decomposed into wind-sea waves, which
        are directly affected by local winds, and swell, the waves
        that were generated by the wind at a different location and
        time. This parameter takes account of all swell only. Many
        ECMWF wave parameters (such as the mean wave period) give
        information averaged over all wave frequencies and
        directions, so do not give any information about the
        distribution of wave energy across frequencies and
        directions. This parameter gives more information about the
        nature of the two-dimensional wave spectrum. This parameter
        is a measure of the range of wave directions for each
        frequency integrated across the two-dimensional spectrum.
        This parameter takes values between 0 and the square root of
        2. Where 0 corresponds to a uni-directional spectrum (i.e.,
        all wave frequencies from the same direction) and the square
        root of 2 indicates a uniform spectrum (i.e., all wave
        frequencies from a different direction).
      |||,
    },
    {
      name: 'wave_spectral_directional_width_for_wind_waves',
      units: units.radian,
      description: |||
        This parameter indicates whether waves generated by the
        local wind are coming from similar directions or from a wide
        range of directions. The ocean/sea surface wave field
        consists of a combination of waves with different heights,
        lengths and directions (known as the two-dimensional wave
        spectrum). The wave spectrum can be decomposed into wind-sea
        waves, which are directly affected by local winds, and
        swell, the waves that were generated by the wind at a
        different location and time. This parameter takes account of
        wind-sea waves only. Many ECMWF wave parameters (such as the
        mean wave period) give information averaged over all wave
        frequencies and directions, so do not give any information
        about the distribution of wave energy across frequencies and
        directions. This parameter gives more information about the
        nature of the two-dimensional wave spectrum. This parameter
        is a measure of the range of wave directions for each
        frequency integrated across the two-dimensional spectrum.
        This parameter takes values between 0 and the square root of
        2. Where 0 corresponds to a uni-directional spectrum (i.e.,
        all wave frequencies from the same direction) and the square
        root of 2 indicates a uniform spectrum (i.e., all wave
        frequencies from a different direction).
      |||,
    },
    {
      name: 'wave_spectral_kurtosis',
      units: units.dimensionless,
      description: |||
        This parameter is a statistical measure used to forecast
        extreme or freak ocean/sea waves. It describes the nature of
        the sea surface elevation and how it is affected by waves
        generated by local winds and associated with swell. Under
        typical conditions, the sea surface elevation, as described
        by its probability density function, has a near normal
        distribution in the statistical sense. However, under
        certain wave conditions the probability density function of
        the sea surface elevation can deviate considerably from
        normality, signalling increased probability of freak waves.
        This parameter gives one measure of the deviation from
        normality. It shows how much of the probability density
        function of the sea surface elevation exists in the tails of
        the distribution. So, a positive kurtosis (typical range 0.0
        to 0.06) means more frequent occurrences of very extreme
        values (either above or below the mean), relative to a
        normal distribution.
      |||,
    },
    {
      name: 'wave_spectral_peakedness',
      units: units.dimensionless,
      description: |||
        This parameter is a statistical measure used to forecast
        extreme or freak waves. It is a measure of the relative
        width of the ocean/sea wave frequency spectrum (i.e.,
        whether the ocean/sea wave field is made up of a narrow or
        broad range of frequencies). The ocean/sea surface wave
        field consists of a combination of waves with different
        heights, lengths and directions (known as the
        two-dimensional wave spectrum). When the wave field is more
        focussed around a narrow range of frequencies, the
        probability of freak/extreme waves increases. This parameter
        is Goda's peakedness factor and is used to calculate the
        Benjamin-Feir Index (BFI). The BFI is in turn used to
        estimate the probability and nature of extreme/freak waves.
      |||,
    },
    {
      name: 'wave_spectral_skewness',
      units: units.dimensionless,
      description: |||
        This parameter is a statistical measure used to forecast
        extreme or freak ocean/sea waves. It describes the nature of
        the sea surface elevation and how it is affected by waves
        generated by local winds and associated with swell. Under
        typical conditions, the sea surface elevation, as described
        by its probability density function, has a near normal
        distribution in the statistical sense. However, under
        certain wave conditions the probability density function of
        the sea surface elevation can deviate considerably from
        normality, signalling increased probability of freak waves.
        This parameter gives one measure of the deviation from
        normality. It is a measure of the asymmetry of the
        probability density function of the sea surface elevation.
        So, a positive/negative skewness (typical range -0.2 to
        0.12) means more frequent occurrences of extreme values
        above/below the mean, relative to a normal distribution.
      |||,
    },
    {
      name: 'zero_degree_level',
      units: units.meter,
      description: |||
        The height above the Earth's surface where the temperature
        passes from positive to negative values, corresponding to
        the top of a warm layer, at the specified time. This
        parameter can be used to help forecast snow. If more than
        one warm layer is encountered, then the zero degree level
        corresponds to the top of the second atmospheric layer. This
        parameter is set to zero when the temperature in the whole
        atmosphere is below 0&deg;C.
      |||,
    },
    {
      name: 'wind_gust_since_previous_post_processing_10m',
      units: units.velocity_si,
      description: |||
        Maximum 3 second wind at 10 m height as defined by WMO.
        Parametrization represents turbulence only before 01102008;
        thereafter effects of convection are included. The 3 s gust
        is computed every time step and and the maximum is kept
        since the last postprocessing.
      |||,
    },
    {
      name: 'geopotential',
      units: units.squared_meter_per_squared_second,
      description: |||
        This parameter is the gravitational potential energy of a
        unit mass, at a particular location at the surface of the
        Earth, relative to mean sea level. It is also the amount of
        work that would have to be done, against the force of
        gravity, to lift a unit mass to that location from mean sea
        level. The (surface) geopotential height (orography) can be
        calculated by dividing the (surface) geopotential by the
        Earth's gravitational acceleration, g (=9.80665 m s^-2 ).
        This parameter does not vary in time.
      |||,
    },
    {
      name: 'maximum_2m_temperature_since_previous_post_processing',
      units: units.kelvin,
      description: |||
        This parameter is the highest temperature of air at 2m above
        the surface of land, sea or inland water since the parameter
        was last archived in a particular forecast. 2m temperature
        is calculated by interpolating between the lowest model
        level and the Earth's surface, taking account of the
        atmospheric conditions.
      |||,
    },
    {
      name: 'maximum_total_precipitation_rate_since_previous_post_processing',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        The total precipitation is calculated from the combined
        large-scale and convective rainfall and snowfall rates every
        time step and the maximum is kept since the last
        postprocessing.
      |||,
    },
    {
      name: 'minimum_2m_temperature_since_previous_post_processing',
      units: units.kelvin,
      description: |||
        This parameter is the lowest temperature of air at 2m above
        the surface of land, sea or inland waters since the
        parameter was last archived in a particular forecast. 2m
        temperature is calculated by interpolating between the
        lowest model level and the Earth's surface, taking account
        of the atmospheric conditions. See further information.
      |||,
    },
    {
      name: 'minimum_total_precipitation_rate_since_previous_post_processing',
      units: units.rainfall_rate_kg_per_m2_per_s,
      description: |||
        The total precipitation is calculated from the combined
        large-scale and convective rainfall and snowfall rates every
        time step and the minimum is kept since the last
        postprocessing.
      |||,
    },
    {
      name: 'divergence_500hPa',
      description: 'The divergence of the wind at the 500hPa pressure level.',
      units: units.rainfall_rate_kg_per_m2_per_s,
    },
    {
      name: 'divergence_850hPa',
      description: 'The divergence of the wind at the 850hPa pressure level.',
      units: units.rainfall_rate_kg_per_m2_per_s,
    },
    {
      name: 'fraction_of_cloud_cover_500hPa',
      description: 'The fraction of cloud cover at the 500hPa pressure level.',
      units: units.dimensionless
    },
    {
      name: 'fraction_of_cloud_cover_850hPa',
      description: 'The fraction of cloud cover at the 850hPa pressure level.',
      units: units.dimensionless
    },
    {
      name: 'ozone_mass_mixing_ratio_500hPa',
      description: |||
        The mass mixing ratio of ozone at the 500hPa pressure level.
      |||,
      units: units.dimensionless
    },
    {
      name: 'ozone_mass_mixing_ratio_850hPa',
      description: |||
        The mass mixing ratio of ozone at the 850hPa pressure level.
      |||,
      units: units.dimensionless
    },
    {
      name: 'potential_vorticity_500hPa',
      description: 'The potential vorticity at the 500hPa pressure level.',
      units: units.pvu,
    },
    {
      name: 'potential_vorticity_850hPa',
      description: 'The potential vorticity at the 850hPa pressure level.',
      units: units.pvu,
    },
    {
      name: 'relative_humidity_500hPa',
      description: 'The relative humidity at the 500hPa pressure level.',
      units: units.percent,
    },
    {
      name: 'relative_humidity_850hPa',
      description: 'The relative humidity at the 850hPa pressure level.',
      units: units.percent,
    },
    {
      name: 'specific_cloud_ice_water_content_500hPa',
      description: |||
        The specific cloud ice water content at the 500hPa pressure level.
      |||,
      units: units.dimensionless,
    },
    {
      name: 'specific_cloud_ice_water_content_850hPa',
      description: |||
        The specific cloud ice water content at the 850hPa pressure level.
      |||,
      units: units.dimensionless,
    },
    {
      name: 'specific_cloud_liquid_water_content_500hPa',
      description: |||
        The specific cloud liquid water content at the 500hPa pressure level.
      |||,
      units: units.dimensionless,
    },
    {
      name: 'specific_cloud_liquid_water_content_850hPa',
      description: |||
        The specific cloud liquid water content at the 850hPa pressure level.
      |||,
      units: units.dimensionless,
    },
    {
      name: 'specific_humidity_500hPa',
      description: 'The specific humidity at the 500hPa pressure level.',
      units: units.dimensionless,
    },
    {
      name: 'specific_humidity_850hPa',
      description: 'The specific humidity at the 850hPa pressure level.',
      units: units.dimensionless,
    },
    {
      name: 'specific_rain_water_content_500hPa',
      description: |||
        The specific rain water content at the 500hPa pressure level.
      |||,
      units: units.dimensionless,
    },
    {
      name: 'specific_rain_water_content_850hPa',
      description: |||
        The specific rain water content at the 850hPa pressure level.
      |||,
      units: units.dimensionless,
    },
    {
      name: 'specific_snow_water_content_500hPa',
      description: |||
        The specific snow water content at the 500hPa pressure level.
      |||,
      units: units.dimensionless,
    },
    {
      name: 'specific_snow_water_content_850hPa',
      description: |||
        The specific snow water content at the 850hPa pressure level.
      |||,
      units: units.dimensionless,
    },
    {
      name: 'temperature_500hPa',
      description: 'The temperature at the 500hPa pressure level.',
      units: units.kelvin,
    },
    {
      name: 'temperature_850hPa',
      description: 'The temperature at the 850hPa pressure level.',
      units: units.kelvin,
    },
    {
      name: 'u_component_of_wind_500hPa',
      description: |||
        The eastward component of the wind at the 500hPa pressure level.
      |||,
      units: units.velocity_si,
    },
    {
      name: 'u_component_of_wind_850hPa',
      description: |||
        The eastward component of the wind at the 850hPa pressure level.
      |||,
      units: units.velocity_si,
    },
    {
      name: 'v_component_of_wind_500hPa',
      description: |||
        The northward component of the wind at the 500hPa pressure level.
      |||,
      units: units.velocity_si,
    },
    {
      name: 'v_component_of_wind_850hPa',
      description: |||
        The northward component of the wind at the 850hPa pressure level.
      |||,
      units: units.velocity_si,
    },
    {
      name: 'vertical_velocity_500hPa',
      description: 'The vertical velocity at the 500hPa pressure level.',
      units: units.pascal_per_second,
    },
    {
      name: 'vertical_velocity_850hPa',
      description: 'The vertical velocity at the 850hPa pressure level.',
      units: units.pascal_per_second,
    },
    {
      name: 'vorticity_500hPa',
      description: 'The vorticity of the wind at the 500hPa pressure level.',
      units: units.pvu,
    },
    {
      name: 'vorticity_850hPa',
      description: 'The vorticity of the wind at the 850hPa pressure level.',
      units: units.pvu,
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
      display_name: 'Mean Sea Level Pressure',
      lookat: {
        lat: 21.2,
        lon: 22.2,
        zoom: 1,
      },
      image_visualization: {
        band_vis: {
          min: [
            95000.0,
          ],
          max: [
            105000.0,
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
            'mean_sea_level_pressure',
          ],
        },
      },
    },
    {
      display_name: 'Total Precipitation',
      lookat: {
        lat: 21.2,
        lon: 22.2,
        zoom: 1,
      },
      image_visualization: {
        band_vis: {
          min: [0.0],
          max: [0.01],
          palette: [
            'ffffff',
            '00ffff',
            '0080ff',
            'da00ff',
            'ffa400',
            'ff0000',
          ],
          bands: ['total_precipitation'],
        },
      },
    },
  ],
  citation: |||
    Hersbach, H., Bell, B., Berrisford, P., Hirahara, S., Horanyi, A., Munoz-Sabater, J., ... & Thepaut, J. N. (2020). The ERA5 global reanalysis. Quarterly Journal of the Royal Meteorological Society, 146(730), 1999-2049.
  |||,
  terms_of_use: |||
    Please acknowledge the use of ERA5 as stated in the [Copernicus C3S/CAMS License agreement](https://apps.ecmwf.int/datasets/licences/copernicus/).
  |||,
}
