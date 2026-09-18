local id = 'JRC/GFC2020/V4';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/jrc_gfc2020_versions.libsonnet';

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
  title: 'EC JRC global map of forest cover 2020, V4',
  version: version,
  'gee:type': ee_const.gee_type.image,
  'gee:status': 'beta',
  description: |||
    The global map of forest cover provides a spatially explicit representation
    of forest presence and absence for the year 2020 at 10m spatial resolution.

    The year 2020 corresponds to the cut-off date of the Regulation from the
    European Union "on the making available on the Union market and the export
    from the Union of certain commodities and products associated with
    deforestation and forest degradation" (EUDR, [Regulation (EU) 2023/1115)](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX%3A32023R1115).
    In the context of the EUDR, the global forest cover map can be used as a
    non-mandatory, non-exclusive and not legally binding source of information.
    Further information about the map and its use can be found on the [EU
    Observatory on Deforestation and Forest Degradation](https://forest-observatory.ec.europa.eu/forest/) (EUFO) and namely in
    the section on Frequently Asked Questions.

    Forest means land spanning more than 0.5 hectares with trees higher than
    5 meters and a canopy cover of more than 10%, or trees able to reach those
    thresholds in situ, excluding land that is predominantly under agricultural
    or urban land use. Agricultural use means the use of land for the purpose of
    agriculture, including for agricultural plantations (i.e. tree stands in
    agricultural production systems such as fruit tree plantations, oil palm
    plantations, olive orchards and agroforestry systems) and set- aside
    agricultural areas, and for rearing livestock. All plantations of relevant
    commodities other than wood, that is cattle, cocoa, coffee, oil palm,
    rubber, soya are excluded from the forest definition.

    In a first step, the workflow identifies the maximum potential extent of forest
    cover circa 2020 by integrating global tree- and mangrove cover data for the year 2020 
    (e.g. [Copernicus global land cover map](https://land.copernicus.eu/en/products/global-dynamic-land-cover/land-cover-2020-raster-10-m-global-annual)).
    In addition, this delineation uses historical time-series of tree cover and loss to
    identify areas of potentially unstocked forest due to e.g., natural disturbances or
    forest management practices. In a second step, this maximum potential forest extent
    is intersected with various other data layers on tree height, deforestation, cropland,
    agroforestry, and other land uses. The application of a series of complex Boolean decision
    rules excludes areas that are not forest according to the definition of the FAO-FRA and EUDR.

    The global input layers, mapping approach, and accuracy of GFC 2020 version 4 will
    be described in a separate technical report, expected to be released by December 2026. The
    mapping approach of version 1, 2 and 3 are described in [Bourgoin et al. 2024](https://op.europa.eu/en/publication-detail/-/publication/f9baaa45-e73f-11ee-9ea8-01aa75ed71a1/language-en), [2025](https://op.europa.eu/en/publication-detail/-/publication/e2c286ac-14e9-11f0-b1a3-01aa75ed71a1/language-en) 
    and [2026](https://publications.jrc.ec.europa.eu/repository/handle/JRC146622), respectively 
    and the overall approach for mapping forests, incorporating both physical characteristics 
    and land-use components, is presented in [Bourgoin et al. 2026](https://essd.copernicus.org/articles/18/1331/2026/). 
    [Colditz et al. (2025)](https://op.europa.eu/en/publication-detail/-/publication/e86f56dd-15b5-11f0-b1a3-01aa75ed71a1/language-en) 
    describe the accuracy assessment protocol and results for GFC 2020 version 2. The 
    global input layers, mapping approach, and accuracy of GFC 2020 version 4 will be 
    described in a separate technical report expected to be released by December 2026. 
    Comparative studies between GFC 2020 and national maps were carried out over Ivory 
    Coast ([Verhegghen et al, 2024](https://op.europa.eu/en/publication-detail/-/publication/ff3a48df-7957-11ef-bbbe-01aa75ed71a1/language-en)) 
    and Thailand ([Khiripet et al, 2026](https://op.europa.eu/en/publication-detail/-/publication/6d5ed8fd-42a7-11f1-8095-01aa75ed71a1/language-en)). 
    A user guide explains how to visualize and interact with GFC2020 to support the EUDR 
    risk assessment ([Simonetti et al. 2025](https://op.europa.eu/en/publication-detail/-/publication/a9ec1c5d-3780-11f0-8a44-01aa75ed71a1/language-en)). 

    The GFC 2020 map may be revised if new information, additional large-scale data 
    layers or revised global spatial data layers will be made available for year 2020.  

    For a list of known issues please refer to [this website](https://forobs.jrc.ec.europa.eu/GFC).
 |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  'gee:categories': ['forest-biomass'],
  keywords: [
    'eudr',
    'forest',
    'jrc',
  ],
  providers: [
    ee.producer_provider(
      'Joint Research Centre, European Commission',
      'https://forest-observatory.ec.europa.eu/forest/'
    ),
    ee.host_provider(self_ee_catalog_url)
  ],
  extent: ee.extent_global('2020-12-31T00:00:00Z', '2020-12-31T00:00:01Z'),
  'sci:citation': |||
    Bourgoin, Clement; Achard, Frederic; Beuchle, Rene; Carboni, Silvia;
    Carreiras, Joao; Marinelli, Daniele; Rotllan-Puig, Xavier; Simonetti, Dario;
    Colditz, Rene (2026): Global map of forest cover 2020 - version 4. 
    European Commission, Joint Research Centre [Dataset] doi: 10.2905/JRC.3KATEH8.  
    PID: [http://data.europa.eu/89h/cf7c49ea-8f00-4c5a-bd40-6f25dc341580](http://data.europa.eu/89h/cf7c49ea-8f00-4c5a-bd40-6f25dc341580)
  |||,
  'sci:publications': [
    {
      citation: |||
        Bourgoin, C., Verhegghen, A., Carboni, S., Ameztoy, I., Degreve, L.,
        Fritz, S., Herold, M., Tsendbazar, N., Lesiv, M., Achard, F., and Colditz,
        R.: GFC2020: A Global Map of Forest Land Use for year 2020 to Support
        the EU Deforestation Regulation, Earth Syst. Sci. Data Discuss.
        [https://doi.org/10.5194/essd-18-1331-2026](https://doi.org/10.5194/essd-18-1331-2026.
      |||
    },
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
    },
    {
      citation: |||
        Bourgoin, C., Verhegghen, A., Carboni, S., Degrève, L., Ameztoy Aramendi, I. 
        et al., Global forest maps for the year 2020 to support the EU regulation on 
        deforestation-free supply chains – Improved map of global forest cover(GFC2020) 
        and preliminary map of global forest types (GFT2020), Publications Office of 
        the European Union, 2025, [https://data.europa.eu/doi/10.2760/1975879](https://data.europa.eu/doi/10.2760/1975879).
      |||
    },
    {
      citation: |||
        Bourgoin, C., Ameztoy, I., Verhegghen, A., Desclée, B., Carboni, S. et al., 
        Mapping global forest cover of the year 2020 to support the EU regulation on 
        deforestation-free supply chains, Publications Office of the European Union, 
        2024, [https://data.europa.eu/doi/10.2760/262532](https://data.europa.eu/doi/10.2760/262532).
      |||
    },
    {
      citation: |||
        Colditz, R. R., Verhegghen, A., Carboni, S., Bourgoin, C., Dürauer, M. et al., 
        Accuracy assessment of the global forest cover map for the year 2020 – Assessment 
        protocol and analysis, Publications Office of the European Union, 2025, 
        [https://data.europa.eu/doi/10.2760/7632707](https://data.europa.eu/doi/10.2760/7632707).
      |||
    },
  ],
  'gee:terms_of_use': |||
      The data may be used by anyone, anywhere, anytime without permission,
      license or royalty payment. Attribution using the recommended citation
      is requested.
  |||,
  summaries: {
    gsd: [
      10
    ],
    'gee:visualizations': [
      {
        display_name: 'GFC',
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
              1
            ],
            bands: [
              'Map',
            ],
            palette: ['4d9221']
          },
        },
      },
    ],
    'eo:bands': [
      {
        name: 'Map',
        description: 'Global forest cover 2020',
        'gee:classes': [
          {
            value: 1,
            color: '4d9221',
            description: 'Forest',
          },
        ]
      },
    ],
  },
}

