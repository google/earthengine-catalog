local id = 'projects/gtac-data-publish/assets/LANDFIRE/Product_Version/LF2024_Dist24_Remap_Metadata';
local subdir = 'gtac-data-publish';
local version = '2.5.0';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  'gee:status': 'beta',
  'gee:user_uploaded': true,
  'gee:skip_featureview_generation': true,

  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'LANDFIRE 2024 Disturbance Remap Metadata ' + version,
  version: version,
  'gee:type': ee_const.gee_type.table,
  description: |||
    The LANDFIRE 2024 Disturbance Remap Metadata table is a nonspatial lookup
    table for interpreting values in the `Dist_raw` band of the LANDFIRE 2024
    Update collection. Each row identifies a source value and its disturbance
    year, source datasets, original type and severity, and normalized remap
    codes for disturbance status, type, and severity.

    The table includes current- and prior-calendar-year classes represented in
    the fiscal year 2024 product, along with background, water, and NoData
    classes. Uppercase fields contain source or descriptive labels. Fields
    beginning with `Dist_` contain the numeric normalized codes used by derived
    bands in the LANDFIRE 2024 collection.

    Features have empty geometries. Use this asset as a lookup table with
    `aggregate_array`, filters, or joins; it is not intended for map display or
    FeatureView generation.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
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
    'wildfire',
  ],
  providers: [
    ee.producer_provider(
      'LANDFIRE, U.S. Department of Agriculture Forest Service and U.S. '
      + 'Department of the Interior Geological Survey',
      'https://www.landfire.gov/'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-175.1,
                    17.52,
                    -63.66,
                    71.48,
                    '2023-10-01T00:00:00Z',
                    '2024-10-01T00:00:00Z'),
  summaries: {
    'gee:visualizations': [
      {
        display_name: 'Disturbance remap metadata',
        lookat: {lon: -112.0, lat: 40.0, zoom: 5},
        // Nonspatial rows render no map features.
        table_visualization: {},
      },
    ],
    'gee:schema': [
      {
        name: "VALUE",
        description: "Source pixel value in the LANDFIRE 2024 Dist_raw band.",
        type: ee_const.var_type.int,
      },
      {
        name: "FISCAL_YR",
        description: "LANDFIRE production fiscal year associated with the class.",
        type: ee_const.var_type.int,
      },
      {
        name: "CALENDAR_YR",
        description: "Calendar year in which the represented disturbance occurred.",
        type: ee_const.var_type.int,
      },
      {
        name: "DIST_TYPE",
        description: "Original disturbance type assigned to the source class.",
        type: ee_const.var_type.string,
      },
      {
        name: "SEVERITY",
        description: "Original severity label assigned to the source class.",
        type: ee_const.var_type.string,
      },
      {
        name: "SEV_SOURCE",
        description: "Dataset or method used to determine disturbance severity.",
        type: ee_const.var_type.string,
      },
      {
        name: "PRIMARY_SOURCE",
        description: "Primary source dataset for the disturbance class.",
        type: ee_const.var_type.string,
      },
      {
        name: "SECONDARY_SOURCE",
        description: "Secondary source dataset or processing method, when applicable.",
        type: ee_const.var_type.string,
      },
      {
        name: "DESCRIPTION",
        description: "Description of the source class and its provenance.",
        type: ee_const.var_type.string,
      },
      {
        name: "STATUS",
        description: "Normalized disturbance-status label.",
        type: ee_const.var_type.string,
      },
      {
        name: "Dist_status",
        description: "Numeric code for the normalized disturbance status.",
        type: ee_const.var_type.int,
      },
      {
        name: "TYPE_L1",
        description: "Normalized level-1 disturbance-type label.",
        type: ee_const.var_type.string,
      },
      {
        name: "Dist_type_L1",
        description: "Numeric code for the normalized level-1 disturbance type.",
        type: ee_const.var_type.int,
      },
      {
        name: "TYPE_L2",
        description: "Normalized level-2 disturbance-type label.",
        type: ee_const.var_type.string,
      },
      {
        name: "Dist_type_L2",
        description: "Numeric code for the normalized level-2 disturbance type.",
        type: ee_const.var_type.int,
      },
      {
        name: "REMAP_SEVERITY",
        description: "Normalized disturbance-severity label.",
        type: ee_const.var_type.string,
      },
      {
        name: "Dist_severity",
        description: "Numeric code for the normalized disturbance severity.",
        type: ee_const.var_type.int,
      },
    ],
  },
  'sci:citation': |||
    LANDFIRE. 2024. LANDFIRE 2024 Disturbance Remap Metadata, LANDFIRE 2.5.0.
    U.S. Department of the Interior, U.S. Geological Survey, and U.S.
    Department of Agriculture, Forest Service. Available from
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
  ],
  'gee:terms_of_use': |||
    LANDFIRE data are public domain data with no use restrictions. If
    modifications or derivatives are created, add a descriptive modifier to
    the dataset name to avoid confusion with the source LANDFIRE product.
  |||,
}
