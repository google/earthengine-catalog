local id = 'ECMWF/ERA5/HOURLY';
local subdir = 'ECMWF';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local era5 = import 'templates/ECMWF_ERA5.libsonnet';

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
  title: 'ERA5 Hourly - ECMWF Climate Reanalysis',
  'gee:type': ee_const.gee_type.image_collection,
  description: era5.description,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['climate'],
  keywords: era5.keywords,
  providers: [
    ee.producer_provider(
      'Copernicus Climate Change Service (C3S)',
      'https://cds.climate.copernicus.eu/datasets/reanalysis-era5-single-levels?tab=overview'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1940-01-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'hour',
        description: 'Hour of the day',
        type: ee_const.var_type.int,
      },
    ],
    gsd: [
      27830.0,
    ],
    'eo:bands': [
      {
        name: band.name,
        description: band.description,
        [if std.objectHas(band, 'units') then 'gee:units']: band.units,
      }
      for band in era5.bands
    ],
    'gee:visualizations': era5.visualizations,
  },
  'sci:citation': era5.citation,
  'gee:interval': {
    type: 'cadence',
    unit: 'hour',
    interval: 1,
  },
  'gee:terms_of_use': era5.terms_of_use,
}
