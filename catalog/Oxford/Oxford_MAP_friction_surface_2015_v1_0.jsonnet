local id = 'Oxford/MAP/friction_surface_2015_v1_0';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/friction_surface_versions.libsonnet';

local subdir = 'Oxford';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.cc_by_4_0;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Global Friction Surface 2015 [deprecated]',
  version: version,
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image,
  description: |||
    This global friction surface enumerates land-based travel
    speed for all land pixels between 85 degrees north and 60 degrees
    south for a nominal year 2015.

    This map was produced through
    a collaboration between the University of Oxford Malaria Atlas
    Project (MAP), Google, the European Union Joint Research Centre
    (JRC), and the University of Twente, Netherlands. The underlying
    datasets used to produce the map include roads (comprising the
    first ever global-scale use of Open Street Map and Google roads
    datasets), railways, rivers, lakes, oceans, topographic conditions
    (slope and elevation), landcover types, and national borders.

    These datasets were each allocated a speed or speeds of travel in terms
    of time to cross each pixel of that type. The datasets were then
    combined to produce this &ldquo;friction surface&rdquo;, a map
    where every pixel is allocated a nominal overall speed of travel
    based on the types occurring within that pixel, with the fastest
    travel mode intersecting the pixel being used to determine the
    speed of travel in that pixel (with some exceptions such as national
    boundaries, which have the effect of imposing a travel time penalty).

    This map represents the travel speed from this allocation process, expressed
    in units of minutes required to travel one meter. It forms the
    underlying dataset behind the global accessibility map described
    in the referenced paper.

    'Source dataset credits are as described in the accompanying paper.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'accessibility',
    'friction',
    'jrc',
    'map',
    'oxford',
    'twente',
  ],
  providers: [
    ee.producer_provider('Malaria Atlas Project', 'https://malariaatlas.org/research-project/accessibility-to-cities/'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -60.0, 180.0, 85.0,
                    '2015-01-01T00:00:00Z', '2016-01-01T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'friction',
        description: 'Land-based travel speed.',
        'gee:units': 'minutes/meter',
        gsd: 927.67,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Land-based travel speed',
        lookat: {
          lat: 22.92,
          lon: 104.77,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              0.2,
            ],
            gamma: [
              1.6,
            ],
            bands: [
              'friction',
            ],
          },
        },
      },
    ],
    friction: {
      minimum: 0.0005,
      maximum: 87.307472,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    D.J. Weiss, A. Nelson, H.S. Gibson, W. Temperley, S. Peedell, A.
    Lieber, M. Hancher, E. Poyart, S. Belchior, N. Fullman, B. Mappin,
    U. Dalrymple, J. Rozier, T.C.D. Lucas, R.E. Howes, L.S. Tusting,
    S.Y. Kang, E. Cameron, D. Bisanzio, K.E. Battle, S. Bhatt, and
    P.W. Gething. A global map of travel time to cities to assess inequalities
    in accessibility in 2015. Nature (2018).
    [doi:10.1038/nature25181](https://doi.org/10.1038/nature25181)
  |||,
  'gee:terms_of_use': |||
    This work is licensed under a [Creative Commons Attribution
    4.0 International License](https://creativecommons.org/licenses/by/4.0/).
  |||,
  'gee:user_uploaded': true,
}
