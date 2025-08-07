local id = 'projects/gcpm041u-lemur/assets/scanfi_v12/SCANFI_v1_2';
local subdir = 'NRCan_CFS_LFC';
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
    1- The spectral disturbances of some areas disturbed by pests are not comprehensively represented in the 
    training set, thus making it impossible to predict all defoliation cases. One such area, severely impacted by 
    the recent eastern spruce budworm outbreak, is located on the North Shore of the St-Lawrence River. These 
    forests are misrepresented in our training data, there is therefore an imprecision in the estimates.
    
    2- Attributes of open stand classes, namely shrub, herbs, rock and bryoid, are more difficult to estimate 
    through the photointerpretation of aerial images. Therefore, these estimates could be less reliable than the 
    forest attribute estimates.
    
    3- As reported in the [manuscript](https://doi.org/10.1139/cjfr-2023-0118), the uncertainty of tree species cover predictions is relatively high. This 
    is particularly true for less abundant tree species, such as ponderosa pine and tamarack. The tree species 
    layers are therefore suitable for regional and coarser scale studies. Also, the broadleaf proportion are 
    slightly underestimated in this product version.
    
    4- Our validation indicates that the areas in Yukon exhibit a notably lower R2 value. Consequently, estimates 
    within these regions are less dependable.
    
    5- Urban areas and roads are classified as rock, according to the 2020 Agriculture and Agri-Food Canada 
    land-use classification map. Even though those areas contain mostly buildings and infrastructure, they may 
    also contain trees. Forested urban parks are usually classified as forested areas. Vegetation attributes are 
    also predicted for forested areas in agricultural regions.
    
    This dataset can also be downloaded from Canada's ["Open Government"](https://doi.org/10.23687/18e6a919-53fd-41ce-b4e2-44a9707c52dc) website.
    
    Contains information licensed under the
    [Open Government Licence - Canada](https://open.canada.ca/en/open-government-licence-canada)
  |||,
  
  
  // One or more category keywords. For the current list, see
  // https://github.com/google/earthengine-catalog/blob/main/checker/node/gee_categories.py
  // All categories will also be added as keywords.
  'gee:categories': ['forest-biomass'],

  // Please look through the list of existing keywords and pick two or more
  // that match the dataset.
  // https://developers.google.com/earth-engine/datasets/tags
  //
  // Please avoid creating new keywords. If you feel you need to add a new one,
  // add it but comment it out.
  keywords: [
    'forest',
    'tree_cover',
    'ecosystems', 
    'landuse-landcover',
    'canada',
    //'forest attributes',
    //'tree species',
  ],

  // Who created the data.
  // Prefer https rather than http links.
  providers: [
    // There can be multiple entries of ee.producer_provider and/or
    // ee.processor_provider.
    ee.producer_provider('NRCan', 'https://open.canada.ca/data/en/dataset/18e6a919-53fd-41ce-b4e2-44a9707c52dc'),
    // This is always the last entry.
    ee.host_provider(self_ee_catalog_url),
  ],

  // Spatial and temporal extent.
  // What area and what time interval does the dataset cover?
  // Date/times must be in UTC, using the form 'YYYY-MM-DDTHH:MM:SSZ'.
  // End date is exclusive. For example, if the dataset covers the whole of
  // year 2021, the end date should be "2022-01-01T00:00:00Z"
  // Global spatial extents should use ee.extent_global.
  // extent: ee.extent_global('2006-01-24T00:00:00Z', '2011-05-13T00:00:00Z'),
  // Alternatively, non-global extents use min_x, min_y, max_x, max_y:
  extent: ee.extent(-142.0, 41.0, -52.0, 84.0,
                    '2020-01-01T00:00:00Z', '2021-01-01T00:00:00Z'),

  // Summaries contain additional information specific to the dataset type.
  summaries: {
    // Platform and instrument fields are optional and can be left out,
    // but are recommended.
    // https://github.com/radiantearth/stac-spec/blob/master/item-spec/common-metadata.md#instrument
    // Name of the ship, aircraft, spacecraft, or other collecting device.
    // platform: ['My_Satellite'],
    // Name of instrument or sensor used (e.g., MODIS, ASTER, OLI, Canon F-1).
    // instruments: ['My_Instrument'],

    // Describe all of the bands in the order they appear in an ee.Image.
    // For each band, only `name` and `description` are required.
    // If the pixel size is the same for all bands, set it here.
    // (In STAC, pixel size is called "gsd", or "ground sample distance".)
    // https://en.wikipedia.org/wiki/Ground_sample_distance
    // Value is in meters. If the pixel size is in degrees, multiply by 111,195.
    gsd: [30],
    'eo:bands': [
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
        name: 'biomass',
        description: 'Aboveground tree biomass (tons/ha): biomass derived from total merchantable volume estimates produced by provincial agencies',
        // gsd: 15,  // Pixel size (ground sample distance). Value is in meters.
                  // If the pixel size is in degrees, multiply by 111,195.
        // center_wavelength: 0.56,  // in nm
        // Note that gee:wavelength is more expressive than 'center_wavelength',
        // as it allows value ranges and units.
        // 'gee:wavelength': '0.520-0.600 &mu;m',
        // See here for predefined units and prefer those over using a custom
        // units string.
        // https://github.com/google/earthengine-catalog/blob/main/catalog/units.libsonnet
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
        name: 'articExtrapolationArea',
        description: 'Flag for marking Artic unreliable extrapolated pixels',
        // Only for bands with enumerated values.
        'gee:classes': [
          {value: 1, color: '000000', description: 'Artic Extrapolation Area'},
        ],
      },
    ],

    // Optional band statistics - one entry per band.
    // If the exact statistics are known, then set gee:estimated_range to true.
    // band_name_1: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    // band_name_2: {minimum: 0, maximum: 1e8, 'gee:estimated_range': false},
    // band_name_3: {minimum: 0, maximum: 100, 'gee:estimated_range': false},
    // band_name_4: {minimum: 0, maximum: 100, 'gee:estimated_range': false},

    // One or more band visualizations.
    'gee:visualizations': [
      // Example with one band and a palette for the colors.
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
  // The scientific extension.
  // The best DOI that describes the *data*.
  // Only use a research paper DOI if there is no dataset or data paper DOI.
  // 'sci:doi': '10.23687/18e6a919-53fd-41ce-b4e2-44a9707c52dc',
  // Use APA style for citations and publications. https://apastyle.apa.org/
  'sci:citation': |||
     Guindon L., Villemaire P., Correia D.L.P., Manka F., Lacarte S., Smiley B. 2023. 
     SCANFI: Spatialized CAnadian National Forest Inventory data product. 
     Natural Resources Canada, Canadian Forest Service, Laurentian Forestry Centre, Quebec, Canada. 
     [https://doi.org/10.23687/18e6a919-53fd-41ce-b4e2-44a9707c52dc](https://doi.org/10.23687/18e6a919-53fd-41ce-b4e2-44a9707c52dc)
     
     Guindon, L., Manka, F., Correia, D.L.P., Villemaire, P., Smiley, B., Bernier, P., Gauthier, S., Beaudoin, A., Boucher, J., and Boulanger, Y. 2024. 
     A new approach for Spatializing the Canadian National Forest Inventory (SCANFI) using Landsat dense time series. Can. J. For. Res. 
     [https://doi.org/10.1139/cjfr-2023-0118](https://doi.org/10.1139/cjfr-2023-0118)
  |||,
  
  // For standard SPDX licenses, use:
  // 'gee:terms_of_use': ee.gee_terms_of_use(license),
  // If there is a custom license (the license is set to spdx.proprietary, set
  // gee:terms_of_use to enough text that a reader has a sense of what they are
  // getting into. Be sure to add a link to the license in this Markdown text
  // and add the link to the license section with ee.link.license(url).
  'gee:terms_of_use': |||
    Licensed under the
    [Open Government Licence - Canada](https://open.canada.ca/en/open-government-licence-canada).
  |||,
  
  // The fields below generally don't need to be changed.

  // TODO(google): Remove gee:status when the dataset is ready.
  'gee:status': 'incomplete',

  // This says that the dataset is an ee.Image.
  //   https://developers.google.com/earth-engine/apidocs/ee-image
  'gee:type': ee_const.gee_type.image,

  // Files should use this line as-is. There is a local license variable at
  // the top of the file that sets the SPDX license entry.
  license: license.id,

  // The standard links cover the basic locations of the dataset, catalog
  // entries, code examples, etc.
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
  ],
  // Here are some of the other links that are sometimes needed. Add by
  // concatenating a Jsonnet array like this:
  //   links: ee.standardLinks(subdir, id) + [more links here],
  // Versions have:
  //   ee.link.latest(latest_id, latest_url),
  //   ee.link.predecessor(predecessor_id, predecessor_url),
  //   ee.link.successor(successor_id, successor_url),
  // For more link types, see earthengine.libsonnet

  // This refers to a STAC term 'collection', not to Earth Engine collections.
  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    // The EO extension is required for bands.
    ee_const.ext_eo,
    // For synthetic aperture radar (SAR)
    // ee_const.ext_sar,
    ee_const.ext_sci,
    // Include the version extension if the dataset uses any of:
    // - the deprecated fields
    // - the version fields
    // - successor link
    // - predecessor link
    // - latest link
    ee_const.ext_ver,
  ],
}
