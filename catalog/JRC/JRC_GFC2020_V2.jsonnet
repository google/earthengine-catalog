local id = 'JRC/GFC2020/V2';
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
  title: 'EC JRC global map of forest cover 2020, V2',
  version: version,
  // The collection contains tiles for a global mosaic.
  'gee:type': ee_const.gee_type.image_collection,
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

    The global map of forest cover was created by combining existing global
    spatial layers (wall-to-wall or global in their scope), e.g. on land cover,
    land use, and tree height. The map aims to represent the state of forest
    cover by 31 December 2020. The global land cover from the ESA World Cover
    project serves as one baseline layer to define the extent of tree cover for
    year 2020 at 10 m spatial resolution. In 2024, the global map of forest
    cover 2020 was improved by integrating user feedback, and new or revised
    spatial data layers.

    It now better captures temporally unstocked forests, low-density
    tropical forests, and secondary tropical forests that have regrown for at
    least five years. Additionally, the exclusion criteria have been enhanced
    to more effectively exclude trees in urban areas, mining sites, wetlands,
    areas with shifting cultivation, and tree plantations. This is achieved by
    utilizing multiple global maps of canopy height, crop area, and specific
    crop commodity maps to more accurately distinguish forests from trees
    under agricultural use.

    For direct access and metadata, please consult the JRC
    data catalogue ([JRC 2024](https://data.jrc.ec.europa.eu/dataset/e554d6fb-6340-45d5-9309-332337e5bc26)). A technical report ([Bourgoin et al 2024](https://op.europa.eu/en/publication-detail/-/publication/f9baaa45-e73f-11ee-9ea8-01aa75ed71a1/language-en))
    describes the mapping approach for the first version; a technical report for
    version 2 is forthcoming. The global map of forest cover may be revised if
    new information, additional large-scale data layers, or revised global
    spatial data layers will be made available for year 2020.

    For a list of known issues please refer to [this website](https://forobs.jrc.ec.europa.eu/GFC)
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
    Bourgoin, Clement; Verhegghen, Astrid; Degreve, Lucas; Ameztoy, Iban;
    Carboni, Silvia; Colditz, Rene; Achard, Frederic (2024): Global map of
    forest cover 2020 - version 2. European Commission, Joint Research
    Centre (JRC) [Dataset]
    PID: [http://data.europa.eu/89h/e554d6fb-6340-45d5-9309-332337e5bc26](http://data.europa.eu/89h/e554d6fb-6340-45d5-9309-332337e5bc26)
  |||,
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

