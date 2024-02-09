local id = 'RESOLVE/ECOREGIONS/2017';
local subdir = 'RESOLVE';

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
    ee_const.ext_sci,
  ],
  id: id,
  title: 'RESOLVE Ecoregions 2017',
  'gee:type': ee_const.gee_type.table,
  description: |||
    The RESOLVE Ecoregions dataset, updated in 2017, offers a depiction of the 846 terrestrial
    ecoregions that represent our living planet.  View the stylized map at
    [https://ecoregions2017.appspot.com/](https://ecoregions2017.appspot.com/) or in
    [Earth Engine](https://code.earthengine.google.com/b961ab2adfcb03c920aab63d86c49eb2).

    Ecoregions, in the simplest definition, are ecosystems of regional extent.
    Specifically, ecoregions represent distinct assemblages of biodiversity-all
    taxa, not just vegetation-whose boundaries include the space required to
    sustain ecological processes. Ecoregions provide a useful basemap for
    conservation planning in particular because they draw on natural, rather
    than political, boundaries, define distinct biogeographic assemblages and
    ecological habitats within biomes, and assist in representation of Earth's
    biodiversity.

    This dataset is based on recent advances in biogeography - the science
    concerning the distribution of plants and animals. The original ecoregions
    dataset has been widely used since its introduction in 2001, underpinning the
    most recent analyses of the effects of global climate change on nature by
    ecologists to the distribution of the world's beetles to modern conservation
    planning.

    The 846 terrestrial ecoregions are grouped into 14 biomes and 8 realms. Six
    of these biomes are forest biomes and remaining eight are non-forest biomes.
    For the forest biomes, the geographic boundaries of the ecoregions
    (Dinerstein et al., 2017) and protected areas (UNEP-WCMC 2016) were
    intersected with the Global Forest Change data (Hansen et al. 2013) for the
    years 2000 to 2015, to calculate percent of habitat in protected areas and
    percent of remaining habitat outside protected areas.  Likewise, the
    boundaries of the non-forest ecoregions and protected areas (UNEP-WCMC 2016)
    were intersected with Anthropogenic Biomes data (Anthromes v2) for the year
    2000 (Ellis et al., 2010) to identify remaining habitats inside and outside
    the protected areas. Each ecoregion has a unique ID, area (sq. degrees), and NNH
    (Nature Needs Half) categories 1-4. NNH categories are based on percent of
    habitat in protected areas and percent of remaining habitat outside
    protected areas.

    1. Half Protected: More than 50% of the total ecoregion area is already
       protected.
    2. Nature Could Reach Half: Less than 50% of the total ecoregion area is
       protected but the amount of remaining unprotected natural habitat could
       bring protection to over 50% if new conservation areas are added to the
       system.
    3. Nature Could Recover: The amount of protected and unprotected natural
       habitat remaining is less than 50% but more than 20%. Ecoregions in this
       category would require restoration to reach Half Protected.
    4. Nature Imperiled: The amount of protected and unprotected natural habitat
       remaining is less than or equal to 20%. Achieving half protected is not
       possible in the short term and efforts should focus on conserving
       remaining, native habitat fragments.

    The updated Ecoregions 2017 is the most-up-to-date (as of February 2018) dataset on remaining
    habitat in each terrestrial ecoregion. It was released to chart progress towards
    achieving the visionary goal of [Nature Needs Half](https://natureneedshalf.org/), to protect half of all
    the land on Earth to save a living terrestrial biosphere.

    Note - a number of ecoregions are very complex polygons with over a million
    vertices, such as Rock & Ice. These ecoregions were split when necessary,
    with attributes like Eco_ID being preserved. If you'd like to see all
    ecoregions that have been split, please [run this script](https://code.earthengine.google.com/7a437c78fc8cb46ec586bb4e2c10e526).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
  ],
  keywords: [
    'biodiversity',
    'conservation',
    'ecoregions',
    'global',
    'habitats',
    'protection',
    'resolve',
  ],
  providers: [
    ee.producer_provider('RESOLVE Biodiversity and Wildlife Solutions', 'https://ecoregions.appspot.com/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2017-04-05T00:00:00Z', '2017-04-05T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'BIOME_NAME',
        description: 'Biome name',
        type: ee_const.var_type.string,
      },
      {
        name: 'BIOME_NUM',
        description: 'Biome number',
        type: ee_const.var_type.double,
      },
      {
        name: 'COLOR',
        description: 'Color',
        type: ee_const.var_type.string,
      },
      {
        name: 'COLOR_BIO',
        description: 'Biome color',
        type: ee_const.var_type.string,
      },
      {
        name: 'COLOR_NNH',
        description: 'NNH color',
        type: ee_const.var_type.string,
      },
      {
        name: 'ECO_ID',
        description: 'Ecoregion unique ID',
        type: ee_const.var_type.double,
      },
      {
        name: 'ECO_NAME',
        description: 'Ecoregion name',
        type: ee_const.var_type.string,
      },
      {
        name: 'LICENSE',
        description: 'CC-BY 4.0',
        type: ee_const.var_type.string,
      },
      {
        name: 'NNH',
        description: |||
          NNH category (1-4) based on percent of habitat in
          protected areas and percent of remaining habitat outside protected areas
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'NNH_NAME',
        description: 'Half Protected, Nature Could Reach Half, Nature Could Recover, or Nature Imperiled',
        type: ee_const.var_type.string,
      },
      {
        name: 'OBJECTID',
        description: 'Object id',
        type: ee_const.var_type.double,
      },
      {
        name: 'REALM',
        description: 'Realm name',
        type: ee_const.var_type.string,
      },
      {
        name: 'SHAPE_AREA',
        description: 'Area of ecoregion polygon in square degrees',
        type: ee_const.var_type.double,
      },
      {
        name: 'SHAPE_LENG',
        description: 'Length of ecoregion polygon in degrees',
        type: ee_const.var_type.double,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Ecoregions',
        lookat: {
          lat: 20.3,
          lon: -20.39,
          zoom: 2,
        },
        polygon_visualization: {
          property_name: 'SHAPE_AREA',
          property_vis: {
            min: [
              0.0,
            ],
            max: [
              500.0,
            ],
            palette: [
              '0080D4',
              'D88000',
              '7A32C1',
              'A2007F',
              'ffc0e8',
              'f5ff64',
              'b5ffb4',
              'beeaff',
              'ffc0e8',
              '8e8dff',
              'A2FF7F',
              '36807F',
              'E5E8E6',
              'cyan',
              'blue',
              'orange',
              'yellow',
              'gray',
            ],
          },
        },
      },
      {
        display_name: 'Ecoregions',
        visualize_as: 'FeatureView',
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 500,
      thinning_strategy: 'HIGHER_DENSITY',
    },
  },
  'sci:citation': |||
    [Bioscience, An Ecoregions-Based Approach to Protecting Half the
    Terrestrial Realm](https://academic.oup.com/bioscience/article/67/6/534/3102935)
    [doi:10.1093/biosci/bix014](https://doi.org/10.1093/biosci/bix014)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
