local id = 'Earth_Big_Data/GLOBAL_SEASONAL_S1/V2019/BACKSCATTER';
local subdir = 'Earth_Big_Data';
local version = '2019';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local basename = 'Earth_Big_Data_' + std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'Global Seasonal Sentinel-1 Interferometric Coherence and Backscatter V' + version + ' Backscatter',
  version: version,

  description: |||
    This data set is the first-of-its-kind spatial representation of
    multi-seasonal, global C-band Synthetic Aperture Radar (SAR)
    interferometric repeat-pass coherence and backscatter signatures.
    Coverage comprises land masses and ice sheets from 82 degrees
    Northern to 79 degrees Southern latitudes. The data set is derived
    from multi-temporal repeat-pass interferometric processing of about
    205,000 Sentinel-1 C-band SAR images acquired in Interferometric
    Wide-Swath Mode from 1-Dec-2019 to 30-Nov-2020.

    This dataset contains mean Radiometrically Terrain Corrected (RTC)
    backscatter. The raw signal intensity has been adjusted to account for the
    influence of local topography (like hills and slopes) on the measured radar
    cross-section. This correction is performed to produce a
    terrain-flattened backscatter value that is more representative of the
    intrinsic scattering properties of the surface itself.

    If you would like to do calculations using the digital numbers from the
    original rasters, load
    *Earth_Big_Data/GLOBAL_SEASONAL_S1/V2019/BACKSCATTER_RAW* instead.

    Other datasets derived from Sentinel-1 observations over the same time
    period include:

    * [Coherence](Earth_Big_Data_GLOBAL_SEASONAL_S1_V2019_COHERENCE)
    * [Decay Model Parameters](Earth_Big_Data_GLOBAL_SEASONAL_S1_V2019_DECAY_MODEL_PARAMETERS)
    * [Incidence Layover Shadow](Earth_Big_Data_GLOBAL_SEASONAL_S1_V2019_INCIDENCE_LAYOVER_SHADOW)
  |||,

  'gee:categories': ['satellite-imagery'],

  keywords: [
    'backscatter',
    'earth_big_data',
    'jpl',
    'nasa',
    'polarization',
    'radar',
    'sar',
    'seasonal',
    'sentinel1-derived',
  ],

  providers: [
    ee.producer_provider(
      'Earth Big Data LLC', 'https://www.earthbigdata.com/'),
    ee.producer_provider(
      'Alaska Satellite Facility', 'https://asf.alaska.edu/'),
    ee.host_provider(self_ee_catalog_url),
  ],

  extent: ee.extent(-180, -79, 180, 82, '2019-12-01T00:00:00Z',
                    '2020-12-01T00:00:00Z'),

  summaries: {
    'eo:bands': [
      {
        name: 'fall_hh_AMP',
        description: 'Fall (Sep-Nov 2020) HH backscatter amplitude.',
        'gee:units': units.decibel,
        'gee:polarization': 'HH',
      },
      {
        name: 'fall_hv_AMP',
        description: 'Fall (Sep-Nov 2020) HV backscatter amplitude.',
        'gee:units': units.decibel,
        'gee:polarization': 'HV',
      },
      {
        name: 'fall_vh_AMP',
        description: 'Fall (Sep-Nov 2020) VH backscatter amplitude.',
        'gee:units': units.decibel,
        'gee:polarization': 'VH',
      },
      {
        name: 'fall_vv_AMP',
        description: 'Fall (Sep-Nov 2020) VV backscatter amplitude.',
        'gee:units': units.decibel,
        'gee:polarization': 'VV',
      },
      {
        name: 'spring_hh_AMP',
        description: 'Spring (Mar-May 2020) HH backscatter amplitude.',
        'gee:units': units.decibel,
        'gee:polarization': 'HH',
      },
      {
        name: 'spring_hv_AMP',
        description: 'Spring (Mar-May 2020) HV backscatter amplitude.',
        'gee:units': units.decibel,
        'gee:polarization': 'HV',
      },
      {
        name: 'spring_vh_AMP',
        description: 'Spring (Mar-May 2020) VH backscatter amplitude.',
        'gee:units': units.decibel,
        'gee:polarization': 'VH',
      },
      {
        name: 'spring_vv_AMP',
        description: 'Spring (Mar-May 2020) VV backscatter amplitude.',
        'gee:units': units.decibel,
        'gee:polarization': 'VV',
      },
      {
        name: 'summer_hh_AMP',
        description: 'Summer (Jun-Aug 2020) HH backscatter amplitude.',
        'gee:units': units.decibel,
        'gee:polarization': 'HH',
      },
      {
        name: 'summer_hv_AMP',
        description: 'Summer (Jun-Aug 2020) HV backscatter amplitude.',
        'gee:units': units.decibel,
        'gee:polarization': 'HV',
      },
      {
        name: 'summer_vh_AMP',
        description: 'Summer (Jun-Aug 2020) VH backscatter amplitude.',
        'gee:units': units.decibel,
        'gee:polarization': 'VH',
      },
      {
        name: 'summer_vv_AMP',
        description: 'Summer (Jun-Aug 2020) VV backscatter amplitude.',
        'gee:units': units.decibel,
        'gee:polarization': 'VV',
      },
      {
        name: 'winter_hh_AMP',
        description: 'Winter (Dec 2019-Feb 2020) HH backscatter amplitude.',
        'gee:units': units.decibel,
        'gee:polarization': 'HH',
      },
      {
        name: 'winter_hv_AMP',
        description: 'Winter (Dec 2019-Feb 2020) HV backscatter amplitude.',
        'gee:units': units.decibel,
        'gee:polarization': 'HV',
      },
      {
        name: 'winter_vh_AMP',
        description: 'Winter (Dec 2019-Feb 2020) VH backscatter amplitude.',
        'gee:units': units.decibel,
        'gee:polarization': 'VH',
      },
      {
        name: 'winter_vv_AMP',
        description: 'Winter (Dec 2019-Feb 2020) VV backscatter amplitude.',
        'gee:units': units.decibel,
        'gee:polarization': 'VV',
      },
    ],
    gsd: [92.7],
    'sar:polarizations': ['HH', 'HV', 'VH', 'VV'],
    'sar:product_type': ['SLC'],

    'gee:schema': [
      {
        name: 'tile_id',
        description: 'Tile ID',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Fall HH AMP',
        lookat: { lon: -45.2, lat: 64.177, zoom: 5 },
        image_visualization: {
          band_vis: {
            min: [0],
            max: [1.25],
            bands: ['fall_hh_AMP'],
          },
        },
      },
    ],
  },

  'sci:doi': '10.1038/s41597-022-01189-6',
  'sci:citation': |||
    Kellndorfer, J., Cartus, O., Lavalle, M. et al. Global seasonal Sentinel-1
    interferometric coherence and backscatter data set. Sci Data 9, 73 (2022).
    [doi:10.1038/s41597-022-01189-6](https://doi.org/10.1038/s41597-022-01189-6).
  |||,

  'gee:terms_of_use': ee.gee_terms_of_use(license),

  // TODO(dpencosk): Remove gee:status when the dataset is ready.
  'gee:status': 'beta',

  'gee:type': ee_const.gee_type.image_collection,

  license: license.id,

  links: ee.standardLinks(subdir, id),

  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sar,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
