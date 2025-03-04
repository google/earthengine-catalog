local id = 'GOOGLE/Research/open-buildings-temporal/v1';
local subdir = 'GOOGLE';
local version = '1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local units = import 'units.libsonnet';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Open Buildings Temporal V' + version,
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Open Buildings 2.5D Temporal Dataset contains data about building
    presence, fractional building counts, and building heights at an effective<sup>1</sup>
    spatial resolution of 4m (rasters are provided at 0.5m resolution) at an
    annual cadence from 2016-2023. It is produced from open-source,
    low-resolution imagery from the [Sentinel-2](https://www.esa.int/Applications/Observing_the_Earth/Copernicus/Sentinel-2)
    collection.

    The dataset is available across Africa, South Asia, South-East Asia, Latin
    America and the Caribbean. The goal of this data is to support organizations
    (e.g., governmental, non-profits, commercial) focusing on a range of
    applications for social good.

    Explore the data interactively with the demo Earth Engine [app](https://goo.gle/open-buildings-temporal-demo-app). (In case you encounter performance issues with the Earth Engine app please try [this](https://goo.gle/open-buildings-temporal-demo) Earth Engine script instead.)

    Alternatively, if you are not an Earth Engine user, you can download the
    data directly from Google Cloud Storage using [this notebook](https://colab.research.google.com/github/google-research/google-research/blob/master/building_detection/open_buildings_temporal_download_region_geotiffs.ipynb).

    For more details on the project and FAQs about the data checkout the project
    [website](https://sites.research.google/gr/open-buildings/temporal/).

    Example scripts:

    * <code>[How to compute building count for a given AOI](https://code.earthengine.google.com/31ca8ccee65887ed2a152c8ea920bbd2)</code>
    * <code>[How to compute built-up area for a given AOI](https://code.earthengine.google.com/46468628f66eb57c79753ae4c1c09f54)</code>
    * <code>[How to see two years side-by-side and compare](https://code.earthengine.google.com/e9e5a84d279d4b5669872a560e8329a2?hideCode=true)</code>

    <small><sup>1</sup>equivalent to what could be achieved by a high-resolution model
    using a single frame of 4 m resolution imagery.</small>
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    ee.link.license(spdx.odbl_1_0.reference),
  ],
  'gee:categories': ['population'],
  keywords: [
    'building_height',
    'height',
    'annual',
    'built_up',
    'open_buildings',
    'africa',
    'asia',
    'south_asia',
    'southeast_asia',
    'high_resolution',
  ],
  providers: [
    ee.producer_provider('Google Research - Open Buildings',
                         'https://sites.research.google/gr/open-buildings/temporal/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2016-06-30T07:00:00Z', '2023-06-30T07:00:00Z'),
  summaries: {
    gsd: [
      4,
    ],
    'gee:schema': [
      {
        name: 'imagery_start_time_epoch_s',
        description: 'Oldest possible date for source Sentinel-2 imagery used to produce these rasters.',
        units: units.seconds,
        type: ee_const.var_type.double,
      },
      {
        name: 'imagery_end_time_epoch_s',
        description: 'Newest possible date for source Sentinel-2 imagery used to produce these rasters.',
        units: units.seconds,
        type: ee_const.var_type.double,
      },
      {
        name: 'inference_time_epoch_s',
        description: |||
          Time the rasters are supposed to predict the state of the world for, in
          seconds since epoch.
        |||,
        units: units.seconds,
        type: ee_const.var_type.double,
      },
      {
        name: 's2cell_token',
        description: |||
          Token of the S2 cell this tile belongs to. Due to UTM zone boundaries,
          a single S2 cell that spans multiple zones may have multiple
          corresponding tiles in different projection zones.
          See [http://s2geometry.io/](http://s2geometry.io/).
        |||,
        type: ee_const.var_type.string,
      },
    ],
    'eo:bands': [
      {
        name: 'building_fractional_count',
        description: |||
          Source data for deriving building counts for a given AOI. Please see
          accompanying example scripts.
        |||,
      },
      {
        name: 'building_height',
        description: 'Building height relative to the terrain in range [0m, 100m].',
        'gee:units': units.meter,
      },
      {
        name: 'building_presence',
        description: |||
          Model confidence values (i.e. how confident a model is that the pixel is
          part of a building) in range [0.0, 1.0]. Note that model confidence
          values are uncalibrated, meaning, if model confidence for a certain
          pixel is 0.8, it doesn't mean the actual likelihood of building
          presence is 80%. As such, confidence values can only be used for
          relative ranking (eg. thresholding) of pixels. Also, the model
          confidence can vary across location and time based on a number
          of factors such as cloud cover, imagery misalignment, etc.
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Open Buildings Temporal V' + version,
        lookat: {
          lat: -5.178058074165919,
          lon: 9.261976832473348,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            bands: ['building_fractional_count', 'building_height', 'building_presence'],
          },
        },
      },
    ],
    building_fractional_count: {
      minimum: 0,
      maximum: 0.0216,
      'gee:estimated_range': false,
    },
    building_height: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
    building_presence: {
      minimum: 0,
      maximum: 1,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Wojciech Sirko, Emmanuel Asiedu Brempong, Juliana T. C. Marcos, Abigail
    Annkah, Abel Korme, Mohammed Alewi Hassen, Krishna Sapkota, Tomer Shekel,
    Abdoulaye Diack, Sella Nevo, Jason Hickey, John Quinn. [High-Resolution
    Building and Road Detection from Sentinel-2](https://arxiv.org/abs/2310.11622), 2023.
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license) + '\n\n' + |||
    The data is shared under the Creative Commons Attribution
    ([CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/)) license and the
    Open Data Commons Open Database License (ODbL) v1.0 license. As the user,
    you can pick which of the two licenses you prefer and use the data under the
    terms of that license.

    Leverages the Copernicus Sentinel-2 data (2015-present). See the [Sentinel Data
    Legal Notice](https://sentinels.copernicus.eu/documents/247904/690755/Sentinel_Data_Legal_Notice)
  |||,
  'gee:user_uploaded': true,

}
