local id = 'projects/nature-trace/assets/ghg/emit/mapl_emit_enhancements_v1_0';
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
  title: 'MAPL-EMIT: Modeled Methane Enhancement and Plume Probability',
  version: '1.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Methane Analysis and Plume Localization with EMIT (MAPL-EMIT) enhancements dataset provides high-resolution (60m) methane (CH₄) enhancement maps and plume probabilities derived from radiance data captured by the Earth Surface Mineral Dust Source Investigation (EMIT) instrument which were generated and released as part of the research paper: "Publication to be updated, preprint: [https://arxiv.org/abs/2604.10094](https://arxiv.org/abs/2604.10094)"

    Methane point-source emissions are a major driver of near-term climate forcing. Traditional space-based identification methods often rely on manual analyst review or matched-filter techniques that can miss smaller plumes. MAPL-EMIT addresses this using a deep learning vision transformer framework that simultaneously analyzes the full radiance spectrum and the spatial context of neighboring pixels. Validated on millions of synthetic plumes and real-world benchmarks, the model achieves significantly lower detection limits, capturing weaker plumes and more plausible emissions than human analysts.

    This dataset provides model-generated granule-level methane enhancements (in ppm-m) along with plume probability scores for each pixel. If you are interested in plume level data, please see [MAPL-EMIT Plumes](https://developers.google.com/earth-engine/datasets/catalog/projects_nature-trace_assets_ghg_emit_mapl_emit_plumes_v1_0)

    The data is provided on a per-pixel basis:
    * **Enhancements:** The estimated column-integrated methane enhancement (ppm-m).
    * **Plume Probability:** A score (0 to 1) representing the model's confidence that the pixel contains a methane plume.

    **Example Uses:**
    * **Enhancement based flux inversion:** Using the granule level enhancements paired with winds and other relevant sources to produce flux inversion estimates. 
    * **Algorithm Development & Cross-Validation:** Utilizing the raw pixel-level enhancements and probabilities to develop custom plume identification algorithms, or comparing against other retrieval techniques.
    * **Detailed Morphological Studies:** Analyzing the continuous spread and diffusion of a plume without relying on pre-computed discrete bounding polygons.

    **Limitations:**
    * **Enhancement noise:** The enhancements can be noisy, especially when we are looking at very low enhancements which can either be missed out by the model entirely or incorrectly estimated. We observe that the SNR (signal-to-noise ratio) for MAPL-EMIT enhancements is much higher than Matched Filter or other approaches, however, noise still exists and should be handled accordingly.
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
        description: 'Methane enhancement (ppm-m)',
        'gee:units': units.ppmm,
      },
      {
        name: 'plume_probability',
        description: 'Plume probability',
      },
    ],
    'gee:schema': [
      {
        name: 'ee_asset_id',
        description: 'Earth Engine asset ID of the corresponding EMIT L1B granule',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Methane Enhancement',
        lookat: {
          lon: -100.0,
          lat: 44.5,
          zoom: 8,
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
