local id = 'projects/malariaatlasproject/assets/LST_Night_v061/1km/Monthly';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/LST_Night_monthly_versions.libsonnet';

local subdir = 'malariaatlasproject';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.cc_by_nc_sa_4_0;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'LST Night: Malaria Atlas Project Gap-Filled Nighttime Land Surface Temperature (Monthly 1km)',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Nighttime Land Surface Temperature (LST) are derived from the ~1km MODIS [MOD11A2 v6.1](https://lpdaac.usgs.gov/products/mod11a2v061/) products.
    The 8-daily composites are converted to degrees Celsius and then gap-filled using the approach outlined in [Weiss et al (2014)](https://doi.org/10.1016/j.isprsjprs.2014.10.001) 
    to eliminate missing data caused by factors such as cloud cover. 
    After gap-filling the data was clipped to thresholds of [-100, 100] to ensure valid values.  

    The gap-filled 8-daily ~1km outputs are then aggregated temporally to produce monthly and annual products.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  'gee:categories': ['climate'],
  keywords: [
    'map',
    'lst', 'surface_temperature'
  ],
  providers: [
    ee.producer_provider('The Malaria Atlas Project', 'https://www.malariaatlas.org'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2001-03-01T00:00:00Z' , null),
  summaries: {
    gsd: [
      5000.0,
    ],
    'eo:bands': [
      {
        name: 'Mean',
        description: 'The mean value of nighttime land surface temperature for each aggregated pixel.',
        
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Nighttime Land Surface Temperature',
        lookat: {
          lat: 26.4,
          lon: -88.6,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [-20.0],
            max: [50.0],
            palette: ['800080','0000ab','0000ff','008000','19ff2b','a8f7ff','ffff00','d6d600','ffa500','ff6b01','ff0000'],
            bands: [
              'Mean',
            ],
          },
        },
      },
    ],
    Mean: {
      minimum: -74.03,
      maximum: 63.87,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Weiss, D.J., P.M. Atkinson, S. Bhatt, B. Mappin, S.I. Hay & P.W. Gething
    (2014) An effective approach for gap-filling continental scale remotely
    sensed time-series. ISPRS Journal of Photogrammetry and Remote Sensing,
    98, 106-118. 
    [doi:10.1016/j.isprsjprs.2014.10.001](https://doi.org/10.1016/j.isprsjprs.2014.10.001)
  |||,
  
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:unusual_terms_of_use': true,
}
