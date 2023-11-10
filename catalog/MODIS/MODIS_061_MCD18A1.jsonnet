local id = 'MODIS/061/MCD18A1';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_061_MCD18A1.libsonnet';

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
  title: 'MCD18A1.061 Surface Radiation Daily/3-Hour',
  version: '6.1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MCD18A1 Version 6.1 is a Moderate Resolution Imaging Spectroradiometer
    (MODIS) Terra and Aqua combined Downward Shortwave Radiation (DSR) gridded
    Level 3 product produced daily at 1 kilometer pixel resolution with
    estimates of DSR every 3 hours. DSR is incident solar radiation over land
    surfaces in the shortwave spectrum (300-4,000 nanometers) and is an
    important variable in land-surface models that address a variety of
    scientific and application issues. The MCD18 products are based on a
    prototyping algorithm that uses multi-temporal signatures of MODIS data to
    derive surface reflectance and then calculate incident DSR using the look-up
    table (LUT) approach. The LUTs consider different types of loadings of
    aerosols and clouds at a variety of illumination/viewing geometry. Global
    DSR products are generated from MODIS and geostationary satellite data.
    Additional details regarding the methodology used to create the data are
    available in the
    [Algorithm Theoretical Basis Document](https://lpdaac.usgs.gov/documents/106/MCD18_ATBD.pdf)

    Provided in the MOD18A1 product are layers for instantaneous DSR array for
    each individual MODIS overpass and 3-hour DSR array along with a View Zenith
    Angle layer.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MCD18A1.061',
    },
  ],
  keywords: [
    'par',
    'radiation',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://lpdaac.usgs.gov/products/mcd18a1v061/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-02-24T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MCD18A1.061',
  'sci:citation': |||
    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC
    have no restrictions on subsequent use, sale, or redistribution.
  |||,
}
