local id = 'JRC/GFC2020/V1';
local subdir = 'JRC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: 'Collection',
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'EC JRC global map of forest cover 2020, V1',
  version: 'V1',
  // The collection contains tiles for a global mosaic.
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The EC JRC global map of forest cover provides a spatially explicit representation
    of forest presence and absence for the year 2020 at 10m spatial resolution.

    The year 2020 corresponds to the cut-off date of the Regulation from the
    European Union "on the making available on the Union market and the export from
    the Union of certain commodities and products associated with deforestation and
    forest degradation" (EUDR, [Regulation (EU) 2023/1115](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX%3A32023R1115)). In the context of the
    EUDR, the global forest cover map can be used as a non-mandatory, non-exclusive,
    and not legally binding source of information. Further information about the
    map and its use can be found on the [EU Observatory on Deforestation and Forest
    Degradation](https://forest-observatory.ec.europa.eu/forest/) (EUFO) in the section on Frequently Asked Questions.

    Forest means land spanning more than 0.5 hectares with trees higher than 5
    meters and a canopy cover of more than 10%, or trees able to reach those
    thresholds in situ, excluding land that is predominantly under agricultural or
    urban land use. Agricultural use means the use of land for the purpose of
    agriculture, including for agricultural plantations (i.e. tree stands in
    agricultural production systems such as fruit tree plantations, oil palm
    plantations, olive orchards and agroforestry systems) and set- aside
    agricultural areas, and for rearing livestock. All plantations of relevant
    commodities other than wood, that is cattle, cocoa, coffee, oil palm, rubber,
    soya, are excluded from the forest definition.

    The global map of forest cover was created by combining available global
    datasets (wall-to-wall or global in their scope) on tree cover, tree height,
    land cover and land use into a single harmonized globally-consistent
    representation of where forests existed in 2020.

    The workflow consisted in first mapping the global maximum extent of tree
    cover circa the year 2020 from the combination of ESA World Cover 2020 and
    2021, WRI Tropical Tree Cover 2020, UMD Global land cover and land use 2019,
    Global Mangrove Watch 2020, and JRC Tropical Moist Forest 2020 datasets. In the
    second step, a series of overlays and decision rules were applied to reduce this
    maximum extent of tree cover and align it with the Forest definition using
    datasets covering cropland and commodity expansion (ESA World Cereal, UMD
    Global land cover and land use 2019, UMD Global Cropland Expansion,
    High-resolution global map of smallholder and industrial oil palm plantations,
    and WRI Spatial Database of Planted Trees), land use change (UMD global forest
    cover loss, JRC Tropical Moist Forest, IIASA Global Forest Management),
    built-up (JRC Global Human Settlement), and water (JRC Global Surface Water).

    The global input layers, mapping approach, and a preliminary accuracy
    assessment are described in a [JRC science for policy report](https://op.europa.eu/en/publication-detail/-/publication/f9baaa45-e73f-11ee-9ea8-01aa75ed71a1).
    The JRC will undertake a formal statistically and thematically robust
    accuracy assessment in 2024.

    Please also refer to the [list of known issues](https://forobs.jrc.ec.europa.eu/GFC) and to the [JRC Data Catalogue entry](https://data.jrc.ec.europa.eu/dataset/10d1b337-b7d1-4938-a048-686c8185b290).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
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
    Bourgoin, Clement; Ameztoy, Iban; Verhegghen, Astrid; Carboni, Silvia;
    Colditz, Rene R.; Achard, Frederic (2023): Global map of forest cover 2020 -
    version 1. European Commission, Joint Research Centre (JRC) [Dataset] PID:
    [http://data.europa.eu/89h/10d1b337-b7d1-4938-a048-686c8185b290](http://data.europa.eu/89h/10d1b337-b7d1-4938-a048-686c8185b290).
  |||,
  'sci:publications': [
    {
      citation: |||
        Bourgoin, C., Ameztoy, I., Verhegghen, A., Desclée, B., Carboni, S.,
        Bastin, J., Beuchle, R., Brink, A., Defourny, P., Delhez, B., Fritz, S.,
        Gond, V., Herold, M., Lamarche, C., Mansuy, N., Mollicone, D., Oom, D.,
        Peedell, S., San-Miguel, J., Colditz, R. and Achard, F., Mapping Global
        Forest Cover of the Year 2020 to Support the EU Regulation on
        Deforestation-free Supply Chains, Publications Office of the European
        Union, Luxembourg, 2024, [doi:10.2760/262532](https://doi.org/10.2760/262532), JRC136960.
      |||,
      doi: '10.2760/262532',
    },
  ],
  'gee:user_uploaded': true,
  'gee:terms_of_use': |||
      The data may be used by anyone, anywhere, anytime without permission,
      license or royalty payment. Attribution using the recommended citation is
      requested.
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

