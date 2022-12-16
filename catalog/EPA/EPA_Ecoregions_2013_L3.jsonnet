local id = 'EPA/Ecoregions/2013/L3';
local subdir = 'EPA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'US EPA Ecoregions (Level III)',
  version: '2013',
  'gee:type': ee_const.gee_type.table,
  description: |||
    The U.S. Environmental Protection Agency (USEPA) provides
    the Ecoregions dataset to serve as a spatial framework for the
    research, assessment, management, and monitoring of ecosystems
    and ecosystem components. Ecoregions denote areas of general
    similarity in ecosystems and in the type, quality, and quantity
    of environmental resources. These general-purpose regions are
    critical for structuring and implementing ecosystem management
    strategies across federal agencies, state agencies, and nongovernmental
    organizations that are responsible for different types of resources
    within the same geographical areas.

    The approach used to
    compile this map is based on the premise that ecological regions
    can be identified through the analysis of patterns of biotic
    and abiotic phenomena, including geology, physiography, vegetation,
    climate, soils, land use, wildlife, and hydrology. The relative
    importance of each characteristic varies from one ecological
    region to another.

    This dataset includes the USEPA ecoregions
    classification scheme, as well as the scheme from the Commission
    for Environmental Cooperation (CEC). Ecoregions are hierarchical,
    with Level IV being the most detailed and Level I defining the
    broadest classifications. Because of this hierarchy, Level III
    features retain information from Levels I and II. The CEC divided
    all of North America in distinct ecoregions for Levels I, II,
    and III, while the USEPA did so only for the United States at
    Level III and Level IV. The columns starting with 'us_' belong
    to the USEPA scheme, and the columns starting with 'na_' belong
    to the CEC scheme. The ingested version of this dataset contains
    features for the conterminous United States only (that is, Alaska
    and Hawaii are not included). Methods used to define the ecoregions
    are explained in Omernik (1995, 2004), Omernik and others (2000),
    and Gallant and others (1989).

    *Calculated by the data provider.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, basename + '_FeatureView'),
    ee.link.license('https://edg.epa.gov/epa_data_license.html'),
  ],
  keywords: [
    'ecoregions',
    'epa',
  ],
  providers: [
    ee.producer_provider('United States Environmental Protection Agency', 'https://www.epa.gov/eco-research/level-iii-and-iv-ecoregions-continental-united-states'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-124.8, 24.5, -66.9, 49.4,
                    '2013-04-16T00:00:00Z', '2013-04-17T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'l1_key',
        description: 'NA Level I Code and Name',
        type: ee_const.var_type.string,
      },
      {
        name: 'l2_key',
        description: 'NA Level II Code and Name',
        type: ee_const.var_type.string,
      },
      {
        name: 'l3_key',
        description: 'US Level III Code and Name',
        type: ee_const.var_type.string,
      },
      {
        name: 'na_l1code',
        description: 'Code for Level I Ecoregion (North America/CEC)',
        type: ee_const.var_type.string,
      },
      {
        name: 'na_l1name',
        description: 'Name for Level I Ecoregion (North America/CEC)',
        type: ee_const.var_type.string,
      },
      {
        name: 'na_l2code',
        description: 'Code for Level II Ecoregion (North America/CEC)',
        type: ee_const.var_type.string,
      },
      {
        name: 'na_l2name',
        description: 'Name for Level II Ecoregion (North America/CEC)',
        type: ee_const.var_type.string,
      },
      {
        name: 'na_l3code',
        description: 'Code for Level III Ecoregion (North America/CEC)',
        type: ee_const.var_type.string,
      },
      {
        name: 'na_l3name',
        description: 'Name for Level III Ecoregion (North America/CEC)',
        type: ee_const.var_type.string,
      },
      {
        name: 'shape_area',
        description: "Area of the feature's geometry in its original format",
        type: ee_const.var_type.double,
      },
      {
        name: 'shape_leng',
        description: "Length of the edges in the feature's geometry in its original format",
        type: ee_const.var_type.double,
      },
      {
        name: 'us_l3code',
        description: 'Code for Level III Ecoregion (US/USEPA)',
        type: ee_const.var_type.string,
      },
      {
        name: 'us_l3name',
        description: 'Name for Level III Ecoregion (US/USEPA)',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Area of Ecoregions',
        lookat: {
          lat: 36.173,
          lon: -95.142,
          zoom: 6,
        },
        polygon_visualization: {
          property_name: 'shape_area',
          property_vis: {
            min: [
              23.0,
            ],
            max: [
              357000000000.0,
            ],
            palette: [
              '0a3b04',
              '1a9924',
              '15d812',
            ],
          },
        },
      },
      {
        display_name: 'Area of Ecoregions',
        visualize_as: 'FeatureView',
        lookat: {
          lat: 36.173,
          lon: -95.142,
          zoom: 6,
        },
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 1000,
      thinning_strategy: 'HIGHER_DENSITY',
      thinning_ranking: ['shape_area DESC'],
    },
  },
  'sci:citation': |||
    Commission for Environmental Cooperation. 1997. Ecological regions
    of North America: toward a common perspective. Commission for Environmental
    Cooperation, Montreal, Quebec, Canada. 71p. Map (scale 1:12,500,000).
    Revised 2006.
  |||,
  'sci:publications': [
    {
      citation: |||
        McMahon, G., S.M. Gregonis, S.W. Waltman, J.M. Omernik, T.D. Thorson,
        J.A. Freeouf, A.H. Rorick, and J.E. Keys. 2001. Developing a spatial
        framework of common ecological regions for the conterminous United
        States. Environmental Management 28(3):293-316.
      |||,
    },
    {
      citation: |||
        Omernik, J.M. 1987. Ecoregions of the conterminous United States.
        Map (scale 1:7,500,000). Annals of the Association of American
        Geographers 77(1):118-125.
      |||,
    },
    {
      citation: |||
        Omernik, J.M. 1995. Ecoregions: A spatial framework for environmental
        management. In: Biological Assessment and Criteria: Tools for Water
        Resource Planning and Decision Making. Davis, W.S. and T.P. Simon
        (eds.),   Lewis Publishers, Boca Raton, FL. p. 49-62.
      |||,
    },
    {
      citation: |||
        Omernik, J.M. 2004. Perspectives on the nature and definition of
        ecological regions. Environmental Management 34(Supplement 1):S27-S38.
      |||,
    },
    {
      citation: |||
        Omernik, J.M. and G.E. Griffith. 2014. Ecoregions of the conterminous
        United States: evolution of a hierarchical spatial framework. Environmental
        Management 54(6):1249-1266.
      |||,
    },
  ],
  'gee:terms_of_use': 'There are no restrictions on use of this US public domain data.',
}
