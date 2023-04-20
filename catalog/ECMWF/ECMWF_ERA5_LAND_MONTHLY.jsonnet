local id = 'ECMWF/ERA5_LAND/MONTHLY';
local latest_id = 'ECMWF/ERA5_LAND/MONTHLY_AGGR';
local successor_id = 'ECMWF/ERA5_LAND/MONTHLY_AGGR';
local subdir = 'ECMWF';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local era5_land = import 'templates/ECMWF_ERA5_LAND.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local latest_basename = std.strReplace(latest_id, '/', '_');
local successor_basename = std.strReplace(successor_id, '/', '_');
local base_filename = basename + '.json';
local latest_filename = latest_basename + '.json';
local successor_filename = successor_basename + '.json';

local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local latest_url = catalog_subdir_url + latest_filename;
local successor_url = catalog_subdir_url + successor_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'ERA5-Land Monthly Averaged - ECMWF Climate Reanalysis [deprecated]',
  deprecated: true,
  version: '1.0.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: era5_land.description + |||

    The data presented here is a subset of the full ERA5-Land dataset
    post-processed by ECMWF. Monthly-mean averages have been pre-calculated to
    facilitate many applications requiring easy and fast access to the data,
    when sub-monthly fields are not required.

    ERA5-Land data is available from 1981 to three months from real-time. More
    information can be found at the [Copernicus Climate Data Store]
    (https://cds.climate.copernicus.eu).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.latest(latest_id, latest_url),
    ee.link.successor(successor_id, successor_url),
  ],
  keywords: era5_land.keywords,
  providers: [
    ee.producer_provider(
      'Copernicus Climate Data Store',
      'https://cds.climate.copernicus.eu/cdsapp'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1981-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      11132.0,
    ],
    'eo:bands': [
      {
        name: band.name,
        description: band.description,
        [if std.objectHas(band, 'units') then 'gee:units']: band.units
      }
      for band in era5_land.bands
    ],
    'gee:visualizations': era5_land.visualizations + [
      {
        display_name: 'Total precipitation in m',
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
              0.1,
            ],
            palette: [
              'ffffff',
              '00ffff',
              '0080ff',
              'da00ff',
              'ffa400',
              'ff0000',
            ],
            bands: [
              'total_precipitation',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': era5_land.citation,
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': era5_land.terms_of_use,
}
