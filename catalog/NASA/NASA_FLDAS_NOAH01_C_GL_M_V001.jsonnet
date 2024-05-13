local id = 'NASA/FLDAS/NOAH01/C/GL/M/V001';
local subdir = 'NASA';

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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'FLDAS: Famine Early Warning Systems Network (FEWS NET) Land Data Assimilation System',
  version: 'V001',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The FLDAS dataset (McNally et al. 2017), was designed to assist with food
    security assessments in data-sparse, developing country settings. It
    includes information on many climate-related variables including moisture
    content, humidity, evapotranspiration, average soil temperature, total
    precipitation rate, etc.

    There are multiple different FLDAS datasets; this one uses Noah version
    3.6.1 surface model with CHIRPS-6 hourly rainfall that has been
    downscaled using the [NASA Land Surface Data Toolkit](https://lis.gsfc.nasa.gov/software/ldt).
    which is part of the [Land Information System
    framework](LIS; [https://lis.gsfc.nasa.gov/](https://lis.gsfc.nasa.gov/)). Temporal desegregation is required so that daily
    rainfall inputs can be used in both energy and water balance calculations

    For forcing data, this simulation uses a combination of the new version of Modern-Era
    Retrospective analysis for Research and Applications version 2 (MERRA-2) data and Climate
    Hazards Group InfraRed Precipitation with Station data (CHIRPS), a quasi-global rainfall
    dataset designed for seasonal drought monitoring and trend analysis (Funk et al., 2015).

    Documentation:

    * [Readme](https://hydro1.gesdisc.eosdis.nasa.gov/data/FLDAS/FLDAS_NOAH01_C_GL_M.001/doc/README_FLDAS.pdf)

    * [How-to](https://disc.gsfc.nasa.gov/information/howto?tags=hydrology)

    * [GES DISC Hydrology Documentation](https://disc.gsfc.nasa.gov/information/documents?title=Hydrology%20Documentation)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.source,
      href: 'https://hydro1.gesdisc.eosdis.nasa.gov/data/FLDAS/FLDAS_NOAH01_C_GL_M.001/',
    },
  ],
  keywords: [
    'climate',
    'evapotranspiration',
    'famine',
    'fldas',
    'humidity',
    'ldas',
    'monthly',
    'nasa',
    'runoff',
    'snow',
    'soil_moisture',
    'soil_temperature',
    'temperature',
    'wind',
  ],
  providers: [
    ee.producer_provider('NASA GES DISC at NASA Goddard Space Flight Center', 'https://doi.org/10.5067/5NHC22T9375G'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1563089663-GES_DISC',
  ],
  extent: ee.extent(-180.0, -60.0, 180.0, 90.0, '1982-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      11132.0,
    ],
    'eo:bands': [
      {
        name: 'Evap_tavg',
        description: 'Evapotranspiration',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'LWdown_f_tavg',
        description: 'Downward longwave radiation flux',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'Lwnet_tavg',
        description: 'Net longwave radiation flux',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'Psurf_f_tavg',
        description: 'Surface pressure',
        'gee:units': units.pascal,
      },
      {
        name: 'Qair_f_tavg',
        description: 'Specific humidity',
        'gee:units': units.mass_fraction,
      },
      {
        name: 'Qg_tavg',
        description: 'Soil heat flux',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'Qh_tavg',
        description: 'Sensible heat net flux',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'Qle_tavg',
        description: 'Latent heat net flux',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'Qs_tavg',
        description: 'Storm surface runoff',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'Qsb_tavg',
        description: 'Baseflow-groundwater runoff',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'RadT_tavg',
        description: 'Surface radiative temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'Rainf_f_tavg',
        description: 'Total precipitation rate',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'SnowCover_inst',
        description: 'Snow cover fraction',
      },
      {
        name: 'SnowDepth_inst',
        description: 'Snow depth',
        'gee:units': units.meter,
      },
      {
        name: 'Snowf_tavg',
        description: 'Snowfall rate',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'SoilMoi00_10cm_tavg',
        description: 'Soil moisture (0 - 10 cm underground)',
        'gee:units': units.volume_fraction,
      },
      {
        name: 'SoilMoi10_40cm_tavg',
        description: 'Soil moisture (10 - 40 cm underground)',
        'gee:units': units.volume_fraction,
      },
      {
        name: 'SoilMoi100_200cm_tavg',
        description: 'Soil moisture (100 - 200 cm underground)',
        'gee:units': units.volume_fraction,
      },
      {
        name: 'SoilMoi40_100cm_tavg',
        description: 'Soil moisture (40 - 100 cm underground)',
        'gee:units': units.volume_fraction,
      },
      {
        name: 'SoilTemp00_10cm_tavg',
        description: 'Soil temperature (0 - 10 cm underground)',
        'gee:units': units.kelvin,
      },
      {
        name: 'SoilTemp10_40cm_tavg',
        description: 'Soil temperature (10 - 40 cm underground)',
        'gee:units': units.kelvin,
      },
      {
        name: 'SoilTemp100_200cm_tavg',
        description: 'Soil temperature (100 - 200 cm underground)',
        'gee:units': units.kelvin,
      },
      {
        name: 'SoilTemp40_100cm_tavg',
        description: 'Soil temperature (40 - 100 cm underground)',
        'gee:units': units.kelvin,
      },
      {
        name: 'SWdown_f_tavg',
        description: 'Surface downward shortwave radiation',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'SWE_inst',
        description: 'Snow water equivalent',
        'gee:units': units.area_density,
      },
      {
        name: 'Swnet_tavg',
        description: 'Net shortwave radiation flux',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'Tair_f_tavg',
        description: 'Near surface air temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'Wind_f_tavg',
        description: 'Near surface wind speed',
        'gee:units': units.velocity_si,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Average Evapotranspiration',
        lookat: {
          lat: 30.0,
          lon: 30.0,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              5e-05,
            ],
            palette: [
              'black',
              'blue',
              'purple',
              'cyan',
              'green',
              'yellow',
              'red',
            ],
            bands: [
              'Evap_tavg',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    If you use these data in your research or applications, please include a
    reference in your publication(s) similar to the following example:
    Amy McNally NASA/GSFC/HSL (2018), FLDAS Noah Land Surface Model L4 Global
    Monthly 0.1 x 0.1 degree (MERRA-2 and CHIRPS), Greenbelt, MD, USA, Goddard
    Earth Sciences Data and Information Services Center (GES DISC), Accessed:
    [Data Access Date], [doi:10.5067/5NHC22T9375G](https://doi.org/10.5067/5NHC22T9375G)
  |||,
  'sci:publications': [
    {
      citation: |||
        McNally, A., Arsenault, K., Kumar, S., Shukla, S., Peterson, P., Wang, S., Funk, C.,
        Peters-Lidard, C.D., & Verdin, J. P. (2017). A land data assimilation system for
        sub-Saharan Africa food and water security applications. Scientific Data, 4, 170012.
      |||,
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': |||
    Distribution of data from the Goddard Earth Sciences
    Data and Information Services Center (GES DISC) is funded by NASA's
    Science Mission Directorate (SMD). Consistent with NASA [Earth
    Science Data and Information Policy](https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy/),
    data from the GES DISC archive are available free to the user community.
    For more information visit the GES DISC [Data Policy](https://disc.sci.gsfc.nasa.gov/citing)
    page.
  |||,
}
