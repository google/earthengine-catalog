local id = 'MODIS/061/MCD43A1';
local latest_id = 'MODIS/061/MCD64A1';
local predecessor_id = 'MODIS/006/MCD43A1';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local template = import 'templates/MODIS_006_MCD43A1.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local latest_basename = std.strReplace(latest_id, '/', '_');
local predecessor_basename = std.strReplace(predecessor_id, '/', '_');
local base_filename = basename + '.json';
local latest_filename = latest_basename + '.json';
local predecessor_filename = predecessor_basename + '.json';

local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;
local latest_url = catalog_subdir_url + latest_filename;
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
  title: 'MCD43A1.061 MODIS BRDF-Albedo Model Parameters Daily 500m',
  version: 'V061',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MCD43A1 V6.1 Bidirectional Reflectance Distribution
    Function and Albedo (BRDF/Albedo) Model Parameters dataset is
    a 500 meter daily 16-day product. The Julian date represents
    the 9th day of the 16-day retrieval period, and consequently
    the observations are weighted to estimate the BRDF/Albedo for
    that day. The MCD43A1 algorithm, as is with all combined products,
    chooses the best representative pixel from a pool that includes
    all the acquisitions from both the Terra and Aqua sensors from
    the retrieval period.

    The MCD43A1 provides the three model
    weighting parameters (isotropic, volumetric, and geometric) for
    each of the MODIS bands 1 through 7 and the visible (vis), near
    infrared (nir), and shortwave bands used to derive the Albedo
    and BRDF products (MCD43A3 and MCD43A4). The Mandatory Quality
    layers for each of the 10 bands are supplied as well.

    Documentation:

    * [User's Guide](https://www.umb.edu/spectralmass/terra_aqua_modis/v006/mcd43a1_brdif_albedo_model_parameters_product)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/97/MCD43_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/61/MCD43A1)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MCD43A1.061',
    },
    ee.link.latest(latest_id, latest_url),
    ee.link.predecessor(predecessor_id, predecessor_url)
  ],
  keywords: [
    'albedo',
    'brdf',
    'daily',
    'global',
    'mcd43a1',
    'modis',
    'nasa',
    'reflectance',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MCD43A1.061'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1620265504-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2000-02-24T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Terra',
      'Aqua',
    ],
  },
  'sci:doi': '10.5067/MODIS/MCD43A1.061',
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
