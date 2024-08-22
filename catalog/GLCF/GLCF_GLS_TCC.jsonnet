local id = 'GLCF/GLS_TCC';
local successor_id = 'NASA/MEASURES/GFCC/TC/v3';
local subdir = 'GLCF';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

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
  title: 'GLCF: Landsat Tree Cover Continuous Fields [deprecated]',
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Landsat Vegetation Continuous Fields (VCF) tree cover layers contain
    estimates of the percentage of horizontal ground in each 30-m pixel covered
    by woody vegetation greater than 5 meters in height. The data represent
    three nominal epochs, 2000, 2005 and 2010, compiled from the NASA/USGS
    Global Land Survey (GLS) collection of Landsat data. The product is derived
    from all seven bands of Landsat-5 Thematic Mapper (TM) and/or Landsat-7
    Enhanced Thematic Mapper Plus (ETM+), depending on the GLS image selection.

    Tree cover, the proportional, vertically projected area of vegetation
    (including leaves, stems, branches, etc.) of woody plants above a given
    height, affects terrestrial energy and water exchanges, photosynthesis and
    transpiration, net primary production, and carbon and nutrient fluxes. Tree
    cover also affects habitat quality and movements of wildlife, residential
    property value for humans, and other ecosystem services. The continuous
    classification scheme of the VCF product enables better depiction of land
    cover gradients than traditional discrete classification schemes.
    Importantly for detection and monitoring of forest changes (e.g.,
    deforestation and degradation), tree cover provides a measurable attribute
    upon which to define forest cover and its changes. Changes in tree cover
    over time can be used to monitor and retrieve site-specific histories of
    forest change.

    The dataset has been produced for three year epochs: 2000, 2005, 2010, with
    an image in the collection for each available WRS2 path/row.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.successor(
        successor_id, ee_const.catalog_base + 'NASA/NASA_MEASURES_GFCC_TC_v3.json'),
  ],
  keywords: [
    'forest',
    'glcf',
    'landsat_derived',
    'nasa',
    'umd',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MEaSUREs/GFCC/GFCC30TC.003'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2010-12-31T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'path',
        description: 'Path',
        type: ee_const.var_type.double,
      },
      {
        name: 'pathrow',
        description: 'Path and row',
        type: ee_const.var_type.string,
      },
      {
        name: 'row',
        description: 'Row',
        type: ee_const.var_type.double,
      },
      {
        name: 'sources',
        description: 'Sources',
        type: ee_const.var_type.double,
      },
      {
        name: 'tree_canopy_cover_class_palette',
        description: 'Tree canopy cover class palette',
        type: ee_const.var_type.double,
      },
      {
        name: 'tree_canopy_cover_class_values',
        description: 'Tree canopy cover class values',
        type: ee_const.var_type.double,
      },
      {
        name: 'year',
        description: 'Year',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      30.0,
    ],
    platform: [
      'Landsat-5',
      'Landsat-7',
    ],
    instruments: [
      'ETM+',
      'TM',
    ],
    'eo:bands': [
      {
        name: 'tree_canopy_cover',
        description: 'The percentage of pixel area covered by trees.',
        'gee:units': units.percent,
      },
      {
        name: 'uncertainty',
        description: 'RMSE for tree-canopy_cover',
      },
      {
        name: 'source_index',
        description: |||
          Identity of source image used for the particular pixel. This is an index
          into the per image metadata array 'sources'.
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Tree Canopy Cover',
        lookat: {
          lat: -88.6,
          lon: 26.4,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              100.0,
            ],
            palette: ['ffffff', 'afce56', '5f9c00', '0e6a00', '003800'],
            bands: [
              'tree_canopy_cover',
            ],
          },
        },
      },
    ],
    tree_canopy_cover: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Data citation: Tree Canopy Cover, {Year, ...}, Global Land Cover Facility.
  |||,
  'sci:publications': [
    {
      citation: |||
        Paper/Methods Citation: Sexton, J. O., Song, X.-P., Feng, M., Noojipady,
        P., Anand, A., Huang, C., Kim, D.-H., Collins, K.M., Channan, S.,
        DiMiceli, C., Townshend, J.R.G. (2013). Global, 30-m resolution
        continuous fields of tree cover: Landsat-based rescaling of MODIS
        Vegetation Continuous Fields with lidar-based estimates of error.
        International Journal of Digital Earth, 130321031236007.
        [doi:10.1080/17538947.2013.786146](https://doi.org/10.1080/17538947.2013.786146).
      |||,
      doi: '10.1080/17538947.2013.786146',
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 5,
  },
  'gee:terms_of_use': |||
    Intellectual property rights to this dataset belong to
    University of Maryland, Department of Geographical Sciences and NASA. Usage
    is free if acklowedgement is made.
  |||,
  version: ee_const.version_unknown,
}
