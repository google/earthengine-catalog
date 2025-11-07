local id = 'projects/global-precipitation-nowcast/assets/global_estimation';
local subdir = 'global-precipitation-nowcast';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  'gee:user_uploaded': true,
  id: id,
  title: 'Oya: 5km Quasi-Global Precipitation Estimates',
  description: |||
    **Note: The associated paper "Oya: Deep Learning for Accurate Global
    Precipitation Estimation" has not yet gone through formal peer review. It
    would be released on arxiv soon.**

    Oya is a quasi-global, high-resolution precipitation estimation dataset
    derived from geostationary (GEO) satellite observations.

    The Oya model utilizes the full spectrum of visible and infrared (VIS-IR)
    channels from a constellation of GEO satellites — including GOES-16/18,
    Meteosat-9/10, and Himawari-8/9 — to generate precipitation estimates
    covering 60°N to 60°S.

    To address the inherent data imbalance between rain and no-rain events,
    Oya employs a two-stage deep learning approach. It combines two U-Net
    models: one specialized for precipitation detection and another for
    Quantitative Precipitation Estimation (QPE). The models are
    trained using high-resolution GPM Combined Radar-Radiometer Algorithm
    (CORRA) v07 data as ground truth and are pre-trained on IMERG-Final
    retrievals to enhance robustness.

    Oya demonstrates superior performance compared to existing operational
    GEO-based baselines, such as the PERSIANN DynamicInfrared Rain Rate
    (PDIR-Now) and the Convective Rainfall Rate (CRR), across all precipitation
    intensities. It also outperforms Passive Microwave (PMW) based products like
    the Integrated Multisatellite Retrievals for GPM (IMERG) Early and is
    competitive with research-grade products like IMERG Final, which has a
    3.5-month latency. This dataset includes a half-hourly historical record
    generated from 2004 with a spatial resolution of 5km.

    Limitations:
    * Geographic Decline: Retrieval accuracy is highest in tropical zones and
      degrades at higher latitudes. This is attributed to geostationary satellite
      viewing angle effects, specifically limb darkening and parallax shift.
    * Topographic Challenges: The model shows reduced performance in arid and
      high-altitude regions, notably the Tibetan Plateau.
    * Indirect Observation: As an IR/VIS-based product, Oya infers precipitation
      from cloud-top properties rather than directly sensing raindrops (as radar
      or passive microwave instruments do).

    Google makes no commitment about future updates to this dataset.
  |||,
  'gee:categories': ['precipitation'],

  keywords: [
    'weather',
    'climate',
    'geophysical',
    'gpm',
    'precipitation',
    'pre-review',
    // 'half_hourly',
  ],

  providers: [
    ee.producer_provider('Google', 'https://research.google/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2004-01-01T00:00:00Z', null),

  // Summaries contain additional information specific to the dataset type.
  summaries: {
    gsd: [5000],
    'eo:bands': [
      {
        name: 'precipitation',
        description: 'Precipitation estimate',
        'gee:units': 'mm/hr'
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Precipitation retrieval (mm/hr)',
        // Do not use too many significant digits.
        lookat: {lon: 0, lat: 0, zoom: 3},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [150],
            bands: ['precipitation'],
          }
        },
      },
    ],
    'gee:schema': [
      {
        name: 'ingestion_time_utc',
        description: 'The time of ingestion.',
        type: ee_const.var_type.string,
      },
    ],
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'minute',
    interval: 30,
  },

  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.image_collection,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_eo,
  ],
}
