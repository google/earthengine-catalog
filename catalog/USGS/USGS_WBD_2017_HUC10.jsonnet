local id = 'USGS/WBD/2017/HUC10';
local subdir = 'USGS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
  ],
  id: id,
  title: 'HUC10: USGS Watershed Boundary Dataset of Watersheds',
  'gee:type': ee_const.gee_type.table,
  description: |||
    The Watershed Boundary Dataset (WBD) is a comprehensive
    aggregated collection of hydrologic unit (HU) data consistent
    with the national criteria for delineation and resolution. It
    defines the areal extent of surface water drainage to a point
    except in coastal or lake front areas where there could be multiple
    outlets as stated by the [Federal Standards and Procedures for
    the National Watershed Boundary Dataset](https://pubs.usgs.gov/tm/11/a3).
    Watershed boundaries are determined solely upon science-based
    hydrologic principles, not favoring any administrative boundaries
    or special projects, nor particular program or agency. The intent
    of defining HUs for the WBD is to establish a baseline drainage
    boundary framework, accounting for all land and surface areas.

    The HUs are delineated at 1:24,000-scale in the conterminous
    United States, 1:25,000-scale in Hawaii and the Caribbean, and
    1:63,360-scale in Alaska, meeting the National Map Accuracy Standards
    (NMAS). WBDs are represented as polygons that define the boundary
    of the HUs. The HUs are given a Hydrologic Unit Code (HUC) that
    ranges from 2 digits to 12 digits. These codes describe where
    the unit is in the country and the level of the unit. The number
    of digits in a HUC is related to 6 levels of detail for the WBD:
    the lower level polygons cover larger areas than higher level
    ones. The higher the level, the more digits to the HUC, since
    previous levels are nested in it.

    The WBD polygons attributes
    include HUCs, size (in the form of acres and square kilometers),
    name, downstream HUC, type of watershed, non-contributing areas,
    and flow modifications. WBD line attributes contain the highest
    level of hydrologic unit for each boundary, line source information
    and flow modifications.

    | Name         | Level | Digit | HU Code |
    |--------------|-------|-------|---------|
    | Region       | 1     | 2     | 2       |
    | Subregion    | 2     | 4     | 4       |
    | Basin        | 3     | 6     | 6       |
    | Subbasin     | 4     | 8     | 8       |
    | Watershed    | 5     | 10    | 10      |
    | Subwatershed | 6     | 12    | 12      |

    *Calculated by the data provider.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
    {
      rel: ee_const.rel.source,
      href: 'https://nrcs.app.box.com/v/huc',
    },
  ],
  'gee:categories': ['surface-ground-water'],
  keywords: [
    'hydrology',
    'usgs',
    'water',
    'watershed',
    'wbd',
  ],
  providers: [
    ee.producer_provider('United States Geological Survey', 'https://nhd.usgs.gov/wbd.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -14.69, 180.0, 71.567,
                    '2017-04-22T00:00:00Z', '2017-04-23T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'areaacres',
        description: 'Size of the feature in acres',
        type: ee_const.var_type.string,
      },
      {
        name: 'areasqkm',
        description: 'Size of the feature in square kilometers',
        type: ee_const.var_type.string,
      },
      {
        name: 'gnis_id',
        description: 'A unique number to relate the name of the hydrologic\nunit to the GNIS names database (always empty)',
        type: ee_const.var_type.string,
      },
      {
        name: 'loaddate',
        description: 'Date when the data were loaded into the official provider database',
        type: ee_const.var_type.string,
      },
      {
        name: 'metasource',
        description: 'A unique identifier that links the element to the metadata tables',
        type: ee_const.var_type.string,
      },
      {
        name: 'name',
        description: 'GNIS name for the geographic area in which the hydrologic unit is located',
        type: ee_const.var_type.string,
      },
      {
        name: 'shape_area',
        description: 'Area of feature in internal units squared',
        type: ee_const.var_type.string,
      },
      {
        name: 'shape_leng',
        description: 'Length of feature in internal units',
        type: ee_const.var_type.string,
      },
      {
        name: 'sourcedata',
        description: |||
          A space provided for a brief description of the
          type of base data used to update or change the current WBD
          (always empty)
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'sourcefeat',
        description: 'Identifies the parent of the feature if the feature\nis the result of a split or merge (always empty)',
        type: ee_const.var_type.string,
      },
      {
        name: 'sourceorig',
        description: 'Description of the agency that created the base\ndata used to improve the WBD (always empty)',
        type: ee_const.var_type.string,
      },
      {
        name: 'states',
        description: 'Identifies the State(s) or outlying areas that the\nhydrologic unit falls within or touches',
        type: ee_const.var_type.string,
      },
      {
        name: 'tnmid',
        description: 'A unique 40-character field that identifies each\nelement in the database exclusively',
        type: ee_const.var_type.string,
      },
      {
        name: 'huc10',
        description: 'Unique hydrologic unit code',
        type: ee_const.var_type.string,
      },
      {
        name: 'humod',
        description: 'Hydrologic unit modification attribute(s)',
        type: ee_const.var_type.string,
      },
      {
        name: 'hutype',
        description: |||
          The 12-digit hydrologic unit type attribute is a single-letter
          abbreviation for watershed type from the list of official names
          provided in the WBD Standards
        |||,
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Watersheds',
        lookat: {
          lat: 37.65,
          lon: -90.62,
          zoom: 4,
        },
        table_visualization: {
          color: '2e5d7e',
          width: 1.0,
          fill_color: '2e85bb',
        },
      },
      {
        display_name: 'Watersheds',
        visualize_as: 'FeatureView',
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 16000,
      thinning_strategy: 'HIGHER_DENSITY',
      thinning_ranking: ['shape_area DESC'],
      prerender_tiles: true,
    },
  },
  'sci:citation': |||
    Coordinated effort between the United States Department of Agriculture-Natural
    Resources Conservation Service (USDA-NRCS), the United States Geological
    Survey (USGS), and the Environmental Protection Agency (EPA). The
    Watershed Boundary Dataset (WBD) was created from a variety of
    sources from each state and aggregated into a standard national
    layer for use in strategic planning and accountability. Watershed
    Boundary Dataset for HUC# [Online WWW]. Available URL: (https://datagateway.nrcs.usda.gov)
    [Accessed 22/04/2017].
  |||,
  'gee:terms_of_use': |||
    Most U.S. Geological Survey (USGS) information resides
    in the public domain and may be used without restriction. Additional
    information on [Acknowledging or Crediting USGS as Information
    Source](https://www.usgs.gov/information-policies-and-instructions/crediting-usgs) is available.
  |||,
}
