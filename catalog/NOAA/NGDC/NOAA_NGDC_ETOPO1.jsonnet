local id = 'NOAA/NGDC/ETOPO1';
local subdir = 'NOAA/NGDC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

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
  title: 'ETOPO1: Global 1 Arc-Minute Elevation',
  'gee:type': ee_const.gee_type.image,
  description: |||
    ETOPO1 is a 1 arc-minute global relief model of Earth''s
    surface that integrates land topography and ocean bathymetry. It
    was built from numerous global and regional data sets. It contains
    two elevation bands: ice_surface and bedrock.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.source,
      href: 'https://www.ngdc.noaa.gov/mgg/global/relief/ETOPO1/data/',
    },
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7289/V5C8276M',
    },
  ],
  keywords: [
    'bathymetry',
    'bedrock',
    'dem',
    'elevation',
    'etopo1',
    'geophysical',
    'ice',
    'ngdc',
    'noaa',
    'topography',
  ],
  providers: [
    ee.producer_provider('NOAA', 'https://www.ngdc.noaa.gov/mgg/global/global.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2008-08-01T00:00:00Z', '2008-08-01T00:00:00Z'),
  summaries: {
    gsd: [
      1855.0,
    ],
    'eo:bands': [
      {
        name: 'bedrock',
        description: 'Elevation at ground level and at the base of the Antarctic and Greenland ice sheets',
        'gee:units': 'm',
      },
      {
        name: 'ice_surface',
        description: 'Elevation at ground level and at the top of the Antarctic and Greenland ice sheets',
        'gee:units': 'm',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Elevation',
        lookat: {
          lat: 25.8,
          lon: -37.62,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              -7000.0,
            ],
            max: [
              3000.0,
            ],
            palette: [
              '011de2',
              'afafaf',
              '3603ff',
              'fff477',
              'b42109',
            ],
            bands: [
              'bedrock',
            ],
          },
        },
      },
    ],
    bedrock: {
      minimum: -10898.0,
      maximum: 8271.0,
      'gee:estimated_range': true,
    },
    ice_surface: {
      minimum: -10898.0,
      maximum: 8271.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.7289/V5C8276M',
  'sci:citation': |||
    Amante, C. and B. W. Eakins, ETOPO1 1 Arc-Minute Global Relief
    Model: Procedures, Data Sources and Analysis. NOAA Technical Memorandum
    NESDIS NGDC-24, 19 pp, March 2009.
  |||,
  'gee:terms_of_use': |||
    It is not necessary to obtain written permission to
    use ETOPO1 or other NOAA products that are in the public domain,
    nor are there any fees for using them. We ask only that you cite
    NCEI as source.
  |||,
}
