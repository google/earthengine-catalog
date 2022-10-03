local id = 'USFS/GTAC/MTBS/annual_burn_severity_mosaics/v1';
local subdir = 'USFS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

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
  title: 'Monitoring Trends in Burn Severity (MTBS) Burn Severity Images',
  version: 'v1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The burn severity mosaics consist of thematic raster images of MTBS burn
    severity classes for all currently completed MTBS fires for the continental
    United States, Alaska, Hawaii and Puerto Rico. Mosaicked burn severity
    images are compiled annually for each year by US State and the continental
    United States.
  ||| + importstr 'mtbs_description.md',
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license('https://data.fs.usda.gov/geodata/'),
    {
      rel: ee_const.rel.source,
      href: 'https://data.fs.usda.gov/geodata/',
    },
  ],
  keywords: [
    'eros',
    'fire',
    'forest',
    'gtac',
    'landcover',
    'landsat_derived',
    // TODO(simonf): Bring back when there is more than one instance.
    // TODO(simonf): Define landscape_disturbance.  Wikipedia, Wiktionary, or ?
    // 'landscape_disturbance',
    'mtbs',
    'redcastle_resources',
    'usda',
    'usfs',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USDA Forest Service (USFS) Geospatial Technology and Applications Center (GTAC)', 'United States Geological Survey (USGS) Earth Resources Observation and Science (EROS) Center'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-135.286387, 20.38379, -56.446306, 52.459364,
                    '1984-01-01T00:00:00Z', '2021-12-31T00:00:00Z'),
  summaries: {
    'gee:properties': [
      {
        name: 'study_area',
        description: |||
          MTBS currently covers CONUS, Alaska, Puerto Rico, and Hawaii.
          Possible values: CONUS, AK, PR, HI.
        |||,
        type: ee_const.var_type.string,
      },
    ],
    'eo:bands': [
      {
        name: 'Severity',
        description: |||
          Burn severity layers are thematic images depicting severity as
          unburned to low, low, moderate, high, and increased greenness
          (increased postfire vegetation response). The layer may also have
          a sixth class representing a mask for clouds, shadows, large water
          bodies, or other features on the landscape that erroneously affect
          the severity classification.
        |||,
        gsd: 30.0,
        'gee:classes': [
          {
            value: 0,
            color: '000000',
            description: 'Background',
          },
          {
            value: 1,
            color: '006400',
            description: 'Unburned to Low',
          },
          {
            value: 2,
            color: '7FFFD4',
            description: 'Low',
          },
          {
            value: 3,
            color: 'FFFF00',
            description: 'Moderate',
          },
          {
            value: 4,
            color: 'FF0000',
            description: 'High',
          },
          {
            value: 5,
            color: '7FFF00',
            description: 'Increased Greenness'
          },
          {
            value: 6,
            color: 'FFFFFF',
            description: 'Non-Mapping Area'
          }
        ],
      }
    ],
    'gee:visualizations': [
      {
        display_name: 'Severity',
        lookat: {
          lat: 37.09,
          lon: -95.71,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              6,
            ],
            palette: [
              '000000', // background
              '006400', // unburned to low
              '7FFFD4', // low
              'FFFF00', // moderate
              'FF0000', // high
              '7FFF00', // increased greenness
              'FFFFFF'  // non mapping area
            ],
            bands: [
              'Severity',
            ],
          },
        },
      }
    ],
  },
  'sci:citation': |||
    USDA Forest Service/US Geological Survey. Monitoring Trends in Burn
    Severity Thematic Burn Severity. Salt Lake City, Utah/Sioux Falls,
    South Dakota
  |||,
  'gee:terms_of_use': importstr 'usgs_gee_terms_of_use.md',
  'gee:user_uploaded': true,
}
