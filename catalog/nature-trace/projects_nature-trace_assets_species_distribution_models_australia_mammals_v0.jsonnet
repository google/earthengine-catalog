local id = 'projects/nature-trace/assets/species_distribution_models/australia_mammals/v0';
local subdir = 'nature-trace';
local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local license = spdx.cc_by_4_0;
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'Species Distribution, Australia Mammals',
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  'gee:type': ee_const.gee_type.image,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  description: |||
    **Note: This dataset is not yet peer-reviewed.**

    These species distribution model outputs, developed by Google in
    collaboration with [QCIF](https://www.qcif.edu.au/) and
    [EcoCommons](https://www.ecocommons.org.au/), represent estimates of
    species’ relative occurrence likelihoods (i.e., higher values indicate a
    higher likelihood that the species would be detected at a location, for a
    given survey methodology and given survey effort, compared to lower values).

    They were generated using a multi-species
    [heterogenous graph neural network model](https://ar5iv.labs.arxiv.org/html/2503.11900)
    trained jointly on species observation data from the
    [Global Biodiversity Information Facility](https://www.gbif.org/) for 174
    Australian mammals from 2017 - 2024 (inclusive), combined with species
    [trait](https://figshare.com/articles/dataset/COMBINE_a_Coalesced_Mammal_Database_of_Intrinsic_and_extrinsic_traits/13028255/4) and taxonomy data for the same species from COMBINE,
    and satellite and environmental as embedded by
    [AlphaEarth Foundations](https://deepmind.google/discover/blog/alphaearth-foundations-helps-map-our-planet-in-unprecedented-detail/).
    Estimates of species’ geographical distributions are made at c. 1km resolution (S2 cells level 13).

    These distributions are intended to support conservation initiatives like
    the [Global Biodiversity Framework](https://www.cbd.int/gbf/targets), which
    includes [30x30](https://en.wikipedia.org/wiki/30_by_30). It is likely that
    distributions could be significantly improved via fine tuning with
    additional species observation data, where this is available.

    Limitations:

    * Experimental Status: These results are intended as demonstrations of early
      research and have not yet been peer-reviewed.
    * Aggregate vs. Specific Validation: Model outputs have been evaluated
      collectively against expert-produced Area of Habitation maps (mean ROC AUC
      = 0.89 over all species,  AUC ROC > 0.9 for each of the released
      species), but have not been vetted by species experts on a
      species-by-species basis.
    * Presence-Only Data Constraints: These models are trained primarily on
      presence-only data. Outputs represent a relative likelihood of detection
      given current survey efforts, rather than true probability of occupancy.
    * Input Data Bias: The accuracy of these maps is intrinsically linked to the
      input datasets. Biodiversity observation data is known to contain spatial,
      temporal, and taxonomic biases (often reflecting accessibility near roads
      or population centers rather than true biological distribution). The
      availability of species observation data has also been found to [reflect
      social and political inequities](https://www.science.org/doi/abs/10.1126/science.adh8874).
      These biases may be propagated into the final model outputs.

    This experimental preview was released November 5, 2025.
  |||,
  'gee:categories': ['ecosystems'],
  keywords: [
    'biodiversity',
    'conservation',
    'alphaearth-derived',
    'pre-review',
    'species',
  ],
  providers: [
    ee.producer_provider('Google', 'https://deepmind.google/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: {
    spatial: {
      bbox: [[112.9, -43.7, 153.7, -10.4]], // Approx. min lon, min lat, max lon, max lat for Australia
    },
    temporal: {
      interval: [['2017-01-01T00:00:00Z', '2025-01-01T00:00:00Z']],
    },
  },
  summaries: {
    'eo:bands': [
      {
        'name': 'AgileAntechinus',
        'description': 'Likelihood of Agile Antechinus occurrence (scaled to [0-250])',
      },
      {
        'name': 'AustralianSwampRat',
        'description': 'Likelihood of Australian Swamp Rat occurrence (scaled to [0-250])',
      },
      {
        'name': 'BlackFlyingFox',
        'description': 'Likelihood of Black flying fox occurrence (scaled to [0-250])',
      },
      {
        'name': 'BrownAntechinus',
        'description': 'Likelihood of Brown Antechinus occurrence (scaled to [0-250])',
      },
      {
        'name': 'Brush-TailedPhascogale',
        'description': 'Likelihood of Brush-tailed Phascogale occurrence (scaled to [0-250])',
      },
      {
        'name': 'Brush-TailedRock-Wallaby',
        'description': 'Likelihood of Brush-tailed Rock-wallaby occurrence (scaled to [0-250])',
      },
      {
        'name': 'BushRat',
        'description': 'Likelihood of Bush Rat occurrence (scaled to [0-250])',
      },
      {
        'name': 'CommonRingtailPossum',
        'description': 'Likelihood of Common Ringtail Possum occurrence (scaled to [0-250])',
      },
      {
        'name': 'CommonWombat',
        'description': 'Likelihood of Common Wombat occurrence (scaled to [0-250])',
      },
      {
        'name': 'EasternGreyKangaroo',
        'description': 'Likelihood of Eastern Grey Kangaroo occurrence (scaled to [0-250])',
      },
      {
        'name': 'GreaterGlider',
        'description': 'Likelihood of Greater Glider occurrence (scaled to [0-250])',
      },
      {
        'name': 'HastingsRiverMouse',
        'description': 'Likelihood of Hastings River Mouse occurrence (scaled to [0-250])',
      },
      {
        'name': 'LeadbeatersPossum',
        'description': 'Likelihood of Leadbeater\'s Possum occurrence (scaled to [0-250])',
      },
      {
        'name': 'Long-NosedBandicoot',
        'description': 'Likelihood of Long-nosed Bandicoot occurrence (scaled to [0-250])',
      },
      {
        'name': 'Long-NosedPotoroo',
        'description': 'Likelihood of Long-nosed Potoroo occurrence (scaled to [0-250])',
      },
      {
        'name': 'LumholtzsTree-Kangaroo',
        'description': 'Likelihood of Lumholtz\'s Tree-kangaroo occurrence (scaled to [0-250])',
      },
      {
        'name': 'MountainBrushtailPossum',
        'description': 'Likelihood of Mountain Brushtail Possum occurrence (scaled to [0-250])',
      },
      {
        'name': 'NorthernBrownBandicoot',
        'description': 'Likelihood of Northern Brown Bandicoot occurrence (scaled to [0-250])',
      },
      {
        'name': 'Platypus',
        'description': 'Likelihood of Platypus occurrence (scaled to [0-250])',
      },
      {
        'name': 'Short-EaredPossum',
        'description': 'Likelihood of Short-eared Possum occurrence (scaled to [0-250])',
      },
      {
        'name': 'SouthernBrownBandicoot',
        'description': 'Likelihood of Southern Brown Bandicoot occurrence (scaled to [0-250])',
      },
      {
        'name': 'SquirrelGlider',
        'description': 'Likelihood of Squirrel Glider occurrence (scaled to [0-250])',
      },
      {
        'name': 'SwampWallaby',
        'description': 'Likelihood of Swamp Wallaby occurrence (scaled to [0-250])',
      },
      {
        'name': 'WesternGreyKangaroo',
        'description': 'Likelihood of Western Grey Kangaroo occurrence (scaled to [0-250])',
      },
      {
        'name': 'Yellow-FootedAntechinus',
        'description': 'Likelihood of Yellow-footed Antechinus occurrence (scaled to [0-250])',
      },
    ],
    'gsd': [
      1000.0
    ],
    'AgileAntechinus': { 'minimum': 0, 'maximum': 254.48, 'gee:estimated_range': false },
    'AustralianSwampRat': { 'minimum': 0, 'maximum': 253.85, 'gee:estimated_range': false },
    'BlackFlyingFox': { 'minimum': 0, 'maximum': 254.94, 'gee:estimated_range': false },
    'BrownAntechinus': { 'minimum': 0, 'maximum': 254.79, 'gee:estimated_range': false },
    'Brush-TailedPhascogale': { 'minimum': 0, 'maximum': 242.99, 'gee:estimated_range': false },
    'Brush-TailedRock-Wallaby': { 'minimum': 0, 'maximum': 252.78, 'gee:estimated_range': false },
    'BushRat': { 'minimum': 0, 'maximum': 254.55, 'gee:estimated_range': false },
    'CommonRingtailPossum': { 'minimum': 0, 'maximum': 254.98, 'gee:estimated_range': false },
    'CommonWombat': { 'minimum': 0, 'maximum': 253.88, 'gee:estimated_range': false },
    'EasternGreyKangaroo': { 'minimum': 0, 'maximum': 253.93, 'gee:estimated_range': false },
    'GreaterGlider': { 'minimum': 0, 'maximum': 254.84, 'gee:estimated_range': false },
    'HastingsRiverMouse': { 'minimum': 0, 'maximum': 243.4, 'gee:estimated_range': false },
    'LeadbeatersPossum': { 'minimum': 0, 'maximum': 254.99, 'gee:estimated_range': false },
    'Long-NosedBandicoot': { 'minimum': 0, 'maximum': 254.13, 'gee:estimated_range': false },
    'Long-NosedPotoroo': { 'minimum': 0, 'maximum': 252.91, 'gee:estimated_range': false },
    'LumholtzsTree-Kangaroo': { 'minimum': 0, 'maximum': 253.14, 'gee:estimated_range': false },
    'MountainBrushtailPossum': { 'minimum': 0, 'maximum': 254.95, 'gee:estimated_range': false },
    'NorthernBrownBandicoot': { 'minimum': 0, 'maximum': 247.76, 'gee:estimated_range': false },
    'Platypus': { 'minimum': 0, 'maximum': 254.59, 'gee:estimated_range': false },
    'Short-EaredPossum': { 'minimum': 0, 'maximum': 254.36, 'gee:estimated_range': false },
    'SouthernBrownBandicoot': { 'minimum': 0, 'maximum': 254.41, 'gee:estimated_range': false },
    'SquirrelGlider': { 'minimum': 0, 'maximum': 234.98, 'gee:estimated_range': false },
    'SwampWallaby': { 'minimum': 0, 'maximum': 253.3, 'gee:estimated_range': false },
    'WesternGreyKangaroo': { 'minimum': 0, 'maximum': 254.99, 'gee:estimated_range': false },
    'Yellow-FootedAntechinus': { 'minimum': 0, 'maximum': 254.58, 'gee:estimated_range': false },
    'gee:visualizations': [
      {
        display_name: 'Greater Glider Occurrence',
        lookat: {
          lon: 133.4,
          lat: -26.6,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [0],
            max: [250],
            palette: [
              '0000FF', '004FFF', '009DFF', '00ECFF', '00FFC4', '00FF75', '00FF27',
              '28FF00', '76FF00', 'C5FF00', 'FFEB00', 'FF9C00', 'FF4E00', 'FF0000',
            ],
            bands: ['GreaterGlider'],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Google LLC, "Australian mammal species distributions" (2025). Available online at %s.
  ||| % self_ee_catalog_url,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
  ],
  'gee:terms_of_use': |||
    All materials are licensed under the [Creative Commons Attribution 4.0 International
    License (CC-BY 4.0)](https://creativecommons.org/licenses/by/4.0/).

    Attribution: "Dataset developed by Google in collaboration with QCIF and
    EcoCommons."

    Unless required by applicable law or agreed to in writing, all materials distributed here
    under the CC-BY license are distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
    CONDITIONS OF ANY KIND, either express or implied.
    See the [license](https://creativecommons.org/licenses/by/4.0/legalcode)
    for the specific language governing permissions and limitations under those licenses.

    This is not an official Google product.
  |||,
}
