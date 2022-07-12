local id = 'WWF/HydroSHEDS/v1/Basins/hybas_1';
local subdir = 'WWF';

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
  title: 'WWF HydroSHEDS Basins Level 1',
  'gee:type': ee_const.gee_type.table,
  description: |||
    HydroSHEDS is a mapping product that provides hydrographic
    information for regional and global-scale applications in a consistent
    format. It offers a suite of geo-referenced datasets (vector and
    raster) at various scales, including river networks, watershed
    boundaries, drainage directions, and flow accumulations. HydroSHEDS
    is based on elevation data obtained in 2000 by NASA's Shuttle Radar
    Topography Mission (SRTM).

    This dataset provides polygons of nested, hierarchical watersheds, based on
    15 arc-seconds (approx. 500 m at the equator) resolution raster data.
    The watersheds range from level 1 (coarse) to level 12 (detailed), using Pfastetter codes.

    Technical documentation:

    [https://hydrosheds.org/images/inpages/HydroBASINS_TechDoc_v1c.pdf](https://hydrosheds.org/images/inpages/HydroBASINS_TechDoc_v1c.pdf)

    Note that the quality of the HydroSHEDS data is significantly lower for regions above
    60 degrees northern latitude as there is no underlying SRTM elevation data available
    and thus a coarser-resolution DEM was (HYDRO1k provided by USGS).

    HydroSHEDS was developed by the World Wildlife Fund (WWF)
    Conservation Science Program in partnership with the U.S. Geological
    Survey, the International Centre for Tropical Agriculture, The
    Nature Conservancy, and the Center for Environmental Systems Research
    of the University of Kassel, Germany.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'geophysical',
    'hydrography',
    'hydrology',
    'hydrosheds',
    'srtm',
    'water',
    'watershed',
    'wwf',
  ],
  providers: [
    ee.producer_provider('WWF', 'https://www.hydrosheds.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-02-11T00:00:00Z', '2000-02-22T00:00:00Z'),
  summaries: {
    'gee:properties': [
      {
        name: 'HYBAS_ID',
        description: |||
          First 1 digit represents the region:
            * 1 = Africa
            * 2 = Europe
            * 3 = Siberia
            * 4 = Asia
            * 5 = Australia
            * 6 = South America
            * 7 = North America
            * 8 = Arctic (North America)
            * 9 = Greenland.

          Next 2 digits define the Pfafstetter level (01-12). The value '00' is used for the
          'Level 0' layer that contains all original sub-basins and all Pfafstetter codes (at
          all levels); 'Level 0' only exists in the standard format of HydroBASINS
          (without lakes).

          Next 6 digits represent a unique identifier within the HydroSHEDS network;
          values larger than 900,000 represent lakes and only occur in the customized
          format (with lakes)

          Last 1 digit indicates the side of a sub-basin in relation to the river network (0 =
          noSide; 1 = Left; 2 = Right). Sides are only defined for the customized format
          (with lakes).
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'NEXT_DOWN',
        description: 'Hybas_id of the next downstream polygon.',
        type: ee_const.var_type.int,
      },
      {
        name: 'NEXT_SINK',
        description: 'Hybas_id of the next downstream sink.',
        type: ee_const.var_type.int,
      },
      {
        name: 'MAIN_BAS',
        description: 'Hybas_id of the most downstream sink, i.e. the outlet of the main river basin.',
        type: ee_const.var_type.int,
      },
      {
        name: 'DIST_SINK',
        description: 'Distance from polygon outlet to the next downstream sink, in km.',
        type: ee_const.var_type.double,
      },
      {
        name: 'DIST_MAIN',
        description: 'Distance from polygon outlet to the most downstream sink, in km.',
        type: ee_const.var_type.double,
      },
      {
        name: 'SUB_AREA',
        description: 'Area of basin, in square kilometers.',
        type: ee_const.var_type.double,
      },
      {
        name: 'UP_AREA',
        description: 'Total upstream area, in square kilometers.',
        type: ee_const.var_type.double,
      },
      {
        name: 'PFAF_ID',
        description: 'The Pfafstetter code.',
        type: ee_const.var_type.int,
      },
      {
        name: 'ENDO',
        description: |||
          Indicator for endorheic (inland) basins without surface flow connection to the
          ocean: 0 = not part of an endorheic basin; 1 = part of an endorheic basin; 2 = sink
          (i.e. most downstream polygon) of an endorheic basin.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'COAST',
        description: |||
          Indicator for lumped coastal basins: 0 = no; 1 = yes. Coastal basins represent
          conglomerates of small coastal watersheds that drain into the ocean between larger
          river basins.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'ORDER',
        description: |||
          Indicator of river order (classical ordering system):
          * Order 1 represents the main stem river from sink to source;
          * Order 2 represents all tributaries that flow into a 1st order river;
          * Order 3 represents all tributaries that flow into a 2nd order river; etc.;
          * Order 0 is used for conglomerates of small coastal watersheds.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'SORT',
        description: |||
          Indicator showing the record number (sequence) in which the original polygons are
          stored in the shapefile (i.e. counting upwards from 1 in the original shapefile). The
          original polygons are sorted from downstream to upstream. This field can be used to
          sort the polygons back to their original sequence or to perform topological searches.
        |||,
        type: ee_const.var_type.property_type_unspecified,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Basins',
        lookat: {
          lat: 40.74101,
          lon: -73.99172,
          zoom: 12,
        },
        table_visualization: {
          color: 'B2B2B3',
          width: 1.0,
        },
      },
      {
        display_name: 'Basins',
        visualize_as: 'FeatureView',
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 250,
      thinning_strategy: 'HIGHER_DENSITY',
      thinning_ranking: 'SUB_AREA DESC',
    },
  },
  'sci:citation': |||
    Lehner, B., Verdin, K., Jarvis, A. (2008): New global hydrography
    derived from spaceborne elevation data. Eos, Transactions, AGU,
    89(10): 93-94.
  |||,
  'sci:publications': [
    {
      citation: |||
        Lehner, B., Grill G. (2013): Global river hydrography and network routing: baseline data and
        new approaches to study the world’s large river systems. Hydrological Processes, 27(15):
        2171-2186. Data is available at www.hydrosheds.org
      |||,
    },
  ],
  'gee:terms_of_use': |||
    HydroSHEDS data are free for non-commercial and commercial
    use. For more information, please refer to the [License Agreement](https://www.hydrosheds.org/page/license).
  |||,
  'gee:user_uploaded': true,
}
