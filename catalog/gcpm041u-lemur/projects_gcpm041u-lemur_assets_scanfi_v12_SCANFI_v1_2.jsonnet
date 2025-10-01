
local id = 'projects/gcpm041u-lemur/assets/scanfi_v12/SCANFI_v1_2';
local subdir = 'gcpm041u-lemur';
local version = '1.2';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.ogl_canada_2_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'SCANFI: the Spatialized CAnadian National Forest Inventory data product' + version,
  version: version,

  description: |||
    This data publication contains a set of 30m resolution raster files representing 2020 
    Canadian wall-to-wall maps of broad land cover type, forest canopy height, degree of 
    crown closure and aboveground tree biomass, along with species composition of several 
    major tree species. The Spatialized CAnadian National Forest Inventory data product (SCANFI) 
    was developed using the newly updated National Forest Inventory photo-plot dataset, which 
    consists of a regular sample grid of photo-interpreted high-resolution imagery covering all 
    of Canada’s non-arctic landmass. SCANFI was produced using temporally harmonized summer and 
    winter Landsat spectral imagery along with hundreds of tile-level regional models based on 
    a novel k-nearest neighbours and random forest imputation method.
    
    A full description of all methods and validation analyses can be found in [Guindon et al. (2024)](https://doi.org/10.1139/cjfr-2023-0118). 
    As the Arctic ecozones are outside NFI’s covered areas, the vegetation attributes in these 
    regions were predicted using a single random forest model. The vegetation attributes in these 
    arctic areas could not be rigorously validated. The "articExtrapolationArea" band identifies these zones.
    
    Data limitations:
    1. The spectral disturbances of some areas disturbed by pests are not comprehensively represented in the 
    training set, thus making it impossible to predict all defoliation cases. One such area, severely impacted by 
    the recent eastern spruce budworm outbreak, is located on the North Shore of the St-Lawrence River. These 
    forests are misrepresented in our training data, there is therefore an imprecision in the estimates.
    
    2. Attributes of open stand classes, namely shrub, herbs, rock and bryoid, are more difficult to estimate 
    through the photointerpretation of aerial images. Therefore, these estimates could be less reliable than the 
    forest attribute estimates.
    
    3. As reported in the [manuscript](https://doi.org/10.1139/cjfr-2023-0118), the uncertainty of tree species cover predictions is relatively high. This 
    is particularly true for less abundant tree species, such as ponderosa pine and tamarack. The tree species 
    layers are therefore suitable for regional and coarser scale studies. Also, the broadleaf proportion are 
    slightly underestimated in this product version.
    
    4. Our validation indicates that the areas in Yukon exhibit a notably lower R2 value. Consequently, estimates 
    within these regions are less dependable. 
    
    5. Urban areas and roads are classified as rock, according to the 2020 Agriculture and Agri-Food Canada 
    land-use classification map. Even though those areas contain mostly buildings and infrastructure, they may 
    also contain trees. Forested urban parks are usually classified as forested areas. Vegetation attributes are 
    also predicted for forested areas in agricultural regions.
    
    This dataset can also be downloaded from Canada's ["Open Government"](https://doi.org/10.23687/18e6a919-53fd-41ce-b4e2-44a9707c52dc) website.
    
    Contains information licensed under the
    [Open Government Licence - Canada](https://open.canada.ca/en/open-government-licence-canada)
  |||,
  
  

  'gee:categories': ['forest-biomass'],

  keywords: [
    'forest',
    'tree_cover',
    'canada',
  ],

  providers: [
    ee.producer_provider('NRCan', 'https://open.canada.ca/data/en/dataset/18e6a919-53fd-41ce-b4e2-44a9707c52dc'),
    ee.host_provider(self_ee_catalog_url),
  ],

  // Spatial and temporal extent.
  extent: ee.extent(-142.0, 41.0, -52.0, 84.0,
                    '2020-01-01T00:00:00Z', '2021-01-01T00:00:00Z'),

  // Summaries contain additional information specific to the dataset type.
  summaries: {
    gsd: [30],
    'eo:bands': [
      {
        name: 'biomass',
        description: 'Aboveground tree biomass: biomass derived from total merchantable volume estimates produced by provincial agencies',
        'gee:units': units.tonnes_per_hectare,
      },
      {
        name: 'closure',
        description: 'Crown closure (%): percentage of pixel covered by the tree canopy',
        'gee:units': units.percent,
      },
      {
        name: 'height',
        description: 'Height (meters): vegetation height',
        'gee:units': units.meter,
      },
      {
        name: 'nfiLandCover',
        description: 'NFI land cover class values: Land cover classes include Bryoid (1), Herbs (2), Rock (3), Shrub (4), 
                        Treed broadleaf (5), Treed conifer (6), Treed mixed (7) and  Water (8)',
        // Only for bands with enumerated values.
        'gee:classes': [
          { value: 1, color: 'e64bfa', description: 'Bryoid' },
          { value: 2, color: 'e7e56c', description: 'Herbs' },
          { value: 3, color: '000000', description: 'Rock' },
          { value: 4, color: 'bd0006', description: 'Shrub' },
          { value: 5, color: '95ea4b', description: 'Treed broadleaf' },
          { value: 6, color: '048e4e', description: 'Coniferous' },
          { value: 7, color: '16d132', description: 'Treed mixed' },
          { value: 8, color: '3be5ff', description: 'Water' },
        ],
      },
      {
        name: 'balsamFir',
        description: 'Balsam fir (%): estimated as the proportion of the canopy covered by Abies balsamea',
        'gee:units': units.percent,
      },
      {
        name: 'blackSpruce',
        description: 'Black spruce (%): estimated as the proportion of the canopy covered by Picea mariana',
        'gee:units': units.percent,
      },
      {
        name: 'douglasFir',
        description: 'Douglas fir (%): estimated as the proportion of the canopy covered by Pseudotsuga menziesii',
        'gee:units': units.percent,
      },
      {
        name: 'jackPine',
        description: 'Jack pine (%): estimated as the proportion of the canopy covered by Pinus banksiana',
        'gee:units': units.percent,
      },
      {
        name: 'lodgepolePine',
        description: 'Lodgepole pine (%): estimated as the proportion of the canopy covered by Pinus contorta',
        'gee:units': units.percent,
      },
      {
        name: 'ponderosaPine',
        description: 'Ponderosa pine (%): estimated as the proportion of the canopy covered by Pinus ponderosa',
        'gee:units': units.percent,
      },
      {
        name: 'prcB',
        description: 'Broadleaf tree cover in percentage (PrcB)',
        'gee:units': units.percent,
      },
      {
        name: 'prcC',
        description: 'Other coniferous tree cover in percentage (PrcC)',
        'gee:units': units.percent,
      },
      {
        name: 'tamarack',
        description: 'Tamarack_tree (%): estimated as the proportion of the canopy covered by Larix laricina',
        'gee:units': units.percent,
      },
      {
        name: 'whiteRedPine',
        description: 'White and red pine (%): estimated as the proportion of the canopy covered by Pinus strobus and Pinus resinosa',
        'gee:units': units.percent,
      },
 
      {
        name: 'articExtrapolationArea',
        description: 'Flag for marking Artic unreliable extrapolated pixels',
        'gee:classes': [
          {value: 1, color: '000000', description: 'Artic Extrapolation Area'},
        ],
      },
    ],

    // One or more band visualizations.
    'gee:visualizations': [
      {
        display_name: 'SCANFI Balsam Fir Percentage',
        lookat: {lon: -94, lat: 56, zoom: 5},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [100],
            palette: ['ffffff', '05ff09'],
            bands: ['balsamFir'],
          },
        },
      },
    ],
  },

  'sci:citation': |||
     Guindon L., Villemaire P., Correia D.L.P., Manka F., Lacarte S., Smiley B. 2023. 
     SCANFI: Spatialized CAnadian National Forest Inventory data product. 
     Natural Resources Canada, Canadian Forest Service, Laurentian Forestry Centre, Quebec, Canada. 
     [https://doi.org/10.23687/18e6a919-53fd-41ce-b4e2-44a9707c52dc](https://doi.org/10.23687/18e6a919-53fd-41ce-b4e2-44a9707c52dc)
     
     Guindon, L., Manka, F., Correia, D.L.P., Villemaire, P., Smiley, B., Bernier, P., Gauthier, S., Beaudoin, A., Boucher, J., and Boulanger, Y. 2024. 
     A new approach for Spatializing the Canadian National Forest Inventory (SCANFI) using Landsat dense time series. Can. J. For. Res. 
     [https://doi.org/10.1139/cjfr-2023-0118](https://doi.org/10.1139/cjfr-2023-0118)
  |||,
  
  'gee:terms_of_use': |||
    Licensed under the
    [Open Government Licence - Canada](https://open.canada.ca/en/open-government-licence-canada).
  |||,
  

  // TODO(google): Remove gee:status when the dataset is ready.
  'gee:status': 'beta',

  'gee:type': ee_const.gee_type.image,

  license: license.id,

  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
  ],

  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
