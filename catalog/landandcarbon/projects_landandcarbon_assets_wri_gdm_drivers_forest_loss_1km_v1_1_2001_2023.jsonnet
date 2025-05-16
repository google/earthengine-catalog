
local id = 'projects/landandcarbon/assets/wri_gdm_drivers_forest_loss_1km/v1_1_2001_2023';
local subdir = 'landandcarbon';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local version = '1.1';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'WRI/Google DeepMind Global Drivers of Forest Loss 2001-2023 v1.1',
  version: version,

  description: |||
    This dataset maps the dominant driver of tree cover loss from 2001-2023 globally at 1 km resolution. 
    Produced by the World Resources Institute (WRI) and Google DeepMind, the data were developed using 
    a global neural network model (ResNet) trained on a set of samples collected through visual 
    interpretation of very high-resolution satellite imagery. The model used satellite imagery 
    (Landsat 7 & 8, Sentinel-2) and ancillary data to classify seven driver categories: 
    permanent agriculture, hard commodities, shifting cultivation, logging, wildfires, 
    settlements and infrastructure, and other natural disturbances. An independent stratified random 
    sample collected through interpretation of very high resolution satellite imagery was used to 
    estimate the accuracy of the map. 

    A *driver* is defined as the direct cause of tree cover loss, and can include both temporary 
    disturbances (natural or anthropogenic) or permanent loss of tree cover due to a change to 
    a non-forest land use (e.g., deforestation).  The *dominant* driver is defined as the 
    direct driver that caused the majority of tree cover loss within each 1 km cell over the time 
    period. Classes are defined as follows:
    * Permanent agriculture: Long-term, permanent tree cover loss for small- to large-scale agriculture. 
    This includes perennial tree crops, as well as pasture and seasonal crops and cropping systems, 
    which may include a fallow period. Agricultural activities are considered "permanent" if there 
    is visible evidence that they persist following the tree cover loss event and are not a part of 
    a temporary cultivation cycle. 
    * Hard commodities: Loss due to the establishment or expansion of mining or energy infrastructure.
    * Shifting cultivation: Tree cover loss due to small- to medium-scale clearing for temporary 
    cultivation that is later abandoned and followed by subsequent regrowth of secondary forest or 
    vegetation.
    * Logging: Forest management and logging activities occurring within managed, natural or semi-natural 
    forests and plantations, often with evidence of forest regrowth or planting in subsequent years. 
    Includes clear-cut and selective logging, establishment of logging roads, forest thinning, and 
    salvage or sanitation logging. 
    * Wildfire: Tree cover loss due to fire with no visible human conversion or agricultural activity 
    afterward. Fires may be started by natural causes (e.g. lightning) or may be related to human 
    activities (accidental or deliberate).
    * Settlements and infrastructure: Tree cover loss due to expansion and intensification of roads, 
    settlements, urban areas, or built infrastructure (not associated with other classes).
    * Other natural disturbances: Tree cover loss due to other non-fire natural disturbances 
    (e.g., landslides, insect outbreaks, river meandering). If loss due to natural causes is followed 
    by salvage or sanitation logging, it is classified as forest management.

    **Limitations**: This product does not distinguish between the loss of *natural forest* and *planted 
    trees* (e.g., plantations, tree crops, or agroforestry systems). While tree cover loss associated 
    with the *permanent agriculture*, *hard commodities*, and *settlements and infrastructure* classes represent 
    a close approximation of deforestation (permanent conversion of forest to another land use), these 
    classes may sometimes include the clearing of planted trees. For example, clearing and replanting an 
    orchard would be included in the *permanent agriculture* class, but is not deforestation of a natural forest. 
    Similarly, replacement of natural forest with wood fiber plantations is not distinguished from routine 
    harvesting within existing plantations established before 2000, as these are both included in the logging 
    class. 

    This product shows the dominant driver in each 1km cell over the entire period. It does not show 
    multiple drivers if they occur in the same cell at smaller scales, nor does it detail the sequence of 
    drivers if multiple occurred at different times within the period. Additionally, these data are limited 
    in scope to attributing drivers to tree cover loss as mapped by the 
    [Global Forest Change v1.11](https://www.science.org/doi/10.1126/science.1244693) tree cover loss product, 
    and therefore the detection of loss is subject to the accuracy of that product. 
    
    **For a full description of the methods, technical specifications, definitions, accuracy, and 
    limitations, please see the publication**: 
    [https://doi.org/10.1088/1748-9326/add606](https://doi.org/10.1088/1748-9326/add606). 
    The data is also available for download on [Zenodo](https://zenodo.org/records/15225267) and 
    the [WRI Data Explorer](https://datasets.wri.org/datasets/dominant-drivers-of-tree-cover-loss-at-1km-v1-1).  
  |||, 


  'gee:categories': ['agriculture', 'ecosystems','fire','landuse-landcover','forest-biomass'],

  keywords: [
    'agriculture',
    'deforestation',
    'forest',
    'landuse',
    'wri',
    'google',
    ],

  providers: [
    ee.producer_provider('World Resources Institute', 'https://www.wri.org/'),
    ee.producer_provider('Google DeepMind', 'https://deepmind.google/'),
    ee.host_provider(self_ee_catalog_url),
  ],

  extent: ee.extent_global('2001-01-01T00:00:00Z', '2024-01-01T00:00:00Z'),

  summaries: {
    gsd: [1111.95],
    'eo:bands': [
      {
        name: 'classification',
        description: 'Most likely class based on raw probabilities.',
        'gee:classes': [
          {value: 1, color: 'E39D29', description: 'Permanent agriculture'},
          {value: 2, color: 'E58074', description: 'Hard commodities'},
          {value: 3, color: 'E9D700', description: 'Shifting cultivation'},
          {value: 4, color: '51A44E', description: 'Logging'},
          {value: 5, color: '895128', description: 'Wildfire'},
          {value: 6, color: 'A354A0', description: 'Settlements and infrastructure'},
          {value: 7, color: '3A209A', description: 'Other natural disturbances'},
        ],
      },
      {
        name: 'probability_1',
        description: 'Probability of "Permanent agriculture" class (scaled to [0-250]).',
      },
      {
        name: 'probability_2',
        description: 'Probability of "Hard commodities" class (scaled to [0-250]).',
      },
      {
        name: 'probability_3',
        description: 'Probability of "Shifting cultivation" class (scaled to [0-250]).',
      },
      {
        name: 'probability_4',
        description: 'Probability of "Logging" class (scaled to [0-250]).',
      },
      {
        name: 'probability_5',
        description: 'Probability of "Wildfire" class (scaled to [0-250]).',
      },
      {
        name: 'probability_6',
        description: 'Probability of "Settlements and infrastructure" class (scaled to [0-250]).',
      },
      {
        name: 'probability_7',
        description: 'Probability of "Other natural disturbances" class (scaled to [0-250]).',
      },
    ],

    classification: {minimum: 1, maximum: 7, 'gee:estimated_range': false},
    probability_1: {minimum: 0, maximum: 250, 'gee:estimated_range': false},
    probability_2: {minimum: 0, maximum: 250, 'gee:estimated_range': false},
    probability_3: {minimum: 0, maximum: 250, 'gee:estimated_range': false},
    probability_4: {minimum: 0, maximum: 250, 'gee:estimated_range': false},
    probability_5: {minimum: 0, maximum: 250, 'gee:estimated_range': false},
    probability_6: {minimum: 0, maximum: 250, 'gee:estimated_range': false},
    probability_7: {minimum: 0, maximum: 250, 'gee:estimated_range': false},

    'gee:visualizations': [
      {
        display_name: 'Drivers of forest loss classification',
        lookat: {lon: -9.22, lat: 20.65, zoom: 3},
        image_visualization: {
          band_vis: {
            min: [1],
            max: [7],
            palette: ['E39D29','E58074','e9d700','51a44e','895128','a354a0','3a209a'],
            bands: ['classification'],
            }
          },  
        },
      ],
  },

  'sci:citation': |||
   Sims, M., Stanimirova, R., Raichuk, A., Neumann, M., Richter, J., Follett, F., 
   MacCarthy, J., Lister, K., Randle, C., Sloat, L., Esipova, E., Jupiter, J., Stanton, 
   C., Morris, D., Slay, C. M., Purves, D., and Harris, N. (2025). 
   Global drivers of forest loss at 1 km resolution. 
   Environmental Research Letters. 
   [doi:10.1088/1748-9326/add606](https://doi.org/10.1088/1748-9326/add606)
  |||,


  'gee:terms_of_use': ee.gee_terms_of_use(license),

  // TODO(google): Remove gee:status when the dataset is ready.
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.image,
  license: license.id,
  links: ee.standardLinks(subdir, id),

  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
