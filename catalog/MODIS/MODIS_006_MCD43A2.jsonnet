local id = 'MODIS/006/MCD43A2';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MCD43A2.libsonnet';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MCD43A2.006 MODIS BRDF-Albedo Quality Daily 500m',
  version: 'V006',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MCD43A2 V6 Bidirectional Reflectance Distribution
    Function and Albedo (BRDF/Albedo) Quality dataset is a 500 meter
    daily 16-day product. It contains all the quality information
    for the corresponding 16-day MCD43A3 Albedo and the MCD43A4 Nadir-BRDF
    (NBAR) products.

    The MCD43A2 contains individual band quality
    and observation information for the MODIS land bands
    1-7, along with the overall BRDF/Albedo quality information.

    See
    [dataset user guide](https://www.umb.edu/spectralmass/terra_aqua_modis/v006/mcd43a2_albedo_product)
    for more information.

    Documentation:

    * [User's Guide](https://www.umb.edu/spectralmass/terra_aqua_modis/v006)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/97/MCD43_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/6/MCD43A2)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MCD43A2.006',
    },
  ],
  keywords: [
    'albedo',
    'brdf',
    'daily',
    'global',
    'mcd43a2',
    'modis',
    'nasa',
    'quality',
    'reflectance',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MCD43A2.006'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1000000454-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2000-02-24T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MCD43A2.006',
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
