local id = 'GLOBAL_FLOOD_DB/MODIS_EVENTS/V1';
local subdir = 'GLOBAL_FLOOD_DB';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_nc_4_0;

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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Global Flood Database v1 (2000-2018)',
  version: 'V1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Global Flood Database contains maps of the extent and
    temporal distribution of 913 flood events occurring between 2000-2018. For more
    information, see
    [the associated journal article](https://doi.org/10.1038/s41586-021-03695-w).

    Flood events were collected from
    the [Dartmouth Flood Observatory](https://floodobservatory.colorado.edu/)
    and used to collect MODIS imagery. The selected
    913 events are those that were successfully mapped (passed quality control as
    having significant inundation beyond permanent water) using 12,719 scenes from
    Terra and Aqua MODIS sensors. Each pixel was classified as water or non-water
    at 250-meter resolution during the full date range of each flood event and
    subsequent data products were generated including maximum flood extent
    ("flooded" band) and the duration of inundation in days ("duration" band).
    Water and non-water classifications during a flood event include permanent
    water (here resampling the 30-meter
    [JRC Global Surface Water dataset](https://global-surface-water.appspot.com/)
    representing permanent water to 250-meter resolution), which can be
    masked out to isolate flood water using the "jrc_perm_water" band.
    Extra data quality
    bands were added representing cloud conditions during the flood event (e.g.,
    "clear_views" representing the number of clear days the flood was observed
    between its start and end dates and "clear_perc" representing the percentage of
    clear day observation of the total event duration in days).

    Each image in the ImageCollection represents the map of an individual flood.
    The collection can be filtered
    by date, country, or Dartmouth Flood Observatory original ID.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://console.cloud.google.com/storage/browser/gfd_v3',
    },
  ],
  keywords: [
    'c2s',
    'cloudtostreet',
    'dartmouth',
    'dfo',
    'flood',
    'gfd',
    'inundation',
    'surface',
    'water',
  ],
  providers: [
    ee.producer_provider('Cloud to Street (C2S) / Dartmouth Flood Observatory (DFO)', 'http://global-flood-database.cloudtostreet.info/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-02-17T00:00:00Z', '2018-12-10T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'id',
        description: 'Unique catalog ID of flood event that aligns with the Dartmouth Flood\nObservatory (DFO).',
        type: ee_const.var_type.int,
      },
      {
        name: 'cc',
        description: |||
          Three-letter ISO country codes (in a list) for countries for which
          flood water was detected in watersheds intersecting the DFO event polygon.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'countries',
        description: |||
          Country names (in a list) for countries for which flood water was
          detected in watersheds intersecting the DFO event polygon.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'dfo_centroid_x',
        description: 'Centroid longitude of DFO polygon estimating the location of a flood\nevent (DFO database).',
        type: ee_const.var_type.double,
      },
      {
        name: 'dfo_centroid_y',
        description: 'Centroid latitude of DFO polygon estimating the location of a flood\nevent (DFO database).',
        type: ee_const.var_type.double,
      },
      {
        name: 'dfo_country',
        description: 'Primary country of flooding (DFO database).',
        type: ee_const.var_type.string,
      },
      {
        name: 'dfo_other_country',
        description: 'Secondary country of flooding (DFO database).',
        type: ee_const.var_type.string,
      },
      {
        name: 'dfo_displaced',
        description: 'Estimated total number of people left homeless or evacuated after a\nflood event (DFO database).',
        type: ee_const.var_type.int,
      },
      {
        name: 'dfo_main_cause',
        description: 'The main cause of a flood event in the DFO database. Not normalized.',
        type: ee_const.var_type.string,
      },
      {
        name: 'dfo_severity',
        description: |||
          Severity of a flood event (DFO database):

          * 1 - large flood events, significant damage to structure or agriculture,
            fatalities, and/or 5-15 year reported interval since the last
            similar event
          * 1.5 - very large events: >15 year but <100 year recurrence interval
          * 2 - extreme events: recurrence interval >100 years)
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'dfo_dead',
        description: 'Estimated fatalities due to a flood event (DFO database).',
        type: ee_const.var_type.int,
      },
      {
        name: 'dfo_validation_type',
        description: 'Primary source of flood event confirmation (DFO database). Not normalized.',
        type: ee_const.var_type.string,
      },
      {
        name: 'glide_index',
        description: '[GLobal IDEntifier Number](https://glidenumber.net/glide/public/about.jsp).',
        type: ee_const.var_type.string,
      },
      {
        name: 'gfd_country_code',
        description: |||
          Comma-separated list of two-letter FIPS country codes for countries
          intersecting with the watershed used as the area of interest
          in the water detection algorithm.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'gfd_country_name',
        description: |||
          Country names (in a list) for countries intersecting with the watershed
          used as the area of interest in the water detection algorithm.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'composite_type',
        description: 'Number of days used for compositing in water detection algorithm.',
        type: ee_const.var_type.string,
      },
      {
        name: 'threshold_type',
        description: |||
          Type of thresholds used to classify water/ non-water in water detection
          algorithm - "otsu" or "standard".
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'threshold_b1b2',
        description: 'Threshold value applied to the b2b1-ratio used in the water detection\nalgorithm.',
        type: ee_const.var_type.double,
      },
      {
        name: 'threshold_b7',
        description: 'Threshold value applied to band 7 (SWIR) used in the water detection\nalgorithm.',
        type: ee_const.var_type.double,
      },
      {
        name: 'otsu_sample_res',
        description: |||
          Spatial resolution (in m) of the reducer used to build MODIS mosaic from
          which to then sample and estimate an otsu threshold (only available for flood
          events which used an otsu and not the default threshold).
        |||,
        type: ee_const.var_type.double,
        units: units.meters,
      },
      {
        name: 'slope_threshold',
        description: 'Value used to mask steep areas from water detection algorithm to\nminimize error from terrain shadows.',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'flooded',
        description: 'Maximum extent of flood water during an event.\n\n* 1 - area of surface water\n* 0 - no water',
      },
      {
        name: 'duration',
        description: |||
          Duration of surface water during an event in days. Pixel values indicate
          the number of composite days a pixel's area was considered water during an
          event. 3-day MODIS composites were used.
        |||,
        'gee:units': units.day,
      },
      {
        name: 'clear_views',
        description: |||
          Number of cloud-free observations in days between the start and end day
          of each event. Cloud coverage is determined by the MODIS Quality
          Assurance band ('state_1km').
        |||,
        'gee:units': units.day,
      },
      {
        name: 'clear_perc',
        description: |||
          Percentage of clear view observations during a given flood event. This is
          equivalent to the 'clear_views' band but normalized to the number of MODIS
          images per flood event.  Cloud coverage is determined by the MODIS
          Quality Assurance band ('state_1km').
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'jrc_perm_water',
        description: |||
          Permanent water determined by the JRC Global Surface Water dataset using the
          'transition' band.  Resolution is maintained as the original 30-meter
          resolution of the JRC dataset.

          * 1 - permanent water
          * 0 - non-water.
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Flood duration in days',
        lookat: {
          lat: -89.2922,
          lon: 29.4064,
          zoom: 9,
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
              'd0efff',
              '2a9df4',
              '187bcd',
              '1167b1',
              '03254c',
            ],
            bands: [
              'duration',
            ],
          },
        },
      },
    ],
    flooded: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    duration: {
      minimum: 0.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    clear_views: {
      minimum: 0.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    clear_perc: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    jrc_perm_water: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Tellman, B., J.A. Sullivan, C. Kuhn, A.J. Kettner, C.S. Doyle, G.R.
    Brakenridge, T. Erickson, D.A. Slayback. (Accepted.)
    Satellites observe increasing proportion of population exposed
    to floods. Nature.
    [doi:10.1038/s41586-021-03695-w](https://doi.org/10.1038/s41586-021-03695-w)
  |||,
  'gee:terms_of_use': |||
    This work is licensed under the Creative Commons Attribution Non Commercial 4.0
    International license.
  |||,
  'gee:unusual_terms_of_use': true,
  'gee:user_uploaded': true,
}
