local id = 'NASA/GSFC/MERRA/aer/2';
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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MERRA-2 M2T1NXAER: Aerosol Diagnostics V5.12.4',
  version: 'V5.12.4',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    M2T1NXAER (or tavg1_2d_aer_Nx) is an hourly time-averaged 2-dimensional data
    collection in Modern-Era Retrospective analysis for Research and
    Applications version 2 (MERRA-2). This collection consists of assimilated
    aerosol diagnostics, such as column mass density of aerosol components
    (black carbon, dust, sea-salt, sulfate, and organic carbon), surface mass
    concentration of aerosol components, and total extinction (and scattering)
    aerosol optical thickness (AOT) at 550 nm. The total PM1.0, PM2.5, and PM10
    may be derived with the formula described in the
    [in the FAQ] (https://gmao.gsfc.nasa.gov/reanalysis/MERRA-2/FAQ/)

    The data field is time-stamped with the
    central time of an hour starting from 00:30 UTC,
    e.g.: 00:30, 01:30, ... , 23:30 UTC.

    MERRA-2 is the latest version of global atmospheric reanalysis for the
    satellite era produced by NASA Global Modeling and Assimilation Office
    (GMAO) using the Goddard Earth Observing System Model (GEOS) version 5.12.4.
    The dataset covers the period of 1980-present with the latency of ~3 weeks
    after the end of a month.
  |||,
  license: license.id,
  links:  ee.standardLinks(subdir, id) + [
    ee.link.license(
    'https://earthdata.nasa.gov/collaborate/open-data-services-and-software/data-information-policy'
    ),
  ],
  keywords: [
    'aerosol',
    'carbon',
    'dust',
    'mass',
    'merra',
    'nasa',
    'sea_salt',
    'so2',
    'so4',
  ],
  providers: [
    ee.producer_provider('NASA/MERRA', 'https://gmao.gsfc.nasa.gov/reanalysis/MERRA-2/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1980-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      69375,
      55000
    ],
    'eo:bands': [
      {
        name: 'BCANGSTR',
        description: 'Black carbon angstrom parameter [470-870 nm]',
      },
      {
        name: 'BCCMASS',
        description: 'Black carbon column mass density',
        'gee:units': units.area_density,
      },
      {
        name: 'BCEXTTAU',
        description: 'Black carbon extinction AOT [550 nm]',
      },
      {
        name: 'BCFLUXU',
        description: 'Black carbon column u-wind mass flux',
        'gee:units': 'kg/m/s',
      },
      {
        name: 'BCFLUXV',
        description: 'Black carbon column v-wind mass flux',
        'gee:units': 'kg/m/s',
      },
      {
        name: 'BCSCATAU',
        description: 'Black carbon scattering AOT [550 nm]',
      },
      {
        name: 'BCSMASS',
        description: 'Black carbon surface mass concentration',
        'gee:units': units.density_si,
      },
      {
        name: 'DMSCMASS',
        description: 'Dms column mass density',
        'gee:units': units.area_density,
      },
      {
        name: 'DMSSMASS',
        description: 'Dms surface mass concentration',
        'gee:units': units.density_si,
      },
      {
        name: 'DUANGSTR',
        description: 'Dust angstrom parameter [470-870 nm]',
      },
      {
        name: 'DUCMASS25',
        description: 'Dust column mass density - PM2.5',
        'gee:units': units.area_density,
      },
      {
        name: 'DUCMASS',
        description: 'Dust column mass density',
        'gee:units': units.area_density,
      },
      {
        name: 'DUEXTT25',
        description: 'Dust extinction AOT [550 nm] - PM2.5',
      },
      {
        name: 'DUEXTTAU',
        description: 'Dust extinction AOT [550 nm]',
      },
      {
        name: 'DUFLUXU',
        description: 'Dust column u-wind mass flux',
        'gee:units': 'kg/m/s',
      },
      {
        name: 'DUFLUXV',
        description: 'Dust column v-wind mass flux',
        'gee:units': 'kg/m/s',
      },
      {
        name: 'DUSCAT25',
        description: 'Dust scattering AOT [550 nm] - PM2.5',
      },
      {
        name: 'DUSCATAU',
        description: 'Dust scattering AOT [550 nm]',
      },
      {
        name: 'DUSMASS25',
        description: 'Dust surface mass concentration - PM2.5',
        'gee:units': units.density_si,
      },
      {
        name: 'DUSMASS',
        description: 'Dust surface mass concentration',
        'gee:units': units.density_si,
      },
      {
        name: 'OCANGSTR',
        description: 'Organic carbon angstrom parameter [470-870 nm]',
      },
      {
        name: 'OCCMASS',
        description: 'Organic carbon column mass density',
        'gee:units': units.area_density,
      },
      {
        name: 'OCEXTTAU',
        description: 'Organic carbon extinction AOT [550 nm]',
      },
      {
        name: 'OCFLUXU',
        description: 'Organic carbon column u-wind mass flux',
        'gee:units': 'kg/m/s',
      },
      {
        name: 'OCFLUXV',
        description: 'Organic carbon column v-wind mass flux',
        'gee:units': 'kg/m/s',
      },
      {
        name: 'OCSCATAU',
        description: 'Organic carbon scattering AOT [550 nm]',
      },
      {
        name: 'OCSMASS',
        description: 'Organic carbon surface mass concentration',
        'gee:units': units.density_si,
      },
      {
        name: 'SO2CMASS',
        description: 'So2 column mass density',
        'gee:units': units.area_density,
      },
      {
        name: 'SO2SMASS',
        description: 'So2 surface mass concentration',
        'gee:units': units.density_si,
      },
      {
        name: 'SO4CMASS',
        description: 'SO4 column mass density',
        'gee:units': units.area_density,
      },
      {
        name: 'SO4SMASS',
        description: 'SO4 surface mass concentration',
        'gee:units': units.density_si,
      },
      {
        name: 'SSANGSTR',
        description: 'Sea salt angstrom parameter [470-870 nm]',
      },
      {
        name: 'SSCMASS25',
        description: 'Sea salt column mass density - PM2.5',
        'gee:units': units.area_density,
      },
      {
        name: 'SSCMASS',
        description: 'Sea salt column mass density',
        'gee:units': units.area_density,
      },
      {
        name: 'SSEXTT25',
        description: 'Sea salt extinction AOT [550 nm] - PM2.5',
      },
      {
        name: 'SSEXTTAU',
        description: 'Sea salt extinction AOT [550 nm]',
      },
      {
        name: 'SSFLUXU',
        description: 'Sea salt column u-wind mass flux',
        'gee:units': 'kg/m/s',
      },
      {
        name: 'SSFLUXV',
        description: 'Sea salt column v-wind mass flux',
        'gee:units': 'kg/m/s',
      },
      {
        name: 'SSSCAT25',
        description: 'Sea salt scattering AOT [550 nm] - PM2.5',
      },
      {
        name: 'SSSCATAU',
        description: 'Sea salt scattering AOT [550 nm]',
      },
      {
        name: 'SSSMASS25',
        description: 'Sea salt surface mass concentration - PM2.5',
        'gee:units': units.density_si,
      },
      {
        name: 'SSSMASS',
        description: 'Sea salt surface mass concentration',
        'gee:units': units.density_si,
      },
      {
        name: 'SUANGSTR',
        description: 'SO4 angstrom parameter [470-870 nm]',
      },
      {
        name: 'SUEXTTAU',
        description: 'SO4 extinction AOT [550 nm]',
      },
      {
        name: 'SUFLUXU',
        description: 'SO4 column u-wind mass flux',
        'gee:units': 'kg/m/s',
      },
      {
        name: 'SUFLUXV',
        description: 'SO4 column v-wind mass flux',
        'gee:units': 'kg/m/s',
      },
      {
        name: 'SUSCATAU',
        description: 'SO4 scattering AOT [550 nm]',
      },
      {
        name: 'TOTANGSTR',
        description: 'Total aerosol angstrom parameter [470-870 nm]',
      },
      {
        name: 'TOTEXTTAU',
        description: 'Total aerosol extinction AOT [550 nm]',
      },
      {
        name: 'TOTSCATAU',
        description: 'Total aerosol scattering AOT [550 nm]',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Black carbon column u-wind mass flux',
        lookat: {
          lat: 39.91,
          lon: -95.62,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              -0.0000115,
            ],
            max: [
              0.0000165,
            ],
            palette: [
              '001137',
              '01abab',
              'e7eb05',
              '620500',
            ],
            bands: [
              'BCFLUXU',
            ],
          },
        },
      },
    ],
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'hour',
    interval: 1,
  },
  'gee:terms_of_use': |||
    NASA promotes the full and open sharing of all data with research and
    applications communities, private industry, academia, and the general
    public.
  |||
}
