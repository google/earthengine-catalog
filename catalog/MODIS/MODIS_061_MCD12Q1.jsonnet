local id = 'MODIS/061/MCD12Q1';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MCD12Q1_versions.libsonnet';

local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local template = import 'templates/MODIS_006_MCD12Q1.libsonnet';


{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MCD12Q1.061 MODIS Land Cover Type Yearly Global 500m',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Terra and Aqua combined Moderate Resolution Imaging Spectroradiometer
    (MODIS) Land Cover Type (MCD12Q1) Version 6.1 data product provides global
    land cover types at yearly intervals. The MCD12Q1 Version 6.1
    data product is derived using supervised classifications of MODIS Terra and
    Aqua reflectance data. Land cover types are derived from the International
    Geosphere-Biosphere Programme (IGBP), University of Maryland (UMD), Leaf
    Area Index (LAI), BIOME-Biogeochemical Cycles (BGC), and Plant Functional
    Types (PFT) classification schemes. The supervised classifications then
    underwent additional post-processing that incorporate prior knowledge and
    ancillary information to further refine specific classes. Additional land
    cover property assessment layers are provided by the Food and Agriculture
    Organization (FAO) Land Cover Classification System (LCCS) for land cover,
    land use, and surface hydrology.

    Layers for Land Cover Type 1-5, Land Cover Property 1-3, Land Cover Property
    Assessment 1-3, Land Cover Quality Control (QC), and a Land Water Mask are
    also provided.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/1409/MCD12_User_Guide_V61.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/86/MCD12_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/61/MCD12Q1)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MCD12Q1.061',
    },] + version_config.version_links,
  keywords: [
    'landcover',
    'modis',
    'nasa',
    'usgs',
    'yearly',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MCD12Q1.061'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2484079608-LPCLOUD',
  ],
  extent: ee.extent_global('2001-01-01T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MCD12Q1.061',
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
