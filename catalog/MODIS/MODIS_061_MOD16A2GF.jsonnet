local id = 'MODIS/061/MOD16A2GF';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MOD16A2.libsonnet';

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
  title: 'MOD16A2GF.061: Terra Net Evapotranspiration Gap-Filled 8-Day Global 500m',
  version: '6.1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Terra Moderate Resolution Imaging Spectroradiometer (MODIS) MOD16A2GF
    Version 6.1 Evapotranspiration/Latent Heat Flux (ET/LE) product is a
    year-end gap-filled 8-day composite dataset produced at 500 meter (m) pixel
    resolution. The algorithm used for the MOD16 data product collection is
    based on the logic of the Penman-Monteith equation, which includes inputs of
    daily meteorological reanalysis data along with MODIS remotely sensed data
    products such as vegetation property dynamics, albedo, and land cover.

    The pixel values for the two Evapotranspiration layers (ET and PET) are the
    sum of all eight days within the composite period, and the pixel values for
    the two Latent Heat layers (LE and PLE) are the average of all eight days
    within the composite period. The last acquisition period of each year is a
    5 or 6-day composite period, depending on the year.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/931/MOD16_User_Guide_V61.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/93/MOD16_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/6/MOD16A2GF)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MOD16A2GF.061',
    },
  ],
  keywords: [
    '8_day',
    'evapotranspiration',
    'global',
    'modis',
    'nasa',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center',
    'https://doi.org/10.5067/MODIS/MOD16A2GF.061'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2565791021-LPCLOUD',
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MOD16A2GF.061',
  'sci:citation': |||
    Please visit
    [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 8,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC
    have no restrictions on subsequent use, sale, or redistribution.
  |||,
}
