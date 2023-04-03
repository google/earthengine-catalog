local id = 'UQ/murray/Intertidal/v1_1/global_intertidal';
local subdir = 'UQ';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

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
  title: 'Murray Global Intertidal Change Classification',
  version: 'v1.1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Murray Global Intertidal Change Dataset contains global maps of tidal flat
    ecosystems produced via a supervised classification of 707,528 Landsat
    Archive images. Each pixel was classified into tidal flat, permanent water
    or other with reference to a globally distributed set of training data.

    The classification was implemented along the entire global coastline
    between 60° North and 60° South from 1 January 1984 to 31 December 2016.
    The image collection consists consists of a time-series of 11 global maps
    of tidal flats at 30m pixel resolution for set time-periods (1984-1986;
    1987-1989; 1990-1992; 1993-1995; 1996-1998; 1999-2001; 2002-2004;
    2005-2007; 2008-2010; 2011-2013; 2014-2016)

    This product depicts tidal flat ecosystems around the global coastline.

    Pixels classified as tidal flat in the analysis represent several types of
    tidal flat ecosystems, including unconsolidated fine-grain sediments (tidal
    mudflats), unconsolidated coarse-grain sediments (tidal sand flats), and
    consolidated sediments, organic material or rocks (wide tidal
    rock-platforms), while excluding spectral signatures indicating the
    presence of vegetation dominated intertidal ecosystems such as mangroves
    and vegetated marshes. The analysis aimed to identify pixels that are
    subject to regular tidal inundation, and therefore may also include other
    intertidal systems where intertidal dynamics are observable.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.1038/s41586-018-0805-8',
    },
  ],
  keywords: [
    'coastal',
    'google',
    'intertidal',
    'landsat_derived',
    'murray',
    'tidal_flats',
    'uq',
  ],
  providers: [
    ee.producer_provider('Murray/UQ/Google/USGS/NASA', 'https://intertidal.app'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -60.0, 180.0, 60.0,
                    '1984-01-01T00:00:00Z', '2017-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'classification',
        description: 'Intertertidal area classification for the interval.',
        'gee:units': 'occurrence',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Intertidal area classification.',
              bit_count: 1,
              values: [
                {
                  description: 'Classified non-intertidal area',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Classified intertidal area',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Intertidal areas',
        lookat: {
          lat: 37.4394,
          lon: 126.6339,
          zoom: 10,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              1.0,
            ],
            palette: [
              '0000FF',
            ],
            bands: [
              'classification',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.1038/s41586-018-0805-8',
  'sci:citation': |||
    Murray, N.J., Phinn, S.R., DeWitt, M., Ferrari, R., Johnston, R., Lyons, M.B.,
    Clinton, N., Thau, D. & Fuller, R.A. (2019) The global distribution and
    trajectory of tidal flats. Nature, 565, 222-225.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 3,
  },
  'gee:terms_of_use': |||
    This work is licensed under a Creative Commons Attribution 4.0
    International License.

    Any use of the intertidal data must include proper acknowledgement,
    including citing the associated journal article.
  |||,
  'gee:user_uploaded': true,
}
