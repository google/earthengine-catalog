local id = 'MODIS/006/MOD44B';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MOD44B.libsonnet';

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
  title: 'MOD44B.006 Terra Vegetation Continuous Fields Yearly Global 250m',
  version: 'V006',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Terra MODIS Vegetation Continuous Fields (VCF)
    product is a sub-pixel-level representation of surface vegetation
    cover estimates globally. Designed to continuously represent
    Earth's terrestrial surface as a proportion of basic vegetation
    traits, it provides a gradation of three surface cover components:
    percent tree cover, percent non-tree cover, and percent bare.
    VCF products provide a continuous, quantitative portrayal of
    land surface cover with improved spatial detail, and hence, are
    widely used in environmental modeling and monitoring applications.

    Generated yearly, the VCF product is produced using monthly
    composites of Terra MODIS 250 and 500 meters Land Surface Reflectance
    data, including all seven bands, and Land Surface Temperature.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/1322/MOD44B_User_Guide_V6.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/113/MOD44B_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/6/MOD44B)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'annual',
    'geophysical',
    'global',
    'mod44b',
    'modis',
    'nasa',
    'terra',
    'tree_cover',
    'vegetation',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MOD44B.006'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1374355842-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2000-03-05T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Terra',
    ],
  },
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
