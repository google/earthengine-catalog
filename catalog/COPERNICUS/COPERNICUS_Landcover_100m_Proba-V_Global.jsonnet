local id = 'COPERNICUS/Landcover/100m/Proba-V/Global';
local successor_id = 'COPERNICUS/Landcover/100m/Proba-V-C3/Global';
local subdir = 'COPERNICUS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local successor_basename = std.strReplace(successor_id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Copernicus Global Land Cover Layers: CGLS-LC100 Collection 2 [deprecated]',
  version: 'V2.02',
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Copernicus Global Land Service (CGLS) is earmarked as a component of
    the Land service to operate a multi-purpose service component that provides
    a series of bio-geophysical products on the status and evolution of land
    surface at global scale.

    The Dynamic Land Cover map at 100 m resolution (CGLS-LC100) is a new product
    in the portfolio of the CGLS and delivers a global land cover map at 100 m
    spatial resolution. The CGLS Land Cover product provides a primary land
    cover scheme. Next to these discrete classes, the product also includes
    continuous field layers for all basic land cover classes that provide
    proportional estimates for vegetation/ground cover for the land cover types.
    This continuous classification scheme may depict areas of heterogeneous
    land cover better than the standard classification scheme and, as such,
    can be tailored for application use (e.g. forest monitoring, crop monitoring,
    biodiversity and conservation, monitoring environment and security in Africa,
    climate modelling, etc.).

    This Land Cover map is provided for the 2015 reference year over
    the entire Globe, derived from the PROBA-V 100 m time-series, a database
    of high quality land cover training sites and several ancillary datasets,
    reaching an accuracy of 80 % at Level1.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.successor(
        successor_id, catalog_subdir_url + successor_basename + '.json'),
    {
      rel: ee_const.rel.source,
      href: 'https://lcviewer.vito.be/download',
    },
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5281/zenodo.3243509',
    },
  ],
  keywords: [
    'copernicus',
    'eea',
    'esa',
    'eu',
    'landcover',
    'proba',
    'probav',
    'vito',
  ],
  providers: [
    ee.producer_provider('Copernicus', 'https://land.copernicus.eu/global/lcviewer'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2015-01-01T00:00:00Z', '2015-01-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'discrete_classification_class_names',
        description: 'Land cover class names',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'discrete_classification_class_palette',
        description: 'Land cover class palette',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'discrete_classification_class_values',
        description: 'Value of the land cover classification.',
        type: ee_const.var_type.int_list,
      },
      {
        name: 'forest_type_class_names',
        description: 'forest cover class names',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'forest_type_class_palette',
        description: 'forest cover class palette',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'forest_type_class_values',
        description: 'forest cover class values',
        type: ee_const.var_type.int_list,
      },
    ],
    gsd: [
      100.0,
    ],
    'eo:bands': [
      {
        name: 'discrete_classification',
        description: 'Land cover classification',
        'gee:classes': [
          {
            color: '282828',
            description: 'Unknown. No or not enough satellite data available.',
            value: 0,
          },
          {
            value: 20,
            color: 'FFBB22',
            description: |||
              Shrubs. Woody perennial plants with persistent and woody stems
              and without any defined main stem being less than 5 m tall. The
              shrub foliage can be either evergreen or deciduous.
            |||,
          },
          {
            value: 30,
            color: 'FFFF4C',
            description: |||
              Herbaceous vegetation. Plants without persistent stem or shoots above ground
              and lacking definite firm structure. Tree and shrub cover is less
              than 10 %.
            |||,
          },
          {
            value: 40,
            color: 'F096FF',
            description: |||
              Cultivated and managed vegetation / agriculture. Lands covered with temporary crops followed by harvest
              and a bare soil period (e.g., single and multiple cropping systems).
              Note that perennial woody crops will be classified as the appropriate
              forest or shrub land cover type.
            |||,
          },
          {
            value: 50,
            color: 'FA0000',
            description: 'Urban / built up. Land covered by buildings and other man-made structures.',
          },
          {
            value: 60,
            color: 'B4B4B4',
            description: |||
              Bare / sparse vegetation. Lands with exposed soil, sand, or rocks and never has
              more than 10 % vegetated cover during any time of the year.
            |||,
          },
          {
            value: 70,
            color: 'F0F0F0',
            description: 'Snow and ice. Lands under snow or ice cover throughout the year.',
          },
          {
            value: 80,
            color: '0032C8',
            description: 'Permanent water bodies. Lakes, reservoirs, and rivers. Can be either fresh or salt-water bodies.',
          },
          {
            value: 90,
            color: '0096A0',
            description: |||
              Herbaceous wetland. Lands with a permanent mixture of water and herbaceous
              or woody vegetation. The vegetation can be present in either salt,
              brackish, or fresh water.
            |||,
          },
          {
            value: 100,
            color: 'FAE6A0',
            description: 'Moss and lichen.',
          },
          {
            value: 111,
            color: '58481F',
            description: |||
              Closed forest, evergreen needle leaf. Tree canopy >70 %, almost all needle leaf trees remain
              green all year. Canopy is never without green foliage.
            |||,
          },
          {
            value: 112,
            color: '009900',
            description: |||
              Closed forest, evergreen broad leaf. Tree canopy >70 %, almost all broadleaf trees remain
              green year round. Canopy is never without green foliage.
            |||,
          },
          {
            value: 113,
            color: '70663E',
            description: |||
              Closed forest, deciduous needle leaf. Tree canopy >70 %, consists of seasonal needle leaf
              tree communities with an annual cycle of leaf-on and leaf-off
              periods.
            |||,
          },
          {
            value: 114,
            color: '00CC00',
            description: |||
              Closed forest, deciduous broad leaf. Tree canopy >70 %, consists of seasonal broadleaf
              tree communities with an annual cycle of leaf-on and leaf-off periods.
            |||,
          },
          {
            value: 115,
            color: '4E751F',
            description: 'Closed forest, mixed.',
          },
          {
            value: 116,
            color: '007800',
            description: 'Closed forest, not matching any of the other definitions.',
          },
          {
            value: 121,
            color: '666000',
            description: |||
              Open forest, evergreen needle leaf. Top layer- trees 15-70 % and second layer- mixed of shrubs
              and grassland, almost all needle leaf trees remain green all year.
              Canopy is never without green foliage.
            |||,
          },
          {
            value: 122,
            color: '8DB400',
            description: |||
              Open forest, evergreen broad leaf. Top layer- trees 15-70 % and second layer- mixed of shrubs
              and grassland, almost all broadleaf trees remain green year round.
              Canopy is never without green foliage.
            |||,
          },
          {
            value: 123,
            color: '8D7400',
            description: |||
              Open forest, deciduous needle leaf. Top layer- trees 15-70 % and second layer- mixed of shrubs
              and grassland, consists of seasonal needle leaf tree communities with
              an annual cycle of leaf-on and leaf-off periods.
            |||,
          },
          {
            value: 124,
            color: 'A0DC00',
            description: |||
              Open forest, deciduous broad leaf. Top layer- trees 15-70 % and second layer- mixed of shrubs
              and grassland, consists of seasonal broadleaf tree communities with
              an annual cycle of leaf-on and leaf-off periods.
            |||,
          },
          {
            value: 125,
            color: '929900',
            description: 'Open forest, mixed.',
          },
          {
            value: 126,
            color: '648C00',
            description: 'Open forest, not matching any of the other definitions.',
          },
          {
            value: 200,
            color: '000080',
            description: 'Oceans, seas. Can be either fresh or salt-water bodies.',
          },
        ],
      },
      {
        name: 'discrete_classification-proba',
        description: 'Quality indicator (classification probability) of the discrete classification',
        'gee:units': units.percent,
      },
      {
        name: 'forest_type',
        description: 'Forest type for all pixels with tree percentage vegetation cover bigger than 1 %',
        'gee:classes': [
          {
            color: '282828',
            description: 'Unknown',
            value: 0,
          },
          {
            value: 1,
            color: '666000',
            description: 'Evergreen needle leaf',
          },
          {
            value: 2,
            color: '009900',
            description: 'Evergreen broad leaf',
          },
          {
            value: 3,
            color: '70663E',
            description: 'Deciduous needle leaf',
          },
          {
            value: 4,
            color: 'A0DC00',
            description: 'Deciduous broad leaf',
          },
          {
            value: 5,
            color: '929900',
            description: 'Mix of forest types',
          },
        ],
      },
      {
        name: 'bare-coverfraction',
        description: 'Percent vegetation cover for bare-sparse-vegetation land cover class',
        'gee:units': units.percent,
      },
      {
        name: 'crops-coverfraction',
        description: 'Percent vegetation cover for cropland land cover class',
        'gee:units': units.percent,
      },
      {
        name: 'grass-coverfraction',
        description: 'Percent vegetation cover for herbaceous vegetation land cover class',
        'gee:units': units.percent,
      },
      {
        name: 'moss-coverfraction',
        description: 'Percent vegetation cover for moss and lichen land cover class',
        'gee:units': units.percent,
      },
      {
        name: 'shrub-coverfraction',
        description: 'Percent vegetation cover for shrubland land cover class',
        'gee:units': units.percent,
      },
      {
        name: 'tree-coverfraction',
        description: 'Percent vegetation cover for forest land cover class',
        'gee:units': units.percent,
      },
      {
        name: 'snow-coverfraction',
        description: 'Percent ground cover for snow and ice land cover class',
        'gee:units': units.percent,
      },
      {
        name: 'urban-coverfraction',
        description: 'Percent ground cover for built-up land cover class',
        'gee:units': units.percent,
      },
      {
        name: 'water-permanent-coverfraction',
        description: 'Percent ground cover for permanent water land cover class',
        'gee:units': units.percent,
      },
      {
        name: 'water-seasonal-coverfraction',
        description: 'Percent ground cover for seasonal water land cover class',
        'gee:units': units.percent,
      },
      {
        name: 'data-density-indicator',
        description: 'Data density indicator for algorithm input data',
      },
      {
        name: 'bare-coverfraction-stddev',
        description: 'Quality indicator (std. dev.) of the bare-sparse-vegetation regression',
        'gee:units': units.percent,
      },
      {
        name: 'crops-coverfraction-stddev',
        description: 'Quality indicator (std. dev.) of the cropland regression',
        'gee:units': units.percent,
      },
      {
        name: 'grass-coverfraction-stddev',
        description: 'Quality indicator (std. dev.) of the herbaceous vegetation regression',
        'gee:units': units.percent,
      },
      {
        name: 'moss-coverfraction-stddev',
        description: 'Quality indicator (std. dev.) of the moss and lichen regression',
        'gee:units': units.percent,
      },
      {
        name: 'shrub-coverfraction-stddev',
        description: 'Quality indicator (std. dev.) of the shrubland regression',
        'gee:units': units.percent,
      },
      {
        name: 'tree-coverfraction-stddev',
        description: 'Quality indicator (std. dev.) of the forest regression',
        'gee:units': units.percent,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Land Cover',
        lookat: {
          lat: 26.4,
          lon: -88.6,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'discrete_classification',
            ],
          },
        },
      },
    ],
    discrete_classification: {
      minimum: 0.0,
      maximum: 200.0,
      'gee:estimated_range': false,
    },
    'discrete_classification-proba': {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    forest_type: {
      minimum: 0.0,
      maximum: 5.0,
      'gee:estimated_range': false,
    },
    'bare-coverfraction': {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    'crops-coverfraction': {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    'grass-coverfraction': {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    'moss-coverfraction': {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    'shrub-coverfraction': {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    'tree-coverfraction': {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    'snow-coverfraction': {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    'urban-coverfraction': {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    'water-permanent-coverfraction': {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    'water-seasonal-coverfraction': {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    'data-density-indicator': {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    'bare-coverfraction-stddev': {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    'crops-coverfraction-stddev': {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    'grass-coverfraction-stddev': {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    'moss-coverfraction-stddev': {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    'shrub-coverfraction-stddev': {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    'tree-coverfraction-stddev': {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
  },
  'sci:doi': '10.5281/zenodo.3243509',
  'sci:citation': |||
    Buchhorn, M. ; Smets, B. ; Bertels, L. ; Lesiv, M. ; Tsendbazar, N. - E. ; Herold, M. ;
    Fritz, S. Copernicus Global Land Service: Land Cover 100m: epoch 2015: Globe. Dataset of the
    global component of the Copernicus Land Monitoring Service 2019.
    [doi:10.5281/zenodo.3243509](https://doi.org/10.5281/zenodo.3243509)
  |||,
  'gee:terms_of_use': |||
    As official product of the global component of the Copernicus Land Service,
    access to this land cover dataset is fully free and open to all users.
  |||,
  'gee:user_uploaded': true,
}
