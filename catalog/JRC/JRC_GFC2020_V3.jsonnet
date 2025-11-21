local id = 'JRC/GFC2020/V3';
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
  title: 'EC JRC global map of forest cover 2020, V3',
  version: version,
  // The collection contains tiles for a global mosaic.
  'gee:type': ee_const.gee_type.image,
  description: |||
    The global map of forest cover provides a spatially explicit representation
    of forest presence and absence for the year 2020 at 10m spatial resolution.

    The year 2020 corresponds to the cut-off date of the Regulation from the
    European Union "on the making available on the Union market and the export
    from the Union of certain commodities and products associated with
    deforestation and forest degradation" (EUDR, Regulation (EU) 2023/1115).
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

    The global input layers, mapping approach, and accuracy of GFC 2020 version 3 will be
    described in a separate technical report, expected to be released by March 2026. A technical
    report ([Bourgoin et al 2024](https://op.europa.eu/en/publication-detail/-/publication/f9baaa45-e73f-11ee-9ea8-01aa75ed71a1/language-en)) describes the mapping approach for the first version; methodological
    changes in version 2 and comparisons with other maps are described in [Bourgoin et al. (2025)](https://op.europa.eu/en/publication-detail/-/publication/e2c286ac-14e9-11f0-b1a3-01aa75ed71a1/language-en).
    [Colditz et al. (2025)](https://op.europa.eu/en/publication-detail/-/publication/e86f56dd-15b5-11f0-b1a3-01aa75ed71a1/language-en) describe the accuracy assessment protocol and results for GFC 2020 version 2.
    [Bourgoin et al. 2025](https://essd.copernicus.org/preprints/essd-2025-351/) present the mapping methodology and accuracy and compare the map to other
    global products. A comparative study between GFC 2020 version 1 and a national map was carried
    out over Ivory Coast ([Verhegghen et al, 2024](https://op.europa.eu/en/publication-detail/-/publication/ff3a48df-7957-11ef-bbbe-01aa75ed71a1/language-en)). A user guide explains how to visualize and interact
    with GFC2020 to support the EUDR risk assessment ([Simonetti et al. 2025](https://op.europa.eu/en/publication-detail/-/publication/a9ec1c5d-3780-11f0-8a44-01aa75ed71a1/language-en)). 

   The GFC 2020 map may be revised if new information, additional large-scale data layers
   or revised global spatial data layers for year 2020 will be made available.

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
    Bourgoin, Clement; Verhegghen, Astrid; Ameztoy, Iban;
    Carboni, Silvia; Achard, Frederic; Colditz, Rene (2024): Global map of
    forest cover 2020 - version 3. European Commission, Joint Research
    Centre (JRC) [Dataset]
    PID: [http://data.europa.eu/89h/8c561543-31df-4e1b-9994-e529afecaf54](http://data.europa.eu/89h/8c561543-31df-4e1b-9994-e529afecaf54)
  |||,
  'sci:publications': [
    {
      citation: |||
        Bourgoin, C., Verhegghen, A., Carboni, S., Ameztoy, I., Degreve, L., Fritz, S., Herold, M., Tsendbazar, N., Lesiv, M., Achard, F., and Colditz, R.: GFC2020: A Global Map of Forest Land Use for year 2020 to Support the EU Deforestation Regulation, Earth Syst. Sci. Data Discuss. [https://doi.org/10.5194/essd-2025-351](https://doi.org/10.5194/essd-2025-351), 2025.
      |||,
    }
  ],
  'gee:user_uploaded': true,
  'gee:terms_of_use': |||
      The data may be used by anyone, anywhere, anytime without permission,
      license or royalty payment. Attribution using the recommended citation
      is requested.
  |||,
  // There's only one year for now.
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
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

