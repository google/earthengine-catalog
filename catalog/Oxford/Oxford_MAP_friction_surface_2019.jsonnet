local id = 'Oxford/MAP/friction_surface_2019';
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
  title: 'Global Friction Surface 2019',
  version: version,
  'gee:type': ee_const.gee_type.image,
  description: |||
    This global friction surface enumerates land-based travel speed for all land pixels between 85 degrees north and 60 degrees south for a nominal year 2019.  It also includes "walking-only" travel speed, using non-motorized means of transportation only.
    This map was produced through a collaboration between MAP (University of Oxford), Telethon Kids Institute (Perth, Australia), Google, and the University of Twente, Netherlands.
    This project builds on previous work published by Weiss et al 2018 ([doi:10.1038/nature25181](https://doi.org/10.1038/nature25181)). Weiss et al (2018) utilised datasets for roads (comprising the first ever global-scale use of Open Street Map and Google roads datasets), railways, rivers, lakes, oceans, topographic conditions (slope and elevation), landcover types, and national borders. These datasets were each allocated a speed or speeds of travel in terms of time to cross each pixel of that type. The datasets were then combined to produce a "friction surface"; a map where every pixel is allocated a nominal overall speed of travel based on the types occurring within that pixel. For the current project, an updated friction surface was created to incorporate recent improvements within OSM roads data.
    Differences between this friction surface and the 2015 version (Weiss et al. 2018) are not necessarily indicative of changes in infrastructure (e.g., new roads being built). Such discrepancies are far more likely to be associated with improved data quality, in particular updates made to OSM road coverage. As a result, comparisons between the friction surfaces and resulting travel time maps should be done cautiously and generally not interpreted as representing changes in access over time.
    This map represents the travel speed from this allocation process, expressed in units of minutes required to travel one meter. It forms the underlying dataset behind the global healthcare accessibility map described in the referenced paper.

    Source dataset credits are as described in the accompanying paper.
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
                    '2019-01-01T00:00:00Z', '2020-01-01T00:00:00Z'),
  summaries: {
    gsd: [927.67],
    'eo:bands': [
      {
        name: 'friction',
        description: 'Land-based travel speed.',
        'gee:units': 'minutes/meter',
      },
      {
        name: 'friction_walking_only',
        description: 'Land-based travel speed using non-motorized transport.',
        'gee:units': 'minutes/meter',
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
      minimum: 0.000429,
      maximum: 87.307472,
      'gee:estimated_range': false,
    },
    friction_walking_only: {
      minimum: 0.012,
      maximum: 87.307472,
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
