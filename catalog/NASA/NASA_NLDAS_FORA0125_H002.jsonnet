local id = 'NASA/NLDAS/FORA0125_H002';
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
  ],
  id: id,
  title: 'NLDAS-2: North American Land Data Assimilation System Forcing Fields',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Land Data Assimilation System (LDAS) combines multiple
    sources of observations (such as precipitation gauge data, satellite
    data, and radar precipitation measurements) to produce estimates
    of climatological properties at or near the Earth''s surface.

    This dataset is the primary (default) forcing file (File A) for
    Phase 2 of the North American Land Data Assimilation System (NLDAS-2).
    The data are in 1/8th-degree grid spacing; the temporal resolution
    is hourly.

    NLDAS is a collaboration project among several groups: NOAA/NCEP''s
    Environmental Modeling Center (EMC), NASA''s Goddard Space Flight
    Center (GSFC), Princeton University, the University of Washington,
    the NOAA/NWS Office of Hydrological Development (OHD), and the
    NOAA/NCEP Climate Prediction Center (CPC). NLDAS is a core project
    with support from NOAA''s Climate Prediction Program for the Americas
    (CPPA).

    Documentation:

    * [Readme](https://hydro1.gesdisc.eosdis.nasa.gov/data/NLDAS/README.NLDAS2.pdf)

    * [How-To](https://disc.gsfc.nasa.gov/information/howto?tags=hydrology)

    * [GES DISC Hydrology Documentation](https://disc.gsfc.nasa.gov/information/documents?title=Hydrology%20Documentation)

    * [GES DISC Data Rods Documentation](https://disc.gsfc.nasa.gov/information/tools?title=Hydrology%20Data%20Rods)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.source,
      href: 'https://disc.sci.gsfc.nasa.gov/datasets?keywords=NLDAS',
    },
  ],
  keywords: [
    'climate',
    'evaporation',
    'forcing',
    'geophysical',
    'hourly',
    'humidity',
    'ldas',
    'nasa',
    'nldas',
    'precipitation',
    'pressure',
    'radiation',
    'temperature',
    'wind',
  ],
  providers: [
    ee.producer_provider('NASA GES DISC at NASA Goddard Space Flight Center', 'https://doi.org/10.5067/6J5LHHOHZHN4'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1233767589-GES_DISC',
  ],
  extent: ee.extent(-125.15, 24.85, -66.85, 53.28,
                    '1979-01-01T13:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'end_hour',
        description: 'End hour',
        type: ee_const.var_type.double,
      },
      {
        name: 'start_hour',
        description: 'Start hour',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      13915.0,
    ],
    'eo:bands': [
      {
        name: 'temperature',
        description: 'Air temperature at 2 meters above the surface',
        'gee:units': units.celsius,
      },
      {
        name: 'specific_humidity',
        description: 'Specific humidity at 2 meters above the surface',
        'gee:units': units.mass_fraction,
      },
      {
        name: 'pressure',
        description: 'Surface pressure',
        'gee:units': units.pascal,
      },
      {
        name: 'wind_u',
        description: 'U wind component at 10 meters above the surface',
        'gee:units': units.velocity_si,
      },
      {
        name: 'wind_v',
        description: 'V wind component at 10 meters above the surface',
        'gee:units': units.velocity_si,
      },
      {
        name: 'longwave_radiation',
        description: 'Surface downward longwave radiation',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'convective_fraction',
        description: 'Fraction of total precipitation that is convective: from NARR',
      },
      {
        name: 'potential_energy',
        description: 'Convective available potential energy (J/kg): from NARR',
        'gee:units': units.joules_per_kg,
      },
      {
        name: 'potential_evaporation',
        description: 'Potential evaporation: from NARR',
        'gee:units': units.area_density,
      },
      {
        name: 'total_precipitation',
        description: 'Hourly total precipitation',
        'gee:units': units.area_density,
      },
      {
        name: 'shortwave_radiation',
        description: 'Surface downward shortwave radiation - bias corrected',
        'gee:units': units.watt_per_meter_squared,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Temperature',
        lookat: {
          lat: 35.1,
          lon: -110.21,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              -5.0,
            ],
            max: [
              40.0,
            ],
            palette: [
              '3d2bd8',
              '4e86da',
              '62c7d8',
              '91ed90',
              'e4f178',
              'ed6a4c',
            ],
            bands: [
              'temperature',
            ],
          },
        },
      },
    ],
    temperature: {
      minimum: -49.79,
      maximum: 51.2,
      'gee:estimated_range': true,
    },
    specific_humidity: {
      minimum: 0.0,
      maximum: 0.02,
      'gee:estimated_range': true,
    },
    pressure: {
      minimum: 61847.58,
      maximum: 105337.62,
      'gee:estimated_range': true,
    },
    wind_u: {
      minimum: -27.93,
      maximum: 27.54,
      'gee:estimated_range': true,
    },
    wind_v: {
      minimum: -27.45,
      maximum: 35.13,
      'gee:estimated_range': true,
    },
    longwave_radiation: {
      minimum: 72.18,
      maximum: 545.11,
      'gee:estimated_range': true,
    },
    convective_fraction: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    potential_energy: {
      minimum: 0.0,
      maximum: 76666.17,
      'gee:estimated_range': true,
    },
    potential_evaporation: {
      minimum: 0.0,
      maximum: 2.76,
      'gee:estimated_range': true,
    },
    total_precipitation: {
      minimum: 0.0,
      maximum: 124.19,
      'gee:estimated_range': true,
    },
    shortwave_radiation: {
      minimum: 0.0,
      maximum: 1368.54,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    The data set source should be properly cited when the data are
    used. A formal reference of the form: \\<authors\\>, 2012, last updated
    2013: \\<dataset name\\>. NASA/GSFC, Greenbelt, MD, USA, NASA Goddard
    Earth Sciences Data and Information Services Center (GES DISC).
    Accessed \\<enter user data access date\\> at \\<DOI\\> is suggested following
    Parsons et al. (2010), [doi:10.1029/2010EO340001](https://doi.org/10.1029/2010EO340001).
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'hour',
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
