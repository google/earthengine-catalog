local id = 'ECMWF/ERA5_LAND/MONTHLY_AGGR';
local predecessor_id = 'ECMWF/ERA5_LAND/MONTHLY';
local subdir = 'ECMWF';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local era5_land = import 'templates/ECMWF_ERA5_LAND.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local predecessor_basename = std.strReplace(predecessor_id, '/', '_');
local predecessor_filename = predecessor_basename + '.json';

local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local predecessor_url = catalog_subdir_url + predecessor_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'ERA5-Land Monthly Aggregated - ECMWF Climate Reanalysis',
  version: '1.0.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: era5_land.description + |||

    The asset is a monthly aggregate of ECMWF ERA5 Land hourly assets which
    includes both flow and non-flow bands. Flow bands are formed by collecting
    the first hour's data of the following day for each day of the month and
    then adding them together, while the non-flow bands are created by
    averaging all hourly data of the month. The flow bands are labeled with
    the "_sum" identifier, which approach is different from the monthly data
    produced by Copernicus Climate Data Store, where flow bands are averaged
    too.

    Monthly aggregates have been pre-calculated to facilitate many applications
    requiring easy and fast access to the data, when sub-monthly fields are not
    required.

    ERA5-Land monthly aggregated data is available from 1950 to three months
    from real-time. More information can be found at the
    [Copernicus Climate Data Store](https://cds.climate.copernicus.eu).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.predecessor(predecessor_id, predecessor_url)
  ],
  keywords: era5_land.keywords,
  providers: [
    ee.producer_provider(
      'Monthly Aggregates: Google and Copernicus Climate Data Store',
      'https://cds.climate.copernicus.eu/cdsapp'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1950-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      11132.0,
    ],
    'eo:bands': [
      if std.member(era5_land.flow_bands, band.name) then
      {
        name: band.name + '_sum',
        description: band.description,
        'gee:units': band.units
      }
      else {
        name: band.name,
        description: band.description,
        'gee:units': band.units
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
              '#FFFFFF',
              '#00FFFF',
              '#0080FF',
              '#DA00FF',
              '#FFA400',
              '#FF0000',
            ],
            bands: [
              'total_precipitation_sum',
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
  'gee:terms_of_use': era5_land.terms_of_use
}
