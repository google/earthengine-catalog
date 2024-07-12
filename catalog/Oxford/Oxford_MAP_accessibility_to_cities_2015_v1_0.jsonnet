local id = 'Oxford/MAP/accessibility_to_cities_2015_v1_0';

local subdir = 'Oxford';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local license = spdx.cc_by_4_0;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'Accessibility to Cities 2015',
  'gee:type': ee_const.gee_type.image,
  description: |||
    This global accessibility map enumerates land-based
    travel time to the nearest densely-populated area for all areas
    between 85 degrees north and 60 degrees south for a nominal year 2015.

    Densely-populated areas are defined as contiguous areas
    with 1,500 or more inhabitants per square kilometer or a majority
    of built-up land cover types coincident with a population center
    of at least 50,000 inhabitants.

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
    combined to produce a &ldquo;friction surface&rdquo;, a map where
    every pixel is allocated a nominal overall speed of travel based
    on the types occurring within that pixel. Least-cost-path algorithms
    (running in Google Earth Engine and, for high-latitude areas, in
    R) were used in conjunction with this friction surface to calculate
    the time of travel from all locations to the nearest city (by travel
    time). Cities were determined using the high-density-cover product
    created by the Global Human Settlement Project.

    Each pixel in the resultant accessibility map thus represents the modeled shortest
    time from that location to a city.

    Source dataset credits are as described in the accompanying paper.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'accessibility',
    'jrc',
    'map',
    'oxford',
    'twente',
  ],
  providers: [
    ee.producer_provider('Malaria Atlas Project', 'https://malariaatlas.org/research-project/accessibility-to-cities/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -60.0, 180.0, 85.0,
                    '2015-01-01T00:00:00Z', '2016-01-01T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'accessibility',
        description: 'Travel time to the nearest densely-populated area.',
        'gee:units': units.minute,
        gsd: 927.67,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Accessibility',
        lookat: {
          lat: 6.66,
          lon: 18.98,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              41556.0,
            ],
            gamma: [
              4.0,
            ],
            bands: [
              'accessibility',
            ],
          },
        },
      },
    ],
    accessibility: {
      minimum: 0.0,
      maximum: 41556.0,
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
