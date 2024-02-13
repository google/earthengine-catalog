local id = 'EDF/MethaneSAT/MethaneAIR/methaneair-L4point-2021';
local subdir = 'EDF';
local version = '2021';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'MethaneAIR L4 Point Sources ' + version,
  version: version,

  description: |||
    This dataset provides high-resolution, spatially disaggregated methane
    emission fluxes (kg/hr) of the Permian Delaware sub-basin in southern New
    Mexico and western Texas as well as for the Uinta basin in Utah.

    Methane is a potent greenhouse gas that has more than 80 times the warming
    power of carbon dioxide over the first 20 years after it reaches the
    atmosphere. At least 30% of today's global warming is driven by methane from
    human actions. Cutting methane emissions associated with human activities
    - including avoidable emissions from oil and gas operations, agriculture,
    and waste management - is the single fastest way to slow the rate of global
    warming.

    This dataset was generated using MethaneAIR measurements taken on 8 August
    2021 (research flight RF06) over the Permian and 11 August 2021 (RF08) over
    Uinta. MethaneAIR is an airborne precursor of the MethaneSAT satellite
    mission, managed by [MethaneSAT LLC](https://www.methanesat.org/), a wholly
    owned subsidiary of Environmental Defense Fund. The methane emission fluxes
    were produced using a geostatistical inverse modeling framework specialized
    to exploit the high spatial resolution, wide spatial coverage, and high
    precision of MethaneAIR data.

    For additional information about the MethaneAIR instrument, instrument
    calibration and emission detections, please refer to recent publications
    by [Staebell et al. (2021)](https://doi.org/10.5194/amt-14-3737-2021),
    [Conway et al. (2023)](https://doi.org/10.5194/amt-2023-111), [Chulakadabba
    et al. (2023)](https://doi.org/10.5194/egusphere-2023-822), [Abbadi et al.
    (2023)](https://doi.org/10.31223/X51D4C), [Omara et al. (2023)](https://doi.org/10.5194/essd-15-3761-2023),
    and [Miller et al. (2023)](https://doi.org/10.5194/egusphere-2023-1962).

    Contact the data provider for more information about the project at this link:
    [https://www.methanesat.org/contact/](https://www.methanesat.org/contact/)
  |||,
  keywords: [
    'climate',
    'emmisions',
    'ghg',
    'methane',
    'edf',
    'methanesat',
    'methaneair'
  ],
  providers: [
    ee.producer_provider('Environmental Defense Fund - MethaneSAT', 'https://methanesat.org'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-110.3, 31.4, -103.1, 40.6,
                    '2021-08-07T00:00:00Z', '2021-08-11T00:00:00Z'),

  summaries: {
    'gee:schema': [
      {
        name: 'Flux_kg_hr',
        description: 'Methane flux quantification, in kg/h.',
        units: units.kg_per_hour,
        type: ee_const.var_type.int,
      },
      {
        name: 'flt',
        description: 'Flight identifier.',
        type: ee_const.var_type.string,
      },
      {
        name: 'plume_numb',
        description: 'Plume number.',
        type: ee_const.var_type.int,
      },
      {
        name: 'sd',
        description: |||
          Standard deviation of methane flux quantification, in kg/h.
        |||,
        units: units.kg_per_hour,
        type: ee_const.var_type.int,
      }
    ],

    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 150,
      thinning_strategy: 'HIGHER_DENSITY',
    },

    'gee:visualizations': [
      {
        display_name: 'Methane point sources flux',
        lookat: { lon: -103.71, lat: 31.96, zoom: 9 },
        table_visualization: {
          color: 'red',
          point_size: 3,
        },
      },
      {
        display_name: 'FeatureView visualization of point flux sources',
        visualize_as: 'FeatureView',
        lookat: { lon: -103.71, lat: 31.96, zoom: 9 },
      },
    ],
  },

  'gee:terms_of_use': importstr 'tos.md',
  'gee:unusual_terms_of_use': true,

  'gee:type': ee_const.gee_type.table,
  'gee:user_uploaded': true,

  license: license.id,
  // TODO(fdom): Add license link when provided.
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView')
  ],


  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_ver,
  ],
}
