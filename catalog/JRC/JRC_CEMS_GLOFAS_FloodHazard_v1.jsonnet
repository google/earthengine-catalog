local id = 'JRC/CEMS_GLOFAS/FloodHazard/v1';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/jrc_cems_glofas_floodhazard_versions.libsonnet';

local subdir = 'JRC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local version_config = versions(subdir, version_table, id);
local version = version_config.version;

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
  title: 'JRC Global River Flood Hazard Maps Version 1 [deprecated]',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  'gee:status': 'deprecated',
  description: |||
    The global river flood hazard maps are a gridded data set representing
    inundation along the river network, for seven different flood return periods
    (from 1-in-10-years to 1-in-500-years). The input river flow data for the
    new maps are produced by means of the open-source hydrological model
    LISFLOOD, while inundation simulations are performed with the hydrodynamic
    model LISFLOOD-FP. The extent comprises the entire world with the exception
    of Greenland and Antarctica and small islands with river basins smaller than
    500 km^2.

    Cell values indicate water depth (in meters). The maps can be used to assess
    the exposure of population and economic assets to river floods, and to
    perform flood risk assessments. The dataset is created as part of the
    Copernicus Emergency Management Service.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  'gee:categories': ['surface-ground-water'],
  keywords: [
    'flood',
    'monitoring',
    'wri',
  ],
  providers: [
    ee.producer_provider('Joint Research Centre', 'https://data.jrc.ec.europa.eu/dataset/jrc-floods-floodmapgl_rp50y-tif'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2024-03-16T00:00:00Z', '2024-03-16T23:59:59Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'return_period',
        description: |||
          Return period of flood in years.

          Note: This property is not present for images that just show the
          permanent water bodies.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'id',
        description: |||
          Unique identifier for the latitude/longitude grid cell.
        |||,
        type: ee_const.var_type.int,
      },
    ],
    gsd: [
      1000.0,
    ],
    'eo:bands': [
      {
        name: 'depth',
        description: 'Flood inundation depth',
        'gee:units': units.meter,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'JRC Flood Hazard Maps',
        lookat: {
          lon: -86.47,
          lat: 47.28,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              1.0,
            ],
            palette: [
              'ffffff',
              '0000ff',
            ],
            bands: [
              'depth',
            ],
          },
        },
      },
    ],
    depth: {
      minimum: 0.1,
      maximum: 9494.89,
      'gee:estimated_range': false,
    },
  },
  'gee:terms_of_use': |||
    The JRC datasets are available without restriction
    on use or distribution. For more information check
    [access rights](https://data.jrc.ec.europa.eu/access-rights/no-limitations),
  |||,
  'sci:publications': [
    {
      citation: |||
        Baugh, Calum; Colonese, Juan; D'Angelo, Claudia; Dottori, Francesco;
        Neal, Jeffrey; Prudhomme, Christel; Salamon, Peter (2024): Global river
        flood hazard maps. European Commission, Joint Research Centre (JRC)
        [Dataset] PID:
        [http://data.europa.eu/89h/jrc-floods-floodmapgl_rp50y-tif](http://data.europa.eu/89h/jrc-floods-floodmapgl_rp50y-tif)
      |||,
      doi: '10.1016/j.advwatres.2016.05.002',
    },
  ],
}
