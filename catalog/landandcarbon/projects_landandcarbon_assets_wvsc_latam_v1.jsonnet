local id = 'projects/landandcarbon/assets/wvsc/latam_v1';
local subdir = 'landandcarbon';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local version = '1.0';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'Latin America Woody Vegetation Structure and Change, 2015-2024',
  version: version,

  description: |||
    This dataset represents annual woody vegetation structure and dynamics within Latin America
    from 2015 to 2024 at a medium (30 meters per pixel) spatial resolution. The dataset was created
    by the World Resources Institute (WRI) and the Global Land Analysis and Discovery (GLAD) Lab
	at the University of Maryland (UMD). The [Landsat Analysis Ready Data (ARD)](https://aws.amazon.com/marketplace/pp/prodview-elqs43227adgw) developed by the GLAD Lab 
	served as the primary input for continental mapping. For each year, we mapped woody vegetation canopy cover, 
	canopy height, and their changes. We employed state-of-the-art methods and tools such as the ARD-based annual 
	land surface phenology and change detection features, locally calibrated regression tree ensemble models 
	for annual woody vegetation structure mapping, annual tree canopy cover loss and degradation detection tools, 
	and temporal filters that improve interannual map consistency. The woody vegetation mapping and monitoring 
	methodology is described in [Potapov et al., 2019](https://doi.org/10.1016/j.rse.2019.111278), [Potapov et al., 2021](https://doi.org/10.1016/j.rse.2020.112165), and [Potapov et al., 2022](https://doi.org/10.3389/frsen.2022.856903). 
	
    We define woody vegetation canopy cover (WVCC) as a proportion of the Landsat 30-m pixel covered 
	by the vertical crown projection of trees and shrubs that are 2 meters tall or higher; the crown 
	projection includes within-crown gaps. WVCC below 10% are not included in our product. The annual 
	WVCC prediction model was calibrated using the 10-m spatial resolution woody vegetation canopy cover 
	developed using Sentinel-1 and Sentinel-2 data by [Brandt et al., 2023](https://doi.org/10.1016/j.rse.2023.113574). 
	
    The annual vegetation canopy height (WVCH) model was calibrated with data collected by two NASA spaceborne
	lidar instruments: the [Global Ecosystem Dynamics Investigation (GEDI)](https://gedi.umd.edu/) sensor onboard the International Space Station
	and the Advanced Topographic Laser Altimeter System (ATLAS) onboard the [ICESat-2](https://icesat-2.gsfc.nasa.gov/) satellite.
	Our definition of the vegetation canopy height (WVCH) is based on the calibration data and corresponds to
	the RH98 GEDI metric and the ATLAS 98% relative canopy height. The WVCH product is limited to areas with
	at least 10% canopy cover.
	
	The Woody Vegetation Structure Change (WVSC) data highlights the annual dynamics of structure variables. 
	Each pixel within an annual WVSC layer has one of the following codes:
	0.	No detected change.
	1.	WVCC/WVCH removal, which is represented by a reduction of cover and height values to zero.
	2.	WVCC degradation, which is represented by WVCC reduction and (not always) WVCH reduction.
	3.	WVCC/WVCH establishment, which is represented by the increase of cover and height from zero to ≥10% and ≥2 m, respectively.
	4.	WVCC and/or WVCH enhancement, which is represented by the increase of cover and/or height values.

	The annual dataset is available online for free, with no restrictions on access, redistribution, or use,
	as long as proper citation is given, following the Creative Commons Attribution License (CC BY). 
	
	
	**For a full description of the methods, technical specifications, and definitions, please see the publication**: 
    [https://zenodo.org/records/14231362](https://zenodo.org/records/14231362). 
	The dataset can be viewed online using the [Google Earth Engine Apps interface](https://ee-potapovpeter.projects.earthengine.app/view/wvsc-latam-v1). 
  |||, 


  'gee:categories': ['forest-biomass'],

  keywords: [
    'deforestation',
    'forest',
    'landuse',
    'wri',
	'eudr',
	'tree-cover',
	'gedi',
	'forest-biomass',
	'landandcarbon'
    ],

  providers: [
    ee.producer_provider('World Resources Institute', 'https://zenodo.org/records/14231362'),
    ee.producer_provider('Global Land Analysis and Discovery Lab', 'https://glad.umd.edu/'),
    ee.host_provider(self_ee_catalog_url),
  ],

  extent: ee.extent_global('2015-01-01T00:00:00Z', '2025-01-01T00:00:00Z'),

  summaries: {
    gsd: [30],
    'eo:bands': [
      {
        name: 'TCC',
        description: 'The woody vegetation canopy cover percentage at the Landsat 30-m pixel level.',
      },
      {
        name: 'TCH',
        description: 'Woody vegetation canopy height at the Landsat 30-m pixel scale in decimeters.',
      },      
	  {
        name: 'Change',
        description: 'Detected annual woody vegetation canopy change events.',
        'gee:classes': [
          {value: 1, color: 'C20000', description: 'Canopy cover removal (loss)'},
          {value: 2, color: 'FFB900', description: 'Canopy cover degradation (partial loss)'},
          {value: 3, color: '0800F2', description: 'Canopy cover establishment (gain)'},
          {value: 4, color: '66D964', description: 'Canopy cover enhancement (increase of cover and/or height)'},
        ],
      },
    ],

    TCC: {minimum: 0, maximum: 100, 'gee:estimated_range': false},
    TCH: {minimum: 0, maximum: 450, 'gee:estimated_range': false},
    Change: {minimum: 0, maximum: 4, 'gee:estimated_range': false},

    'gee:visualizations': [
      {
        display_name: 'Woody Vegetation Canopy Height 2024',
        lookat: {lon: -58.6727, lat: -9.7881, zoom: 12},
        image_visualization: {
          band_vis: {
            min: [20],
            max: [300],
            palette: ['8a35ac','466be3','28bceb','32f298,'a4fc3c','eecf3a','fb7e21','d02f05','7a0403'],
            bands: ['TCH'],
            }
          },  
        },
      ],
  },

  'sci:citation': |||
   Potapov, P., Brandt, J., Li, X., Turubanova, S., Hernandez-Serna, A.,
   Adzhar, R., Pascual, A., Adami, M., Dutra, A. C., Lima, A., Tyukavina,A.,
   Hansen, M. C., Reytar, K., Stolle, F., & Harris, N. 2024. 
   "Latin America Woody Vegetation Structure and Change (LAM WVSC), 2015-2023".
   Zenodo. [https://doi.org/10.5281/zenodo.14231362](https://doi.org/10.5281/zenodo.14231362)
  |||,

  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  
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
