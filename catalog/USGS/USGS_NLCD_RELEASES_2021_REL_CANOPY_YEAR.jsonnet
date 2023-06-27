// The asset id as referenced in Earth Engine:
// ee.ImageCollection('projects/usgs-gee-audra-griebel/assets/eros/canopy/year')

local id = 'USGS/NLCD_RELEASES/2021_REL/CANOPY/YEAR';
local subdir = 'USGS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc0_1_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  // TODO(schwehr): Remove skip_indexing when the dataset is ready.
  'gee:skip_indexing': true,
  'gee:user_uploaded': true,

  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Tree Canopy Cover (TCC) data (2011-2021) ' + version,
  version: version,
  'gee:type': ee_const.gee_type.image_collection,

  description: |||
    The USDA Forest Service (USFS) builds two versions of percent tree canopy
    cover data, in order to serve needs of multiple user communities. These
    datasets encompass conterminous United States (CONUS), Coastal Alaska,
    Hawaii, and Puerto Rico and U.S. Virgin Islands (PRUSVI).

    The two versions of data within the v2021-4 Tree Canopy Cover (TCC) product
    suite include: The initial model outputs referred to as the Science data;
    And a modified version built for the National Land Cover Database and
    referred to as NLCD data. The NLCD product suite includes data for years
    2011, 2013, 2016, 2019, and 2021.

    The NCLD data are processed to remove small interannual changes from the
    annual TCC timeseries, and to mask TCC pixels that are known to be 0 percent
    TCC, non-tree agriculture, and water.  A small interannual change is defined
    as a TCC change less than an increase or decrease of 10 percent compared to
    a TCC baseline value established in a prior year. The initial TCC baseline
    value is the mean of 2008-2010 TCC data. For each year following 2011, on a
    pixel-wise basis TCC values are updated to a new baseline value if an
    increase or decrease of 10 percent TCC occurs relative to the 2008-2010 TCC
    baseline value. If no increase or decrease greater than 10 percent TCC
    occurs relative to the 2008-2010 baseline, then the 2008-2010 TCC baseline
    value is caried through to the next year in the timeseries. Pixel values
    range from 0 to 100 percent.  The non-processing area is represented by
    value 254, and the background is represented by the value 255.  The Science
    and NLCD tree canopy cover data are accessible for multiple user
    communities, through multiple channels and platforms.

    For more information visit
    [Multi-Resolution Land Characteristics Consortium](
    https://www.mrlc.gov/data) or
    [The USFS Tree Canopy Cover Datasets page](
      https://data.fs.usda.gov/geodata/rastergateway/treecanopycover/).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'gtac',
    'landcover',
    'mrlc',
    'nlcd',
    'tree_cover',
    'usfs',
    'usgs',
    'yearly',
  ],
  providers: [
    ee.producer_provider(
      'The U.S. Forest Service (USFS) Geospatial Technology and Applications ' +
      'Center (GTAC)',
      'https://www.fs.usda.gov/about-agency/gtac'),
    ee.producer_provider(
      'Multi-Resolution Land Characteristics (MRLC) Consortium',
      'https://www.mrlc.gov/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-130.24, 21.75, -63.66, 50,
                    '2011-01-01T00:00:00Z', '2022-01-01T00:00:00Z'),
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  summaries: {
    gsd: [30],
    'eo:bands': [{
      name: 'cover',
      description: 'Tree Canopy Cover percent (254 for unprocessed)',
      'gee:units': units.percent,
    }],
    'gee:visualizations': [
      {
        display_name: 'cover (%)',
        lookat: {lon: -115.34, lat: 38.67, zoom: 6},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [255],
            palette: ['000080', '000080', 'fafad2'],
            bands: ['cover'],
          },
        },
      },
    ],
    cover: {minimum: 0, maximum: 254, 'gee:estimated_range': false}
  },
  'sci:citation': |||
    Yang, L.; Jin, S.; Danielson, P.; Homer, C.; Gass, L.; Bender, S.; 
    Case, A.; Costello, C.; Dewitz, J.; Fry, J.; Funk, M. 2018. 
    A new generation of the United States National Land Cover Database: 
    Requirements, research priorities, design, and implementation strategies. 
    ISPRS Journal of Photogrammetry and Remote Sensing 146:108-123. 
    [doi:10.1016/j.isprsjprs.2018.09.006](https://doi.org/10.1016/j.isprsjprs.2018.09.006)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license) + '\n\n' + |||
    This work was authored as part of the Contributor's official duties as an
    Employee of the United States Government and is therefore a work of the
    United States Government. In accordance with 17 U.S.C. 105, no copyright
    protection is available for such works under U.S. Law. This is an Open
    Access article that has been identified as being free of known restrictions
    under copyright law, including all related and neighboring rights
    (https://creativecommons.org/publicdomain/mark/1.0/). You can copy, modify,
    distribute and perform the work, even for commercial purposes, all without
    asking permission.
  |||,
}