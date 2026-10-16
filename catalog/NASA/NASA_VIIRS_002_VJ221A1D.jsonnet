local id = 'NASA/VIIRS/002/VJ221A1D';
local subdir = 'NASA';
local version = '002';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local template = import 'templates/NASA_VIIRS_002_VNP21A1.libsonnet';

local license = spdx.proprietary;

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
  title: 'VJ221A1D.002: Day Land Surface Temperature and Emissivity Daily 1km',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The NOAA-21 Visible Infrared Imaging Radiometer Suite (VIIRS) Land Surface
    Temperature and Emissivity (LST&E) Day Version 2 product (VJ221A1D) is
    compiled daily from daytime Level 2 Gridded (L2G) intermediate products.

    The L2G process maps the daily VJ221 swath granules onto a sinusoidal MODIS
    grid and stores all observations overlapping a gridded cell for a given
    day. The VJ221A1 algorithm sorts through all these observations for each
    cell and estimates the final LST value as an average from all cloud-free
    observations that have good LST accuracies. Only observations having
    observation coverage more than a certain threshold (15%) are considered for
    this averaging.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/429/VNP21_User_Guide_V1.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/1332/VNP21_ATBD_V1.pdf)

    * [General Documentation](https://lpdaac.usgs.gov/products/vj221a1dv002/)

    * [Land Product Quality Assessment website](https://landweb.modaps.eosdis.nasa.gov/browse?sensor=VIIRS&sat=NOAA-21)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/VIIRS/VJ221A1D.002',
    },
  ],
  'gee:categories': ['weather-and-climate'],
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
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/VIIRS/VJ221A1D.002'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2831628020-LPCLOUD',
  ],
  extent: ee.extent_global('2023-02-10T00:00:00Z', null),
  summaries: template.summaries {
    'gee:schema': [
      {
        name: 'num_tiles',
        description: |||
          The number of source tiles that were mosaicked to create this image.
        |||,
        type: ee_const.var_type.int,
      },
    ],
    platform: [
      'NOAA-21',
    ],
  },
  'sci:doi': '10.5067/VIIRS/VJ221A1D.002',
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
