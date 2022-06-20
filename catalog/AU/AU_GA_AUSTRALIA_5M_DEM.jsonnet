local id = 'AU/GA/AUSTRALIA_5M_DEM';
local subdir = 'AU';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;
local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'Australian 5M DEM',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Digital Elevation Model (DEM) 5 Metre Grid of Australia
    derived from LiDAR model represents a National 5 metre (bare
    earth) DEM which has been derived from some 236 individual LiDAR
    surveys between 2001 and 2015 covering an area in excess of 245,000
    square kilometres. These surveys cover Australia's populated
    coastal zone; floodplain surveys within the Murray Darling Basin,
    and individual surveys of major and minor population centres.
    All available 1 metre resolution LiDAR-derived DEMs have been
    compiled and resampled using a neighbourhood-mean method to 5
    metre resolution datasets for each survey area, and then merged
    into a single dataset for each State. Each state's dataset is
    provided as a separate image within the image collection.

    The acquisition of the individual LiDAR surveys and derivation
    of the 5m product has been part of a long-term collaboration
    between Geoscience Australia, the Cooperative Research Centre
    for Spatial Information (CRCSI), the Departments of Climate Change
    and Environment, State and Territory jurisdictions, Local Government
    and the Murray Darling Basin Authority under the auspices of
    the National Elevation Data Framework and Coastal and Urban DEM
    Program. The source datasets have been captured to standards
    that are generally consistent with the Australian ICSM LiDAR
    Acquisition Specifications with require a fundamental vertical
    accuracy of at least 0.30m (95% confidence) and horizontal accuracy
    of at least 0.80m (95% confidence).

    There are several areas close to Perth with null (NaN) values around
    (115.85, -31.99), (115.72, -33.75), and (115.10, -33.43).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.4225/25/5652419862E23',
    },
  ],
  keywords: [
    'australia',
    'dem',
    'elevation',
    'ga',
    'geophysical',
    'geoscience_australia',
    'lidar',
  ],
  providers: [
    ee.producer_provider('Geoscience Australia', 'https://ecat.ga.gov.au/geonetwork/srv/eng/catalog.search#/metadata/89644'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(114.09, -43.45, 153.64, -9.88,
                    '2015-12-01T00:00:00Z', '2015-12-01T00:00:00Z'),
  summaries: {
    gsd: [
      5.0,
    ],
    'eo:bands': [
      {
        name: 'elevation',
        description: 'Elevation',
        'gee:units': 'Meters',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Elevation',
        lookat: {
          lat: -35.9113,
          lon: 140.1883,
          zoom: 8,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              150.0,
            ],
            palette: [
              '0000ff',
              '00ffff',
              'ffff00',
              'ff0000',
              'ffffff',
            ],
            bands: [
              'elevation',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.4225/25/5652419862E23',
  'sci:citation': |||
    Geoscience Australia, 2015. Digital Elevation Model (DEM) of Australia
    derived from LiDAR 5 Metre Grid. Geoscience Australia, Canberra.
  |||,
  'gee:terms_of_use': |||
    This dataset is made available by Geoscience Australia
    under the Creative Commons Attribution 4.0 International Licence.
    The data must be referenced with the provided citation and DOI.
  |||,
}
