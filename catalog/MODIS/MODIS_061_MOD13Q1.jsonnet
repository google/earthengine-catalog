local id = 'MODIS/061/MOD13Q1';
local predecessor_id = 'MODIS/006/MOD13Q1';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MOD13Q1.libsonnet';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local predecessor_basename = std.strReplace(predecessor_id, '/', '_');
local predecessor_filename = predecessor_basename + '.json';

local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;
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
  title: 'MOD13Q1.061 Terra Vegetation Indices 16-Day Global 250m',
  version: 'V061',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MOD13Q1 V6.1 product provides a Vegetation Index (VI)
    value at a per pixel basis. There are two primary vegetation layers.
    The first is the Normalized Difference Vegetation Index (NDVI)
    which is referred to as the continuity index to the existing National
    Oceanic and Atmospheric Administration-Advanced Very High Resolution
    Radiometer (NOAA-AVHRR) derived NDVI. The second vegetation layer
    is the Enhanced Vegetation Index (EVI) that minimizes canopy background
    variations and maintains sensitivity over dense vegetation conditions.
    The EVI also uses the blue band to remove residual atmosphere contamination
    caused by smoke and sub-pixel thin cloud clouds. The MODIS NDVI
    and EVI products are computed from atmospherically corrected bi-directional
    surface reflectances that have been masked for water, clouds, heavy
    aerosols, and cloud shadows.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/103/MOD13_User_Guide_V6.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/104/MOD13_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/6/MOD13A2)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: 'cite-as',
      href: 'https://doi.org/10.5067/MODIS/MOD13Q1.061',
    },
    ee.link.predecessor(predecessor_id, predecessor_url)
  ],
  keywords: [
    '16-day',
    'evi',
    'global',
    'mod13q1',
    'modis',
    'nasa',
    'ndvi',
    'terra',
    'usgs',
    'vegetation',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MOD13Q1.061'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C194001241-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2000-02-18T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MOD13Q1.061',
  'sci:citation': |||
    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC
    have no restrictions on subsequent use, sale, or redistribution.
  |||,
}
