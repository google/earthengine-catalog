local id = 'MODIS/006/MCD12Q2';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MCD12Q2.libsonnet';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MCD12Q2.006 Land Cover Dynamics Yearly Global 500m',
  version: 'V006',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MCD12Q2 V6 Land Cover Dynamics product (informally
    called the MODIS Global Vegetation Phenology product) provides
    estimates of the timing of vegetation phenology at global scales.
    Additionally, it provides information related to the range and
    summation of the enhanced vegetation index (EVI) computed from
    MODIS surface reflectance data at each pixel. It identifies the
    onset of greenness, greenup midpoint, maturity, peak greenness,
    senescence, greendown midpoint, dormancy, EVI2 minimum, EVI2 amplitude,
    integrated EVI2 over a vegetation cycle, as well as overall and phenology
    metric-specific quality information.

    The MCD12Q2 Version 6 data product is derived from time series of the
    2-band Enhanced Vegetation Index (EVI2) calculated from MODIS Nadir
    Bidirectional Reflectance Distribution Function (BRDF)-Adjusted Reflectance
    (NBAR). Vegetation phenology metrics are identified for up to two detected
    growing cycles per year. For pixels with more than two valid vegetation
    cycles, the data represent the two cycles with the largest NBAR-EVI2
    amplitudes.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MCD12Q2.006',
    },
  ],
  keywords: [
    'evi',
    'global',
    'mcd12q2',
    'modis',
    'onset_greenness',
    'phenology',
    'usgs',
    'yearly',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://lpdaac.usgs.gov/products/mcd12q2v006/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2001-01-01T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Terra',
      'Aqua',
    ],
  },
  'sci:doi': '10.5067/MODIS/MCD12Q2.006',
  'sci:citation': |||
    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC
    have no restrictions on subsequent use, sale, or redistribution.
  |||,
}
