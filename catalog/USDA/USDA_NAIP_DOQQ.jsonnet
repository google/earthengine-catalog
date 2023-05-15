local id = 'USDA/NAIP/DOQQ';
local subdir = 'USDA';

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
  ],
  id: id,
  title: 'NAIP: National Agriculture Imagery Program',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The National Agriculture Imagery Program (NAIP) acquires aerial imagery
    during the agricultural growing seasons in the continental U.S.

    NAIP projects are contracted each year based upon available funding and the
    imagery acquisition cycle. Beginning in 2003, NAIP was acquired on
    a 5-year cycle. 2008 was a transition year, and a three-year cycle began
    in 2009.

    NAIP imagery is acquired at a one-meter ground sample distance (GSD) with a
    horizontal accuracy that matches within six meters of photo-identifiable
    ground control points, which are used during image inspection.

    Older images were collected using 3 bands (Red, Green, and Blue: RGB), but
    newer imagery is usually collected with an additional near-infrared band
    (RGBN). RGB asset ids begin with 'n_', NRG asset ids begin with 'c_', RGBN
    asset ids begin with 'm_'.

    Some older images have GSD of 2 meters.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'aerial',
    'agriculture',
    'fpac',
    'highres',
    'imagery',
    'naip',
    'usda',
  ],
  providers: [
    ee.producer_provider('USDA Farm Production and Conservation - Business Center, Geospatial Enterprise Operations', 'https://naip-usdaonline.hub.arcgis.com/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-124.84, 24.42, -64.82, 49.72,
                    '2002-06-15T00:00:00Z', null),
  summaries: {
    gsd: [
      0.6
    ],
    'eo:bands': [
      {
        name: 'R',
        description: 'Red',
        'gee:units': units.dn,
      },
      {
        name: 'G',
        description: 'Green',
        'gee:units': units.dn,
      },
      {
        name: 'B',
        description: 'Blue',
        'gee:units': units.dn,
      },
      {
        name: 'N',
        description: 'Near infrared',
        'gee:units': units.dn,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'True Color',
        lookat: {
          lat: 40.7278,
          lon: -73.9958,
          zoom: 15,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              255.0,
            ],
            bands: [
              'R',
              'G',
              'B',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': 'USDA Farm Production and Conservation - Business Center, Geospatial Enterprise Operations',
  'gee:terms_of_use': |||
    Most information presented on the FSA Web site is considered public domain
    information. Public domain information may be freely distributed or copied,
    but use of appropriate byline/photo/image credits is requested. For more
    information visit the [FSA Policies and Links](https://www.fsa.usda.gov/help/policies-and-links)
    website.

    Users should acknowledge USDA Farm Production and Conservation -
    Business Center, Geospatial Enterprise Operations when using or
    distributing this data set.
  |||,
}
