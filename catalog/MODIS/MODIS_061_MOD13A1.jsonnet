local id = 'MODIS/061/MOD13A1';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MOD13A1_versions.libsonnet';

local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MOD13A1.libsonnet';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MOD13A1.061 Terra Vegetation Indices 16-Day Global 500m',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MOD13A1 V6.1 product provides a Vegetation Index (VI)
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

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/61/MOD13A1)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MOD13A1.061',
    },
  ] + version_config.version_links,
  keywords: [
    '16_day',
    'evi',
    'global',
    'mod13a1',
    'modis',
    'nasa',
    'ndvi',
    'terra',
    'usgs',
    'vegetation',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MOD13A1.061'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C194001237-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2000-02-18T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MOD13A1.061',
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
