local id = 'MODIS/061/MCD12C1';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_061_MCD12C1.libsonnet';

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
  title: 'MCD12C1.061 MODIS Land Cover Type Yearly Global 0.05 Deg CMG',
  version: '6.1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Terra and Aqua combined Moderate Resolution Imaging Spectroradiometer
    (MODIS) Land Cover Climate Modeling Grid (CMG) (MCD12C1) Version 6.1 data
    product provides a spatially aggregated and reprojected version of the tiled
    MCD12Q1 Version 6.1 data product. Maps of the International
    Geosphere-Biosphere Programme (IGBP), University of Maryland (UMD), and Leaf
    Area Index (LAI) classification schemes are provided at yearly intervals at
    0.05 degree (5,600 meter) spatial resolution for the entire globe from 2001
    to 2022. Additionally, sub-pixel proportions of each land cover class in
    each 0.05 degree pixel is provided along with the aggregated quality
    assessment information for each of the three land classification schemes.

    Provided in each MCD12C1 Version 6.1 Hierarchical Data Format 4 (HDF4) file
    are layers for Majority Land Cover Type 1-3, Majority Land Cover Type 1-3
    Assessment, and Land Cover Type 1-3 Percent for each class.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/1409/MCD12_User_Guide_V61.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/86/MCD12_ATBD.pdf)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MCD12C1.061',
    }
  ],
  keywords: [
    'landcover',
    'modis',
    'nasa',
    'usgs',
    'yearly',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MCD12C1.061'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2484078896-LPCLOUD',
  ],
  extent: ee.extent_global('2001-01-01T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MCD12C1.061',
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
