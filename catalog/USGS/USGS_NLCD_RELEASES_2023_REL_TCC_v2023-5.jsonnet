local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local versions = import 'versions.libsonnet';
local versions_table = import 'templates/TCC_versions.libsonnet';

local id = 'USGS/NLCD_RELEASES/2023_REL/TCC/v2023-5';
local subdir = 'USGS';
local version_config = versions(subdir, versions_table, id);
local version = version_config.version;
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'USFS Tree Canopy Cover ' + version + ' ' + '(CONUS and OCONUS)',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    **Overview**
    
    The Tree Canopy Cover (TCC) data suite, produced by the United States Department of Agriculture, Forest Service (USFS), 
    are annual remote sensing-based map outputs spanning from 1985-2023.
    These data support the National Land Cover Database (NLCD) project, 
    which is managed by the US Geological Survey (USGS) as part of the Multi-Resolution Land Characteristics (MRLC) consortium. 
    The project aims to use the latest technology to create a consistent, "best available" map of tree canopy cover. 
    The geographic scope includes the Conterminous United States (CONUS) and OCONUS regions (Southeast Alaska (SEAK), Hawaii, 
    Puerto Rico, and the US Virgin Islands (PRUSVI)). 

    **Products**

    The TCC data suite includes three products:

    * **Science TCC:** The raw, direct outputs from the model.

    * **Science standard error (SE):** The model standard deviation of the predicted values from all regression trees. 
    
    * **NLCD TCC:** A refined product derived from the annual Science TCC images. It undergoes post-processing to 
    reduce interannual noise, highlight long-term trends, and mask specific features (such as water and non-tree agriculture).  

    Each image includes a data mask band that has three values representing areas of no data (0), mapped tree canopy cover(1), 
    and non-processing area (2). The non-processing areas are pixels in the study area with no cloud or cloud shadow-free data. No data
    and non-processing area pixels are masked in TCC and SE images.

    **Data and Methods**

    We developed training data and random forest models for CONUS, SEAK, PRUSVI and HAWAII using the 
    USFS Forest Inventory and Analysis (FIA) photo-interpreted TCC as reference data. We leveraged Google Earth Engine (GEE) 
    (Gorelick et al., 2017) to process fitted LandTrendr and terrain predictors. Terrain data from the 3D Elevation Program (3DEP) 
    (U.S. Geological Survey, 2019) include elevation, slope, sine of aspect, and cosine of aspect. 
    For CONUS, we also included the Crop Data Layer (CDL) as a predictor (Lin et al., 2022). 

    We utilized USGS Collection 2 Landsat Tier 1 and Sentinel 2A/2B Level-1C top of atmosphere reflectance imagery to 
    produce annual medoid composites. To ensure data quality, we applied various algorithms to mask clouds and shadows, 
    including cFmask (Foga et al., 2017; Zhu and Woodcock, 2012), cloudScore (Chastain et al., 2019), s2cloudless (Sentinel-Hub, 2021), 
    Cloud Score+ (Pasquarella et al., 2023), and TDOM (Chastain et al., 2019). Once masked, we computed annual medoids to create 
    a single cloud-free composite for each year. Finally, the composite time series was temporally segmented using LandTrendr 
    (Kennedy et al., 2010, 2018; Cohen et al., 2018). 

    For CONUS, we used 70% of the reference data for calibration and 30% for independent error assessment. 
    Given the ecological diversity of CONUS, we divided the modeling area into 54 tiles (480 km × 480 km). 
    On local computers we built a unique random forest model for each tile (Breiman, 2001), training it on reference data intersecting a 
    5×5 window around the center tile. The models were then deployed in GEE to predict wall-to-wall TCC. For OCONUS regions, 
    we used an 80/20 split and developed a single random forest model for each region.

    **Additional Resources**

    * Please see the [TCC Methods Brief](https://data.fs.usda.gov/geodata/rastergateway/treecanopycover/docs/TCC_v2023-5_Methods.pdf) or 
    [Science of Remote Sensing journal article](https://www.sciencedirect.com/science/article/pii/S2666017225001075)
    for detailed information regarding methods and accuracy assessment. 
    
    * Please see the [TCC Geodata Clearinghouse](https://data.fs.usda.gov/geodata/rastergateway/treecanopycover/)
    for data downloads, metadata, and support documents.

    * The string HAWAII will be updated to HI in the upcoming v2025.6 data release.

    Contact [sm.fs.tcc@usda.gov] with any
    questions or specific data requests.

  |||,

  license: license.id,
  links: ee.standardLinks(subdir, id)  + version_config.version_links + [
    ee.link.license('https://data.fs.usda.gov/geodata/rastergateway/treecanopycover/')
  ],
  'gee:categories': ['landuse-landcover'],
  keywords: [
    'forest',
    'usda',
    'usfs',
    'gtac',
    'redcastle_resources',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USDA Forest Service (USFS) Field Services and Innovation Center Geospatial Office (FSIC-GO)', 
    'https://www.fs.usda.gov/about-agency/gtac'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-135.286387, 20.38379, -56.446306, 52.459364,
                    '1985-06-01T00:00:00Z', '2023-09-30T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'study_area',
        description: |||
          TCC currently covers CONUS, Southeastern Alaska, Puerto Rico-US
          Virgin Islands and Hawaii. This version contains data for CONUS, 
          AK, PRUSVI, and HAWAII.
          Possible values: 'CONUS, AK, PRUSVI, HAWAII'
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'version',
        description: |||
          This is the fifth version of the TCC product released in the MRLC consortium 
          that is part of the National Land Cover Database (NLCD)'
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'startYear',
        description: |||
          'Start year of the product'
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'endYear',
        description: |||
          'End year of the product'
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'year',
        description: |||
          'Year of the product'
        |||,
        type: ee_const.var_type.int,
      },
    ],
    gsd: [30],
    'eo:bands': [
      {
        name: 'Science_Percent_Tree_Canopy_Cover',
        description: |||
          The raw direct model outputs. Each pixel has a mean predicted tree canopy 
          cover value for each year.
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'Science_Percent_Tree_Canopy_Cover_Standard_Error',
        description: |||
          The standard deviation of the predicted values from all regression trees we refer 
          to as standard error. Each pixel has a standard error for each year.
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'NLCD_Percent_Tree_Canopy_Cover',
        description: |||
          To produce NLCD tree canopy cover, a post-processing workflow is applied to the direct 
          model output that identifies and sets non-treed pixel values to zero percent 
          tree canopy cover. 
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'data_mask',
        description: |||
          Three values representing areas of no data, mapped tree canopy cover, and non-processing area. 
          The non-processing area is where pixels within the study area have no cloud or cloud shadow-free 
          data available to produce an output.
        |||,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Three values representing areas of no data, mapped tree canopy cover, and non-processing area.',
              bit_count: 2,
              values: [
                {
                  description: 'No data',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Mapped tree canopy cover',
                },
                {
                  value: 2,
                  description: 'Non-processing area',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 2,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'tccViz',
        lookat: {
          lat: 37.09024,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              100.0,
            ],
            palette: [
              'CDA066',
              'D7C29E',
              'C2D096',
              'B7D692',
              'ADDD8E',
              '78C679',
              '5CB86B',
              '41AB5D',
              '39A156',
              '329750',
              '238443',
              '11763D',
              '006837',
              '004529'
            ],
            bands: [
              'Science_Percent_Tree_Canopy_Cover',
            ],
          },
        },
      },
      {
        display_name: 'seViz',
        lookat: {
          lat: 37.09024,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              4000.0,
            ],
            palette: [
              '000000',
              'FFFFFF',
            ],
            bands: [
              'Science_Percent_Tree_Canopy_Cover_Standard_Error',
            ],
          },
        },
      },
      {
        display_name: 'nlcdViz',
        lookat: {
          lat: 37.09024,
          lon: -95.712891,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              100.0,
            ],
            palette: [
              'CDA066',
              'D7C29E',
              'C2D096',
              'B7D692',
              'ADDD8E',
              '78C679',
              '5CB86B',
              '41AB5D',
              '39A156',
              '329750',
              '238443',
              '11763D',
              '006837',
              '004529'
            ],
            bands: [
              'NLCD_Percent_Tree_Canopy_Cover',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    USDA Forest Service. 2025. USFS Tree Canopy Cover v2023.5
    (Conterminous United States and Outer Conterminous United States).
    Salt Lake City, Utah.
  |||,
   'sci:publications': [
      {
        citation: |||
          Breiman, L., 2001.
          Random Forests. In Machine Learning. Springer,
          45: 5-32
          [doi:10.1023/A:1010933404324](https://doi.org/10.1023/A:1010933404324)
        |||,
          doi:'10.1023/A:1010933404324',
      },
      {
        citation: |||
          Chastain, R., Housman, I., Goldstein, J., Finco, M., and Tenneson, K., 2019.
          Empirical cross sensor comparison of Sentinel-2A and 2B MSI, Landsat-8 OLI, and Landsat-7 ETM
          top of atmosphere spectral characteristics over the conterminous United States. In Remote
          Sensing of Environment. Science Direct,
          221: 274-285
          [doi:10.1016/j.rse.2018.11.012](https://doi.org/10.1016/j.rse.2018.11.012)
        |||,
          doi:'10.1016/j.rse.2018.11.012',
      },
      {
        citation: |||
          Cohen, W. B., Yang, Z., Healey, S. P., Kennedy, R. E., and Gorelick, N., 2018.
          A LandTrendr multispectral ensemble for forest disturbance detection. In Remote Sensing of
          Environment. Science Direct,
          205: 131-140
          [doi:10.1016/j.rse.2017.11.015](https://doi.org/10.1016/j.rse.2017.11.015)
        |||,
        doi:'10.1016/j.rse.2017.11.015',
      },
      {
        citation: |||
          Foga, S., Scaramuzza, P.L., Guo, S., Zhu, Z., Dilley, R.D., Beckmann,
          T., Schmidt, G.L., Dwyer, J.L., Hughes, M.J., Laue, B., 2017. Cloud
          detection algorithm comparison and validation for operational Landsat data
          products. In Remote Sensing of Environment.  Science Direct, 194: 379-390
          [doi:10.1016/j.rse.2017.03.026](http://doi.org/10.1016/j.rse.2017.03.026)
        |||,
        doi:'10.1016/j.rse.2017.03.026',
      },
      {
        citation: |||
          Kennedy, R. E., Yang, Z., and Cohen, W. B., 2010.
          Detecting trends in forest disturbance and recovery using yearly Landsat time series: 1.
          LandTrendr - Temporal segmentation algorithms. In Remote Sensing of Environment. Science Direct,
          114(12): 2897-2910
          [doi:10.1016/j.rse.2010.07.008](https://doi.org/10.1016/j.rse.2010.07.008)
        |||,
        doi:'10.1016/j.rse.2010.07.008',
      },
      {
        citation: |||
          Kennedy, R., Yang, Z., Gorelick, N., Braaten, J., Cavalcante, L., Cohen, W., and Healey, S., 2018.
          Implementation of the LandTrendr Algorithm on Google Earth Engine. In Remote Sensing. MDPI,
          10(5): 691
          [doi:10.3390/rs10050691](https://doi.org/10.3390/rs10050691)
        |||,
        doi:'10.3390/rs10050691',
      },
      {
        citation: |||
          Lin, L.; Di, L.; Zhang, C.; Guo, L.; Di, Y.; Li, H.; Yang, A. 2022. Validation and refinement of cropland
          data layer using a spatial-temporal decision tree algorithm. Scientific Data. 9(1): 63.
          [doi:10.3390/rs10050691](https://doi.org/10.1038/s41597-022-01169-w)
        |||,
        doi:'10.1038/s41597-022-01169-w',
      },
      {
        citation: |||
          Pasquarella, V. J., Brown, C. F., Czerwinski, W., and Rucklidge, W. J., 2023. 
          Comprehensive Quality Assessment of Optical Satellite Imagery Using 
          Weakly Supervised Video Learning. In Proceedings of the IEEE/CVF Conference 
          on Computer Vision and Pattern Recognition. 2124-2134. 
          [doi:10.1109/cvprw59228.2023.00206](https://doi.org/10.1109/cvprw59228.2023.00206)
        |||,
        doi:'10.3390/rs10050691',
      },
      {
        citation: |||
          Sentinel-Hub, 2021.
          Sentinel 2 Cloud Detector. [Online].
          Available at: [https://github.com/sentinel-hub/sentinel2-cloud-detector](https://github.com/sentinel-hub/sentinel2-cloud-detector)
        |||,
      },
      {
        citation: |||
            U.S. Geological Survey, 2019. USGS 3D Elevation Program Digital Elevation 
            Model, accessed August 2022 at https://developers.google.com/earth-engine/datasets/catalog/USGS_3DEP_10m
        |||,
      },
      {
        citation: |||
            Zhu, Z., and Woodcock, C. E., 2012. 
            Object-based cloud and cloud shadow detection in Landsat imagery. In Remote Sensing of
            Environment. Science Direct, 
            118: 83-94
            [doi:10.1016/j.rse.2011.10.028](https://doi.org/10.1016/j.rse.2011.10.028)
        |||,
        doi:'10.1016/j.rse.2011.10.028',
      },
   ],

  'gee:terms_of_use': |||
    The USDA Forest Service makes no warranty, expressed or implied, including the warranties of
    merchantability and fitness for a particular purpose, nor assumes any legal liability or
    responsibility for the accuracy, reliability, completeness or utility of these geospatial data,
    or for the improper or incorrect use of these geospatial data. These geospatial data and
    related maps or graphics are not legal documents and are not intended to be used as such. The
    data and maps may not be used to determine title, ownership, legal descriptions or boundaries,
    legal jurisdiction, or restrictions that may be in place on either public or private land.
    Natural hazards may or may not be depicted on the data and maps, and land users should exercise
    due caution. The data are dynamic and may change over time. The user is responsible to verify
    the limitations of the geospatial data and to use the data accordingly.

    These data were collected using funding from the U.S. Government and can be used
    without additional permissions or fees. If you use these data in a publication, presentation, or
    other research product please use the following citation:

    USDA Forest Service. 2025. USFS Tree Canopy Cover v2023.5
    (Conterminous United States and Outer Conterminous United States). Salt Lake City, Utah.
  |||,
  'gee:user_uploaded': true,
}
