local id = 'IPCC/AR6/SLP';
local subdir = 'IPCC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local bands_info = import 'templates/ipcc_ar6.libsonnet';
local components = importstr 'templates/components.md';

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
  title: 'IPCC AR6 Sea Level Projections Regional (Medium Confidence)',
  version: '20210809',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The dataset provided by the IPCC features comprehensive global and
    regional sea level projections from the IPCC 6th Assessment Report (AR6).
    This collection contains assets for the medium confidence sea level
    rise projections. The dataset spans from 2020 to 2150 and includes
    projections for various future scenarios outlined in the AR6. It offers a
    detailed breakdown of individual processes contributing to sea level
    changes, alongside globally averaged projections, regional projections on a
    regular global grid. These projections align with those in the IPCC AR6
    report, ensuring consistency and reliability. (Local projections at specific
    tide gauge locations are not included because they are not on a regular
    grid.)

    The following are summaries of the future scenarios included in the dataset:

    - SSP1-1.9 holds warming to approximately 1.5&deg;C above 1850-1900 in 2100
      after slight overshoot (median) and implies net zero CO2 emissions around
      the middle of the century.
    - SSP1-2.6 stays below 2.0&deg;C warming relative to 1850-1900 (median) with
      implied net zero emissions in the second half of the century.
    - SSP2-4.5 is approximately in line with the upper end of aggregate
      Nationally Determined Contribution emission levels by 2030. SR1.5 assessed
      temperature projections for NDCs to be between 2.7 and 3.4&deg;C by 2100,
      corresponding to the upper half of projected warming under SSP2-4.5.
    - SSP3-7.0 is a medium to high reference scenario resulting from no
      additional climate policy under the SSP3 socioeconomic development
      narrative. SSP3-7.0 has particularly high non-CO2 emissions, including
      high aerosols emissions.
    - SSP5-8.5 is a high reference scenario with no additional climate policy.
      Emission levels as high as SSP5-8.5 are not obtained by Integrated
      Assessment Models (IAMs) under any of the SSPs other than the fossil
      fueled SSP5 socioeconomic development pathway.

    Each component of the sea level projection scenarios is provided as a
    separate band, as detailed in the table below.

  ||| + components,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(
      'https://creativecommons.org/licenses/by/4.0/legalcode.en'
    ),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5281/zenodo.5914709',
    },
  ],
  keywords: [
    'ocean',
    'sea_level_changes',
  ],
  providers: [
    ee.producer_provider('IPCC', 'https://zenodo.org/records/6382554'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2020-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      111.32,
    ],
    'eo:bands': [
      {
        name: std.join('_', [band, 'quantile', index]),
        description: std.join(
          ' ',
          [
            bands_info.DESCRIPTION_MAPPING[band],
            'quantile',
            std.strReplace(index, '_', '.'),
          ]
        ),
        'gee:units': bands_info.UNITS_MAPPING[band],
      }
      for band in bands_info.BAND_PREFIXES
      for index in bands_info.QUANTILES
    ],
    'gee:visualizations': [
      {
        display_name: 'Total values quantile 0.5',
        lookat: {
          lat: 21.44,
          lon: -51.49,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              10,
            ],
            max: [
              150,
            ],
            palette: ['0000FF', '00FFFF', 'FFFF00', 'FF0000'],
            bands: [
              'total_values_quantile_0_5',
            ],
          },
        },
      },
    ],
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 10,
  },
  'sci:citation': |||
    Garner, G. G., T. Hermans, R. E. Kopp, A. B. A. Slangen, T. L. Edwards,
    A. Levermann, S. Nowikci, M. D. Palmer, C. Smith, B. Fox-Kemper,
    H. T. Hewitt, C. Xiao, G. Aðalgeirsdóttir, S. S. Drijfhout, T. L. Edwards,
    N. R. Golledge, M. Hemer, G. Krinner, A. Mix, D. Notz, S. Nowicki,
    I. S. Nurhati, L. Ruiz, J-B. Sallée, Y. Yu, L. Hua, T. Palmer, B. Pearson,
    2021. IPCC AR6 Sea Level Projections. Version 20210809. Dataset
    accessed [YYYY-MM-DD] at
    [10.5281/zenodo.5914709](https://doi.org/10.5281/zenodo.5914709)
  |||,
  'sci:publications': [
    {
      citation: |||
        Fox-Kemper, B., et al., 2021: Ocean, Cryosphere and Sea Level Change.
        In Climate Change 2021: The Physical Science Basis. Contribution of
        Working Group I to the Sixth Assessment Report of the
        IPCC [Masson-Delmotte, V., et al. (eds.)]. Cambridge University Press,
        pp. 1211-1362.
        [doi:10.1017/9781009157896.011](https://doi.org/10.1017/9781009157896.011).
      |||,
      doi: '10.1017/9781009157896.011',
    },
    {
      citation: |||
        Kopp, R. E., Garner, G. G., Hermans, T. H. J., Jha, S., Kumar, P.,
        Reedy, A., Slangen, A. B. A., Turilli, M., Edwards, T. L.,
        Gregory, J. M., Koubbe, G., Levermann, A., Merzky, A., Nowicki, S.,
        Palmer, M. D., & Smith, C. (2023). The Framework for Assessing Changes
        To Sea-Level (FACTS) v1.0, 16, 7461-7489.
        [10.5194/gmd-16-7461-2023](https://doi.org/10.5194/gmd-16-7461-2023)
      |||,
      doi: '10.5194/gmd-16-7461-2023',
    },
  ],
  'gee:terms_of_use': |||
    This dataset is made available publicly under the Creative Commons by
    Attribution license(CC-BY-4.0).
  |||,
}
