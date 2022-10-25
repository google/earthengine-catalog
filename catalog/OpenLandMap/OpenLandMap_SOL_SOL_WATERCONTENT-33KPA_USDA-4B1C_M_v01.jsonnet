local id = 'OpenLandMap/SOL/SOL_WATERCONTENT-33KPA_USDA-4B1C_M/v01';
local subdir = 'OpenLandMap';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_sa_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'OpenLandMap Soil Water Content at 33kPa (Field Capacity)',
  'gee:type': ee_const.gee_type.image,
  description: |||
    Soil water content (volumetric %) for 33kPa and 1500kPa suctions
    predicted at 6 standard depths (0, 10, 30, 60, 100 and 200 cm) at 250 m resolution

    Training points are based on a global compilation of soil profiles:

    * [USDA NCSS](https://ncsslabdatamart.sc.egov.usda.gov/)
    * [AfSPDB](https://www.isric.org/projects/africa-soil-profiles-database-afsp)
    * [ISRIC WISE](https://data.isric.org/geonetwork/srv/eng/catalog.search#/metadata/a351682c-330a-4995-a5a1-57ad160e621c)
    * [EGRPR](http://egrpr.esoil.ru/)
    * [SPADE](https://esdac.jrc.ec.europa.eu/content/soil-profile-analytical-database-2)
    * [CanNPDB](https://open.canada.ca/data/en/dataset/6457fad6-b6f5-47a3-9bd1-ad14aea4b9e0)
    * [UNSODA](https://data.nal.usda.gov/dataset/unsoda-20-unsaturated-soil-hydraulic-database-database-and-program-indirect-methods-estimating-unsaturated-hydraulic-properties)
    * [SWIG](https://doi.pangaea.de/10.1594/PANGAEA.885492)
    * [HYBRAS](https://www.cprm.gov.br/en/Hydrology/Research-and-Innovation/HYBRAS-4208.html)
    * [HydroS](https://doi.org/10.4228/ZALF.2003.273)

    Data import steps are available [here](https://gitlab.com/openlandmap/compiled-ess-point-data-sets).
    Spatial prediction steps are described in detail [here](https://gitlab.com/openlandmap/global-layers/tree/master/soil/soil_water).
    Note: these are actually measured and mapped soil content values; no Pedo-Transfer-Functions
    have been used (except to fill in the missing NCSS bulk densities). Available
    water capacity in mm (derived as a difference between field capacity and wilting
    point multiplied by layer thickness) per layer is available [here](https://doi.org/10.5281/zenodo.2629148).
    Antartica is not included.

    To access and visualize maps outside of Earth Engine, use [this page](https://landgis.opengeohub.org).

    If you discover a bug, artifact or inconsistency in the LandGIS maps
    or if you have a question please use the following channels:

     *  [Technical issues and questions about the code](https://gitlab.com/openlandmap/global-layers/issues)
     *  [General questions and comments](https://disqus.com/home/forums/landgis/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5281/zenodo.2629589',
    },
  ],
  keywords: [
    'envirometrix',
    'opengeohub',
    'openlandmap',
    'soil',
    'watercontent',
  ],
  providers: [
    ee.producer_provider('EnvirometriX Ltd', 'https://doi.org/10.5281/zenodo.2629589'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1950-01-01T00:00:00Z', '2018-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      250.0,
    ],
    'eo:bands': [
      {
        name: 'b0',
        description: 'Soil water content at 33kPa (field capacity) at 0 cm depth',
        'gee:units': '%',
      },
      {
        name: 'b10',
        description: 'Soil water content at 33kPa (field capacity) at 10 cm depth',
        'gee:units': '%',
      },
      {
        name: 'b30',
        description: 'Soil water content at 33kPa (field capacity) at 30 cm depth',
        'gee:units': '%',
      },
      {
        name: 'b60',
        description: 'Soil water content at 33kPa (field capacity) at 60 cm depth',
        'gee:units': '%',
      },
      {
        name: 'b100',
        description: 'Soil water content at 33kPa (field capacity) at 100 cm depth',
        'gee:units': '%',
      },
      {
        name: 'b200',
        description: 'Soil water content at 33kPa (field capacity) at 200 cm depth',
        'gee:units': '%',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Soil water content at 33kPa (field capacity)',
        lookat: {
          lon: -5.6,
          lat: 30.7,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              52.9740182135385,
            ],
            palette: [
              'd29642',
              'eec764',
              'b4ee87',
              '32eeeb',
              '0c78ee',
              '2601b7',
              '083371',
            ],
            bands: [
              'b0',
            ],
          },
        },
      },
    ],
    b0: {
      minimum: 0.0,
      maximum: 52.9740182135385,
      'gee:estimated_range': true,
    },
    b10: {
      minimum: 0.0,
      maximum: 52.9740182135385,
      'gee:estimated_range': true,
    },
    b30: {
      minimum: 0.0,
      maximum: 52.9740182135385,
      'gee:estimated_range': true,
    },
    b60: {
      minimum: 0.0,
      maximum: 52.9740182135385,
      'gee:estimated_range': true,
    },
    b100: {
      minimum: 0.0,
      maximum: 52.9740182135385,
      'gee:estimated_range': true,
    },
    b200: {
      minimum: 0.0,
      maximum: 52.9740182135385,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.5281/zenodo.2629589',
  'sci:citation': |||
    Tomislav Hengl, & Surya Gupta. (2019). Soil water content (volumetric %) for 33kPa and 1500kPa suctions predicted at 6 standard depths (0, 10, 30, 60, 100 and 200 cm) at 250 m resolution (Version v01) [Data set]. Zenodo.
    [10.5281/zenodo.2629589](https://doi.org/10.5281/zenodo.2629589)
  |||,
  'gee:terms_of_use': 'Licensed under the Creative Commons Attribution Share Alike 4.0 International License.',
  'gee:unusual_terms_of_use': true,
  'gee:user_uploaded': true,
}
