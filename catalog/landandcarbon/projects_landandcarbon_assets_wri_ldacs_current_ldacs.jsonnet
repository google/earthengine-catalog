local id = 'projects/landandcarbon/assets/wri_ldacs/current/ldacs';
local subdir = 'landandcarbon';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local version = 1.0;

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'Land Disturbance Alert Classification System (LDACS)',
  version: version,

  description: |||
    The Land Disturbance Alert Classification System (LDACS) is designed to make global land monitoring more actionable 
    for governments, companies, researchers, and civil society. Built on NASA’s DIST-ALERT system, which detects global 
    vegetation disturbances at 30-meter resolution in near real-time, LDACS integrates additional data on fire, water, 
    cropland extent, and natural ecosystems to classify alerts into four categories: potential land conversion, 
    fire-related, water-related, and cropland dynamics.

    LDACS classifies global vegetation disturbance alerts from the previous 12 months into four categories (fire-related,
    cropland dynamics, water-related, or potential conversion) on a quarterly basis using a rule-based approach to
    assign a probable cause to each alert.

    The system integrates the following data sources:

    * DIST-ALERT ([Pickens, Hansen, and Song, 2024](https://lpdaac.usgs.gov/documents/1766/OPERA_DIST_HLS_Product_Specification_V1.pdf "https://lpdaac.usgs.gov/documents/1766/OPERA_DIST_HLS_Product_Specification_V1.pdf"))
    * VIIRS Fire Alerts ([Schroeder et al. 2014](https://www.earthdata.nasa.gov/data/instruments/viirs/viirs-i-band-375-m-active-fire-data "https://www.earthdata.nasa.gov/data/instruments/viirs/viirs-i-band-375-m-active-fire-data"))
    * UMD Surface Water Dynamics ([Pickens et al. 2020](https://doi.org/10.1016/j.rse.2020.111792 "https://doi.org/10.1016/j.rse.2020.111792"))
    * Cropland extent
      * UMD Global Cropland Dynamics ([Potapov et al. 2022](https://doi.org/10.1038/s43016-021-00429-z "https://doi.org/10.1038/s43016-021-00429-z"))
      * ESA WorldCover ([Zanaga et al. 2020](https://esa-worldcover.org/en/data-access "https://esa-worldcover.org/en/data-access"))
    * Natural land cover ([Mazur et al. 2025](https://sciencebasedtargetsnetwork.org/wp-content/uploads/2025/02/Technical-Guidance-2025-Step3-Land-v1_1-Natural-Lands-Map.pdf "https://sciencebasedtargetsnetwork.org/wp-content/uploads/2025/02/Technical-Guidance-2025-Step3-Land-v1_1-Natural-Lands-Map.pdf"))
        
    Only a subset of DIST-ALERT data is classified by LDACS. Alerts with less than 50% vegetation loss or fewer than two 
    cloud-free satellite observations are excluded to minimize false positives.

    The following describes the methodology behind each class:
    * **Fire-related:** Alerts are classified as fire-related if they fall within three kilometers and three months of 
    a VIIRS Fire Alert and occur within natural land cover.
    * **Cropland dynamics:** Alerts within areas mapped as cropland by either the UMD Global Cropland Dynamics or ESA 
    WorldCover datasets are classified as cropland dynamics.
    * **Water-related:** Alerts falling within areas where surface water was detected at least once between 1999 and 
    2021 in the UMD Surface Water Dynamics dataset are classified as water-related.
    * **Potential conversion:** Alerts are classified as potential conversion if they occur within natural land cover 
    and persist for at least 75 days.
        

    Where alerts met criteria for both fire-related disturbance and potential conversion, Dynamic World land cover 
    classifications two months after the DIST-ALERT start date were used to resolve the overlap. Alerts where the dominant 
    post-disturbance class indicated vegetation recovery (trees, grass, shrub and scrub, or flooded vegetation) were 
    classified as fire-related, while those showing bare ground, cropland, or built area were classified as potential 
    conversion.

    The resulting classes are merged into a final classification layer using a hierarchical scheme: fire-related alerts
    take the highest priority, followed by cropland dynamics, water-related alerts, and potential conversion. Alerts 
    that do not meet the criteria for any of the four categories are considered “unclassified” alerts.

    **Limitations**
    Because potential conversion is identified based on the duration of vegetation loss, there is an inherent delay in 
    labeling these alerts. Although vegetation loss may be detected shortly after clearing, alerts are not assigned to 
    the potential conversion class until they exceed the 75-day duration threshold. This delay allows for greater 
    confidence in classification but may reduce the timeliness of conversion detection for rapid response. Additionally,
    input datasets used to produce the LDACS contain temporal gaps or known mapping errors that may affect classification
    accuracy. Please refer to the technical note for more information on the limitations of the input datasets.

    **For a full description of the methods, technical specifications, definitions, accuracy, and limitations, please 
    see the technical note**: [Land Disturbance Alert Classification System](http://doi.org/10.46830/writn.25.00016). 
  |||, 


  'gee:categories': ['landuse-landcover'],

  keywords: [
    'vegetation',
    'disturbance',
    'fire',
    'flood',
    'crop',
    'land use',
    'monitoring',
    'change-detection',
    'global',
    'wri'
    ],

  providers: [
    ee.producer_provider('World Resources Institute', 'https://www.wri.org/research/land-disturbance-alert-classification-system'),
    ee.producer_provider('UMD/GLAD', 'https://glad.umd.edu/dataset/DIST-ALERT'),
    ee.host_provider(self_ee_catalog_url),
  ],

  extent: ee.extent_global('2025-07-01T00:00:00Z', '2026-06-30T00:00:00Z'),

  summaries: {
    gsd: [27.83],
    'eo:bands': [
      {
        name: 'attribution',
        description: 'Driver class attribution.',
        'gee:classes': [
          {value: 1, color: '9A3B01', description: 'Fire-related'},
          {value: 2, color: 'AB8C00', description: 'Cropland dynamics'},
          {value: 3, color: '0000FF', description: 'Water-related'},
          {value: 4, color: 'DB2777', description: 'Potential conversion'},
        ],
      },
    ],

    classification: {minimum: 1, maximum: 4, 'gee:estimated_range': false},

    'gee:visualizations': [
      {
        display_name: 'Land Disturbance Alert Classification System (LDACS)',
        lookat: {lon: -45.9893, lat: -11.1868, zoom: 10},
        image_visualization: {
          band_vis: {
            min: [1],
            max: [4],
            palette: ['9A3B01','AB8C00','0000FF','DB2777'],
            bands: ['attribution'],
            }
          },  
        },
      ],
  },

  'sci:citation': |||
   MacCarthy, J., J. Richter, V. Zalles, S. Carter, A. Pickens, Z. Song, A. Barrett, and G. Nussbaum. 2025. “Land Disturbance Alert Classification System” Technical Note. Washington, DC: World Resources Institute. [doi.org/10.46830/writn.25.00016](doi.org/10.46830/writn.25.00016)
  |||,


  'gee:terms_of_use': ee.gee_terms_of_use(license),


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
