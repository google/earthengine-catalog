local id = 'Oxford/MAP/accessibility_to_healthcare_2019';

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
  title: 'Accessibility to Healthcare 2019',
  'gee:type': ee_const.gee_type.image,
  description: |||
    This global accessibility map enumerates land-based travel time (in
    minutes) to the nearest hospital or clinic for all areas between 85
    degrees north and 60 degrees south for a nominal year 2019. It also
    includes "walking-only" travel time, using non-motorized means of
    transportation only.

    Major data collection efforts underway by OpenStreetMap, Google Maps, and
    academic researchers have been harnessed to compile the most complete
    collection of healthcare facility locations to date. This map was
    produced through a collaboration between MAP (University of Oxford),
    Telethon Kids Institute (Perth, Australia), Google, and the University
    of Twente, Netherlands.

    This project builds on previous work published by Weiss et al 2018
    ([doi:10.1038/nature25181](https://doi.org/10.1038/nature25181)).
    Weiss et al (2018) utilised datasets for roads
    (comprising the first ever global-scale use of Open Street Map and Google
    roads datasets), railways, rivers, lakes, oceans, topographic conditions
    (slope and elevation), landcover types, and national borders. These
    datasets were each allocated a speed or speeds of travel in terms of time
    to cross each pixel of that type. The datasets were then combined to
    produce a "friction surface": a map where every pixel is allocated a
    nominal overall speed of travel based on the types occurring within that
    pixel. For the current project, an updated friction surface was created to
    incorporate recent improvements within OSM roads data.

    Least-cost-path algorithms (run in Google Earth Engine and, for
    high-latitude areas, in R) were used in conjunction with this friction
    surface to calculate the time of travel from all locations to the nearest
    (in time) healthcare facility. The healthcare facilities dataset utilized
    location data from two of the largest global databases: (1) OSM data that
    was collated and made available for download at
    [www.healthsites.io](https://www.healthsites.io/); and (2) data
    extracted from Google Maps. The global datasets were augmented with
    continental-scale facility locations that were recently published for
    Africa and Australia. To facilitate comparisons between data sources, only
    facilities defined as hospitals and clinics were used. Multiple points
    found within the same pixel were merged to match the resolution of the
    analysis as defined by the selected gridded representation of the Earth's
    surface. Each pixel in the resultant accessibility map thus represents the
    modelled shortest time (in minutes) from that location to a hospital or
    clinic.

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
                    '2019-01-01T00:00:00Z', '2020-01-01T00:00:00Z'),
  summaries: {
    gsd: [927.67],
    'eo:bands': [
      {
        name: 'accessibility',
        description: 'Travel time to the nearest hospital or clinic.',
        'gee:units': units.minute,
      },
      {
        name: 'accessibility_walking_only',
        description: 'Travel time to the nearest hospital or clinic using non-motorized transport.',
        'gee:units': units.minute,
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
      maximum: 41504.1,
      'gee:estimated_range': false,
    },
    accessibility_walking_only: {
      minimum: 0.0,
      maximum: 138893.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    D.J. Weiss, A. Nelson, C.A. Vargas-Ruiz, K. Gligori&cacute;, S. Bavadekar,
    E. Gabrilovich, A. Bertozzi-Villa, J. Rozier, H.S. Gibson, T. Shekel,
    C. Kamath, A. Lieber, K. Schulman, Y. Shao, V. Qarkaxhija, A.K. Nandi,
    S.H. Keddie, S. Rumisha, E. Cameron, K.E. Battle, S. Bhatt, P.W. Gething.
    Global maps of travel time to healthcare facilities. Nature Medicine (2020).
  |||,
  'gee:terms_of_use': |||
    This work is licensed under a [Creative Commons Attribution
    4.0 International License](https://creativecommons.org/licenses/by/4.0/).
  |||,
  'gee:user_uploaded': true,
}
