local id = 'NOAA/GFS0P25';
local subdir = 'NOAA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'GFS: Global Forecast System 384-Hour Predicted Atmosphere Data',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Global Forecast System (GFS) is a weather forecast model produced by
    the National Centers for Environmental Prediction (NCEP). The GFS dataset
    consists of selected model outputs (described below) as gridded forecast
    variables. The 384-hour forecasts, with 1-hour (up to 120 hours)
    and 3-hour (after 120 hours) forecast intervals, are made at 6-hour temporal
    resolution (i.e. updated four times daily). Use the 'creation_time' and
    'forecast_time' properties to select data of interest.

    The GFS is a coupled model, composed of an atmosphere model, an ocean model,
    a land/soil model, and a sea ice model which work together to provide an
    accurate picture of weather conditions. Note that this model may change;
    see [history of recent modifications to the global forecast/analysis system](https://www.emc.ncep.noaa.gov/gmb/STATS/html/model_changes.html)
    and the [documentation](https://www.emc.ncep.noaa.gov/emc/pages/numerical_forecast_systems/gfs.php)
    for more information. There may be significant hour-to-hour and day-to-day
    fluctuations that require noise-reduction techniques to be applied to bands
    before analysis.

    Note that the available forecast hours and intervals have also changed:

    * From 2015/04/01-2017/07/09: 36-hour forecasts, excluding hour 0, at
    3-hour intervals.
    * From 2017/07/09-2021/06/11: 384-hour forecasts, at 1-hour intervals from
    hours 0-120, at 3-hour intervals from hours 120-240, and 12-hour intervals
    from hours 240-384.
    * From 2021/06/12: 384-hour forecasts, at 1-hour intervals from hours 0-120
    and 3-hour intervals from hours 120-384.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'climate',
    'cloud',
    'emc',
    'flux',
    'forecast',
    'geophysical',
    'gfs',
    'humidity',
    'ncep',
    'noaa',
    'precipitation',
    'radiation',
    'temperature',
    'vapor',
    'weather',
    'wind',
  ],
  providers: [
    ee.producer_provider('NOAA/NCEP/EMC', 'https://www.ncdc.noaa.gov/data-access/model-data/model-datasets/global-forcast-system-gfs'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2015-07-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'creation_time',
        description: 'Time of creation',
        type: ee_const.var_type.double,
      },
      {
        name: 'forecast_hours',
        description: 'Forecast hours',
        type: ee_const.var_type.double,
      },
      {
        name: 'forecast_time',
        description: 'Forecast time',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      27830.0,
    ],
    'eo:bands': [
      {
        name: 'temperature_2m_above_ground',
        description: 'Temperature 2m above ground',
        'gee:units': units.celsius,
      },
      {
        name: 'specific_humidity_2m_above_ground',
        description: 'Specific humidity 2m above ground',
        'gee:units': units.mass_fraction,
      },
      {
        name: 'relative_humidity_2m_above_ground',
        description: 'Relative humidity 2m above ground',
        'gee:units': units.percent,
      },
      {
        name: 'u_component_of_wind_10m_above_ground',
        description: 'U component of wind 10m above ground',
        'gee:units': units.velocity_si,
      },
      {
        name: 'v_component_of_wind_10m_above_ground',
        description: 'V component of wind 10m above ground',
        'gee:units': units.velocity_si,
      },
      {
        name: 'total_precipitation_surface',
        description: |||
          Cumulative precipitation at surface for the previous 1-6 hours,
          depending on the value of the "forecast_hours" property according to
          the formula ((F - 1) % 6) + 1 (and only for assets with
          forecast_hours > 0).

          As a consequence, to calculate the total precipitation by hour X,
          double-counting should be avoided by only summing the values for
          forecast_hours that are multiples of 6 plus any remainder to reach
          X. It also means that to determine the precipitation for just hour
          X, one must subtract the value for the preceding hour unless X is the
          first hour in a 6-hour window.
        |||,
        'gee:units': units.area_density,
      },
      {
        name: 'precipitable_water_entire_atmosphere',
        description: 'Precipitable water for entire atmosphere',
        'gee:units': units.area_density,
      },
      {
        name: 'total_cloud_cover_entire_atmosphere',
        description: 'Total cloud cover for entire atmosphere (only for assets with forecast_hours > 0)',
        'gee:units': units.percent,
      },
      {
        name: 'downward_shortwave_radiation_flux',
        description: 'Downward shortwave radiation flux (only for assets with forecast_hours > 0)',
        'gee:units': units.watt_per_meter_squared,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Temperature Above Ground',
        lookat: {
          lat: 52.48,
          lon: 71.72,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              -40.0,
            ],
            max: [
              35.0,
            ],
            palette: [
              'blue',
              'purple',
              'cyan',
              'green',
              'yellow',
              'red',
            ],
            bands: [
              'temperature_2m_above_ground',
            ],
          },
        },
      },
    ],
    temperature_2m_above_ground: {
      minimum: -69.18,
      maximum: 52.25,
      'gee:estimated_range': true,
    },
    specific_humidity_2m_above_ground: {
      minimum: 0.0,
      maximum: 0.03,
      'gee:estimated_range': true,
    },
    relative_humidity_2m_above_ground: {
      minimum: 1.0,
      maximum: 100.05,
      'gee:estimated_range': true,
    },
    u_component_of_wind_10m_above_ground: {
      minimum: -60.73,
      maximum: 59.28,
      'gee:estimated_range': true,
    },
    v_component_of_wind_10m_above_ground: {
      minimum: -63.78,
      maximum: 59.39,
      'gee:estimated_range': true,
    },
    total_precipitation_surface: {
      minimum: 0.0,
      maximum: 626.75,
      'gee:estimated_range': true,
    },
    precipitable_water_entire_atmosphere: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
    total_cloud_cover_entire_atmosphere: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
    downward_shortwave_radiation_flux: {
      minimum: 0.0,
      maximum: 1230.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': 'Alpert, J., 2006 Sub-Grid Scale Mountain Blocking at NCEP, 20th Conf.\nWAF/16 Conf. NWP P2.4.',
  'sci:publications': [
    {
      citation: |||
        Alpert, J. C., S-Y. Hong and Y-J. Kim: 1996, Sensitivity of cyclogenesis
        to lower troposphere enhancement of gravity wave drag using the EMC MRF",
        Proc. 11 Conf. On NWP, Norfolk, 322-323.
      |||,
    },
    {
      citation: |||
        Alpert,J,, M. Kanamitsu, P. M. Caplan, J. G. Sela, G. H. White, and
        E. Kalnay, 1988: Mountain induced gravity wave drag parameterization in
        the NMC medium-range forecast model. Pre-prints, Eighth Conf. on
        Numerical Weather Prediction, Baltimore, MD, Amer. Meteor. Soc., 726-733.
      |||,
    },
    {
      citation: |||
        Buehner, M., J. Morneau, and C. Charette, 2013: Four-dimensional
         ensemble-variational data assimilation for global deterministic weather
         prediction. Nonlinear Processes Geophys., 20, 669-682.
      |||,
    },
    {
      citation: |||
        Chun, H.-Y., and J.-J. Baik, 1998: Momentum Flux by Thermally Induced
        Internal Gravity Waves and Its Approximation for Large-Scale Models.
        J. Atmos. Sci., 55, 3299-3310.
      |||,
    },
    {
      citation: |||
        Chun, H.-Y., Song, I.-S., Baik, J.-J. and Y.-J. Kim. 2004: Impact of a
        Convectively Forced Gravity Wave Drag Parameterization in NCAR CCM3.
        J. Climate, 17, 3530-3547.
      |||,
    },
    {
      citation: |||
        Chun, H.-Y., Song, M.-D., Kim, J.-W., and J.-J. Baik, 2001: Effects of
        Gravity Wave Drag Induced by Cumulus Convection on the Atmospheric General
        Circulation. J. Atmos. Sci., 58, 302-319.
      |||,
    },
    {
      citation: |||
        Clough, S.A., M.W. Shephard, E.J. Mlawer, J.S. Delamere, M.J. Iacono,
        K.Cady-Pereira, S. Boukabara, and P.D. Brown, 2005: Atmospheric radiative
        transfer modeling: A summary of the AER codes, J. Quant. Spectrosc. Radiat.
        Transfer, 91, 233-244.
        [doi:10.1016/j.jqsrt.2004.05.058](https://doi.org/10.1016/j.jqsrt.2004.05.058)
      |||,
      doi: '10.1016/j.jqsrt.2004.05.058',
    },
    {
      citation: |||
        Ebert, E.E., and J.A. Curry, 1992: A parameterization of ice cloud optical
        properties for climate models. J. Geophys. Res., 97, 3831-3836.
      |||,
    },
    {
      citation: |||
        Fu, Q., 1996: An Accurate Parameterization of the Solar Radiative
        Properties of Cirrus Clouds for Climate Models. J. Climate, 9, 2058-2082.
      |||,
    },
    {
      citation: |||
        Han, J., and H.-L. Pan, 2006: Sensitivity of hurricane intensity forecast
        to convective momentum transport parameterization. Mon. Wea. Rev.,
        134, 664-674.
      |||,
    },
    {
      citation: |||
        Han, J., and H.-L. Pan, 2011: Revision of convection and vertical
        diffusion schemes in the NCEP global forecast system. Weather and
        Forecasting, 26, 520-533.
      |||,
    },
    {
      citation: |||
        Han, J., M. Witek, J. Teixeira, R. Sun, H.-L. Pan, J. K. Fletcher,
        and C. S. Bretherton, 2016: Implementation in the NCEP GFS of a hybrid
        eddy-diffusivity mass-flux (EDMF) boundary layer parameterization with
        dissipative heating and modified stable boundary layer mixing. Weather
        and Forecasting, 31, 341-352.
      |||,
    },
    {
      citation: |||
        Hou, Y., S. Moorthi and K. Campana, 2002: Parameterization of Solar
        Radiation Transfer in the NCEP Models, NCEP Office Note #441, pp46.
        [Available here](https://www.emc.ncep.noaa.gov/officenotes/newernotes/on441.pdf)
      |||,
    },
    {
      citation: |||
        Hu, Y.X., and K. Stamnes, 1993: An accurate parameterization of the
        radiative properties of water clouds suitable for use in climate models.
        J. Climate, 6, 728-74.
      |||,
    },
    {
      citation: |||
        Iacono, M.J., E.J. Mlawer, S.A. Clough, and J.-J. Morcrette, 2000: Impact
        of an improved longwave radiation model, RRTM, on the energy budget and
        thermodynamic properties of the NCAR community climate model, CCM3,
        J. Geophys. Res., 105(D11), 14,873-14,890.2.
      |||,
    },
    {
      citation: |||
        Johansson, Ake, 2008: Convectively Forced Gravity Wave Drag in the NCEP
        Global Weather and Climate Forecast Systems, SAIC/Environmental Modelling
        Center internal report.
      |||,
    },
    {
      citation: |||
        Juang, H-M, et al. 2014:Regional Spectral Model workshop in memory of
        John Roads and Masao Kanamitsu, BAMS, A. Met. Soc, ES61-ES65.
      |||,
    },
    {
      citation: |||
        Kim, Y.-J., and A. Arakawa (1995), Improvement of orographic gravity wave
        parameterization using a mesoscale gravity-wave model, J. Atmos. Sci.,52,
        875-1902.
      |||,
    },
    {
      citation: |||
        Kleist, D. T., 2012: An evaluation of hybrid variational-ensemble data
        assimilation for the NCEP GFS , Ph.D. Thesis, Dept. of Atmospheric and
        Oceanic Science, University of Maryland-College Park, 149 pp.
      |||,
    },
    {
      citation: |||
        Lott, F and M. J. Miller: 1997, "A new subgrid-scale orographic drag
        parameterization: Its formulation and testing", QJRMS, 123, pp101-127.
      |||,
    },
    {
      citation: |||
        Mlawer, E.J., S.J. Taubman, P.D. Brown, M.J. Iacono, and S.A. Clough,
        1997: Radiative transfer for inhomogeneous atmospheres: RRTM, a validated
        correlated-k model for the longwave. J. Geophys. Res., 102, 16663-16682.
      |||,
    },
    {
      citation: |||
        Sela, J., 2009: The implementation of the sigma-pressure hybrid coordinate
        into the GFS. NCEP Office Note #461, pp25.
      |||,
    },
    {
      citation: |||
        Sela, J., 2010: The derivation of sigmapressure hybrid coordinate
        semi-Lagrangian model equations for the GFS. NCEP Office Note #462 pp31.
      |||,
    },
    {
      citation: |||
        Yang, F., 2009: On the Negative Water Vapor in the NCEP GFS: Sources and
        Solution. 23rd Conference on Weather Analysis and Forecasting/19th
        Conference on Numerical Weather Prediction, 1-5 June 2009, Omaha, NE.
      |||,
    },
    {
      citation: |||
        Yang, F., K. Mitchell, Y. Hou, Y. Dai, X. Zeng, Z. Wang, and X. Liang,
        2008: Dependence of land surface albedo on solar zenith angle: observations
        and model parameterizations. Journal of Applied Meteorology and
        Climatology.No.11, Vol 47, 2963-2982.
      |||,
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'hour',
    interval: 6,
  },
  'gee:terms_of_use': |||
    NOAA data, information, and products, regardless of the method of delivery,
    are not subject to copyright and carry no restrictions on their subsequent
    use by the public. Once obtained, they may be put to any lawful use. The
    forgoing data is in the public domain and is being provided without
    restriction on use and distribution.
  |||,
}
