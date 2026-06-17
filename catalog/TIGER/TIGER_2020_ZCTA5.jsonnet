local id = 'TIGER/2020/ZCTA5';
local versions = import 'versions.libsonnet';
local version_table = import 'TIGER_ZCTA_versions.libsonnet';

local subdir = 'TIGER';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'TIGER: US Census 5-digit ZIP Code Tabulation Areas 2020',
  'gee:status': 'beta',
  version: version,
  'gee:type': ee_const.gee_type.table,
  description: |||
    ZIP Code tabulation areas (ZCTAs) are approximate area representations of
    U.S. Postal Service (USPS) 5-digit ZIP Codes.
    The Census Bureau defines ZCTAs by allocating each
    Census block that contains addresses to a single ZIP Code tabulation area, usually
    to the ZCTA that reflects the most frequently occurring ZIP Code for the
    addresses within that block. Blocks that do not contain addresses but that
    are completely surrounded by a single ZIP Code tabulation area (enclaves)
    are assigned to the surrounding ZCTA; those surrounded by multiple ZCTAs
    will be added to a single ZCTA based on the longest shared border.

    The Census Bureau identifies 5-digit ZIP Code tabulation areas using a 5-
    character numeric code that represents the most frequently occurring USPS
    ZIP Code within that ZCTA.  This code may contain leading zeros.

    Data users should not use ZCTAs to identify the official USPS ZIP Code for
    mail delivery. The USPS makes periodic changes to ZIP Codes to support more
    efficient mail delivery. ZIP Codes that cover primarily nonresidential or
    post office box addresses may not have a corresponding ZCTA because the
    delineation process uses primarily residential addresses, resulting in a
    bias towards ZIP Codes used for city-style mail delivery.

    For full technical details on all TIGER 2020 products, see the [TIGER
    technical documentation](https://www2.census.gov/geo/pdfs/maps-data/data/tiger/tgrshp2020/TGRSHP2020_TechDoc_Ch5.pdf)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
  ] + version_config.version_links,
  'gee:categories': ['infrastructure-boundaries'],
  keywords: [
    'census',
    'tiger',
    'us',
    'zcta',
    'zip_code',
  ],
  providers: [
    ee.producer_provider('United States Census Bureau', 'https://www.census.gov/programs-surveys/geography/guidance/tiger-data-products-guide.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -14.69, -64.435, 71.567,
                    '2020-01-01T00:00:00Z', '2020-01-02T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'ALAND20',
        description: '2020 Census Land area',
        type: ee_const.var_type.double,
        units: units.square_m,
      },
      {
        name: 'AWATER20',
        description: '2020 Census Water area',
        type: ee_const.var_type.double,
        units: units.square_m,
      },
      {
        name: 'CLASSFP20',
        description: '2020 Census FIPS 55 class code',
        type: ee_const.var_type.string,
      },
      {
        name: 'FUNCSTAT20',
        description: '2020 Census functional status\n(Always "S", for "Statistical entity".)',
        type: ee_const.var_type.string,
      },
      {
        name: 'GEOID20',
        description: '2020 Census 5-digit ZIP Code Tabulation Area identifier',
        type: ee_const.var_type.string,
      },
      {
        name: 'INTPTLAT20',
        description: '2020 Census latitude of the internal point',
        type: ee_const.var_type.string,
      },
      {
        name: 'INTPTLON20',
        description: '2020 Census longitude of the internal point',
        type: ee_const.var_type.string,
      },
      {
        name: 'MTFCC20',
        description: 'MAF/TIGER feature class code (Always "G6350".)',
        type: ee_const.var_type.string,
      },
      {
        name: 'ZCTA5CE20',
        description: '2020 Census 5-digit ZIP Code Tabulation Area code',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'ZCTA Boundaries',
        lookat: {
          lat: 37.649,
          lon: -99.844,
          zoom: 5,
        },
        polygon_visualization: {
          property_name: 'ALAND20',
          property_vis: {
            min: [
              500000.0,
            ],
            max: [
              500000000.0,
            ],
            palette: [
              'purple',
              'blue',
              'green',
              'yellow',
              'orange',
              'red',
            ],
          },
        },
      },
      {
        display_name: 'ZCTA Boundaries',
        visualize_as: 'FeatureView',
        lookat: {
          lat: 37.649,
          lon: -99.844,
          zoom: 5,
        },
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 16000,
      thinning_strategy: 'HIGHER_DENSITY',
      prerender_tiles: true,
    },
  },
  'sci:citation': |||
    For the creation of any reports, publications, new data sets, derived
    products, or services resulting from the data set, users should
    [cite the US Census Bureau](https://www.census.gov/about/policies/citation.html).
  |||,
  'gee:terms_of_use': |||
    The U.S. Census Bureau offers some of its public data
    in machine-readable format via an Application Programming Interface
    (API). All of the content, documentation, code and related materials
    made available to you through the API are subject to [these terms and
    conditions](https://www.census.gov/data/developers/about/terms-of-service.html).
  |||,
}
