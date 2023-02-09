local id = 'ECMWF/ERA5_LAND/HOURLY';
local subdir = 'ECMWF';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local era5_land = import 'templates/ECMWF_ERA5_LAND.libsonnet';

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
  title: 'ERA5-Land Hourly - ECMWF Climate Reanalysis',
  'gee:type': ee_const.gee_type.image_collection,
  description: era5_land.description + |||

    Please note that the convention for accumulations used in ERA5-Land differs
    with that for ERA5. The accumulations are treated the same as those in
    ERA-Interim or ERA-Interim/Land, i.e., they are accumulated from the
    beginning of the forecast to the end of the forecast step. This happens
    within every day and gets reset on midnight. The Earth Engine Data team
    added 19 additional bands,
    one for each of the accumulation bands, with the hourly values computed as
    the difference between two consecutive forecast steps.

    ERA5-Land data is available from 1981 to three months from real-time. More
    information can be found at the
    [Copernicus Climate Data Store](https://cds.climate.copernicus.eu).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: era5_land.keywords,
  providers: [
    ee.producer_provider(
      'Climate Data Store',
      'https://cds.climate.copernicus.eu/cdsapp'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1981-01-01T01:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'hour',
        description: 'Hour of the day',
        type: ee_const.var_type.int,
      },
    ],
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
              '#FFFFFF',
              '#00FFFF',
              '#0080FF',
              '#DA00FF',
              '#FFA400',
              '#FF0000',
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
    unit: 'hour',
    interval: 1,
  },
  'gee:terms_of_use': era5_land.terms_of_use,
}
