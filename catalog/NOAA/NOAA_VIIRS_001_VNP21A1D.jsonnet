local id = 'NOAA/VIIRS/001/VNP21A1D';
local subdir = 'NOAA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local template = import 'templates/NOAA_VIIRS_001_VNP21A1.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'VNP21A1D: Day Land Surface Temperature and Emissivity Daily 1km',
  version: '1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The NASA Suomi National Polar-Orbiting Partnership (Suomi NPP) Visible
    Infrared Imaging Radiometer Suite (VIIRS) Land Surface Temperature and
    Emissivity (LST&E) Day Version 1 product (VNP21A1D) is compiled daily
    from daytime Level 2 Gridded (L2G) intermediate products.

    The L2G process maps the daily VNP21 swath granules onto a sinusoidal MODIS
    grid and stores all observations overlapping a gridded cell for a given
    day. The VNP21A1 algorithm sorts through all these observations for each
    cell and estimates the final LST value as an average from all cloud-free
    observations that have good LST accuracies. Only observations having
    observation coverage more than a certain threshold (15%) are considered for
    this averaging.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/429/VNP21_User_Guide_V1.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/1332/VNP21_ATBD_V1.pdf)

    * [General Documentation](https://lpdaac.usgs.gov/products/vnp21a1dv001/)

    * [Land Product Quality Assessment website](https://landweb.modaps.eosdis.nasa.gov/NPP_QA/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/VIIRS/VNP21A1D.001',
    },
  ],
  keywords: [
    'daily',
    'day',
    'land',
    'nasa',
    'noaa',
    'surface',
    'temperature',
    'viirs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/VIIRS/VNP21A1D.001'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1442270800-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2012-01-19T00:00:00Z', null),
  summaries: template.summaries,
  'sci:doi': '10.5067/VIIRS/VNP21A1D.001',
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
    LP DAAC NASA data are freely accessible; however, when an author
    publishes these data or works based on the data, it is requested that the
    author cite the datasets within the text of the publication and include a
    reference to them in the reference list.
  |||,
}
