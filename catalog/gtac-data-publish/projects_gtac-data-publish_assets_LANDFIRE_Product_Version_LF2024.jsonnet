local id = 'projects/gtac-data-publish/assets/LANDFIRE/Product_Version/LF2024';
local subdir = 'gtac-data-publish';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/LANDFIRE_2024_versions.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.proprietary;

local bands = import 'templates/LANDFIRE_2024_bands.libsonnet';
local publications = import 'templates/LANDFIRE_2024_publications.libsonnet';

{
  'gee:status': 'beta',
  'gee:user_uploaded': true,

  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'LANDFIRE 2024 Update ' + version,
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    LANDFIRE 2024 Update (LF 2024, version 2.5.0) is a 30-meter collection of vegetation, fuel, and disturbance products for the conterminous United States, Alaska, Hawaii, and Puerto Rico and the U.S. Virgin Islands. Each image represents one LANDFIRE study area and exposes the same ordered band schema.

    The collection combines current vegetation structure and type, canopy and surface fuel products, annual and preliminary disturbance products, and vegetation condition products. LANDFIRE creates these products from field and lidar reference data, satellite imagery, biophysical gradients, predictive landscape models, disturbance events, fire-program data, and remotely sensed landscape change. Derived disturbance bands provide normalized status, type, severity, and timing codes alongside the original LANDFIRE source codes.

    CFFDRS source data are available only for Alaska. SClass, VCC, and VDep source data are unavailable for Puerto Rico and the U.S. Virgin Islands.

    **Purpose**

    The LANDFIRE 2024 Update (LF 2024, version 2.5.0) is the fourth update to LANDFIRE's base map, LF 2016 Remap (version 2.0.0) and was released throughout calendar year 2025.

    LF 2024 products are designed to facilitate national and regional level strategic fire and resource management planning and reporting of management activities. The principal purposes of the products include providing: 1) national level landscape scale geospatial products to support fire and fuels management planning and 2) consistent fuels products to support fire planning, analysis, and budgeting to evaluate fire management alternatives.

    Products are created at a 30-meter raster; however, the applicability of products varies by location and specific use. LF products were designed to support 1) national (all states) strategic planning, 2) regional (single large states or groups of smaller states), and 3) strategic/tactical planning for large sub regional (such as significant portions of states or multiple federal administrative entities). The applicability of LF products to support fire and land management planning on smaller areas will vary by product, location, and specific use. Managers and planners must evaluate LF products according to the scale and requirements specific to their needs.

    **Methods**

    Methods for the LANDFIRE Remap base map are described in the [LANDFIRE Remap technical documentation](https://pubs.usgs.gov/publication/ofr20231045).

    Ongoing since the LF 2020 update all CONUS products are created with a 90km buffer into both Canada and Mexico.  

    The disturbance layers distributed here (Dist_status, Dist_type, Dist_severity, and equivalents for FDist and PDist) are derived from the original LANDFIRE disturbance layers (Dist_raw, FDist_raw, PDist_raw). The Dist_raw layer, or Final Annual Disturbance 2024, is created from the LANDFIRE disturbance and treatment database along with a composite of multiple disturbance sources. The derived layers provide normalized status, type, and severity codes alongside the original LANDFIRE source codes. The derived layers are intended to provide a more consistent and interpretable representation of disturbance events across the entire LANDFIRE study area. The remap scheme for Dist_raw is provided in the [LANDFIRE 2024 Disturbance Remap Metadata table](https://developers.google.com/earth-engine/datasets/catalog/projects_gtac-data-publish_assets_LANDFIRE_Product_Version_LF2024_Dist24_Remap_Metadata).

    **Usage Notes**

    When using any product from the LF 2024 fuel product suite, users should consider adjusting fuel layers for disturbances that occurred after the end of the 2024 fiscal year (on or after October 1, 2024). Disturbances that occurred after the end of the 2024 fiscal year are not accounted for within LF 2024 fuel products.

    **Additional Resources**

    For complete information about LANDFIRE products, see the [LANDFIRE website](https://www.landfire.gov/).

    For clarification on versioning and version naming, see the [LANDFIRE Versioning page](https://www.landfire.gov/data/comparison-table) and the [Historic LANDFIRE Naming Conventions](https://www.landfire.gov/LFNameConvention).

    These products were created by the LF team at USGS EROS, Sioux Falls, SD. For general support with data products, contact the LANDFIRE Help Desk at helpdesk@landfire.gov.

    These products were uploaded to the Google Earth Engine Publisher's Data Catalog by the Landscape Change Monitoring System (LCMS) team at the US Forest Service Geospatial Office. For support or inquiries regarding the Google Earth Engine Data Catalog, contact the LCMS team at support at sm.fs.lcms@usda.gov.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + (
    if std.length(version_table) > 1 then version_config.version_links else []
  ) + [
    ee.link.license('https://www.landfire.gov/'),
    {
      rel: ee_const.rel.source,
      href: 'https://www.landfire.gov/data',
    },
  ],
  'gee:categories': ['fire', 'landuse-landcover'],
  keywords: [
    'disturbance',
    'fire',
    'landcover',
    'landfire',
    'usda',
    'usfs',
    'usgs',
    'vegetation',
    'wildfire',
  ],
  providers: [
    ee.producer_provider(
      'LANDFIRE, U.S. Department of Agriculture Forest Service and U.S. '
      + 'Department of the Interior Geological Survey',
      'https://www.landfire.gov/'
    ),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent(-175.1,
                    17.52,
                    -63.66,
                    71.48,
                    '2023-10-01T00:00:00Z',
                    '2024-10-01T00:00:00Z'),
  summaries: {
    gsd: [30],
    'gee:schema': [
      {
        name: 'study_area',
        description: |||
          LANDFIRE study area. Values are CONUS, AK, HI, and PRVI.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'year',
        description: 'LANDFIRE product year.',
        type: ee_const.var_type.string,
      },
      {
        name: 'landfire_ver',
        description: 'LANDFIRE semantic version.',
        type: ee_const.var_type.string,
      },
      {
        name: 'landfire_version_name',
        description: 'LANDFIRE version name, such as LF_2024.',
        type: ee_const.var_type.string,
      },
      {
        name: 'landfire_version_number',
        description: 'Integer LANDFIRE version number, such as 250.',
        type: ee_const.var_type.int,
      },
    ],
    'eo:bands': bands.eo_bands,
    'gee:visualizations': bands.visualizations,
  },
  'sci:citation': |||
    LANDFIRE. 2024. LANDFIRE 2024 Update, LANDFIRE 2.5.0. U.S.
    Department of the Interior, U.S. Geological Survey, and U.S. Department
    of Agriculture, Forest Service. Available from
    [LANDFIRE](https://www.landfire.gov/).
  |||,
  'sci:publications': [
    {
      citation: |||
        Picotte, J. J., Dockter, D. J., Long, J., Tolk, B., Davidson, A.,
        Peterson, B., and Gage, J. D. 2023. LANDFIRE Remap technical
        documentation. U.S. Geological Survey Open-File Report 2023-1045.
        [doi:10.3133/ofr20231045](https://doi.org/10.3133/ofr20231045).
      |||,
      doi: '10.3133/ofr20231045',
    },
  ] + publications,
  'gee:terms_of_use': |||
    These data are marked with a Creative Common CC0 1.0 Universal License. 
    These data are in the public domain and do not have any use constraints. If
    modifications or derivatives are created, add a descriptive modifier to
    the dataset name to avoid confusion with the source LANDFIRE product.

    To cite LANDFIRE data, use the following citation:

    Format: 
    Data product. 
    (Last update). Agency. [Online]. 
    Available: URL [Access date].	

    Example: 
    LANDFIRE Existing Vegetation Type layer.
    (2024). U.S. Department of Interior, Geological Survey, and U.S. Department of Agriculture.[Online]. 
    Available: [LANDFIRE 2024 Update](https://developers.google.com/earth-engine/datasets/catalog/projects_gtac-data-publish_assets_LANDFIRE_Product_Version_LF2024).

    This product is reproduced from geospatial information prepared by the U.S. Department of the Interior (DOI) USGS EROS. By accessing these data or taking receipt of these files via electronic file transfer methods, you understand that the data stored on this media can be updated at any time. Represented features may not be in an accurate geographic location. USGS EROS makes no expressed or implied warranty, including warranty of merchantability and fitness, with respect to the character, function, or capabilities of the data or their appropriateness for any user's purposes. USGS EROS reserves the right to correct, update, modify, or replace this geospatial information without notification.

    Unless otherwise stated, all data, metadata and related materials are considered to satisfy the quality standards relative to the purpose for which the data were collected. Although these data and associated metadata have been reviewed for accuracy and completeness and approved for release by the U.S. Geological Survey (USGS), no warranty expressed or implied is made regarding the display or utility of the data for other purposes, nor on all computer systems, nor shall the act of distribution constitute any such warranty.
  |||,
}
