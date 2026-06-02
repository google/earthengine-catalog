local id = 'NASA/VIIRS/002/VNP22Q2';
local subdir = 'NASA';
local version = '2';
local predecessor_id = 'NOAA/VIIRS/001/VNP22Q2';
local latest_id = id;

local viirs_vnp22q2_bands = import '../NOAA/viirs_vnp22q2_bands.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local predecessor_basename = std.strReplace(predecessor_id, '/', '_');
local latest_basename = std.strReplace(latest_id, '/', '_');
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
  title: 'VNP22Q2.002: Land Surface Phenology Yearly L3 Global 500m SIN Grid',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Suomi National Polar-Orbiting Partnership (Suomi NPP) NASA Visible
    Infrared Imaging Radiometer Suite (VIIRS) Land Surface Phenology Yearly
    (VNP22Q2) Version 2 data product provides global land surface phenology (GLSP)
    metrics at yearly intervals. The VNP22Q2 data product is derived from time
    series of the two-band Enhanced Vegetation Index (EVI2) calculated from
    VIIRS Nadir Bidirectional Reflectance Distribution Function (BRDF)-Adjusted
    Reflectance (NBAR). Vegetation phenology metrics at 500 meter spatial
    resolution are identified for up to two detected growing cycles per year.

    The product contains six phenological transition dates: onset of greenness
    increase, onset of greenness maximum, onset of greenness decrease, onset of
    greenness minimum, dates of mid-greenup, and senescence phases. The product
    also includes the growing season length. The greenness-related metrics
    consist of EVI2 onset of greenness increase, EVI2 onset of greenness
    maximum, EVI2 growing season, rate of greenness increase, and rate of
    greenness decrease. The confidence of phenology detection is provided as
    greenness agreement growing season, proportion of good quality (PGQ)
    growing season, PGQ onset greenness increase, PGQ onset greenness maximum,
    PGQ onset greenness decrease, and PGQ onset greenness minimum.
    The final layer is quality control specifying the overall quality of the
    product.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/2263/VNP22_UserGuide_v2.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/2228/VNP22_ATBD_V2.pdf)

    * [General Documentation](https://doi.org/10.5067/VIIRS/VNP22Q2.002)

    * [Land Product Quality Assessment website](https://landweb.modaps.eosdis.nasa.gov/browse?sensor=VIIRS&sat=SNPP)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/VIIRS/VNP22Q2.002',
    },
    ee.link.latest(latest_id, catalog_subdir_url + latest_basename + '.json'),
    ee.link.predecessor(predecessor_id, ee_const.catalog_base + 'NOAA/' +
      predecessor_basename + '.json'),
  ],
  'gee:categories': ['vegetation-indices'],
  keywords: [
    'land',
    'nasa',
    'ndvi',
    'noaa',
    'npp',
    'onset_greenness',
    'phenology',
    'surface',
    'vegetation',
    'viirs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/VIIRS/VNP22Q2.002'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2847915918-LPCLOUD',
  ],
  extent: ee.extent_global('2013-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      500.0,
    ],
    'gee:schema': [
      {
        name: 'num_tiles',
        description: 'The number of source tiles that were mosaicked to create this image.',
        type: 'INT',
      },
    ],
    platform: [
      'Suomi NPP',
    ],
    instruments: [
      'VIIRS',
    ],
    'eo:bands': [
      if band.name != 'GLSP_QC' then
      {
        name: band.name+'_'+cycle,
        description: band.description
      }
      else {
        name: band.name+'_'+cycle,
        description: band.description,
        'gee:bitmask': band.bitmask
      }
      for cycle in std.range(1, 2) for band in viirs_vnp22q2_bands.bands
    ],
    'gee:visualizations': [
      {
        display_name: 'Default visualization',
        lookat: {
          lat: 27.808,
          lon: 95.571,
          zoom: 8,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              10000.0,
            ],
            palette: [
              '000000',
              '004400',
              '008800',
              '00bb00',
              '00ff00',
            ],
            bands: [
              'EVI2_Growing_Season_Area_1',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5067/VIIRS/VNP22Q2.002',
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
    LP DAAC NASA data are freely accessible; however, when an author
    publishes these data or works based on the data, it is requested that the
    author cite the datasets within the text of the publication and include a
    reference to them in the reference list.
  |||,
}
