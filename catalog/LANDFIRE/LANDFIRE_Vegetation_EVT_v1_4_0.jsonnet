local id = 'LANDFIRE/Vegetation/EVT/v1_4_0';
local subdir = 'LANDFIRE';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

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
  title: 'LANDFIRE EVT (Existing Vegetation Type) v1.4.0',
  version: '1.4.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    LANDFIRE (LF), Landscape Fire and Resource Management Planning Tools, is a
    shared program between the wildland fire management programs of the U.S.
    Department of Agriculture's Forest Service, U.S. Department of the Interior's
    Geological Survey, and The Nature Conservancy.

    LANDFIRE (LF) layers are created using predictive landscape models based on
    extensive field-referenced data, satellite imagery and biophysical gradient
    layers using classification and regression trees.

    LANDFIRE's (LF) Existing Vegetation Type (EVT) represents the current distribution of the terrestrial ecological systems classification, developed by NatureServe for the western hemisphere, through 2016. A terrestrial ecological system is defined as a group of plant community types (associations) that tend to co-occur within landscapes with similar ecological processes, substrates, and/or environmental gradients.

    *The LF Ecological Systems Descriptions for CONUS provides descriptions for each Ecological System including species, distribution and classification information.

    EVT also includes ruderal or semi-natural vegetation types within the U.S. National Vegetation Classification.
    The LF Ruderal NVC Groups Descriptions for CONUS provides descriptions for each ruderal NVC Group including species, distribution, and classification information.

    EVT is mapped using decision tree models, field data, Landsat imagery, elevation, and biophysical gradient data.

    * Decision tree models are developed separately for each of the three lifeforms-tree, shrub, and herbaceous and are then used to generate lifeform specific EVT layers.

    * Disturbance products are included in LF Remap products to describe areas on the landscape that have experienced change within the previous 10-year period.

    * The EVT product is reconciled through QA/QC measures to ensure life-form is synchronized with both Existing Vegetation Cover and Existing Vegetation Height.

    The LANDIFRE Vegetation datasets include:

    * Biophysical Settings (BPS)
    * Environmental Site Potential (ESP)
    * Existing Vegetation Canopy Cover (EVC)
    * Existing Vegetation Height (EVH).
    * Existing Vegetation Type (EVT)
    These layers are created using predictive landscape models based on extensive
    field-referenced data, satellite imagery and biophysical gradient layers using
    classification and regression trees.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'doi',
    'fire',
    'landfire',
    'nature_conservancy',
    'usda',
    'usgs',
    'vegetation',
    'wildfire',
  ],
  providers: [
    ee.producer_provider("U.S. Department of Agriculture's (USDA), U.S. Forest Service (USFS), U.S.
Department of the Interior's Geological Survey (USGS), and The Nature Conservancy.", 'https://landfire.gov/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-175.1, 17.52, -63.66, 71.48,
                    '2014-09-01T00:00:00Z', '2014-09-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'EVT_classes',
        description: 'Class values of the Existing Vegetation Type.',
        type: ee_const.var_type.double,
      },
      {
        name: 'EVT_names',
        description: 'Descriptive names of the Existing Vegetation Type.',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'EVT',
        description: 'Existing Vegetation Type',
        'gee:classes': [
          {
            value: 3001,
            color: '000000',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 3002,
            color: '000000',
            description: 'Mediterranean California Sparsely Vegetated Systems',
          },
          {
            value: 3003,
            color: '000000',
            description: 'North Pacific Sparsely Vegetated Systems',
          },
          {
            value: 3004,
            color: '000000',
            description: 'North American Warm Desert Sparsely Vegetated Systems',
          },
          {
            value: 3006,
            color: '000000',
            description: 'Rocky Mountain Alpine/Montane Sparsely Vegetated Systems',
          },
          {
            value: 3007,
            color: '000000',
            description: 'Western Great Plains Sparsely Vegetated Systems',
          },
          {
            value: 3008,
            color: '000100',
            description: 'North Pacific Oak Woodland',
          },
          {
            value: 3009,
            color: '000100',
            description: 'Northwestern Great Plains Aspen Forest and Parkland',
          },
          {
            value: 3011,
            color: '000100',
            description: 'Rocky Mountain Aspen Forest and Woodland',
          },
          {
            value: 3012,
            color: '000100',
            description: 'Rocky Mountain Bigtooth Maple Ravine Woodland',
          },
          {
            value: 3013,
            color: '000000',
            description: 'Western Great Plains Dry Bur Oak Forest and Woodland',
          },
          {
            value: 3014,
            color: '000100',
            description: 'Central and Southern California Mixed Evergreen Woodland',
          },
          {
            value: 3015,
            color: '000100',
            description: 'California Coastal Redwood Forest',
          },
          {
            value: 3016,
            color: '000100',
            description: 'Colorado Plateau Pinyon-Juniper Woodland',
          },
          {
            value: 3017,
            color: '000100',
            description: 'Columbia Plateau Western Juniper Woodland and Savanna',
          },
          {
            value: 3018,
            color: '000100',
            description: 'East Cascades Mesic Montane Mixed-Conifer Forest and Woodland',
          },
          {
            value: 3019,
            color: '000100',
            description: 'Great Basin Pinyon-Juniper Woodland',
          },
          {
            value: 3020,
            color: '000100',
            description: 'Inter-Mountain Basins Subalpine Limber-Bristlecone Pine Woodland',
          },
          {
            value: 3021,
            color: '000100',
            description: 'Klamath-Siskiyou Lower Montane Serpentine Mixed Conifer Woodland',
          },
          {
            value: 3022,
            color: '000000',
            description: 'Klamath-Siskiyou Upper Montane Serpentine Mixed Conifer Woodland',
          },
          {
            value: 3023,
            color: '000000',
            description: 'Madrean Encinal',
          },
          {
            value: 3024,
            color: '000000',
            description: 'Madrean Lower Montane Pine-Oak Forest and Woodland',
          },
          {
            value: 3025,
            color: '000100',
            description: 'Madrean Pinyon-Juniper Woodland',
          },
          {
            value: 3026,
            color: '000000',
            description: 'Madrean Upper Montane Conifer-Oak Forest and Woodland',
          },
          {
            value: 3027,
            color: '000000',
            description: 'Mediterranean California Dry-Mesic Mixed Conifer Forest and Woodland',
          },
          {
            value: 3028,
            color: '000000',
            description: 'Mediterranean California Mesic Mixed Conifer Forest and Woodland',
          },
          {
            value: 3029,
            color: '000000',
            description: 'Mediterranean California Mixed Oak Woodland',
          },
          {
            value: 3030,
            color: '000000',
            description: 'Mediterranean California Lower Montane Conifer Forest and Woodland',
          },
          {
            value: 3031,
            color: '000000',
            description: 'California Montane Jeffrey Pine(-Ponderosa Pine) Woodland',
          },
          {
            value: 3032,
            color: '000000',
            description: 'Mediterranean California Red Fir Forest',
          },
          {
            value: 3033,
            color: '000000',
            description: 'Mediterranean California Subalpine Woodland',
          },
          {
            value: 3034,
            color: '000000',
            description: 'Mediterranean California Mesic Serpentine Woodland and Chaparral',
          },
          {
            value: 3035,
            color: '000000',
            description: 'North Pacific Dry Douglas-fir(-Madrone) Forest and Woodland',
          },
          {
            value: 3036,
            color: '000000',
            description: 'North Pacific Hypermaritime Seasonal Sitka Spruce Forest',
          },
          {
            value: 3037,
            color: '000000',
            description: 'North Pacific Maritime Dry-Mesic Douglas-fir-Western Hemlock Forest',
          },
          {
            value: 3038,
            color: '000000',
            description: 'North Pacific Maritime Mesic Subalpine Parkland',
          },
          {
            value: 3039,
            color: '000000',
            description: 'North Pacific Maritime Mesic-Wet Douglas-fir-Western Hemlock Forest',
          },
          {
            value: 3041,
            color: '000000',
            description: 'North Pacific Mountain Hemlock Forest',
          },
          {
            value: 3042,
            color: '000000',
            description: 'North Pacific Mesic Western Hemlock-Silver Fir Forest',
          },
          {
            value: 3043,
            color: '000000',
            description: 'Mediterranean California Mixed Evergreen Forest',
          },
          {
            value: 3044,
            color: '000000',
            description: 'Northern California Mesic Subalpine Woodland',
          },
          {
            value: 3045,
            color: '000000',
            description: 'Northern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest',
          },
          {
            value: 3046,
            color: '000100',
            description: 'Northern Rocky Mountain Subalpine Woodland and Parkland',
          },
          {
            value: 3047,
            color: '000100',
            description: 'Northern Rocky Mountain Mesic Montane Mixed Conifer Forest',
          },
          {
            value: 3048,
            color: '000000',
            description: 'Northwestern Great Plains Highland White Spruce Woodland',
          },
          {
            value: 3049,
            color: '000000',
            description: 'Rocky Mountain Foothill Limber Pine-Juniper Woodland',
          },
          {
            value: 3050,
            color: '000000',
            description: 'Rocky Mountain Lodgepole Pine Forest',
          },
          {
            value: 3051,
            color: '000000',
            description: 'Southern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 3052,
            color: '000000',
            description: 'Southern Rocky Mountain Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 3053,
            color: '000100',
            description: 'Northern Rocky Mountain Ponderosa Pine Woodland and Savanna',
          },
          {
            value: 3054,
            color: '000100',
            description: 'Southern Rocky Mountain Ponderosa Pine Woodland',
          },
          {
            value: 3055,
            color: '000000',
            description: 'Rocky Mountain Subalpine Dry-Mesic Spruce-Fir Forest and Woodland',
          },
          {
            value: 3056,
            color: '000000',
            description: 'Rocky Mountain Subalpine Mesic-Wet Spruce-Fir Forest and Woodland',
          },
          {
            value: 3057,
            color: '000100',
            description: 'Rocky Mountain Subalpine-Montane Limber-Bristlecone Pine Woodland',
          },
          {
            value: 3058,
            color: '000000',
            description: 'Sierra Nevada Subalpine Lodgepole Pine Forest and Woodland',
          },
          {
            value: 3059,
            color: '000100',
            description: 'Southern Rocky Mountain Pinyon-Juniper Woodland',
          },
          {
            value: 3060,
            color: '000100',
            description: 'East Cascades Ponderosa Pine Forest and Woodland',
          },
          {
            value: 3061,
            color: '000100',
            description: 'Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland',
          },
          {
            value: 3062,
            color: '000000',
            description: 'Inter-Mountain Basins Curl-leaf Mountain Mahogany Woodland',
          },
          {
            value: 3063,
            color: '000000',
            description: 'North Pacific Broadleaf Landslide Forest and Shrubland',
          },
          {
            value: 3064,
            color: '000000',
            description: 'Colorado Plateau Mixed Low Sagebrush Shrubland',
          },
          {
            value: 3065,
            color: '000000',
            description: 'Columbia Plateau Scabland Shrubland',
          },
          {
            value: 3066,
            color: '000000',
            description: 'Inter-Mountain Basins Mat Saltbush Shrubland',
          },
          {
            value: 3067,
            color: '010000',
            description: 'Mediterranean California Alpine Fell-Field',
          },
          {
            value: 3068,
            color: '000000',
            description: 'North Pacific Dry and Mesic Alpine Dwarf-Shrubland or Fell-field or Meadow',
          },
          {
            value: 3070,
            color: '000000',
            description: 'Rocky Mountain Alpine Dwarf-Shrubland',
          },
          {
            value: 3071,
            color: '010000',
            description: 'Sierra Nevada Alpine Dwarf-Shrubland',
          },
          {
            value: 3072,
            color: '000000',
            description: 'Wyoming Basins Dwarf Sagebrush Shrubland and Steppe',
          },
          {
            value: 3074,
            color: '000000',
            description: 'Chihuahuan Creosotebush Desert Scrub',
          },
          {
            value: 3075,
            color: '000000',
            description: 'Chihuahuan Mixed Salt Desert Scrub',
          },
          {
            value: 3076,
            color: '000000',
            description: 'Chihuahuan Stabilized Coppice Dune and Sand Flat Scrub',
          },
          {
            value: 3077,
            color: '000000',
            description: 'Chihuahuan Succulent Desert Scrub',
          },
          {
            value: 3078,
            color: '000000',
            description: 'Colorado Plateau Blackbrush-Mormon-tea Shrubland',
          },
          {
            value: 3079,
            color: '000000',
            description: 'Great Basin Xeric Mixed Sagebrush Shrubland',
          },
          {
            value: 3080,
            color: '000000',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 3081,
            color: '000000',
            description: 'Inter-Mountain Basins Mixed Salt Desert Scrub',
          },
          {
            value: 3082,
            color: '000000',
            description: 'Mojave Mid-Elevation Mixed Desert Scrub',
          },
          {
            value: 3083,
            color: '000000',
            description: 'North Pacific Avalanche Chute Shrubland',
          },
          {
            value: 3084,
            color: '000000',
            description: 'North Pacific Montane Shrubland',
          },
          {
            value: 3085,
            color: '000000',
            description: 'Northwestern Great Plains Shrubland',
          },
          {
            value: 3086,
            color: '000000',
            description: 'Rocky Mountain Lower Montane-Foothill Shrubland',
          },
          {
            value: 3087,
            color: '000000',
            description: 'Sonora-Mojave Creosotebush-White Bursage Desert Scrub',
          },
          {
            value: 3088,
            color: '000000',
            description: 'Sonora-Mojave Mixed Salt Desert Scrub',
          },
          {
            value: 3090,
            color: '000000',
            description: 'Sonoran Granite Outcrop Desert Scrub',
          },
          {
            value: 3091,
            color: '000000',
            description: 'Sonoran Mid-Elevation Desert Scrub',
          },
          {
            value: 3092,
            color: '000000',
            description: 'Southern California Coastal Scrub',
          },
          {
            value: 3093,
            color: '000000',
            description: 'Southern Colorado Plateau Sand Shrubland',
          },
          {
            value: 3094,
            color: '000000',
            description: 'Western Great Plains Sandhill Shrubland',
          },
          {
            value: 3095,
            color: '000000',
            description: 'Apacherian-Chihuahuan Mesquite Upland Scrub',
          },
          {
            value: 3096,
            color: '000000',
            description: 'California Maritime Chaparral',
          },
          {
            value: 3097,
            color: '000000',
            description: 'California Mesic Chaparral',
          },
          {
            value: 3098,
            color: '000000',
            description: 'California Montane Woodland and Chaparral',
          },
          {
            value: 3099,
            color: '000000',
            description: 'California Xeric Serpentine Chaparral',
          },
          {
            value: 3100,
            color: '000000',
            description: 'Chihuahuan Mixed Desert and Thornscrub',
          },
          {
            value: 3101,
            color: '000000',
            description: 'Madrean Oriental Chaparral',
          },
          {
            value: 3103,
            color: '000000',
            description: 'Great Basin Semi-Desert Chaparral',
          },
          {
            value: 3104,
            color: '000000',
            description: 'Mogollon Chaparral',
          },
          {
            value: 3105,
            color: '000000',
            description: 'Northern and Central California Dry-Mesic Chaparral',
          },
          {
            value: 3106,
            color: '000000',
            description: 'Northern Rocky Mountain Montane-Foothill Deciduous Shrubland',
          },
          {
            value: 3107,
            color: '000000',
            description: 'Rocky Mountain Gambel Oak-Mixed Montane Shrubland',
          },
          {
            value: 3108,
            color: '000000',
            description: 'Sonora-Mojave Semi-Desert Chaparral',
          },
          {
            value: 3109,
            color: '000000',
            description: 'Sonoran Paloverde-Mixed Cacti Desert Scrub',
          },
          {
            value: 3110,
            color: '000000',
            description: 'Southern California Dry-Mesic Chaparral',
          },
          {
            value: 3111,
            color: '000000',
            description: 'Western Great Plains Mesquite Woodland',
          },
          {
            value: 3112,
            color: '000000',
            description: 'California Central Valley Mixed Oak Savanna',
          },
          {
            value: 3113,
            color: '000000',
            description: 'California Coastal Live Oak Woodland and Savanna',
          },
          {
            value: 3114,
            color: '000000',
            description: 'California Lower Montane Foothill Pine Woodland and Savanna',
          },
          {
            value: 3115,
            color: '000100',
            description: 'Inter-Mountain Basins Juniper Savanna',
          },
          {
            value: 3116,
            color: '000000',
            description: 'Madrean Juniper Savanna',
          },
          {
            value: 3117,
            color: '000100',
            description: 'Southern Rocky Mountain Ponderosa Pine Savanna',
          },
          {
            value: 3118,
            color: '000000',
            description: 'Southern California Oak Woodland and Savanna',
          },
          {
            value: 3119,
            color: '000100',
            description: 'Southern Rocky Mountain Juniper Woodland and Savanna',
          },
          {
            value: 3120,
            color: '000100',
            description: 'Willamette Valley Upland Prairie and Savanna',
          },
          {
            value: 3121,
            color: '010000',
            description: 'Apacherian-Chihuahuan Semi-Desert Shrubland',
          },
          {
            value: 3122,
            color: '010000',
            description: 'Chihuahuan Gypsophilous Grassland and Steppe',
          },
          {
            value: 3123,
            color: '000000',
            description: 'Columbia Plateau Steppe and Grassland',
          },
          {
            value: 3124,
            color: '000000',
            description: 'Columbia Plateau Low Sagebrush Steppe',
          },
          {
            value: 3125,
            color: '000000',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 3126,
            color: '000000',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe',
          },
          {
            value: 3127,
            color: '000000',
            description: 'Inter-Mountain Basins Semi-Desert Shrub-Steppe',
          },
          {
            value: 3128,
            color: '000000',
            description: 'Northern California Coastal Scrub',
          },
          {
            value: 3129,
            color: '010000',
            description: 'California Central Valley and Southern Coastal Grassland',
          },
          {
            value: 3130,
            color: '010000',
            description: 'California Mesic Serpentine Grassland',
          },
          {
            value: 3131,
            color: '010000',
            description: 'California Northern Coastal Grassland',
          },
          {
            value: 3132,
            color: '010000',
            description: 'Central Mixedgrass Prairie Grassland',
          },
          {
            value: 3133,
            color: '010000',
            description: 'Chihuahuan Sandy Plains Semi-Desert Grassland',
          },
          {
            value: 3134,
            color: '010000',
            description: 'Columbia Basin Foothill and Canyon Dry Grassland',
          },
          {
            value: 3135,
            color: '010000',
            description: 'Inter-Mountain Basins Semi-Desert Grassland',
          },
          {
            value: 3136,
            color: '010000',
            description: 'Mediterranean California Alpine Dry Tundra',
          },
          {
            value: 3137,
            color: '010000',
            description: 'Mediterranean California Subalpine Meadow',
          },
          {
            value: 3138,
            color: '010000',
            description: 'North Pacific Montane Grassland',
          },
          {
            value: 3139,
            color: '010000',
            description: 'Northern Rocky Mountain Lower Montane-Foothill-Valley Grassland',
          },
          {
            value: 3140,
            color: '010000',
            description: 'Northern Rocky Mountain Subalpine-Upper Montane Grassland',
          },
          {
            value: 3141,
            color: '010000',
            description: 'Northwestern Great Plains Mixedgrass Prairie',
          },
          {
            value: 3142,
            color: '010000',
            description: 'Columbia Basin Palouse Prairie',
          },
          {
            value: 3143,
            color: '000000',
            description: 'Rocky Mountain Alpine Fell-Field',
          },
          {
            value: 3144,
            color: '000000',
            description: 'Rocky Mountain Alpine Turf',
          },
          {
            value: 3145,
            color: '010000',
            description: 'Rocky Mountain Subalpine-Montane Mesic Meadow',
          },
          {
            value: 3146,
            color: '000000',
            description: 'Southern Rocky Mountain Montane-Subalpine Grassland',
          },
          {
            value: 3147,
            color: '010000',
            description: 'Western Great Plains Foothill and Piedmont Grassland',
          },
          {
            value: 3148,
            color: '010000',
            description: 'Western Great Plains Sand Prairie Grassland',
          },
          {
            value: 3149,
            color: '010000',
            description: 'Western Great Plains Shortgrass Prairie',
          },
          {
            value: 3150,
            color: '010000',
            description: 'Western Great Plains Tallgrass Prairie',
          },
          {
            value: 3151,
            color: '000000',
            description: 'California Central Valley Riparian Forest and Woodland',
          },
          {
            value: 3152,
            color: '000000',
            description: 'California Montane Riparian Systems',
          },
          {
            value: 3153,
            color: '000000',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 3154,
            color: '000000',
            description: 'Inter-Mountain Basins Montane Riparian Forest and Woodland',
          },
          {
            value: 3155,
            color: '000000',
            description: 'North American Warm Desert Riparian Forest and Woodland',
          },
          {
            value: 3156,
            color: '000000',
            description: 'North Pacific Lowland Riparian Forest and Shrubland',
          },
          {
            value: 3157,
            color: '000000',
            description: 'North Pacific Swamp Systems',
          },
          {
            value: 3158,
            color: '000000',
            description: 'North Pacific Montane Riparian Woodland and Shrubland',
          },
          {
            value: 3159,
            color: '000000',
            description: 'Rocky Mountain Montane Riparian Forest and Woodland',
          },
          {
            value: 3160,
            color: '000000',
            description: 'Rocky Mountain Subalpine/Upper Montane Riparian Forest and Woodland',
          },
          {
            value: 3161,
            color: '000000',
            description: 'Northern Rocky Mountain Conifer Swamp',
          },
          {
            value: 3162,
            color: '000000',
            description: 'Western Great Plains Floodplain Forest and Woodland',
          },
          {
            value: 3163,
            color: '010000',
            description: 'Pacific Coastal Marsh Systems',
          },
          {
            value: 3164,
            color: '000000',
            description: 'Rocky Mountain Wetland-Herbaceous',
          },
          {
            value: 3165,
            color: '000000',
            description: 'Northern Rocky Mountain Foothill Conifer Wooded Steppe',
          },
          {
            value: 3166,
            color: '000000',
            description: 'Middle Rocky Mountain Montane Douglas-fir Forest and Woodland',
          },
          {
            value: 3167,
            color: '000000',
            description: 'Rocky Mountain Poor-Site Lodgepole Pine Forest',
          },
          {
            value: 3168,
            color: '000000',
            description: 'Northern Rocky Mountain Avalanche Chute Shrubland',
          },
          {
            value: 3169,
            color: '000000',
            description: 'Northern Rocky Mountain Subalpine Deciduous Shrubland',
          },
          {
            value: 3170,
            color: '000000',
            description: 'Klamath-Siskiyou Xeromorphic Serpentine Savanna and Chaparral',
          },
          {
            value: 3171,
            color: '010000',
            description: 'North Pacific Alpine and Subalpine Dry Grassland',
          },
          {
            value: 3172,
            color: '000000',
            description: 'Sierran-Intermontane Desert Western White Pine-White Fir Woodland',
          },
          {
            value: 3173,
            color: '000000',
            description: 'North Pacific Wooded Volcanic Flowage',
          },
          {
            value: 3174,
            color: '000000',
            description: 'North Pacific Dry-Mesic Silver Fir-Western Hemlock-Douglas-fir Forest',
          },
          {
            value: 3177,
            color: '000000',
            description: 'California Coastal Closed-Cone Conifer Forest and Woodland',
          },
          {
            value: 3178,
            color: '000000',
            description: 'North Pacific Hypermaritime Western Red-cedar-Western Hemlock Forest',
          },
          {
            value: 3179,
            color: '000100',
            description: 'Northwestern Great Plains-Black Hills Ponderosa Pine Woodland and Savanna',
          },
          {
            value: 3180,
            color: '010000',
            description: 'Introduced Riparian Forest and Woodland',
          },
          {
            value: 3181,
            color: '010000',
            description: 'Introduced Upland Vegetation-Annual Grassland',
          },
          {
            value: 3182,
            color: '010000',
            description: 'Introduced Upland Vegetation-Perennial Grassland and Forbland',
          },
          {
            value: 3183,
            color: '010000',
            description: 'Introduced Upland Vegetation-Annual and Biennial Forbland',
          },
          {
            value: 3184,
            color: '010000',
            description: 'California Annual Grassland',
          },
          {
            value: 3185,
            color: '000000',
            description: 'Introduced Forest Wetland',
          },
          {
            value: 3186,
            color: '010000',
            description: 'Introduced Upland Vegetation-Shrub',
          },
          {
            value: 3187,
            color: '010000',
            description: 'Introduced Upland Vegetation-Treed',
          },
          {
            value: 3191,
            color: '010000',
            description: 'Recently Logged-Herb and Grass Cover',
          },
          {
            value: 3192,
            color: '010000',
            description: 'Recently Logged-Shrub Cover',
          },
          {
            value: 3193,
            color: '010000',
            description: 'Recently Logged-Tree Cover',
          },
          {
            value: 3194,
            color: '010000',
            description: 'Ruderal Upland-Treed',
          },
          {
            value: 3195,
            color: '010000',
            description: 'Recently Burned-Herb and Grass Cover',
          },
          {
            value: 3196,
            color: '000000',
            description: 'Introduced Shrub Wetland',
          },
          {
            value: 3199,
            color: '000000',
            description: 'Introduced Herbaceous Wetland',
          },
          {
            value: 3200,
            color: '000000',
            description: 'Coastal Douglas-fir Woodland',
          },
          {
            value: 3201,
            color: '000100',
            description: 'Quercus garryana Woodland Alliance',
          },
          {
            value: 3202,
            color: '000100',
            description: 'Juniperus occidentalis Wooded Herbaceous Alliance',
          },
          {
            value: 3203,
            color: '000000',
            description: 'Juniperus occidentalis Woodland Alliance',
          },
          {
            value: 3204,
            color: '000000',
            description: 'Western Great Plains Mesquite Shrubland',
          },
          {
            value: 3205,
            color: '000000',
            description: 'Tsuga mertensiana-Abies amabilis Woodland Alliance',
          },
          {
            value: 3206,
            color: '000000',
            description: 'Pseudotsuga menziesii Giant Forest Alliance',
          },
          {
            value: 3207,
            color: '010000',
            description: 'Central Mixedgrass Prairie Shrubland',
          },
          {
            value: 3208,
            color: '000000',
            description: 'Abies concolor Forest Alliance',
          },
          {
            value: 3209,
            color: '010000',
            description: 'Western Great Plains Sand Prairie Shrubland',
          },
          {
            value: 3210,
            color: '000000',
            description: 'Coleogyne ramosissima Shrubland Alliance',
          },
          {
            value: 3211,
            color: '000000',
            description: 'Grayia spinosa Shrubland Alliance',
          },
          {
            value: 3212,
            color: '000000',
            description: 'Western Great Plains Sandhill Grassland',
          },
          {
            value: 3213,
            color: '000000',
            description: 'Quercus havardii Shrubland Alliance',
          },
          {
            value: 3214,
            color: '000000',
            description: 'Arctostaphylos patula Shrubland Alliance',
          },
          {
            value: 3215,
            color: '000000',
            description: 'Quercus turbinella Shrubland Alliance',
          },
          {
            value: 3216,
            color: '000000',
            description: 'Cercocarpus montanus Shrubland Alliance',
          },
          {
            value: 3217,
            color: '000000',
            description: 'Quercus gambelii Shrubland Alliance',
          },
          {
            value: 3218,
            color: '000000',
            description: 'North American Warm Desert Sparsely Vegetated Systems II',
          },
          {
            value: 3219,
            color: '000000',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems II',
          },
          {
            value: 3220,
            color: '000000',
            description: 'Artemisia tridentata ssp. vaseyana Shrubland Alliance',
          },
          {
            value: 3221,
            color: '000000',
            description: 'Mediterranean California Sparsely Vegetated Systems II',
          },
          {
            value: 3222,
            color: '000000',
            description: 'Rocky Mountain Alpine/Montane Sparsely Vegetated Systems II',
          },
          {
            value: 3223,
            color: '000000',
            description: 'Sonoran Desert Sparsely Vegetated',
          },
          {
            value: 3227,
            color: '000000',
            description: 'Dry-mesic Montane Douglas-fir Forest',
          },
          {
            value: 3228,
            color: '000100',
            description: 'Dry-mesic Montane Western Larch Forest',
          },
          {
            value: 3229,
            color: '000100',
            description: 'Pinus albicaulis Woodland Alliance',
          },
          {
            value: 3230,
            color: '000000',
            description: 'Pinus sabiniana Woodland Alliance',
          },
          {
            value: 3231,
            color: '000000',
            description: 'Sequoiadendron giganteum Forest Alliance',
          },
          {
            value: 3232,
            color: '000100',
            description: 'Abies grandis Forest Forest',
          },
          {
            value: 3233,
            color: '000000',
            description: 'Subalpine Douglas-fir Forest',
          },
          {
            value: 3234,
            color: '000000',
            description: 'Mesic Montane Douglas-fir Forest',
          },
          {
            value: 3235,
            color: '000000',
            description: 'Xeric Montane Douglas-fir Forest',
          },
          {
            value: 3236,
            color: '000100',
            description: 'Subalpine Western Larch Forest',
          },
          {
            value: 3237,
            color: '000100',
            description: 'Mesic Montane Western Larch Forest',
          },
          {
            value: 3238,
            color: '000000',
            description: 'Laurentian-Acadian Northern Oak Forest',
          },
          {
            value: 3239,
            color: '000000',
            description: 'Laurentian-Acadian Northern Pine-Oak Forest',
          },
          {
            value: 3240,
            color: '000000',
            description: 'Laurentian-Acadian Hardwood Forest',
          },
          {
            value: 3241,
            color: '000000',
            description: 'Laurentian-Acadian Pine-Hemlock-Hardwood Forest',
          },
          {
            value: 3242,
            color: '000000',
            description: 'Laurentian Oak Barrens',
          },
          {
            value: 3243,
            color: '000000',
            description: 'Laurentian Pine-Oak Barrens',
          },
          {
            value: 3244,
            color: '000000',
            description: 'Boreal Hardwood Forest',
          },
          {
            value: 3245,
            color: '000000',
            description: 'Boreal White Spruce-Fir-Hardwood Forest',
          },
          {
            value: 3247,
            color: '000000',
            description: 'Southern Appalachian Grass Bald',
          },
          {
            value: 3248,
            color: '010000',
            description: 'Northern Atlantic Coastal Plain Dune and Swale Grassland',
          },
          {
            value: 3249,
            color: '000000',
            description: 'Atlantic Coastal Plain Peatland Pocosin and Canebrake Shrubland',
          },
          {
            value: 3250,
            color: '000000',
            description: 'Inter-Mountain Basins Curl-leaf Mountain Mahogany Shrubland',
          },
          {
            value: 3251,
            color: '000000',
            description: 'Rocky Mountain Montane Riparian Shrubland',
          },
          {
            value: 3252,
            color: '000000',
            description: 'Rocky Mountain Subalpine/Upper Montane Riparian Shrubland',
          },
          {
            value: 3253,
            color: '000000',
            description: 'Western Great Plains Floodplain Shrubland',
          },
          {
            value: 3254,
            color: '000000',
            description: 'Western Great Plains Floodplain Herbaceous',
          },
          {
            value: 3255,
            color: '000000',
            description: 'Inter-Mountain Basins Montane Riparian Shrubland',
          },
          {
            value: 3256,
            color: '010000',
            description: 'Apacherian-Chihuahuan Semi-Desert Grassland',
          },
          {
            value: 3257,
            color: '000000',
            description: 'California Central Valley Riparian Herbaceous',
          },
          {
            value: 3258,
            color: '000000',
            description: 'North American Warm Desert Riparian Herbaceous',
          },
          {
            value: 3259,
            color: '010000',
            description: 'Introduced Riparian Shrubland',
          },
          {
            value: 3260,
            color: '000000',
            description: 'Mediterranean California Lower Montane Black Oak Forest and Woodland',
          },
          {
            value: 3261,
            color: '000000',
            description: 'Mediterranean California Lower Montane Black Oak - Conifer Forest and Woodland',
          },
          {
            value: 3262,
            color: '000100',
            description: 'East Cascades Oak Forest and Woodland',
          },
          {
            value: 3263,
            color: '000100',
            description: 'East Cascades Oak - Ponderosa Pine Forest and Woodland',
          },
          {
            value: 3264,
            color: '000000',
            description: 'California Lower Montane Blue Oak Forest and Woodland',
          },
          {
            value: 3265,
            color: '000000',
            description: 'California Lower Montane Blue Oak-Foothill Pine Forest and Woodland',
          },
          {
            value: 3266,
            color: '000000',
            description: 'Oregon White Oak Woodland',
          },
          {
            value: 3267,
            color: '000000',
            description: 'Douglas-fir - Oregon White Oak Woodland',
          },
          {
            value: 3268,
            color: '000100',
            description: 'Eastern Great Plains Tallgrass Aspen Shrubland',
          },
          {
            value: 3269,
            color: '000000',
            description: 'Laurentian Shrubland Barrens',
          },
          {
            value: 3270,
            color: '010000',
            description: 'North-Central Interior Sand and Gravel Shrubland',
          },
          {
            value: 3271,
            color: '000000',
            description: 'Eastern Boreal Floodplain Herbaceous',
          },
          {
            value: 3272,
            color: '000000',
            description: 'Eastern Boreal Floodplain Shrubland',
          },
          {
            value: 3273,
            color: '000000',
            description: 'Eastern Great Plains Floodplain Herbaceous',
          },
          {
            value: 3274,
            color: '000000',
            description: 'Central Interior and Appalachian Floodplain Herbaceous',
          },
          {
            value: 3275,
            color: '000000',
            description: 'Central Interior and Appalachian Floodplain Shrubland',
          },
          {
            value: 3276,
            color: '000000',
            description: 'Laurentian-Acadian Floodplain Herbaceous',
          },
          {
            value: 3277,
            color: '000000',
            description: 'Laurentian-Acadian Floodplain Shrubland',
          },
          {
            value: 3278,
            color: '000000',
            description: 'Boreal Acidic Peatland Herbaceous',
          },
          {
            value: 3279,
            color: '000000',
            description: 'Boreal Acidic Peatland Shrubland',
          },
          {
            value: 3280,
            color: '000000',
            description: 'Central Interior and Appalachian Swamp Shrubland',
          },
          {
            value: 3281,
            color: '000000',
            description: 'Laurentian-Acadian Alkaline Conifer-Hardwood Swamp Shrubland',
          },
          {
            value: 3282,
            color: '010000',
            description: 'Great Lakes Coastal Marsh Shrubland',
          },
          {
            value: 3283,
            color: '000000',
            description: 'Central Interior and Appalachian Shrub Wetlands',
          },
          {
            value: 3284,
            color: '010000',
            description: 'Laurentian-Acadian Herbaceous Wetlands',
          },
          {
            value: 3285,
            color: '010000',
            description: 'Laurentian-Acadian Shrub Wetlands',
          },
          {
            value: 3286,
            color: '000000',
            description: 'Paleozoic Plateau Bluff and Talus Herbaceous',
          },
          {
            value: 3287,
            color: '010000',
            description: 'Modified/Managed Northern Tallgrass Shrubland',
          },
          {
            value: 3288,
            color: '000000',
            description: 'Central Appalachian Rocky Shrubland',
          },
          {
            value: 3289,
            color: '000000',
            description: 'Acadian-Appalachian Subalpine Heath-Krummholz',
          },
          {
            value: 3290,
            color: '000000',
            description: 'North-Central Oak Barrens Herbaceous',
          },
          {
            value: 3291,
            color: '010000',
            description: 'Central Interior Highlands Calcareous Glade and Barrens Herbaceous',
          },
          {
            value: 3292,
            color: '000001',
            description: 'Open Water',
          },
          {
            value: 3293,
            color: '000000',
            description: 'Snow-Ice',
          },
          {
            value: 3294,
            color: '000000',
            description: 'Barren',
          },
          {
            value: 3295,
            color: '000000',
            description: 'Quarries-Strip Mines-Gravel Pits',
          },
          {
            value: 3296,
            color: '010000',
            description: 'Developed-Low Intensity',
          },
          {
            value: 3297,
            color: '000000',
            description: 'Developed-Medium Intensity',
          },
          {
            value: 3298,
            color: '000000',
            description: 'Developed-High Intensity',
          },
          {
            value: 3299,
            color: '010101',
            description: 'Developed-Roads',
          },
          {
            value: 3300,
            color: '000000',
            description: 'Central Interior and Appalachian Riparian Herbaceous',
          },
          {
            value: 3301,
            color: '000100',
            description: 'Boreal Aspen-Birch Forest',
          },
          {
            value: 3302,
            color: '000100',
            description: 'Laurentian-Acadian Northern Hardwoods Forest',
          },
          {
            value: 3303,
            color: '000000',
            description: 'Northeastern Interior Dry-Mesic Oak Forest',
          },
          {
            value: 3304,
            color: '000000',
            description: 'Ozark-Ouachita Dry-Mesic Oak Forest',
          },
          {
            value: 3305,
            color: '000000',
            description: 'Southern Interior Low Plateau Dry-Mesic Oak Forest',
          },
          {
            value: 3306,
            color: '000000',
            description: 'East Gulf Coastal Plain Northern Loess Plain Oak-Hickory Upland',
          },
          {
            value: 3307,
            color: '000000',
            description: 'East Gulf Coastal Plain Northern Dry Upland Hardwood Forest',
          },
          {
            value: 3308,
            color: '000000',
            description: 'Crosstimbers Oak Forest and Woodland',
          },
          {
            value: 3309,
            color: '000000',
            description: 'Southern Appalachian Northern Hardwood Forest',
          },
          {
            value: 3310,
            color: '000000',
            description: 'North-Central Interior Dry-Mesic Oak Forest and Woodland',
          },
          {
            value: 3311,
            color: '000000',
            description: 'North-Central Interior Dry Oak Forest and Woodland',
          },
          {
            value: 3312,
            color: '000000',
            description: 'Ouachita Montane Oak Forest',
          },
          {
            value: 3313,
            color: '000000',
            description: 'North-Central Interior Beech-Maple Forest',
          },
          {
            value: 3314,
            color: '000100',
            description: 'North-Central Interior Maple-Basswood Forest',
          },
          {
            value: 3315,
            color: '000000',
            description: 'Southern Appalachian Oak Forest',
          },
          {
            value: 3316,
            color: '000000',
            description: 'Southern Piedmont Mesic Forest',
          },
          {
            value: 3317,
            color: '000000',
            description: 'Allegheny-Cumberland Dry Oak Forest and Woodland',
          },
          {
            value: 3318,
            color: '000000',
            description: 'Southern and Central Appalachian Cove Forest',
          },
          {
            value: 3319,
            color: '000000',
            description: 'Central Interior and Appalachian Riparian Shrubland',
          },
          {
            value: 3320,
            color: '000000',
            description: 'Central and Southern Appalachian Montane Oak Forest',
          },
          {
            value: 3321,
            color: '000000',
            description: 'South-Central Interior Mesophytic Forest',
          },
          {
            value: 3322,
            color: '000000',
            description: "Crowley's Ridge Mesic Loess Slope Forest",
          },
          {
            value: 3323,
            color: '000100',
            description: 'West Gulf Coastal Plain Mesic Hardwood Forest',
          },
          {
            value: 3324,
            color: '000000',
            description: 'Northern Atlantic Coastal Plain Hardwood Forest',
          },
          {
            value: 3325,
            color: '000100',
            description: 'East Gulf Coastal Plain Northern Mesic Hardwood Slope Forest',
          },
          {
            value: 3326,
            color: '000000',
            description: 'South-Central Interior/Upper Coastal Plain Flatwoods',
          },
          {
            value: 3327,
            color: '000000',
            description: 'East Gulf Coastal Plain Northern Loess Bluff Forest',
          },
          {
            value: 3328,
            color: '000000',
            description: 'Southern Coastal Plain Limestone Forest',
          },
          {
            value: 3329,
            color: '000000',
            description: 'East Gulf Coastal Plain Southern Loess Bluff Forest',
          },
          {
            value: 3330,
            color: '000100',
            description: 'Southern Coastal Plain Dry Upland Hardwood Forest',
          },
          {
            value: 3331,
            color: '000100',
            description: 'Eastern Great Plains Tallgrass Aspen Forest and Woodland',
          },
          {
            value: 3332,
            color: '000100',
            description: 'Gulf and Atlantic Coastal Plain Floodplain Herbaceous',
          },
          {
            value: 3333,
            color: '000000',
            description: 'South Florida Hardwood Hammock',
          },
          {
            value: 3334,
            color: '000000',
            description: 'Ozark-Ouachita Mesic Hardwood Forest',
          },
          {
            value: 3335,
            color: '000100',
            description: 'Southern Atlantic Coastal Plain Dry and Dry-Mesic Oak Forest',
          },
          {
            value: 3336,
            color: '000000',
            description: 'Southwest Florida Coastal Strand and Maritime Hammock',
          },
          {
            value: 3337,
            color: '000000',
            description: 'Southeast Florida Coastal Strand and Maritime Hammock',
          },
          {
            value: 3338,
            color: '000100',
            description: 'Central and South Texas Coastal Fringe Forest and Woodland',
          },
          {
            value: 3339,
            color: '000100',
            description: 'West Gulf Coastal Plain Chenier and Upper Texas Coastal Fringe Forest and Woodland',
          },
          {
            value: 3340,
            color: '000000',
            description: 'Appalachian Shale Barrens',
          },
          {
            value: 3342,
            color: '000000',
            description: 'Piedmont Hardpan Woodland and Forest',
          },
          {
            value: 3343,
            color: '000100',
            description: 'Southern Atlantic Coastal Plain Mesic Hardwood Forest',
          },
          {
            value: 3344,
            color: '000000',
            description: 'Boreal Jack Pine-Black Spruce Forest',
          },
          {
            value: 3346,
            color: '000000',
            description: 'Atlantic Coastal Plain Fall-line Sandhills Longleaf Pine Woodland',
          },
          {
            value: 3347,
            color: '000000',
            description: 'Atlantic Coastal Plain Upland Longleaf Pine Woodland',
          },
          {
            value: 3348,
            color: '000000',
            description: 'West Gulf Coastal Plain Upland Longleaf Pine Forest and Woodland',
          },
          {
            value: 3349,
            color: '000000',
            description: 'East Gulf Coastal Plain Interior Upland Longleaf Pine Woodland',
          },
          {
            value: 3350,
            color: '000100',
            description: 'Central and Southern Appalachian Spruce-Fir Forest',
          },
          {
            value: 3351,
            color: '000000',
            description: 'Southeastern Interior Longleaf Pine Woodland',
          },
          {
            value: 3352,
            color: '000000',
            description: 'Southern Appalachian Montane Pine Forest and Woodland',
          },
          {
            value: 3353,
            color: '000000',
            description: 'Southern Appalachian Low-Elevation Pine Forest',
          },
          {
            value: 3354,
            color: '000000',
            description: 'Northeastern Interior Pine Barrens',
          },
          {
            value: 3355,
            color: '000000',
            description: 'Northern Atlantic Coastal Plain Pitch Pine Barrens',
          },
          {
            value: 3356,
            color: '000000',
            description: 'Florida Longleaf Pine Sandhill',
          },
          {
            value: 3357,
            color: '000100',
            description: 'Southern Coastal Plain Mesic Slope Forest',
          },
          {
            value: 3358,
            color: '000000',
            description: 'East-Central Texas Plains Pine Forest and Woodland',
          },
          {
            value: 3359,
            color: '000100',
            description: 'Gulf and Atlantic Coastal Plain Floodplain Shrubland',
          },
          {
            value: 3361,
            color: '000000',
            description: 'Central Atlantic Coastal Plain Maritime Forest',
          },
          {
            value: 3362,
            color: '000000',
            description: 'Laurentian-Acadian Northern Pine Forest',
          },
          {
            value: 3363,
            color: '010000',
            description: 'Central Interior Highlands Dry Acidic Glade and Barrens',
          },
          {
            value: 3364,
            color: '000000',
            description: 'Ozark-Ouachita Dry Oak Woodland',
          },
          {
            value: 3365,
            color: '000000',
            description: 'Boreal White Spruce-Fir Forest',
          },
          {
            value: 3366,
            color: '000000',
            description: 'Laurentian-Acadian Pine-Hemlock Forest',
          },
          {
            value: 3367,
            color: '000000',
            description: 'Ozark-Ouachita Shortleaf Pine Forest and Woodland',
          },
          {
            value: 3368,
            color: '000100',
            description: 'Southern Piedmont Dry Pine Forest',
          },
          {
            value: 3369,
            color: '000000',
            description: 'Central Appalachian Dry Pine Forest',
          },
          {
            value: 3370,
            color: '000000',
            description: 'Appalachian Hemlock Forest',
          },
          {
            value: 3371,
            color: '000100',
            description: 'West Gulf Coastal Plain Pine Forest',
          },
          {
            value: 3372,
            color: '000000',
            description: 'East Gulf Coastal Plain Interior Shortleaf Pine Forest',
          },
          {
            value: 3373,
            color: '000000',
            description: 'Acadian Low-Elevation Spruce-Fir Forest',
          },
          {
            value: 3374,
            color: '000000',
            description: 'Acadian-Appalachian Montane Spruce-Fir Forest',
          },
          {
            value: 3375,
            color: '000000',
            description: 'Eastern Serpentine Woodland',
          },
          {
            value: 3376,
            color: '000000',
            description: 'Southern Ridge and Valley/Cumberland Dry Calcareous Forest',
          },
          {
            value: 3377,
            color: '000000',
            description: 'Central Appalachian Rocky Pine Woodland',
          },
          {
            value: 3378,
            color: '000000',
            description: 'West Gulf Coastal Plain Sandhill Shortleaf Pine Forest and Woodland',
          },
          {
            value: 3379,
            color: '000100',
            description: 'Northern Atlantic Coastal Plain Maritime Forest',
          },
          {
            value: 3380,
            color: '000000',
            description: 'East Gulf Coastal Plain Maritime Forest',
          },
          {
            value: 3381,
            color: '000000',
            description: 'Lower Mississippi River Dune Woodland and Forest',
          },
          {
            value: 3382,
            color: '000000',
            description: 'Southern Atlantic Coastal Plain Maritime Forest',
          },
          {
            value: 3383,
            color: '000000',
            description: 'Edwards Plateau Limestone Woodland',
          },
          {
            value: 3384,
            color: '000100',
            description: 'Mississippi Delta Maritime Forest',
          },
          {
            value: 3385,
            color: '000000',
            description: 'Western Great Plains Wooded Draw and Ravine',
          },
          {
            value: 3386,
            color: '000000',
            description: 'Acadian-Appalachian Alpine Tundra',
          },
          {
            value: 3387,
            color: '000100',
            description: 'Florida Peninsula Inland Scrub Shrubland',
          },
          {
            value: 3389,
            color: '000000',
            description: 'Acadian-Appalachian Subalpine Woodland',
          },
          {
            value: 3390,
            color: '000000',
            description: 'Tamaulipan Mixed Deciduous Thornscrub',
          },
          {
            value: 3391,
            color: '000000',
            description: 'Tamaulipan Mesquite Upland Tree',
          },
          {
            value: 3392,
            color: '000000',
            description: 'Tamaulipan Calcareous Thornscrub',
          },
          {
            value: 3393,
            color: '000000',
            description: 'Edwards Plateau Limestone Shrubland',
          },
          {
            value: 3394,
            color: '000000',
            description: 'North-Central Interior Oak Savanna',
          },
          {
            value: 3395,
            color: '000000',
            description: 'North-Central Oak Barrens Woodland',
          },
          {
            value: 3396,
            color: '010000',
            description: 'Gulf and Atlantic Coastal Plain Tidal Marsh Herbaceous',
          },
          {
            value: 3397,
            color: '000000',
            description: 'Nashville Basin Limestone Glade and Woodland',
          },
          {
            value: 3398,
            color: '000000',
            description: 'Cumberland Sandstone Glade and Barrens',
          },
          {
            value: 3399,
            color: '000000',
            description: 'Northern Atlantic Coastal Plain Grassland',
          },
          {
            value: 3400,
            color: '000000',
            description: 'Central Appalachian Alkaline Glade and Woodland',
          },
          {
            value: 3401,
            color: '010000',
            description: 'Central Interior Highlands Calcareous Glade and Barrens Woodland',
          },
          {
            value: 3402,
            color: '000000',
            description: 'Laurentian-Acadian Swamp Shrubland',
          },
          {
            value: 3403,
            color: '000000',
            description: 'West Gulf Coastal Plain Catahoula Barrens',
          },
          {
            value: 3405,
            color: '010000',
            description: 'West Gulf Coastal Plain Nepheline Syenite Glade',
          },
          {
            value: 3406,
            color: '000100',
            description: 'Southern Piedmont Dry Oak Forest',
          },
          {
            value: 3407,
            color: '000000',
            description: 'Laurentian Pine Barrens',
          },
          {
            value: 3408,
            color: '000000',
            description: 'Alabama Ketona Glade and Woodland',
          },
          {
            value: 3409,
            color: '000000',
            description: 'Great Lakes Alvar Shrubland',
          },
          {
            value: 3410,
            color: '000000',
            description: 'Llano Uplift Acidic Forest and Woodland',
          },
          {
            value: 3411,
            color: '010000',
            description: 'Great Lakes Wet-Mesic Lakeplain Prairie',
          },
          {
            value: 3412,
            color: '010000',
            description: 'North-Central Interior Sand and Gravel Tallgrass Prairie',
          },
          {
            value: 3413,
            color: '000000',
            description: 'Bluegrass Savanna and Woodland',
          },
          {
            value: 3414,
            color: '000000',
            description: 'Southern Appalachian Shrub Bald',
          },
          {
            value: 3415,
            color: '010000',
            description: 'Arkansas Valley Prairie and Woodland',
          },
          {
            value: 3416,
            color: '000000',
            description: 'Western Highland Rim Prairie and Barrens',
          },
          {
            value: 3417,
            color: '000000',
            description: 'Eastern Highland Rim Prairie and Barrens',
          },
          {
            value: 3418,
            color: '000000',
            description: 'Pennyroyal Karst Plain Prairie and Barrens',
          },
          {
            value: 3419,
            color: '000000',
            description: 'Southern Ridge and Valley Patch Prairie',
          },
          {
            value: 3420,
            color: '010000',
            description: 'Northern Tallgrass Prairie',
          },
          {
            value: 3421,
            color: '010000',
            description: 'Central Tallgrass Prairie',
          },
          {
            value: 3422,
            color: '010000',
            description: 'Texas Blackland Tallgrass Prairie',
          },
          {
            value: 3423,
            color: '010000',
            description: 'Southeastern Great Plains Tallgrass Prairie',
          },
          {
            value: 3425,
            color: '000000',
            description: 'Florida Dry Prairie Grassland',
          },
          {
            value: 3426,
            color: '010000',
            description: 'Southern Atlantic Coastal Plain Dune and Maritime Grassland',
          },
          {
            value: 3428,
            color: '010000',
            description: 'West Gulf Coastal Plain Northern Calcareous Prairie',
          },
          {
            value: 3429,
            color: '010000',
            description: 'West Gulf Coastal Plain Southern Calcareous Prairie',
          },
          {
            value: 3430,
            color: '000000',
            description: 'Southern Coastal Plain Blackland Prairie',
          },
          {
            value: 3433,
            color: '010000',
            description: 'East Gulf Coastal Plain Jackson Prairie',
          },
          {
            value: 3434,
            color: '010000',
            description: 'Texas-Louisiana Coastal Prairie',
          },
          {
            value: 3435,
            color: '010000',
            description: 'East Gulf Coastal Plain Dune and Coastal Grassland',
          },
          {
            value: 3436,
            color: '010000',
            description: 'Northern Atlantic Coastal Plain Dune and Swale Shrubland',
          },
          {
            value: 3437,
            color: '010000',
            description: 'Central and Upper Texas Coast Dune and Coastal Grassland',
          },
          {
            value: 3438,
            color: '000000',
            description: 'Tamaulipan Savanna Grassland',
          },
          {
            value: 3439,
            color: '010000',
            description: 'South Texas Lomas',
          },
          {
            value: 3440,
            color: '010000',
            description: 'Tamaulipan Clay Grassland',
          },
          {
            value: 3442,
            color: '010000',
            description: 'South Texas Sand Sheet Grassland',
          },
          {
            value: 3443,
            color: '010000',
            description: 'South Texas Dune and Coastal Grassland',
          },
          {
            value: 3444,
            color: '000000',
            description: 'Eastern Boreal Floodplain Woodland',
          },
          {
            value: 3446,
            color: '000000',
            description: 'South Florida Pine Flatwoods',
          },
          {
            value: 3447,
            color: '000000',
            description: 'South Florida Cypress Dome',
          },
          {
            value: 3448,
            color: '000100',
            description: 'Southern Piedmont Dry Oak-Pine Forest',
          },
          {
            value: 3449,
            color: '000000',
            description: 'Central Atlantic Coastal Plain Wet Longleaf Pine Savanna and Flatwoods',
          },
          {
            value: 3450,
            color: '000000',
            description: 'Southern Atlantic Coastal Plain Wet Pine Savanna and Flatwoods',
          },
          {
            value: 3451,
            color: '000000',
            description: 'West Gulf Coastal Plain Wet Longleaf Pine Savanna and Flatwoods',
          },
          {
            value: 3452,
            color: '000000',
            description: 'Atlantic Coastal Plain Peatland Pocosin and Canebrake Woodland',
          },
          {
            value: 3453,
            color: '000000',
            description: 'Central Florida Pine Flatwoods',
          },
          {
            value: 3454,
            color: '000000',
            description: 'East Gulf Coastal Plain Near-Coast Pine Flatwoods',
          },
          {
            value: 3455,
            color: '000000',
            description: 'East Gulf Coastal Plain Southern Loblolly Flatwoods',
          },
          {
            value: 3456,
            color: '000000',
            description: 'Northern Atlantic Coastal Plain Pitch Pine Lowland',
          },
          {
            value: 3457,
            color: '000100',
            description: 'South-Central Interior/Upper Coastal Plain Wet Flatwoods',
          },
          {
            value: 3458,
            color: '000100',
            description: 'West Gulf Coastal Plain Pine Flatwoods',
          },
          {
            value: 3459,
            color: '000000',
            description: 'Atlantic Coastal Plain Clay-Based Carolina Bay Wetland',
          },
          {
            value: 3460,
            color: '000000',
            description: 'Southern Coastal Plain Nonriverine Cypress Dome Woodland',
          },
          {
            value: 3461,
            color: '000000',
            description: 'Southern Coastal Plain Seepage Swamp and Baygall Woodland',
          },
          {
            value: 3462,
            color: '000000',
            description: 'West Gulf Coastal Plain Seepage Swamp and Baygall',
          },
          {
            value: 3463,
            color: '000000',
            description: 'Central Appalachian Dry Oak Forest',
          },
          {
            value: 3464,
            color: '000000',
            description: 'Acadian Near-Boreal Spruce Barrens',
          },
          {
            value: 3466,
            color: '000000',
            description: 'Great Lakes Wooded Dune and Swale',
          },
          {
            value: 3467,
            color: '000000',
            description: 'Tamaulipan Floodplain Forest',
          },
          {
            value: 3468,
            color: '000000',
            description: 'Atlantic Coastal Plain Streamhead Seepage Swamp-Pocosin-Baygall',
          },
          {
            value: 3469,
            color: '000000',
            description: 'Eastern Great Plains Floodplain Woodland',
          },
          {
            value: 3470,
            color: '000000',
            description: 'Caribbean Coastal Wetland Systems',
          },
          {
            value: 3471,
            color: '000000',
            description: 'Central Interior and Appalachian Floodplain Forest',
          },
          {
            value: 3472,
            color: '000000',
            description: 'Central Interior and Appalachian Riparian Forest',
          },
          {
            value: 3473,
            color: '000100',
            description: 'Gulf and Atlantic Coastal Plain Floodplain Forest',
          },
          {
            value: 3474,
            color: '000100',
            description: 'Gulf and Atlantic Coastal Plain Small Stream Riparian Woodland',
          },
          {
            value: 3475,
            color: '000000',
            description: 'Laurentian-Acadian Floodplain Forest',
          },
          {
            value: 3476,
            color: '000000',
            description: 'Tamaulipan Riparian Woodland',
          },
          {
            value: 3477,
            color: '000000',
            description: 'Boreal Acidic Peatland Forest',
          },
          {
            value: 3478,
            color: '000000',
            description: 'Caribbean Forested Swamp',
          },
          {
            value: 3479,
            color: '000000',
            description: 'Central Interior and Appalachian Swamp Forest',
          },
          {
            value: 3480,
            color: '000000',
            description: 'Gulf and Atlantic Coastal Plain Swamp Systems',
          },
          {
            value: 3481,
            color: '000000',
            description: 'Laurentian-Acadian Alkaline Conifer-Hardwood Swamp Forest',
          },
          {
            value: 3482,
            color: '000000',
            description: 'Great Plains Prairie Pothole',
          },
          {
            value: 3483,
            color: '010000',
            description: 'South Florida Everglades Sawgrass Marsh',
          },
          {
            value: 3485,
            color: '010000',
            description: 'East Gulf Coastal Plain Savanna and Wet Prairie',
          },
          {
            value: 3486,
            color: '010000',
            description: 'Texas Saline Coastal Prairie',
          },
          {
            value: 3488,
            color: '000000',
            description: 'Eastern Great Plains Wet Meadow-Prairie-Marsh',
          },
          {
            value: 3489,
            color: '010000',
            description: 'Floridian Highlands Freshwater Marsh Herbaceous',
          },
          {
            value: 3490,
            color: '010000',
            description: 'Gulf and Atlantic Coastal Plain Tidal Marsh Shrubland',
          },
          {
            value: 3491,
            color: '010000',
            description: 'Acadian Salt Marsh and Estuary Systems',
          },
          {
            value: 3492,
            color: '010000',
            description: 'Great Lakes Coastal Marsh Herbaceous',
          },
          {
            value: 3493,
            color: '000000',
            description: 'Central Interior and Appalachian Herbaceous Wetlands',
          },
          {
            value: 3494,
            color: '010000',
            description: 'Laurentian-Acadian Forested Wetlands',
          },
          {
            value: 3495,
            color: '010000',
            description: 'Western Great Plains Depressional Wetland Systems',
          },
          {
            value: 3497,
            color: '000000',
            description: 'Central Interior and Appalachian Sparsely Vegetated Systems',
          },
          {
            value: 3498,
            color: '000000',
            description: 'Gulf and Atlantic Coastal Plain Sparsely Vegetated Systems',
          },
          {
            value: 3499,
            color: '000000',
            description: 'Laurentian-Acadian Sparsely Vegetated Systems',
          },
          {
            value: 3501,
            color: '000000',
            description: 'Southern Atlantic Coastal Plain Nonriverine Swamp and Wet Hardwood Forest',
          },
          {
            value: 3502,
            color: '000000',
            description: 'Central Appalachian Dry Oak-Pine Forest',
          },
          {
            value: 3503,
            color: '010000',
            description: 'Chihuahuan Loamy Plains Desert Grassland',
          },
          {
            value: 3504,
            color: '010000',
            description: 'Chihuahuan-Sonoran Desert Bottomland and Swale Grassland',
          },
          {
            value: 3506,
            color: '000100',
            description: 'West Gulf Coastal Plain Nonriverine Wet Hardwood Flatwoods',
          },
          {
            value: 3507,
            color: '000000',
            description: 'Ozark-Ouachita Shortleaf Pine-Bluestem Woodland',
          },
          {
            value: 3509,
            color: '000000',
            description: 'Mississippi River Alluvial Plain Dry-Mesic Loess Slope Forest',
          },
          {
            value: 3510,
            color: '000000',
            description: "Crowley's Ridge Sand Forest",
          },
          {
            value: 3511,
            color: '000000',
            description: 'Appalachian Northern Hardwood Forest',
          },
          {
            value: 3512,
            color: '000000',
            description: 'Appalachian Hemlock-Northern Hardwood Forest',
          },
          {
            value: 3513,
            color: '000100',
            description: 'Lower Mississippi River Flatwoods',
          },
          {
            value: 3517,
            color: '000000',
            description: 'Paleozoic Plateau Bluff and Talus Woodland',
          },
          {
            value: 3518,
            color: '000100',
            description: 'North-Central Interior Wet Flatwoods',
          },
          {
            value: 3519,
            color: '000000',
            description: 'East-Central Texas Plains Post Oak Savanna and Woodland',
          },
          {
            value: 3522,
            color: '000000',
            description: 'Northern Atlantic Coastal Plain Heathland',
          },
          {
            value: 3523,
            color: '000000',
            description: 'Edwards Plateau Dry-Mesic Slope Forest and Woodland',
          },
          {
            value: 3524,
            color: '000000',
            description: 'Edwards Plateau Mesic Canyon',
          },
          {
            value: 3525,
            color: '000000',
            description: 'Edwards Plateau Riparian Woodland',
          },
          {
            value: 3526,
            color: '000000',
            description: 'Laurentian-Acadian Swamp Woodland',
          },
          {
            value: 3527,
            color: '000000',
            description: 'East Gulf Coastal Plain Interior Oak Forest',
          },
          {
            value: 3528,
            color: '010000',
            description: 'Ruderal Upland Shrubland',
          },
          {
            value: 3529,
            color: '010000',
            description: 'Ruderal Upland Herbaceous',
          },
          {
            value: 3531,
            color: '010000',
            description: 'Ruderal Upland Forest',
          },
          {
            value: 3532,
            color: '010000',
            description: 'Ruderal Forest-Northern and Central Hardwood and Conifer',
          },
          {
            value: 3533,
            color: '010000',
            description: 'Ruderal Forest-Southeast Hardwood and Conifer',
          },
          {
            value: 3534,
            color: '000000',
            description: 'Managed Tree Plantation-Northern and Central Hardwood and Conifer Plantation Group',
          },
          {
            value: 3535,
            color: '000000',
            description: 'Managed Tree Plantation-Southeast Conifer and Hardwood Plantation Group',
          },
          {
            value: 3536,
            color: '000000',
            description: 'Introduced Wetland Vegetation-Tree',
          },
          {
            value: 3538,
            color: '000000',
            description: 'Introduced Wetland Vegetation-Herbaceous',
          },
          {
            value: 3539,
            color: '010000',
            description: 'Modified/Managed Northern Tallgrass Grassland',
          },
          {
            value: 3540,
            color: '010000',
            description: 'Modified/Managed Southern Tallgrass Grassland',
          },
          {
            value: 3546,
            color: '000000',
            description: 'East Gulf Coastal Plain Interior Shortleaf Pine-Oak Forest',
          },
          {
            value: 3550,
            color: '000100',
            description: 'Pinus taeda Forest Alliance',
          },
          {
            value: 3551,
            color: '000000',
            description: 'Pinus elliottii Saturated Temperate Woodland Alliance',
          },
          {
            value: 3552,
            color: '000000',
            description: 'Pinus palustris-Pinus elliottii Forest Alliance',
          },
          {
            value: 3553,
            color: '000000',
            description: 'Mixed Loblolly-Slash Pine',
          },
          {
            value: 3554,
            color: '000000',
            description: 'Acadian Low-Elevation Hardwood Forest',
          },
          {
            value: 3555,
            color: '000000',
            description: 'Acadian Low-Elevation Spruce-Fir-Hardwood Forest',
          },
          {
            value: 3556,
            color: '000000',
            description: 'Central Appalachian Rocky Oak Woodland',
          },
          {
            value: 3557,
            color: '000000',
            description: 'Central Appalachian Rocky Pine-Oak Woodland',
          },
          {
            value: 3558,
            color: '000000',
            description: 'Edwards Plateau Limestone Grassland',
          },
          {
            value: 3559,
            color: '000000',
            description: 'Edwards Plateau Limestone Shrubland',
          },
          {
            value: 3560,
            color: '000000',
            description: 'Tamaulipan Mesquite Upland Shrub',
          },
          {
            value: 3561,
            color: '000000',
            description: 'Llano Uplift Acidic Herbaceous Glade',
          },
          {
            value: 3562,
            color: '000000',
            description: 'Tamaulipan Riparian Shrubland',
          },
          {
            value: 3563,
            color: '000000',
            description: 'Edwards Plateau Riparian Shrubland',
          },
          {
            value: 3564,
            color: '010000',
            description: 'Modified/Managed Southern Tallgrass Shrubland',
          },
          {
            value: 3565,
            color: '000100',
            description: 'Florida Peninsula Inland Scrub Woodland',
          },
          {
            value: 3566,
            color: '000000',
            description: 'Florida Dry Prairie Shruband',
          },
          {
            value: 3567,
            color: '000000',
            description: 'Southern Coastal Plain Blackland Prairie Woodland',
          },
          {
            value: 3568,
            color: '010000',
            description: 'East Gulf Coastal Plain Jackson Prairie Woodland',
          },
          {
            value: 3569,
            color: '000000',
            description: 'Central Atlantic Coastal Plain Wet Longleaf Pine Savanna and Shrubland',
          },
          {
            value: 3570,
            color: '000000',
            description: 'Southern Coastal Plain Nonriverine Cypress Dome Herbaceous',
          },
          {
            value: 3571,
            color: '000000',
            description: 'Southern Coastal Plain Seepage Swamp and Baygall Shrubland',
          },
          {
            value: 3572,
            color: '000000',
            description: 'South Florida Cypress Dome Herbaceous',
          },
          {
            value: 3573,
            color: '000100',
            description: 'Gulf and Atlantic Coastal Plain Small Stream Riparian Herbaceous',
          },
          {
            value: 3574,
            color: '000100',
            description: 'Gulf and Atlantic Coastal Plain Small Stream Riparian Shrubland',
          },
          {
            value: 3575,
            color: '000000',
            description: 'Caribbean Herbaceous Swamp',
          },
          {
            value: 3576,
            color: '010000',
            description: 'South Florida Everglades Forest',
          },
          {
            value: 3577,
            color: '010000',
            description: 'East Gulf Coastal Plain Wet Prairie Grassland',
          },
          {
            value: 3578,
            color: '010000',
            description: 'East Gulf Coastal Plain Wet Prairie Shrubland',
          },
          {
            value: 3579,
            color: '010000',
            description: 'Floridian Highlands Freshwater Marsh Shrubland',
          },
          {
            value: 3580,
            color: '010000',
            description: 'Floridian Highlands Freshwater Marsh Woodland',
          },
          {
            value: 3581,
            color: '010000',
            description: 'South Florida Everglades Shrubland',
          },
          {
            value: 3582,
            color: '000000',
            description: 'Ozark-Ouachita Oak Forest and Woodland',
          },
          {
            value: 3583,
            color: '000000',
            description: 'Ozark-Ouachita Shortleaf Pine-Oak Forest and Woodland',
          },
          {
            value: 3584,
            color: '000100',
            description: 'West Gulf Coastal Plain Hardwood Forest',
          },
          {
            value: 3585,
            color: '000100',
            description: 'West Gulf Coastal Plain Pine-Hardwood Forest',
          },
          {
            value: 3586,
            color: '000000',
            description: 'West Gulf Coastal Plain Sandhill Oak Forest and Woodland',
          },
          {
            value: 3587,
            color: '000000',
            description: 'West Gulf Coastal Plain Sandhill Oak and Shortleaf Pine Forest and Woodland',
          },
          {
            value: 3588,
            color: '000000',
            description: 'East Gulf Coastal Plain Southern Hardwood Flatwoods',
          },
          {
            value: 3589,
            color: '000000',
            description: 'East Gulf Coastal Plain Southern Loblolly-Hardwood Flatwoods',
          },
          {
            value: 3590,
            color: '000100',
            description: 'West Gulf Coastal Plain Hardwood Flatwoods',
          },
          {
            value: 3591,
            color: '000100',
            description: 'West Gulf Coastal Plain Pine-Hardwood Flatwoods',
          },
          {
            value: 3600,
            color: '000000',
            description: 'Western North American Boreal White Spruce Forest',
          },
          {
            value: 3601,
            color: '000000',
            description: 'Western North American Boreal Treeline White Spruce Woodland',
          },
          {
            value: 3602,
            color: '000000',
            description: 'Western North American Boreal Spruce-Lichen Woodland',
          },
          {
            value: 3603,
            color: '000000',
            description: 'Alaska Boreal White Spruce Forest',
          },
          {
            value: 3604,
            color: '000000',
            description: 'Western North American Boreal Mesic Black Spruce Forest',
          },
          {
            value: 3605,
            color: '000000',
            description: 'Western North American Boreal Mesic Birch-Aspen Forest',
          },
          {
            value: 3606,
            color: '000100',
            description: 'Western North American Boreal Dry Aspen-Steppe Bluff',
          },
          {
            value: 3607,
            color: '000000',
            description: 'Western North American Boreal Subalpine Balsam Poplar-Aspen Woodland',
          },
          {
            value: 3608,
            color: '000000',
            description: 'Alaska Sub-boreal Avalanche Slope Shrubland',
          },
          {
            value: 3609,
            color: '000000',
            description: 'Alaska Sub-boreal Mesic Subalpine Alder Shrubland',
          },
          {
            value: 3610,
            color: '000000',
            description: 'Western North American Boreal Mesic Scrub Birch-Willow Shrubland',
          },
          {
            value: 3611,
            color: '010000',
            description: 'Western North American Sub-boreal Mesic Bluejoint Meadow',
          },
          {
            value: 3612,
            color: '010000',
            description: 'Western North American Boreal Dry Grassland',
          },
          {
            value: 3631,
            color: '000000',
            description: 'Western North American Boreal Alpine Dwarf-Shrub Summit',
          },
          {
            value: 3633,
            color: '010000',
            description: 'Western North American Boreal Alpine Mesic Herbaceous Meadow',
          },
          {
            value: 3634,
            color: '010000',
            description: 'Western North American Boreal Alpine Dryas Dwarf-Shrubland',
          },
          {
            value: 3635,
            color: '000000',
            description: 'Western North American Boreal Alpine Ericaceous Dwarf-Shrubland',
          },
          {
            value: 3636,
            color: '000000',
            description: 'Western North American Boreal Alpine Dwarf-Shrub-Lichen Shrubland',
          },
          {
            value: 3638,
            color: '000000',
            description: 'Alaska Arctic Mesic Alder Shrubland',
          },
          {
            value: 3639,
            color: '000000',
            description: 'Alaska Arctic Mesic-Wet Willow Shrubland',
          },
          {
            value: 3640,
            color: '000000',
            description: 'Aleutian Mesic-Wet Willow Shrubland',
          },
          {
            value: 3641,
            color: '000000',
            description: 'North Pacific Maritime Mesic Subalpine Parkland',
          },
          {
            value: 3642,
            color: '000000',
            description: 'Aleutian Kenai Birch-Cottonwood-Poplar Forest',
          },
          {
            value: 3643,
            color: '000000',
            description: 'Alaskan Pacific Maritime Alpine Dwarf-Shrubland',
          },
          {
            value: 3644,
            color: '000000',
            description: 'Alaskan Pacific Maritime Sitka Spruce Forest',
          },
          {
            value: 3645,
            color: '010000',
            description: 'Alaska Sub-boreal and Maritime Alpine Mesic Herbaceous Meadow',
          },
          {
            value: 3646,
            color: '000000',
            description: 'Alaskan Pacific Maritime Western Hemlock Forest',
          },
          {
            value: 3648,
            color: '000000',
            description: 'Alaskan Pacific Maritime Mountain Hemlock Forest',
          },
          {
            value: 3649,
            color: '000000',
            description: 'Alaskan Pacific Maritime Subalpine Mountain Hemlock Woodland',
          },
          {
            value: 3650,
            color: '000000',
            description: 'Alaskan Pacific Maritime Periglacial Woodland',
          },
          {
            value: 3651,
            color: '010000',
            description: 'Aleutian Mesic Herbaceous Meadow',
          },
          {
            value: 3652,
            color: '000000',
            description: 'Alaskan Pacific Maritime Subalpine Alder-Salmonberry Shrubland',
          },
          {
            value: 3653,
            color: '010000',
            description: 'Alaskan Pacific Maritime Mesic Herbaceous Meadow',
          },
          {
            value: 3654,
            color: '000000',
            description: 'Alaskan Pacific Maritime Sitka Spruce Beach Ridge',
          },
          {
            value: 3671,
            color: '010000',
            description: 'Aleutian American Dunegrass Grassland',
          },
          {
            value: 3672,
            color: '000000',
            description: 'Alaskan Pacific Maritime Subalpine Copperbush Shrubland',
          },
          {
            value: 3674,
            color: '000000',
            description: 'Alaskan Pacific Maritime Alpine Sparse Shrub and Fell-field',
          },
          {
            value: 3675,
            color: '000000',
            description: 'North Pacific Mesic Western Hemlock-Yellow-cedar Forest',
          },
          {
            value: 3677,
            color: '000000',
            description: 'Alaska Sub-boreal White-Lutz Spruce Forest and Woodland',
          },
          {
            value: 3678,
            color: '000000',
            description: 'Alaska Sub-boreal Mountain Hemlock-White Spruce Forest',
          },
          {
            value: 3679,
            color: '000100',
            description: 'Alaska Sub-boreal White Spruce Forest',
          },
          {
            value: 3680,
            color: '000000',
            description: 'Alaskan Pacific Maritime Avalanche Slope Shrubland',
          },
          {
            value: 3682,
            color: '000000',
            description: 'Alaska Arctic Scrub Birch-Ericaceous Shrubland',
          },
          {
            value: 3683,
            color: '000000',
            description: 'Alaska Arctic Mesic Sedge-Willow Tundra',
          },
          {
            value: 3684,
            color: '000000',
            description: 'Alaska Arctic Mesic Sedge-Dryas Tundra',
          },
          {
            value: 3685,
            color: '010000',
            description: 'Alaska Arctic Acidic Sparse Tundra',
          },
          {
            value: 3686,
            color: '010000',
            description: 'Alaska Arctic Non-Acidic Sparse Tundra',
          },
          {
            value: 3687,
            color: '010000',
            description: 'Alaska Arctic Lichen Tundra',
          },
          {
            value: 3688,
            color: '010000',
            description: 'Alaska Arctic Acidic Dryas Dwarf-Shrubland',
          },
          {
            value: 3689,
            color: '010000',
            description: 'Alaska Arctic Non-Acidic Dryas Dwarf-Shrubland',
          },
          {
            value: 3690,
            color: '010000',
            description: 'Alaska Arctic Dwarf-Shrubland',
          },
          {
            value: 3691,
            color: '010000',
            description: 'Alaska Arctic Acidic Dwarf-Shrub Lichen Tundra',
          },
          {
            value: 3692,
            color: '010000',
            description: 'Alaska Arctic Non-Acidic Dwarf-Shrub Lichen Tundra',
          },
          {
            value: 3699,
            color: '010000',
            description: 'Alaska Arctic Mesic Herbaceous Meadow',
          },
          {
            value: 3709,
            color: '010000',
            description: 'Alaska Arctic Marine Beach and Beach Meadow',
          },
          {
            value: 3718,
            color: '000000',
            description: 'Aleutian Mesic Alder-Salmonberry Shrubland',
          },
          {
            value: 3719,
            color: '000000',
            description: 'Aleutian Crowberry-Herbaceous Heath',
          },
          {
            value: 3720,
            color: '000000',
            description: 'Aleutian Mixed Dwarf-Shrub-Herbaceous Shrubland',
          },
          {
            value: 3725,
            color: '010000',
            description: 'Aleutian Marine Beach and Beach Meadow',
          },
          {
            value: 3730,
            color: '000000',
            description: 'Aleutian Sparse Heath and Fell-Field',
          },
          {
            value: 3731,
            color: '000000',
            description: 'Aleutian Oval-leaf Blueberry Shrubland',
          },
          {
            value: 3736,
            color: '000000',
            description: 'Barren',
          },
          {
            value: 3737,
            color: '000000',
            description: 'Snow-Ice',
          },
          {
            value: 3738,
            color: '000001',
            description: 'Open Water',
          },
          {
            value: 3739,
            color: '000000',
            description: 'North Pacific Hypermaritime Western Red-cedar-Western Hemlock Forest',
          },
          {
            value: 3740,
            color: '010000',
            description: 'Boreal Aquatic Beds',
          },
          {
            value: 3741,
            color: '010000',
            description: 'Polar Tidal Marshes and Aquatic Beds',
          },
          {
            value: 3742,
            color: '010000',
            description: 'Temperate Pacific Tidal Marshes, Aquatic Beds, and Intertidal Flats',
          },
          {
            value: 3743,
            color: '010000',
            description: 'Aleutian Herbaceous Wetlands',
          },
          {
            value: 3744,
            color: '010000',
            description: 'Arctic Herbaceous Wetlands',
          },
          {
            value: 3745,
            color: '010000',
            description: 'Boreal Herbaceous Wetlands',
          },
          {
            value: 3746,
            color: '010000',
            description: 'Pacific Maritime Herbaceous Wetlands',
          },
          {
            value: 3747,
            color: '010000',
            description: 'Arctic Sedge Meadows',
          },
          {
            value: 3748,
            color: '010000',
            description: 'Aleutian Shrub-Herbaceous Wetlands',
          },
          {
            value: 3749,
            color: '010000',
            description: 'Pacific Maritime Coastal Meadows and Slough-Levee',
          },
          {
            value: 3750,
            color: '000100',
            description: 'Alaska Sub-boreal Hardwood Forest',
          },
          {
            value: 3751,
            color: '000000',
            description: 'Boreal Coniferous Woody Wetland',
          },
          {
            value: 3752,
            color: '000000',
            description: 'Pacific Maritime Coniferous Woody Wetland',
          },
          {
            value: 3753,
            color: '000000',
            description: 'Boreal Coniferous-Deciduous Woody Wetland',
          },
          {
            value: 3754,
            color: '010100',
            description: 'Agriculture-Pasture and Hay',
          },
          {
            value: 3755,
            color: '010100',
            description: 'Agriculture-Cultivated Crops and Irrigated Agriculture',
          },
          {
            value: 3756,
            color: '010000',
            description: 'Arctic Dwarf Shrub Wetland',
          },
          {
            value: 3757,
            color: '000000',
            description: 'Boreal Dwarf Shrub Wetland',
          },
          {
            value: 3758,
            color: '000000',
            description: 'Pacific Maritime Dwarf Shrub Wetland',
          },
          {
            value: 3759,
            color: '010000',
            description: 'Recently Burned - Herb Cover',
          },
          {
            value: 3760,
            color: '010000',
            description: 'Recently Burned - Shrub Cover',
          },
          {
            value: 3761,
            color: '010000',
            description: 'Aleutian Shrub Floodplains',
          },
          {
            value: 3762,
            color: '000000',
            description: 'Arctic Floodplains',
          },
          {
            value: 3763,
            color: '000000',
            description: 'Boreal Forested Floodplains',
          },
          {
            value: 3764,
            color: '000000',
            description: 'Pacific Maritime Forested Floodplains',
          },
          {
            value: 3765,
            color: '000000',
            description: 'Boreal Black Spruce-Tussock Woodland',
          },
          {
            value: 3766,
            color: '000000',
            description: 'Alaskan Pacific Maritime Periglacial Shrubland',
          },
          {
            value: 3767,
            color: '000000',
            description: 'Developed-Open Space',
          },
          {
            value: 3768,
            color: '010000',
            description: 'Developed-Low Intensity',
          },
          {
            value: 3769,
            color: '000000',
            description: 'Developed-Medium Intensity',
          },
          {
            value: 3770,
            color: '000000',
            description: 'Developed-High Intensity',
          },
          {
            value: 3771,
            color: '000000',
            description: 'Aleutian Shrub Peatlands',
          },
          {
            value: 3772,
            color: '000000',
            description: 'Arctic Shrub Peatlands',
          },
          {
            value: 3773,
            color: '000000',
            description: 'Boreal Peatlands',
          },
          {
            value: 3774,
            color: '000000',
            description: 'Pacific Maritime Forested Peatlands',
          },
          {
            value: 3775,
            color: '010000',
            description: 'Aleutian Forested Floodplains',
          },
          {
            value: 3776,
            color: '000000',
            description: 'Boreal Riparian Stringer Forest and Shrubland',
          },
          {
            value: 3777,
            color: '000000',
            description: 'Boreal Shrub Swamp',
          },
          {
            value: 3778,
            color: '000000',
            description: 'Pacific Maritime Shrub Swamp',
          },
          {
            value: 3779,
            color: '000100',
            description: 'Alaska Boreal Hardwood Forest',
          },
          {
            value: 3780,
            color: '000100',
            description: 'Alaska Boreal White Spruce-Hardwood Forest',
          },
          {
            value: 3781,
            color: '010000',
            description: 'Arctic Shrub Sedge-Tussock-Lichen Tundra',
          },
          {
            value: 3782,
            color: '010000',
            description: 'Boreal Tussock Tundra',
          },
          {
            value: 3783,
            color: '010000',
            description: 'Arctic Shrub Tussock Tundra',
          },
          {
            value: 3784,
            color: '010000',
            description: 'Arctic Shrub-Tussock Tundra',
          },
          {
            value: 3785,
            color: '000000',
            description: 'Arctic Shrub Tundra',
          },
          {
            value: 3786,
            color: '000000',
            description: 'Boreal Shrub-Tussock Tundra',
          },
          {
            value: 3787,
            color: '000000',
            description: 'Boreal Herbaceous Floodplains',
          },
          {
            value: 3788,
            color: '000000',
            description: 'Boreal Shrub Floodplains',
          },
          {
            value: 3789,
            color: '000100',
            description: 'Alaska Sub-boreal White Spruce-Hardwood Forest',
          },
          {
            value: 3790,
            color: '000000',
            description: 'Pacific Maritime Shrub Floodplains',
          },
          {
            value: 3791,
            color: '000000',
            description: 'Aleutian Sparsely Vegetated',
          },
          {
            value: 3792,
            color: '000000',
            description: 'Arctic Sparsely Vegetated',
          },
          {
            value: 3793,
            color: '000000',
            description: 'Boreal Sparsely Vegetated',
          },
          {
            value: 3794,
            color: '000000',
            description: 'Pacific Maritime Sparsely Vegetated',
          },
          {
            value: 3795,
            color: '000000',
            description: 'Aleutian Herbaceous Peatlands',
          },
          {
            value: 3796,
            color: '000000',
            description: 'Arctic Herbaceous Peatlands',
          },
          {
            value: 3797,
            color: '000000',
            description: 'Pacific Maritime Shrub Peatlands',
          },
          {
            value: 3798,
            color: '010000',
            description: 'Arctic Herbaceous Sedge-Tussock-Lichen Tundra',
          },
          {
            value: 3799,
            color: '010000',
            description: 'Arctic Herbaceous Tussock Tundra',
          },
          {
            value: 3800,
            color: '000000',
            description: 'Developed-Open Space',
          },
          {
            value: 3801,
            color: '010000',
            description: 'Developed-Low Intensity',
          },
          {
            value: 3802,
            color: '000000',
            description: 'Developed-Medium Intensity',
          },
          {
            value: 3803,
            color: '000000',
            description: 'Developed-High Intensity',
          },
          {
            value: 3804,
            color: '010100',
            description: 'Agriculture',
          },
          {
            value: 3805,
            color: '000001',
            description: 'Water',
          },
          {
            value: 3806,
            color: '010000',
            description: "Hawai'i Bog",
          },
          {
            value: 3807,
            color: '010000',
            description: "Hawai'i Islands Introduced Wetland Vegetation-Tree",
          },
          {
            value: 3808,
            color: '000100',
            description: "Hawai'i Lowland Rainforest",
          },
          {
            value: 3809,
            color: '000100',
            description: "Hawai'i Montane Cloud Forest",
          },
          {
            value: 3810,
            color: '000100',
            description: "Hawai'i Montane Rainforest",
          },
          {
            value: 3811,
            color: '000000',
            description: "Hawai'i Wet Cliff and Ridge Crest Shrubland",
          },
          {
            value: 3812,
            color: '010000',
            description: "Hawai'i Introduced Wetland Vegetation-Shrub",
          },
          {
            value: 3813,
            color: '000000',
            description: "Hawai'i Lowland Dry Forest",
          },
          {
            value: 3814,
            color: '000000',
            description: "Hawai'i Lowland Mesic Forest",
          },
          {
            value: 3815,
            color: '000000',
            description: "Hawai'i Montane-Subalpine Dry Forest and Woodland",
          },
          {
            value: 3816,
            color: '000000',
            description: "Hawai'i Montane-Subalpine Mesic Forest",
          },
          {
            value: 3817,
            color: '000000',
            description: "Hawai'i Lowland Dry Shrubland",
          },
          {
            value: 3818,
            color: '000000',
            description: "Hawai'i Lowland Mesic Shrubland",
          },
          {
            value: 3819,
            color: '000000',
            description: "Hawai'i Lowland Dry Grassland",
          },
          {
            value: 3820,
            color: '010000',
            description: "Hawai'i Lowland Mesic Grassland",
          },
          {
            value: 3821,
            color: '000000',
            description: "Hawai'i Montane-Subalpine Dry Shrubland",
          },
          {
            value: 3822,
            color: '000000',
            description: "Hawai'i Montane-Subalpine Dry Grassland",
          },
          {
            value: 3823,
            color: '010000',
            description: "Hawai'i Montane-Subalpine Mesic Grassland",
          },
          {
            value: 3824,
            color: '000000',
            description: "Hawai'i Alpine Dwarf-Shrubland",
          },
          {
            value: 3825,
            color: '000000',
            description: "Hawai'i Dry Cliff",
          },
          {
            value: 3826,
            color: '000000',
            description: "Hawai'i Dry Coastal Strand",
          },
          {
            value: 3827,
            color: '000000',
            description: "Hawai'i Wet-Mesic Coastal Strand",
          },
          {
            value: 3828,
            color: '010000',
            description: "Hawai'i Subalpine Mesic Shrubland",
          },
          {
            value: 3830,
            color: '000000',
            description: 'Barren',
          },
          {
            value: 3832,
            color: '000000',
            description: 'Barren',
          },
          {
            value: 3833,
            color: '000100',
            description: 'Pacific Islands Limestone Forest',
          },
          {
            value: 3834,
            color: '000100',
            description: 'Pacific Islands Littoral/Strand Vegetation',
          },
          {
            value: 3835,
            color: '000000',
            description: 'Pacific Islands Lowland Forest',
          },
          {
            value: 3836,
            color: '000000',
            description: 'Pacific Islands Mangrove Forest',
          },
          {
            value: 3837,
            color: '000100',
            description: 'Pacific Islands Palm Forest',
          },
          {
            value: 3838,
            color: '010000',
            description: "Hawai'i Introduced Wetland Vegetation-Herbaceous",
          },
          {
            value: 3839,
            color: '000000',
            description: 'Pacific Islands Ravine Forest',
          },
          {
            value: 3840,
            color: '000000',
            description: 'Pacific Islands Savannah',
          },
          {
            value: 3841,
            color: '000000',
            description: 'Pacific Islands Scrub Forest/Shrub',
          },
          {
            value: 3842,
            color: '000000',
            description: 'Pacific Islands Swamp/Marsh',
          },
          {
            value: 3843,
            color: '000000',
            description: 'Pacific Islands Upland Forest',
          },
          {
            value: 3845,
            color: '010000',
            description: "Hawai'i Introduced Dry Forest",
          },
          {
            value: 3846,
            color: '010000',
            description: "Hawai'i Introduced Wet-Mesic Forest",
          },
          {
            value: 3847,
            color: '010000',
            description: "Hawai'i Introduced Deciduous Shrubland",
          },
          {
            value: 3848,
            color: '010000',
            description: "Hawai'i Introduced Perennial Grassland",
          },
          {
            value: 3849,
            color: '010000',
            description: "Hawai'i Introduced Evergreen Shrubland",
          },
          {
            value: 3850,
            color: '000000',
            description: 'Pacific Islands Introduced Forest',
          },
          {
            value: 3852,
            color: '010000',
            description: "Hawai'i Introduced Coastal Wetland Vegetation - Tree",
          },
          {
            value: 3853,
            color: '010000',
            description: "Hawai'i Introduced Coastal Wetland Vegetation - Shrub",
          },
          {
            value: 3854,
            color: '010000',
            description: "Hawai'i Introduced Coastal Wetland Vegetation - Herbaceous",
          },
          {
            value: 3855,
            color: '000000',
            description: "Hawai'i Managed Tree Plantation",
          },
          {
            value: 3856,
            color: '000000',
            description: 'Pacific Islands Plantation Forest',
          },
          {
            value: 3857,
            color: '000000',
            description: 'Urban',
          },
          {
            value: 3858,
            color: '010000',
            description: 'Agriculture',
          },
          {
            value: 3859,
            color: '000001',
            description: 'Water',
          },
          {
            value: 3860,
            color: '000000',
            description: 'Caribbean High-medium density urban',
          },
          {
            value: 3861,
            color: '000000',
            description: 'Caribbean Low-medium density urban',
          },
          {
            value: 3862,
            color: '010000',
            description: 'Caribbean Herbaceous agriculture - cultivated lands',
          },
          {
            value: 3863,
            color: '000100',
            description: 'Caribbean Active sun coffee and mixed woody agriculture',
          },
          {
            value: 3864,
            color: '010000',
            description: 'Caribbean Pasture, hay or inactive agriculture',
          },
          {
            value: 3865,
            color: '010000',
            description: 'Caribbean Pasture, hay or other grassy areas',
          },
          {
            value: 3866,
            color: '000000',
            description: 'Caribbean Drought deciduous open woodland',
          },
          {
            value: 3867,
            color: '000000',
            description: 'Caribbean Drought deciduous dense woodland',
          },
          {
            value: 3868,
            color: '000100',
            description: 'Caribbean Deciduous, evergreen coastal and mixed forest or shrubland with succulents',
          },
          {
            value: 3869,
            color: '000100',
            description: 'Caribbean Semi-deciduous and drought deciduous forest on alluvium and non-carbonate substrates',
          },
          {
            value: 3870,
            color: '000000',
            description: 'Caribbean Semi-deciduous and drought deciduous forest on karst (includes semi-evergreen forest)',
          },
          {
            value: 3871,
            color: '000000',
            description: 'Caribbean Drought deciduous, semi-deciduous and seasonal evergreen forest on serpentine',
          },
          {
            value: 3872,
            color: '000100',
            description: 'Caribbean Seasonal evergreen and semi-deciduous forest on karst',
          },
          {
            value: 3873,
            color: '000000',
            description: 'Caribbean Seasonal evergreen and evergreen forest',
          },
          {
            value: 3874,
            color: '000100',
            description: 'Caribbean Seasonal evergreen forest with coconut palm',
          },
          {
            value: 3875,
            color: '000000',
            description: 'Caribbean Evergreen and seasonal evergreen forest on karst',
          },
          {
            value: 3876,
            color: '000000',
            description: 'Caribbean Evergreen forest on serpentine',
          },
          {
            value: 3877,
            color: '000000',
            description: 'Caribbean Elfin, sierra palm, transitional and tall cloud forest',
          },
          {
            value: 3878,
            color: '010000',
            description: 'Caribbean Emergent wetlands including seasonnally flooded pasture',
          },
          {
            value: 3879,
            color: '000000',
            description: 'Caribbean Salt or mud flats',
          },
          {
            value: 3880,
            color: '000000',
            description: 'Caribbean Mangrove',
          },
          {
            value: 3881,
            color: '000000',
            description: 'Caribbean Seasonally flooded savannahs and woodlands',
          },
          {
            value: 3882,
            color: '010000',
            description: 'Caribbean Pterocarpus swamp',
          },
          {
            value: 3883,
            color: '000000',
            description: 'Caribbean Tidally flooded evergreen dwarf-shrubland and forb vegetation',
          },
          {
            value: 3884,
            color: '000000',
            description: 'Quarries',
          },
          {
            value: 3885,
            color: '000000',
            description: 'Coastal sand and rock',
          },
          {
            value: 3886,
            color: '000000',
            description: 'Bare soil',
          },
          {
            value: 3887,
            color: '000001',
            description: 'Water',
          },
          {
            value: 3900,
            color: '000000',
            description: 'Western Cool Temperate Urban Deciduous Forest',
          },
          {
            value: 3901,
            color: '000000',
            description: 'Western Cool Temperate Urban Evergreen Forest',
          },
          {
            value: 3902,
            color: '000000',
            description: 'Western Cool Temperate Urban Mixed Forest',
          },
          {
            value: 3903,
            color: '000000',
            description: 'Western Cool Temperate Urban Herbaceous',
          },
          {
            value: 3904,
            color: '000000',
            description: 'Western Cool Temperate Urban Shrubland',
          },
          {
            value: 3905,
            color: '000000',
            description: 'Eastern Cool Temperate Urban Deciduous Forest',
          },
          {
            value: 3906,
            color: '000000',
            description: 'Eastern Cool Temperate Urban Evergreen Forest',
          },
          {
            value: 3907,
            color: '000000',
            description: 'Eastern Cool Temperate Urban Mixed Forest',
          },
          {
            value: 3908,
            color: '000000',
            description: 'Eastern Cool Temperate Urban Herbaceous',
          },
          {
            value: 3909,
            color: '000000',
            description: 'Eastern Cool Temperate Urban Shrubland',
          },
          {
            value: 3910,
            color: '000000',
            description: 'Western Warm Temperate Urban Deciduous Forest',
          },
          {
            value: 3911,
            color: '000000',
            description: 'Western Warm Temperate Urban Evergreen Forest',
          },
          {
            value: 3912,
            color: '000000',
            description: 'Western Warm Temperate Urban Mixed Forest',
          },
          {
            value: 3913,
            color: '000000',
            description: 'Western Warm Temperate Urban Herbaceous',
          },
          {
            value: 3914,
            color: '000000',
            description: 'Western Warm Temperate Urban Shrubland',
          },
          {
            value: 3915,
            color: '000000',
            description: 'Eastern Warm Temperate Urban Urban Deciduous Forest',
          },
          {
            value: 3916,
            color: '000000',
            description: 'Eastern Warm Temperate Urban Urban Evergreen Forest',
          },
          {
            value: 3917,
            color: '000000',
            description: 'Eastern Warm Temperate Urban Urban Mixed Forest',
          },
          {
            value: 3918,
            color: '000000',
            description: 'Eastern Warm Temperate Urban Urban Herbaceous',
          },
          {
            value: 3919,
            color: '000000',
            description: 'Eastern Warm Temperate Urban Urban Shrubland',
          },
          {
            value: 3920,
            color: '000000',
            description: 'Western Cool Temperate Developed Ruderal Deciduous Forest',
          },
          {
            value: 3921,
            color: '000000',
            description: 'Western Cool Temperate Developed Ruderal Evergreen Forest',
          },
          {
            value: 3922,
            color: '000000',
            description: 'Western Cool Temperate Developed Ruderal Mixed Forest',
          },
          {
            value: 3923,
            color: '000000',
            description: 'Western Cool Temperate Developed Ruderal Shrubland',
          },
          {
            value: 3924,
            color: '000000',
            description: 'Western Cool Temperate Developed Ruderal Grassland',
          },
          {
            value: 3925,
            color: '000000',
            description: 'Western Warm Temperate Developed Ruderal Deciduous Forest',
          },
          {
            value: 3926,
            color: '000000',
            description: 'Western Warm Temperate Developed Ruderal Evergreen Forest',
          },
          {
            value: 3927,
            color: '000000',
            description: 'Western Warm Temperate Developed Ruderal Mixed Forest',
          },
          {
            value: 3928,
            color: '000000',
            description: 'Western Warm Temperate Developed Ruderal Shrubland',
          },
          {
            value: 3929,
            color: '000000',
            description: 'Western Warm Temperate Developed Ruderal Grassland',
          },
          {
            value: 3930,
            color: '000000',
            description: 'Eastern Cool Temperate Developed Ruderal Deciduous Forest',
          },
          {
            value: 3931,
            color: '000000',
            description: 'Eastern Cool Temperate Developed Ruderal Evergreen Forest',
          },
          {
            value: 3932,
            color: '000000',
            description: 'Eastern Cool Temperate Developed Ruderal Mixed Forest',
          },
          {
            value: 3933,
            color: '000000',
            description: 'Eastern Cool Temperate Developed Ruderal Shrubland',
          },
          {
            value: 3934,
            color: '000000',
            description: 'Eastern Cool Temperate Developed Ruderal Grassland',
          },
          {
            value: 3935,
            color: '000000',
            description: 'Eastern Warm Temperate Developed Ruderal Deciduous Forest',
          },
          {
            value: 3936,
            color: '000000',
            description: 'Eastern Warm Temperate Developed Ruderal Evergreen Forest',
          },
          {
            value: 3937,
            color: '000000',
            description: 'Eastern Warm Temperate Developed Ruderal Mixed Forest',
          },
          {
            value: 3938,
            color: '000000',
            description: 'Eastern Warm Temperate Developed Ruderal Shrubland',
          },
          {
            value: 3939,
            color: '000000',
            description: 'Eastern Warm Temperate Developed Ruderal Grassland',
          },
          {
            value: 3940,
            color: '010000',
            description: 'Western Cool Temperate Undeveloped Ruderal Deciduous Forest',
          },
          {
            value: 3941,
            color: '010000',
            description: 'Western Cool Temperate Undeveloped Ruderal Evergreen Forest',
          },
          {
            value: 3942,
            color: '010000',
            description: 'Western Cool Temperate Undeveloped Ruderal Mixed Forest',
          },
          {
            value: 3943,
            color: '000000',
            description: 'Western Cool Temperate Undeveloped Ruderal Shrubland',
          },
          {
            value: 3944,
            color: '000000',
            description: 'Western Cool Temperate Undeveloped Ruderal Grassland',
          },
          {
            value: 3945,
            color: '010000',
            description: 'Western Warm Temperate Undeveloped Ruderal Deciduous Forest',
          },
          {
            value: 3946,
            color: '010000',
            description: 'Western Warm Temperate Undeveloped Ruderal Evergreen Forest',
          },
          {
            value: 3947,
            color: '010000',
            description: 'Western Warm Temperate Undeveloped Ruderal Mixed Forest',
          },
          {
            value: 3948,
            color: '000000',
            description: 'Western Warm Temperate Undeveloped Ruderal Shrubland',
          },
          {
            value: 3949,
            color: '000000',
            description: 'Western Warm Temperate Undeveloped Ruderal Grassland',
          },
          {
            value: 3950,
            color: '010000',
            description: 'Eastern Cool Temperate Undeveloped Ruderal Deciduous Forest',
          },
          {
            value: 3951,
            color: '010000',
            description: 'Eastern Cool Temperate Undeveloped Ruderal Evergreen Forest',
          },
          {
            value: 3952,
            color: '010000',
            description: 'Eastern Cool Temperate Undeveloped Ruderal Mixed Forest',
          },
          {
            value: 3953,
            color: '000000',
            description: 'Eastern Cool Temperate Undeveloped Ruderal Shrubland',
          },
          {
            value: 3954,
            color: '000000',
            description: 'Eastern Cool Temperate Undeveloped Ruderal Grassland',
          },
          {
            value: 3955,
            color: '010000',
            description: 'Eastern Warm Temperate Undeveloped Ruderal Deciduous Forest',
          },
          {
            value: 3956,
            color: '010000',
            description: 'Eastern Warm Temperate Undeveloped Ruderal Evergreen Forest',
          },
          {
            value: 3957,
            color: '010000',
            description: 'Eastern Warm Temperate Undeveloped Ruderal Mixed Forest',
          },
          {
            value: 3958,
            color: '000000',
            description: 'Eastern Warm Temperate Undeveloped Ruderal Shrubland',
          },
          {
            value: 3959,
            color: '000000',
            description: 'Eastern Warm Temperate Undeveloped Ruderal Grassland',
          },
          {
            value: 3960,
            color: '000000',
            description: 'Western Cool Temperate Orchard',
          },
          {
            value: 3961,
            color: '000000',
            description: 'Western Cool Temperate Vineyard',
          },
          {
            value: 3962,
            color: '000000',
            description: 'Western Cool Temperate Bush fruit and berries',
          },
          {
            value: 3963,
            color: '010000',
            description: 'Western Cool Temperate Row Crop - Close Grown Crop',
          },
          {
            value: 3964,
            color: '000100',
            description: 'Western Cool Temperate Row Crop',
          },
          {
            value: 3965,
            color: '010000',
            description: 'Western Cool Temperate Close Grown Crop',
          },
          {
            value: 3966,
            color: '010100',
            description: 'Western Cool Temperate Fallow/Idle Cropland',
          },
          {
            value: 3967,
            color: '000000',
            description: 'Western Cool Temperate Pasture and Hayland',
          },
          {
            value: 3968,
            color: '000000',
            description: 'Western Cool Temperate Wheat',
          },
          {
            value: 3969,
            color: '000100',
            description: 'Western Cool Temperate Aquaculture',
          },
          {
            value: 3970,
            color: '000000',
            description: 'Eastern Cool Temperate Orchard',
          },
          {
            value: 3971,
            color: '000000',
            description: 'Eastern Cool Temperate Vineyard',
          },
          {
            value: 3972,
            color: '000000',
            description: 'Eastern Cool Temperate Bush fruit and berries',
          },
          {
            value: 3973,
            color: '010000',
            description: 'Eastern Cool Temperate Row Crop - Close Grown Crop',
          },
          {
            value: 3974,
            color: '000100',
            description: 'Eastern Cool Temperate Row Crop',
          },
          {
            value: 3975,
            color: '010000',
            description: 'Eastern Cool Temperate Close Grown Crop',
          },
          {
            value: 3976,
            color: '010100',
            description: 'Eastern Cool Temperate Fallow/Idle Cropland',
          },
          {
            value: 3977,
            color: '000000',
            description: 'Eastern Cool Temperate Pasture and Hayland',
          },
          {
            value: 3978,
            color: '000000',
            description: 'Eastern Cool Temperate Wheat',
          },
          {
            value: 3979,
            color: '000100',
            description: 'Eastern Cool Temperate Aquaculture',
          },
          {
            value: 3980,
            color: '000000',
            description: 'Western Warm Temperate Orchard',
          },
          {
            value: 3981,
            color: '000000',
            description: 'Western Warm Temperate Vineyard',
          },
          {
            value: 3982,
            color: '000000',
            description: 'Western Warm Temperate Bush fruit and berries',
          },
          {
            value: 3983,
            color: '010000',
            description: 'Western Warm Temperate Row Crop - Close Grown Crop',
          },
          {
            value: 3984,
            color: '000100',
            description: 'Western Warm Temperate Row Crop',
          },
          {
            value: 3985,
            color: '010000',
            description: 'Western Warm Temperate Close Grown Crop',
          },
          {
            value: 3986,
            color: '010100',
            description: 'Western Warm Temperate Fallow/Idle Cropland',
          },
          {
            value: 3987,
            color: '000000',
            description: 'Western Warm Temperate Pasture and Hayland',
          },
          {
            value: 3988,
            color: '000000',
            description: 'Western Warm Temperate Wheat',
          },
          {
            value: 3989,
            color: '000100',
            description: 'Western Warm Temperate Aquaculture',
          },
          {
            value: 3990,
            color: '000000',
            description: 'Eastern Warm Temperate Orchard',
          },
          {
            value: 3991,
            color: '000000',
            description: 'Eastern Warm Temperate Vineyard',
          },
          {
            value: 3992,
            color: '000000',
            description: 'Eastern Warm Temperate Bush fruit and berries',
          },
          {
            value: 3993,
            color: '010000',
            description: 'Eastern Warm Temperate Row Crop - Close Grown Crop',
          },
          {
            value: 3994,
            color: '000100',
            description: 'Eastern Warm Temperate Row Crop',
          },
          {
            value: 3995,
            color: '010000',
            description: 'Eastern Warm Temperate Close Grown Crop',
          },
          {
            value: 3996,
            color: '010100',
            description: 'Eastern Warm Temperate Fallow/Idle Cropland',
          },
          {
            value: 3997,
            color: '000000',
            description: 'Eastern Warm Temperate Pasture and Hayland',
          },
          {
            value: 3998,
            color: '000000',
            description: 'Eastern Warm Temperate Wheat',
          },
          {
            value: 3999,
            color: '000100',
            description: 'Eastern Warm Temperate Aquaculture',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'EVT',
        lookat: {
          lat: 40.699,
          lon: -121.671,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'EVT',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    The suggested way to cite LANDFIRE products is specific to each product,
    so the model for citation is provided, with an example for a particular product.
    Producer. Year released. Product xxxxx:

    - Individual model name.
    - BpS Models and Descriptions, Online. LANDFIRE. Washington, DC. U.S. Department of
      Agriculture, Forest Service
    - U.S. Department of the Interior; U.S. Geological Survey; Arlington, VA
    - The Nature Conservancy (Producers). Available- URL. Access date.

    Example Citation: LANDFIRE Biophysical Settings. 2018. Biophysical setting 14420:
    South Texas sand sheet grassland. In: LANDFIRE Biophysical Setting Model: Map zone 36,
    [Online]. In: BpS Models and Descriptions. In: LANDFIRE. Washington, DC:
    U.S. Department of Agriculture, Forest Service; U.S. Department of the Interior;
    U.S. Geological Survey; Arlington, VA: The Nature Conservancy (Producers).
    Available: [https://www.landfire.gov/bps-models.php](https://www.landfire.gov/bps-models.php) [2018, June 27].
    Additional guidance on citation of LANDFIRE products can be found
    [here](https://landfire.gov/data/citation)
  |||,
  'gee:terms_of_use': |||
    LANDFIRE data are public domain data with no use restrictions, though if modifications
    or derivatives of the product(s) are created, then please add some descriptive modifier
    to the data set to avoid confusion.
  |||,
  'gee:user_uploaded': true,
}
