local id = 'MODIS/061/MCD12Q2';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MCD12Q2_versions.libsonnet';

local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local template = import 'templates/MODIS_006_MCD12Q2.libsonnet';

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
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Terra and Aqua combined Moderate Resolution Imaging Spectroradiometer
    (MODIS) Land Cover Dynamics (MCD12Q2) Version 6.1 data product provides
    global land surface phenology metrics at yearly intervals. The MCD12Q2
    Version 6.1 data product is derived from time series of the 2-band Enhanced
    Vegetation Index (EVI2) calculated from MODIS Nadir Bidirectional
    Reflectance Distribution Function (BRDF)-Adjusted Reflectance(NBAR).
    Vegetation phenology metrics at 500 meter spatial resolution are identified
    for up to two detected growing cycles per year. For pixels with more than
    two valid vegetation cycles, the data represent the two cycles with the
    largest NBAR-EVI2 amplitudes.

    Each asset contains bands are layers for the total number of vegetation
    cycles detected for the product year, the onset of greenness, greenup
    midpoint, maturity, peak greenness, senescence, greendown midpoint,
    dormancy, EVI2 minimum, EVI2 amplitude, integrated EVI2 over a vegetation
    cycle, as well as overall and phenology metric-specific quality information.

    For areas where the NBAR-EVI2 values are missing due to cloud cover or other
    reasons, the data gaps are filled with good quality NBAR-EVI2 values from
    the year directly preceding or following the product year.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MCD12Q2.061',
    },
  ] + version_config.version_links,
  keywords: [
    'evi',
    'global',
    'modis',
    'onset_greenness',
    'phenology',
    'usgs',
    'yearly',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://lpdaac.usgs.gov/products/mcd12q2v061/'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2001-01-01T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MCD12Q2.061',
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
