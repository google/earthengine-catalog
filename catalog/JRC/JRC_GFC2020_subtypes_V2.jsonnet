local id = 'JRC/GFC2020_subtypes/V2';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/jrc_gft2020_versions.libsonnet';
local subdir = 'JRC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'EC JRC global map of forest types 2020, V2',
  version: version,
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The global map of forest types provides a spatially explicit representation 
    of primary forest, naturally regenerating forest and planted forest (including 
    plantation forest) for the year 2020 at 10m spatial resolution. The base layer 
    for mapping these forest types is the extent of forest cover of version 4 of 
    the Global Forest Cover map for year 2020 (JRC GFC 2020). The definitions 
    of the forest types follow the definitions of the Regulation from the European 
    Union "on the making available on the Union market and the export from the Union 
    of certain commodities and products associated with deforestation and forest 
    degradation" (EUDR, Regulation (EU) 2023/1115), which are similar to 
    characteristics and specific forest categories from the FAO Global Forest 
    Resources Assessment. The year 2020 corresponds to the cut-off date of the EUDR. 

    In the context of the EUDR, the global forest type map can be used as a 
    non-mandatory, non-exclusive and not legally binding source of information, 
    namely in the phase of risk assessment by operators and traders. Further 
    information about the map and its use can be found on the EU Observatory on 
    Deforestation and Forest Degradation. The definition of forest degradation 
    under the EUDR implies that for year 2020 it is only necessary to assess the 
    presence of primary forests and naturally regenerating forests; all other 
    forests, including plantation forests, were mapped under class "planted forests". 
    Class "other wooded land" exists only outside the extent of forest cover in the 
    Global Forest Cover map for year 2020 and is therefore not mapped in GFT 2020. 

    Building on version 4 of the 2020 Global Forest Cover dataset (GFC2020 V4), 
    the workflow proceeds in two main steps. First, the extent of planted and 
    plantation forests is identified by integrating global forest-type datasets with 
    wall-to-wall maps of forest management. This step also includes temporarily 
    unstocked forest land resulting from harvesting operations, using historical 
    time series of tree cover, forest loss, and tree-height dynamics. Second, the 
    extent of primary forests is delineated by combining datasets on intact forests 
    and protected areas, while excluding areas where anthropogenic disturbances 
    have been recorded over the past 20–30 years. The results of these two steps 
    are harmonized to classify all forest areas mapped in GFC2020 V4 that are 
    neither primary nor planted forests as naturally regenerating forests, followed 
    by the application of a minimum mapping unit of 0.5 hectares to each forest type. 
    
    The main data layers that are used to delineate primary
    forests in GFT 2020 are:

    1. Global maps of forest typology and management in 2020 
    1. Map of undisturbed tropical mangroves in 2020 and degradation and
    deforestation in tropical moist forests from 1990 to 2020 (from JRC-TMF)
    1. Deforestation alerts (RADD) up to end of 2020
    1. Map of Intact Forest Landscapes 2020
    1. World Database on Protected Areas
    1. The European Primary Forest Dataset from Sabatini et al. 2021
    1. Global tree cover loss from 2001 to 2020 in combination with the map of
    drivers of global forest loss
    1. A map on global mining land use and tree crop commodity maps

    The main layers to map planted forests (including plantation forests) are:

    1. The WRI Spatial Database on Planted Trees (version 3)
    1. Maps of global forest typology and management in 2020 
    1. 2018-2024 time series of global canopy heights 
    1. Global tree cover in 2000 and loss from 2001 to 2020
    1. Global drivers of forest loss
    1. Global natural forests 2020

    
    The global input layers and mapping approach of GFT 2020 version 2 will be 
    described in a separate technical report, expected to be released by December 
    2026. A technical report ([Bourgoin et al. 2026](https://publications.jrc.ec.europa.eu/repository/handle/JRC146622)) 
    describes the mapping approach for the first version of GFT 2020 (version 1). 


    For a list of known issues please refer to
    [this website](https://forobs.jrc.ec.europa.eu/GFT).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  'gee:categories': ['forest-biomass'],
  keywords: [
    'eudr',
    'forest',
    'jrc',
    'landcover',
    'primary_forest'
  ],
  providers: [
    ee.producer_provider(
      'Joint Research Centre, European Commission',
      'https://forest-observatory.ec.europa.eu/forest/'
    ),
    ee.host_provider(self_ee_catalog_url)
  ],
  extent: ee.extent_global('2020-01-01T00:00:00Z', '2020-12-31T23:59:59Z'),
  'sci:citation': |||
    Bourgoin, Clement; Achard, Frederic; Beuchle, Rene; Carboni, Silvia; 
    Carreiras, Joao; Korosuo, Anu; Rotllan-Puig, Xavier; Simonetti, Dario; 
    Colditz, Rene (2026): Global map
    of forest types 2020 - version 2. European Commission, Joint Research Centre
    (JRC). [Dataset]. [doi:10.2905/JRC.NP3B8MG](https://doi.org/10.2905/JRC.NP3B8MG). 
    PID: [https://data.jrc.ec.europa.eu/dataset/07231b6b-23da-4f49-8132-481f241c97e3](https://data.jrc.ec.europa.eu/dataset/07231b6b-23da-4f49-8132-481f241c97e3)
  |||,
  'sci:publications': [
    {
      citation: |||
        Bourgoin, C., Verhegghen, A., Ameztoy, I., Beuchle, R., Carboni, S. et al.,
        Maps of Global Forest Cover 2020 Version 3 and Global Forest Type 2020
        Version 1 Supporting the EU Deforestation Regulation - Methodology,
        Accuracy Assessment and Comparison, Publications Office of the European
        Union, Luxembourg, 2026,
        [https://data.europa.eu/doi/10.2760/9982436](https://data.europa.eu/doi/10.2760/9982436),
        JRC146622.
      |||
    }
  ],
  'gee:user_uploaded': true,
  'gee:terms_of_use': |||
      The data may be used by anyone, anywhere, anytime without permission,
      license or royalty payment. Attribution using the recommended citation is
      requested.
  |||,
  summaries: {
    gsd: [
      10
    ],
    'gee:visualizations': [
      {
        display_name: 'GFT',
        lookat: {
          lat: 0,
          lon: 0,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              1
            ],
            max: [
              20
            ],
            bands: [
              'Map',
            ],
            palette: [
              '78c679', '000000', '000000', '000000', '000000', '000000', '000000', '000000', '000000',
              '006837', '000000', '000000', '000000', '000000', '000000', '000000', '000000', '000000',
              'cc6600'
            ]
          },
        },
      },
    ],
    'eo:bands': [
      {
        name: 'Map',
        description: 'Global forest types 2020',
        'gee:classes': [
          {
            value: 1,
            color: '78c679',
            description: 'Naturally regenerating forest',
          },
          {
            value: 10,
            color: '006837',
            description: 'Primary forest',
          },
          {
            value: 20,
            color: 'cc6600',
            description: 'Planted/Plantation forest',
          },
        ]
      },
    ],
  },
}
