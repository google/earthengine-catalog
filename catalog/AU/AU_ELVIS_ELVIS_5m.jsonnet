local id = 'AU/ELVIS/ELVIS_5m';
local subdir = 'AU';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local elvis = import 'AU/ELVIS.libsonnet';

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
  title: 'Australia ELVIS Digital Elevation Model 5m',
  'gee:type': ee_const.gee_type.image_collection,
  'gee:status': 'beta',
  description: |||
    The Digital Elevation Model (DEM) 5 Metre Grid of Australia derived from
    LiDAR represents a National 5 metre bare earth DEM which has been derived
    from some 236 individual LiDAR surveys between 2001 and 2015 covering an
    area in excess of 245,000 square kilometres. These surveys cover
    Australia's populated coastal zone, floodplain surveys within the Murray
    Darling Basin, and individual surveys of major and minor population
    centres. All available 1 metre resolution LiDAR-derived DEMs have been
    compiled and resampled to 5 metre resolution datasets for each survey area,
    and then merged into a single dataset for each State. Each state's dataset
    is provided as a separate image within the image collection.
  ||| + elvis.common_description,
  license: elvis.license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(elvis.license.reference),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.4225/25/5652419862E23',
    },
  ],
  'gee:categories': ['elevation-topography'],
  keywords: elvis.common_keywords,
  providers: [
    ee.producer_provider(elvis.provider.name, elvis.provider.url),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(114.09, -43.45, 153.64, -9.88,
                    '2015-12-01T00:00:00Z', '2015-12-01T23:59:59Z'),
  summaries: {
    gsd: [5.0],
    'eo:bands': [
      elvis.elevation_band,
    ],
    'gee:visualizations': elvis.visualizations,
  },
  'sci:doi': '10.4225/25/5652419862E23',
  'sci:citation': |||
    Geoscience Australia, 2015. Digital Elevation Model (DEM) of Australia
    derived from LiDAR 5 Metre Grid. Geoscience Australia, Canberra.
  |||,
  'gee:terms_of_use': elvis.terms_of_use,
}
