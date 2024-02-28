local id = 'NASA/SMAP/SPL4SMGP/007';
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local UNITS = "Soil wetness units (dimensionless) vary between 0 and 1,
        indicating relative saturation between completely dry conditions and
        completely saturated conditions, respectively.";
local DISCLAIMER = "Excluding areas of open water and permanent ice";

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver
  ],
  id: id,
  title: 'SPL4SMGP.007 SMAP L4 Global 3-hourly 9-km Surface and Root Zone Soil Moisture',
  version: '7',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The SMAP Level-4 (L4) Soil Moisture product includes surface soil moisture
    (0-5 cm vertical average), root-zone soil moisture (0-100 cm vertical
    average), and additional research products (not validated), including
    surface meteorological forcing variables, soil temperature,
    evapotranspiration, and net radiation.

    SMAP L4 provides uninterrupted soil moisture data.  During outages of the
    SMAP instrument, SMAP L4 soil moisture is based on land model simulations
    alone, without the concomitant assimilation of SMAP brightness temperature
    observations.  Significant SMAP instrument outages occurred between 19 June
    and 23 July 2019 and between 6 August and 20 September 2022.

    SMAP L-band brightness temperature data from descending and ascending
    half-orbit satellite passes (approximately 6:00 a.m. and 6:00 p.m. local
    solar time, respectively) are assimilated into a land surface model that is
    gridded using an Earth-fixed, global cylindrical 9 km Equal-Area Scalable
    Earth Grid, Version 2.0 (EASE-Grid 2.0) projection.

    The SPL4SMGP product includes a series of 3-hourly time-averaged geophysical
    data fields from the assimilation system. SPL4SMGP data are transformed to
    [geographic coordinates using GDAL libraries](https://github.com/google/earthengine-catalog/blob/main/pipelines/smap_convert_l4.py)
    before the data are ingested into Google Earth Engine.

    See the [SMAP L4 Soil Moisture User Guide](https://nsidc.org/sites/default/files/documents/user-guide/multi_spl4smau-v007-userguide.pdf)
    and references therein for additional documentation and algorithm details.

    See
    [basic](https://developers.google.com/earth-engine/tutorials/community/smap-soil-moisture)
    and
    [advanced](https://developers.google.com/earth-engine/tutorials/community/anomalies-analysis-smo-and-pre)
    tutorials to learn how to use SMAP data in Earth Engine.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'drought',
    'nasa',
    'smap',
    'soil_moisture',
    'surface',
    'weather'
  ],
  'gee:provider_ids': [
    'C2531308461-NSIDC_ECS',
  ],
  providers: [
    ee.producer_provider('Google and NSIDC', 'https://nsidc.org/data/spl4smgp/versions/7'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -84, 180.0, 84, '2015-03-31T12:00:00Z', null),
  summaries: {
    gsd: [
      11000.0,
    ],
    'eo:bands': [
      {
        name: 'sm_surface',
        description: 'Top layer soil moisture (0-5 cm)',
        'gee:units': units.volume_fraction,
      },
      {
        name: 'sm_rootzone',
        description: 'Root zone soil moisture (0-100 cm)',
        'gee:units': units.volume_fraction,
      },
      {
        name: 'sm_profile',
        description: 'Total profile soil moisture (0 cm to model bedrock depth).',
        'gee:units': units.volume_fraction,
      },
      {
        name: 'sm_surface_wetness',
        description: 'Top layer soil wetness (0-5 cm;wetness units). ' + UNITS,
      },
      {
        name: 'sm_rootzone_wetness',
        description: 'Root zone soil wetness (0-100 cm;wetness units). ' + UNITS,
      },
      {
        name: 'sm_profile_wetness',
        description: |||
          Total profile soil wetness (0 cm to model bedrock depth;
          wetness units).
        ||| + UNITS,
      },
      {
        name: 'surface_temp',
        description: |||
          Mean land surface temperature (including snow-covered land
          area).
        ||| + DISCLAIMER,
        'gee:units': units.kelvin,
      },
      {
        name: 'soil_temp_layer1',
        description: 'Soil temperature in layer 1 of soil heat diffusion model',
        'gee:units': units.kelvin,
      },
      {
        name: 'soil_temp_layer2',
        description: 'Soil temperature in layer 2 of soil heat diffusion model',
        'gee:units': units.kelvin,
      },
      {
        name: 'soil_temp_layer3',
        description: 'Soil temperature in layer 3 of soil heat diffusion model',
        'gee:units': units.kelvin,
      },
      {
        name: 'soil_temp_layer4',
        description: 'Soil temperature in layer 4 of soil heat diffusion model',
        'gee:units': units.kelvin,
      },
      {
        name: 'soil_temp_layer5',
        description: 'Soil temperature in layer 5 of soil heat diffusion model',
        'gee:units': units.kelvin,
      },
      {
        name: 'soil_temp_layer6',
        description: 'Soil temperature in layer 6 of soil heat diffusion model',
        'gee:units': units.kelvin,
      },
      {
        name: 'snow_mass',
        description: 'Average snow mass (or snow water equivalent) over land
          fraction of grid cell',
        'gee:units': units.area_density,
      },
      {
        name: 'snow_depth',
        description: 'Snow depth within snow-covered land fraction of grid cell',
        'gee:units': units.meter,
      },
      {
        name: 'land_evapotranspiration_flux',
        description: 'Evapotranspiration from land',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'overland_runoff_flux',
        description: 'Overland (surface) runoff (including throughflow)',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'baseflow_flux',
        description: 'Baseflow',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'snow_melt_flux',
        description: 'Snowmelt',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'soil_water_infiltration_flux',
        description: 'Soil water infiltration rate',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'land_fraction_saturated',
        description: 'Fractional land area that is saturated and snow-free',
      },
      {
        name: 'land_fraction_unsaturated',
        description: |||
          Fractional land area that is unsaturated (but non-wilting)
          and snow-free
        |||,
      },
      {
        name: 'land_fraction_wilting',
        description: 'Fractional land area that is wilting and snow-free',
      },
      {
        name: 'land_fraction_snow_covered',
        description: 'Fractional land area that is snowcovered',
      },
      {
        name: 'heat_flux_sensible',
        description: 'Sensible heat flux from land',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'heat_flux_latent',
        description: 'Latent heat flux from land',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'heat_flux_ground',
        description: |||
          Downward ground heat flux into layer 1 of soil heat
          diffusion model
        |||,
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'net_downward_shortwave_flux',
        description: 'Net downward shortwave flux over land',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'net_downward_longwave_flux',
        description: 'Net downward longwave flux over land',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'radiation_shortwave_downward_flux',
        description: 'Downward shortwave flux incident on the surface',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'radiation_longwave_absorbed_flux',
        description: 'Absorbed (downward) longwave radiation at the surface',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'precipitation_total_surface_flux',
        description: 'Total surface precipitation (incl. snow fall)',
        'gee:units': 'kg m^-2 s^-2',
      },
      {
        name: 'snowfall_surface_flux',
        description: 'Surface snow fall ',
        'gee:units': 'kg m^-2 s^-2',
      },
      {
        name: 'surface_pressure',
        description: 'Mean land surface temperature (incl. snow-covered land area)',
        'gee:units': units.kelvin,
      },
      {
        name: 'height_lowatmmodlay',
        description: 'Center height of lowest atmospheric model layer',
        'gee:units': units.meter,
      },
      {
        name: 'temp_lowatmmodlay',
        description: 'Air temperature at center height of lowest atmospheric
          model layer',
        'gee:units': units.kelvin,
      },
      {
        name: 'specific_humidity_lowatmmodlay',
        description: |||
          Air specific humidity at center height of lowest
          atmospheric model layer
        |||,
        'gee:units': units.mass_fraction,
      },
      {
        name: 'windspeed_lowatmmodlay',
        description: |||
          Surface wind speed at center height of lowest atmospheric
          model layer
        |||,
        'gee:units': units.velocity_si,
      },
      {
        name: 'vegetation_greenness_fraction',
        description: |||
          Vegetation "greenness" or fraction of transpiring leaves
          averaged over the land area* of the grid cell.
        |||,
      },
      {
        name: 'leaf_area_index',
        description: 'Vegetation leaf area index',
        'gee:units': units.area_fraction,
      },
      {
        name: 'sm_rootzone_pctl',
        description: 'Root zone soil moisture (0-100 cm; percentile units)',
        'gee:units': units.percent,
      },
      {
        name: 'sm_profile_pctl',
        description: |||
          Total profile soil moisture (0 cm to model bedrock depth;
          percentile units)
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'depth_to_water_table_from_surface_in_peat',
        description: |||
          Depth to water table from mean surface elevation in
          peatlands (positive above ground)
        |||,
        'gee:units': units.meter,
      },
      {
        name: 'free_surface_water_on_peat_flux',
        description: 'Change in free surface water storage on peatlands',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'mwrtm_vegopacity',
        description: 'Microwave radiative transfer model: Vegetation opacity.',
      },
      {
        name: 'sm_surface_anomaly',
        description: |||
          Experimental. Difference of the 30-day average of 'sm_surface',
          centered on asset date, relative to the same 30-day period averaged
          across years from 2015 to present, excluding asset year.

          See
          [this script](https://github.com/google/earthengine-community/blob/master/datasets/smap_anomaly_l4.py)
          for anomaly computations.
        |||
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'SM Surface',
        lookat: {
          lat: -6.746,
          lon: 46.529,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              0.9,
            ],
            palette: [
              '0300ff',
              '418504',
              'efff07',
              'efff07',
              'ff0303',
            ],
            bands: [
              'sm_surface',
            ],
          },
        },
      },
    ],
    sm_surface: {
      minimum: 0.0,
      maximum: 0.9,
      'gee:estimated_range': false,
    },
    sm_rootzone: {
      minimum: 0.0,
      maximum: 0.9,
      'gee:estimated_range': false,
    },
    sm_profile: {
      minimum: 0.0,
      maximum: 0.9,
      'gee:estimated_range': false,
    },
    sm_surface_wetness: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    sm_rootzone_wetness: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    sm_profile_wetness: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    surface_temp: {
      minimum: 180.0,
      maximum: 350.0,
      'gee:estimated_range': false,
    },
    soil_temp_layer1: {
      minimum: 210.0,
      maximum: 350.0,
      'gee:estimated_range': false,
    },
    soil_temp_layer2: {
      minimum: 210.0,
      maximum: 330.0,
      'gee:estimated_range': false,
    },
    soil_temp_layer3: {
      minimum: 215.0,
      maximum: 325.0,
      'gee:estimated_range': false,
    },
    soil_temp_layer4: {
      minimum: 220.0,
      maximum: 325.0,
      'gee:estimated_range': false,
    },
    soil_temp_layer5: {
      minimum: 225.0,
      maximum: 325.0,
      'gee:estimated_range': false,
    },
    soil_temp_layer6: {
      minimum: 230.0,
      maximum: 320.0,
      'gee:estimated_range': false,
    },
    snow_mass: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    snow_depth: {
      minimum: 0.0,
      maximum: 50.0,
      'gee:estimated_range': false,
    },
    land_evapotranspiration_flux: {
      minimum: -0.001,
      maximum: 0.001,
      'gee:estimated_range': false,
    },
    overland_runoff_flux: {
      minimum: 0.0,
      maximum: 0.05,
      'gee:estimated_range': false,
    },
    baseflow_flux: {
      minimum: 0.0,
      maximum: 0.01,
      'gee:estimated_range': false,
    },
    snow_melt_flux: {
      minimum: 0.0,
      maximum: 0.05,
      'gee:estimated_range': false,
    },
    soil_water_infiltration_flux: {
      minimum: 0.0,
      maximum: 0.05,
      'gee:estimated_range': false,
    },
    land_fraction_saturated: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    land_fraction_unsaturated: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    land_fraction_wilting: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    land_fraction_snow_covered: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    heat_flux_sensible: {
      minimum: -2500.0,
      maximum: 3000.0,
      'gee:estimated_range': false,
    },
    heat_flux_latent: {
      minimum: -2500.0,
      maximum: 3000.0,
      'gee:estimated_range': false,
    },
    heat_flux_ground: {
      minimum: -1000.0,
      maximum: 1000.0,
      'gee:estimated_range': false,
    },
    net_downward_shortwave_flux: {
      minimum: 0.0,
      maximum: 1365.0,
      'gee:estimated_range': false,
    },
    net_downward_longwave_flux: {
      minimum: -1000.0,
      maximum: 200.0,
      'gee:estimated_range': false,
    },
    radiation_shortwave_downward_flux: {
      minimum: 0.0,
      maximum: 1500.0,
      'gee:estimated_range': false,
    },
    radiation_longwave_absorbed_flux: {
      minimum: 35.0,
      maximum: 800.0,
      'gee:estimated_range': false,
    },
    precipitation_total_surface_flux: {
      minimum: 0.0,
      maximum: 0.05,
      'gee:estimated_range': false,
    },
    snowfall_surface_flux: {
      minimum: 0.0,
      maximum: 0.05,
      'gee:estimated_range': false,
    },
    surface_pressure: {
      minimum: 40000.0,
      maximum: 110000.0,
      'gee:estimated_range': false,
    },
    height_lowatmmodlay: {
      minimum: 40.0,
      maximum: 80.0,
      'gee:estimated_range': false,
    },
    temp_lowatmmodlay: {
      minimum: 180.0,
      maximum: 350.0,
      'gee:estimated_range': false,
    },
    specific_humidity_lowatmmodlay: {
      minimum: 0.0,
      maximum: 0.4,
      'gee:estimated_range': false,
    },
    windspeed_lowatmmodlay: {
      minimum: -60.0,
      maximum: 60.0,
      'gee:estimated_range': false,
    },
    vegetation_greenness_fraction: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    leaf_area_index: {
      minimum: 0.0,
      maximum: 10.0,
      'gee:estimated_range': false,
    },
    sm_rootzone_pctl: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    sm_profile_pctl: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    depth_to_water_table_from_surface_in_peat: {
      minimum: -5.0,
      maximum: 0.15,
      'gee:estimated_range': false,
    },
    free_surface_water_on_peat_flux: {
      minimum: -0.001,
      maximum: 0.001,
      'gee:estimated_range': false,
    },
    mwrtm_vegopacity: {
      minimum: 0.0,
      maximum: 2.5,
      'gee:estimated_range': false,
    },

  },
  'sci:citation':|||
      **Reichle, R.H., G. De Lannoy, R.D. Koster, W.T. Crow, J.S. Kimball,
      Q. Liu, and M. Bechtold. 2022.**
      SMAP L4 Global 3-hourly 9 km EASE-Grid Surface and Root Zone Soil
      Moisture Analysis Update, Version 7. [Indicate subset used]. Boulder,
      Colorado USA. NASA National Snow and Ice Data Center Distributed Active
      Archive Center.
      [doi:10.5067/LWJ6TF5SZRG3](https://doi.org/10.5067/LWJ6TF5SZRG3)

      **Reichle, R.H., G. De Lannoy, R.D. Koster, W.T. Crow, J.S. Kimball,
      Q. Liu, and M. Bechtold. 2022.**
      SMAP L4 Global 3-hourly 9 km EASE-Grid Surface and Root Zone Soil
      Moisture Analysis Update, Version 7. [Indicate subset used]. Boulder,
      Colorado USA. NASA National Snow and Ice Data Center Distributed Active
      Archive Center.
      [doi:10.5067/EVKPQZ4AFC4D](https://doi.org/10.5067/EVKPQZ4AFC4D)

      **Reichle, R.H., G. De Lannoy, R.D. Koster, W.T. Crow, J.S. Kimball,
      Q. Liu, and M. Bechtold. 2022.**
      SMAP L4 Global 3-hourly 9 km EASE-Grid Surface and Root Zone Soil
      Moisture Analysis Update, Version 7. [Indicate subset used]. Boulder,
      Colorado USA. NASA National Snow and Ice Data Center Distributed Active
      Archive Center.
      [doi:10.5067/EVKPQZ4AFC4D](https://doi.org/10.5067/EVKPQZ4AFC4D)
    |||,

  'gee:interval': {
    type: 'cadence',
    unit: 'hour',
    interval: 3,
  },
  'gee:terms_of_use': |||
    This dataset is in the public domain and is available
    without restriction on use and distribution. See [NASA's
    Earth Science Data & Information Policy](https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
}
