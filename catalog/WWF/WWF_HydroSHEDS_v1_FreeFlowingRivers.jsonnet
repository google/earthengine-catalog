local id = 'WWF/HydroSHEDS/v1/FreeFlowingRivers';
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
  title: 'WWF HydroSHEDS Free Flowing Rivers Network v1',
  'gee:type': ee_const.gee_type.table,
  description: |||
    HydroSHEDS is a mapping product that provides hydrographic
    information for regional and global-scale applications in a consistent
    format. It offers a suite of geo-referenced datasets (vector and
    raster) at various scales, including river networks, watershed
    boundaries, drainage directions, and flow accumulations. HydroSHEDS
    is based on elevation data obtained in 2000 by NASA's Shuttle Radar
    Topography Mission (SRTM).

    This dataset provides polylines that represent river networks, derived from and consistent
    with other HydroSHEDS datasets. These data are based on 15 arc-seconds
    (approx. 500 m at the equator) resolution raster data.

    [Mapping the world's free-flowing rivers: data set and technical documentation](
    https://figshare.com/articles/Mapping_the_world_s_free-flowing_rivers_data_set_and_technical_documentation/7688801)

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
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, basename + '_FeatureView'),
  ],
  keywords: [
    'flow_regulation',
    'geophysical',
    'hydrography',
    'hydrology',
    'hydrosheds',
    'river_networks',
    'srtm',
    'water',
    'wwf',
  ],
  providers: [
    ee.producer_provider('WWF', 'https://www.hydrosheds.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-02-11T00:00:00Z', '2000-02-22T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'BAS_ID',
        description: 'Basin Identifier. Identifies the hydrological river basin according to the\nHydroSHEDS framework',
        type: ee_const.var_type.int,
      },
      {
        name: 'BAS_NAME',
        description: 'Basin Name (if available). Based on HydroSHEDS original basins and other sources.',
        type: ee_const.var_type.string,
      },
      {
        name: 'BB_DIS_ORD',
        description: |||
          Backbone river discharge order. River Order (RIV_ORD) of the most downstream
          reach of the backbone river (BB_ID).
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'BB_ID',
        description: |||
          Backbone River Identifier. Represents the contiguous river unit (defined as
          flow path from source/headwater to sink/terminus).
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'BB_LEN_KM',
        description: 'Backbone river length. Sum of length (LENGTH_KM) of the river reaches of the\nbackbone river (BB_ID).',
        type: ee_const.var_type.double,
      },
      {
        name: 'BB_OCEAN',
        description: |||
          Ocean connectivity. Determines if river reach is part of a backbone river (BB_ID)
          that is directly connected to the ocean (value=1) or not (value=0). Used to summarize
          statistics based on connectivity to ocean.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'BB_VOL_TCM',
        description: 'Backbone river volume. Sum of volume (VOLUME_TCM) of the river reaches of the\nbackbone river (BB_ID).',
        type: ee_const.var_type.double,
      },
      {
        name: 'CONTINENT',
        description: 'Name of the continent. See CON_ID.',
        type: ee_const.var_type.string,
      },
      {
        name: 'CON_ID',
        description: |||
          Identifier for the continent to which the reach beINTs. Continent boundaries are
          delineated based on HydroBASINS.
           * 1 = North America
           * 2 = South America
           * 3 = Europe
           * 4 = Africa
           * 5 = Asia
           * 6 = Australia
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'COUNTRY',
        description: 'Country name',
        type: ee_const.var_type.string,
      },
      {
        name: 'CSI',
        description: 'Connectivity Status. Index from 0 to 100%; 100% = full connectivity; 0% = no connectivity.',
        type: ee_const.var_type.double,
      },
      {
        name: 'CSI_D',
        description: 'Dominant pressure factor (DOM). Possible field values are: DOF; DOR; SED; USE; RDD; URB.',
        type: ee_const.var_type.string,
      },
      {
        name: 'CSI_FF',
        description: |||
          CSI above or below free-flowing threshold. Indicates if the CSI value of a river
          reach is below (value = 0) or above (value = 1) the threshold of 95%. The attribute
          is used to calculate the free-flowing status of the river (see CSI_FF1 and CSI_FF2).
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'CSI_FF1',
        description: |||
          Free-flowing status (two categories). Indicates river reaches that beINT to a
          river with "freeflowing" status (value = 1) or "non-free-flowing" status (value = 3).
          Note that the value 2 is reserved for river stretches with "good connectivity"
          status (see CSI_FF2).
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'CSI_FF2',
        description: |||
          Free-flowing status (three categories). Indicates river reaches that beINT
          to a river with "free flowing" status (value = 1), or a river stretch with
          "good connectivity" status (value = 2) or a river or river stretch with
          "impacted" status(value = 3).
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'CSI_FFID',
        description: 'River stretch identifier. Additional identifier to distinguish contiguous\nriver stretches.',
        type: ee_const.var_type.int,
      },
      {
        name: 'DIS_AV_CMS',
        description: 'Average INT-term (1971-2000) naturalized discharge in cubic meters per second (CMS).',
        type: ee_const.var_type.double,
      },
      {
        name: 'DOF',
        description: 'Degree of Fragmentation. Index from 0 to 100% (see extended Data figure 5a of manuscript).',
        type: ee_const.var_type.double,
      },
      {
        name: 'DOR',
        description: 'Degree of Regulation. Index from 0 to 100% (see extended Data figure 5b of manuscript).',
        type: ee_const.var_type.double,
      },
      {
        name: 'ERO_YLD_TO',
        description: |||
          Sum of erosion in tons per year per river reach. Calculated as the sum
          of sediment erosion within the river reach catchment (i.e., sediment erosion
          is not accumulated aINT the river network).
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'FLD',
        description: 'Inundation (floodplain) extent in river reach catchment (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'GOID',
        description: 'The feature ID.',
        type: ee_const.var_type.int,
      },
      {
        name: 'HYFALL',
        description: 'Indicates the presence (1) or absence (0) of one or more waterfalls\naINT the river reach.',
        type: ee_const.var_type.double,
      },
      {
        name: 'INC',
        description: |||
          Filter field. In Grill et al. (2019), we considered all river reaches for
          routing purposes, but only analyzed and produced results for a subset of
          river reaches (INC = 1).
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'LENGTH_KM',
        description: 'Length of the river reach in kilometers.',
        type: ee_const.var_type.double,
      },
      {
        name: 'NDOID',
        description: |||
          Identifies the NOID of the next downstream river reach. If value=0, the river reach
          represents a terminal reach (ocean, inland sink).
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'NOID',
        description: "Network Object Identifier. Same purpose as GOID'",
        type: ee_const.var_type.int,
      },
      {
        name: 'NUOID',
        description: |||
          Identifies the NOIDs of the next upstream river reach. If there is "NoData"
          given, the reach is a headwater reach. Otherwise, the field holds 2 or more
          NOIDs. In the case of multiple NOIDs, the NOIDs are separated by an underscore.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'OBJECTID',
        description: 'Object Identifier',
        type: ee_const.var_type.int,
      },
      {
        name: 'RDD',
        description: 'Road construction. Index from 0 to 100% (see extended Data figure 5e of manuscript).',
        type: ee_const.var_type.double,
      },
      {
        name: 'REACH_ID',
        description: 'Reach Identifier. The reach identifier can be used to link this dataset to\nthe HydroATLAS database.',
        type: ee_const.var_type.int,
      },
      {
        name: 'RIV_ORD',
        description: |||
          River order. River order is here defined and calculated based on the INT-term
          average discharge (DIS_AV_CMS) using logarithmic progression:
           * 1 = > 100000
           * 2 = 10000 - 100000
           * 3 = 1000 - 10000
           * 4 = 100 - 1000
           * 5 = 10 - 100
           * 6 = 1 - 10
           * 7 = 0.1 - 1
           * 8 = 0.01 - 0.1
           * 9 = 0.001 - 0.01
           * 10 = < 0.001
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'SED',
        description: 'Sediment trapping. Index from 0 to 100% (see extended Data figure 5c of manuscript).',
        type: ee_const.var_type.double,
      },
      {
        name: 'Shape_Leng',
        description: 'Use field LENGTH_KM instead.',
        type: ee_const.var_type.double,
      },
      {
        name: 'UPLAND_SKM',
        description: 'Upstream watershed area of river reach in square kilometers (SKM).',
        type: ee_const.var_type.double,
      },
      {
        name: 'URB',
        description: 'Urbanization. Index from 0 to 100% (see extended Data figure 5f of manuscript).',
        type: ee_const.var_type.double,
      },
      {
        name: 'USE',
        description: 'Water consumption. Index from 0 to 100% (see extended Data figure 5d of manuscript).',
        type: ee_const.var_type.double,
      },
      {
        name: 'VOLUME_TCM',
        description: |||
          Volume of the reach channel in thousand cubic meters (TCM). Calculated using width,
          length and depth of river channel.
        |||,
        type: ee_const.var_type.double,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Free Flowing Rivers',
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
        display_name: 'Free Flowing Rivers',
        visualize_as: 'FeatureView',
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 1500,
      thinning_strategy: 'GLOBALLY_CONSISTENT',
      thinning_ranking: ['BB_LEN_KM DESC'],
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
        Grill, G., Lehner, B., Thieme, M., Geenen, B., Tickner, D., Antonelli, F., Babu, S., Borrelli,
        P., Cheng, L., Crochetiere, H. and Macedo, H.E., 2019. Mapping the world's free-flowing rivers.
        Nature, 569(7755), p.215. Data is available at www.hydrosheds.org
      |||,
    },
  ],
  'gee:terms_of_use': |||
    HydroSHEDS data are free for non-commercial and commercial
    use. For more information, please refer to the [License Agreement](https://www.hydrosheds.org/page/license).
  |||,
  'gee:user_uploaded': true,
}
