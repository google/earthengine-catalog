local id = 'projects/nature-trace/assets/ghg/emit/mapl_emit_plumes_v1_0';
local subdir = 'nature-trace';

local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;
local basename = std.strReplace(id, '/', '_');
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
  title: 'MAPL-EMIT: Modeled Methane Plumes',
  version: '1.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Methane Analysis and Plume Localization with EMIT (MAPL-EMIT) dataset provides high-resolution (60m) methane (CH₄) plume complex maps and plume source locations derived from radiance data captured by the Earth Surface Mineral Dust Source Investigation (EMIT) instrument.

    Methane point-source emissions are a major driver of near-term climate forcing. Traditional space-based identification methods often rely on manual analyst review or matched-filter techniques that can miss smaller emissions and are laborious to characterize and delineate. MAPL-EMIT addresses this using a deep learning vision transformer framework that simultaneously analyzes the full radiance spectrum and the spatial context of neighboring pixels. Validated on millions of synthetic plumes and real-world benchmarks, the model provides automated plume detection across full-granule radiances, estimating per-plume spatial extents, column integrated enhancements (ppm-m increase over background) and source locations.

    This dataset contains the model-predicted outputs for methane plume complexes. For each identified plume, the dataset provides the corresponding methane enhancements, an instance mask delineating the plume's shape, and the most likely source location. If you are interested in granule level enhancements and plume probabilities, please see
    [MAPL-EMIT Enhancements](https://developers.google.com/earth-engine/datasets/catalog/projects_nature-trace_assets_ghg_emit_mapl_emit_enhancements_v1_0)

    Each plume has a 'confidence' property containing one of the following confidence scores:
    * **High confidence:** Plumes detected three or more times across different EMIT observations over time. Human review of a random subset of these plumes yielded a false positive rate of ~3-5%. This low error rate is comparable to existing human-annotated datasets, making high-confidence plumes suitable for direct downstream use.
    * **Medium confidence:** Plumes without a temporal match across multiple EMIT observations. Human review indicates a false positive rate of ~50-55% for this category. Due to the high likelihood of false positives, users should exercise caution and apply secondary filtering before downstream analysis. Recommended filtering strategies include matching plumes with known infrastructure, analyzing spectral signatures, applying d_norm or d_cor spectral scores, and cross-referencing with local wind direction.

    **Example Uses:**
    * **Automated Plume Delineation & Source Localization:** Identifying the spatial footprint of methane plumes and attributing them to specific infrastructure features (e.g., wells, landfills, compressor stations), even amid overlapping plumes.
    * **Global Methane Tracking:** Scanning the complete EMIT data catalog to automatically construct a comprehensive database of global methane point sources.
    * **Impact Quantification:** Combining instance masks and enhancement values to estimate leak severity from previously undetected or uncaptured sources.

    **Limitations:**
    * **False Positives:** Automated detection inherently carries a risk of false positives. When utilizing medium-confidence plumes, it is critical to treat detections as candidates and filter them against known locations of physical infrastructure, employ temporal aggregations to confirm persistent sources, or other verification methods.
    * **False Negatives:** The model may miss some plumes, particularly those with low enhancements or small spatial extents. Approximately 16% of expert-annotated NASA EMIT L2B plumes are missed by the model.
    * **Enhancement vs. emission rate:** Reported pixel values represent atmospheric column enhancements (ppm-m), not emission rates (kg/hr). Estimating emission flux requires using methods like IME along with external wind fields and introduces additional uncertainty.
    * **Instrument coverage:** Data coverage is constrained by EMIT's orbital sampling and field-of-view; observations are only available for locations and times when the instrument collected measurements from the International Space Station.
    * **Environmental Factors:** Model performance degrades in scenarios with heavy cloud cover, shadows, or low-albedo (dark) surfaces, which reduce the quality of the hyperspectral radiance signal.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  'gee:categories': ['atmosphere'],
  keywords: [
    'emit',
    'methane',
    'ghg',
  ],
  providers: [
    ee.producer_provider('Google Research', 'https://research.google/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2022-08-10T00:00:00Z', null),
  summaries: {
    gsd: [
      60.0,
    ],
    'eo:bands': [
      {
        name: 'methane_enhancement',
        description: 'Methane enhancement',
        'gee:units': units.ppmm,
      },
      {
        name: 'plume_probability',
        description: 'Plume probability',
      },
      {
        name: 'origin_probability',
        description: 'Origin probability',
      },
    ],
        'gee:schema': [
      {
        name: 'observed_enh',
        description: 'Observed methane enhancement',
        type: ee_const.var_type.double,
      },
      {
        name: 'spectral_vetting_background_pixels',
        description: 'Number of background pixels used in spectral vetting',
        type: ee_const.var_type.double,
      },
      {
        name: 'plume_head_lat',
        description: 'Latitude of the detected plume head',
        type: ee_const.var_type.double,
      },
      {
        name: 'radiance_plume_std',
        description: 'Standard deviation of radiance within the plume',
        type: ee_const.var_type.double_list,
      },
      {
        name: 'baseline_transmittance',
        description: 'Baseline estimated transmittance',
        type: ee_const.var_type.double_list,
      },
      {
        name: 'fitted_enh',
        description: 'Fitted methane enhancement',
        type: ee_const.var_type.double,
      },
      {
        name: 'cluster_size',
        description: 'Number of plume detects over strided inference windows with the maximum being 16',
        type: ee_const.var_type.double,
      },
      {
        name: 'time_start',
        description: 'Start time of the observation in milliseconds since epoch',
        type: ee_const.var_type.double,
      },
      {
        name: 'radiance_plume_mean',
        description: 'Mean radiance within the plume',
        type: ee_const.var_type.double_list,
      },
      {
        name: 'ee_asset_id',
        description: 'Earth Engine asset ID of the corresponding EMIT L1B granule',
        type: ee_const.var_type.string,
      },
      {
        name: 'radiance_context_mean',
        description: 'Mean radiance of the contextual background',
        type: ee_const.var_type.double_list,
      },
      {
        name: 'observed_transmittance_sel',
        description: 'Observed transmittance in selected wavelengths',
        type: ee_const.var_type.double_list,
      },
      {
        name: 'd_norm',
        description: 'Spectral fit normalized distance metric. Ranges from 0 to 1 where 1 indicates a poor fit. Plumes with a d_norm <= 0.5 are typically high confidence real plumes. Please refer to the paper for more details.',
        type: ee_const.var_type.double,
      },
      {
        name: 'era5_u_10m',
        description: 'ERA5 10m U-component of wind',
        type: ee_const.var_type.double,
      },
      {
        name: 'plume_len_max',
        description: 'Distance to the end of the detected plume',
        type: ee_const.var_type.double,
      },
      {
        name: 'era5_v_10m',
        description: 'ERA5 10m V-component of wind',
        type: ee_const.var_type.double,
      },
      {
        name: 'plume_len_min',
        description: 'Distance to the start of the detected plume',
        type: ee_const.var_type.double,
      },
      {
        name: 'modeled_transmittance',
        description: 'Modeled transmittance for the observation',
        type: ee_const.var_type.double_list,
      },
      {
        name: 'spectral_vetting_plume_pixels',
        description: 'Number of plume pixels used in spectral vetting',
        type: ee_const.var_type.double,
      },
      {
        name: 'plume_head_lon',
        description: 'Longitude of the detected plume head',
        type: ee_const.var_type.double,
      },
      {
        name: 'radiance_context_std',
        description: 'Standard deviation of radiance of the contextual background',
        type: ee_const.var_type.double_list,
      },
      {
        name: 'd_cor',
        description: 'Spectral fit correlation distance metric. Ranges from 0 to 1 where 1 indicates a poor fit. Plumes with a d_cor <= 0.4 are typically real plumes. Please refer to the paper for more details.',
        type: ee_const.var_type.double,
      },
      {
        name: 'wavelengths_sel',
        description: 'Selected wavelengths for spectral fit analysis',
        type: ee_const.var_type.double_list,
      },
      {
        name: 'confidence',
        description: 'Confidence of the detected plume. Either high or medium.',
        type: ee_const.var_type.string,
      },
      {
        name: 'temporal_cluster_index',
        description: 'Temporal cluster index of the detected plume. Plumes with the same temporal cluster index are potentially pointing to the same source across time. Plumes with a temporal cluster index of -1 are single detects across time.',
        type: ee_const.var_type.double,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Methane plume enhancement (ppm-m)',
        lookat: {
          lon: -101.93,
          lat: 32.28,
          zoom: 12,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              300.0,
            ],
            bands: [
              'methane_enhancement',
            ],
            palette: ['000004', '1b0c41', '4a0c6b', '781c6d', 'a52c60', 'cf4446', 'ed6925', 'fb9b06', 'f7d13d', 'fcffa4'],
          },
        },
      },
    ],
  },
  'sci:citation': ||| 
    Batchu, V. V., Conserva, M., Wilson, A., Michalak, A. M., Gulshan, V., Brodrick, P. G., Thorpe, A. K., & Arsdale, C. V. (2026). Global monitoring of methane point sources using deep learning on hyperspectral radiance measurements from EMIT. arXiv preprint arXiv:2604.10094.
  |||,
  'gee:terms_of_use': |||
    This dataset is licensed under
    [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) and requires the
    following attribution: "This dataset is produced by Google".
  |||,
}
