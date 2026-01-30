local id = 'Earth_Big_Data/GLOBAL_SEASONAL_S1/V2019/DECAY_MODEL_PARAMETERS';
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
  title: 'Global Seasonal Sentinel-1 Interferometric Coherence and Backscatter V' + version + ' Decay Model Parameters',
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

    This dataset includes parameters for the coherence decay model, an
    exponential function fitted to the seasonal median coherence values as a
    function of the repeat interval to quantify how quickly coherence is lost
    over time. The parameters are:

    * **rho**: Represents the long-term coherence, the value that the model
      predicts as the repeat interval increases to infinity. It is a measure of
      the temporal stability of the scattering elements in the target area.

    * **tau**: Represents the rate of coherence decay, a measure of how quickly
     the coherence drops from its initial high value towards *rho*. Lower
     values indicate faster decorrelation.

    * **rmse**: The root mean square error, a quality indicator of the model
      fit. It quantifies the difference between the modeled coherence curve and
      the original, non-aggregated coherence observations used to fit the model.

    The scale factor has already been applied to each of the bands. If you
    would like to do calculations using the digital numbers from the original
    rasters, load
    *Earth_Big_Data/GLOBAL_SEASONAL_S1/V2019/DECAY_MODEL_PARAMETERS_RAW*
    instead.

    Other datasets derived from Sentinel-1 observations over the same time
    period include:

    * [Backscatter](Earth_Big_Data_GLOBAL_SEASONAL_S1_V2019_BACKSCATTER)
    * [Coherence](Earth_Big_Data_GLOBAL_SEASONAL_S1_V2019_COHERENCE)
    * [Incidence Layover Shadow](Earth_Big_Data_GLOBAL_SEASONAL_S1_V2019_INCIDENCE_LAYOVER_SHADOW)
  |||,

  'gee:categories': ['satellite-imagery'],

  keywords: [
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
        name: 'fall_hh_rho',
        description: 'Fall (Sep-Nov 2020) HH rho.',
        'gee:polarization': 'HH',
      },
      {
        name: 'fall_hh_rmse',
        description: 'Fall (Sep-Nov 2020) HH rmse.',
        'gee:polarization': 'HH',
      },
      {
        name: 'fall_hh_tau',
        description: 'Fall (Sep-Nov 2020) HH tau.',
        'gee:polarization': 'HH',
      },
      {
        name: 'fall_vv_rho',
        description: 'Fall (Sep-Nov 2020) VV rho.',
        'gee:polarization': 'VV',
      },
      {
        name: 'fall_vv_rmse',
        description: 'Fall (Sep-Nov 2020) VV rmse.',
        'gee:polarization': 'VV',
      },
      {
        name: 'fall_vv_tau',
        description: 'Fall (Sep-Nov 2020) VV tau.',
        'gee:polarization': 'VV',
      },
      {
        name: 'spring_hh_rho',
        description: 'Spring (Mar-May 2020) HH rho.',
        'gee:polarization': 'HH',
      },
      {
        name: 'spring_hh_rmse',
        description: 'Spring (Mar-May 2020) HH rmse.',
        'gee:polarization': 'HH',
      },
      {
        name: 'spring_hh_tau',
        description: 'Spring (Mar-May 2020) HH tau.',
        'gee:polarization': 'HH',
      },
      {
        name: 'spring_vv_rho',
        description: 'Spring (Mar-May 2020) VV rho.',
        'gee:polarization': 'VV',
      },
      {
        name: 'spring_vv_rmse',
        description: 'Spring (Mar-May 2020) VV rmse.',
        'gee:polarization': 'VV',
      },
      {
        name: 'spring_vv_tau',
        description: 'Spring (Mar-May 2020) VV tau.',
        'gee:polarization': 'VV',
      },
      {
        name: 'summer_hh_rho',
        description: 'Summer (Jun-Aug 2020) HH rho.',
        'gee:polarization': 'HH',
      },
      {
        name: 'summer_hh_rmse',
        description: 'Summer (Jun-Aug 2020) HH rmse.',
        'gee:polarization': 'HH',
      },
      {
        name: 'summer_hh_tau',
        description: 'Summer (Jun-Aug 2020) HH tau.',
        'gee:polarization': 'HH',
      },
      {
        name: 'summer_vv_rho',
        description: 'Summer (Jun-Aug 2020) VV rho.',
        'gee:polarization': 'VV',
      },
      {
        name: 'summer_vv_rmse',
        description: 'Summer (Jun-Aug 2020) VV rmse.',
        'gee:polarization': 'VV',
      },
      {
        name: 'summer_vv_tau',
        description: 'Summer (Jun-Aug 2020) VV tau.',
        'gee:polarization': 'VV',
      },
      {
        name: 'winter_hh_rho',
        description: 'Winter (Dec 2019-Feb 2020) HH rho.',
        'gee:polarization': 'HH',
      },
      {
        name: 'winter_hh_rmse',
        description: 'Winter (Dec 2019-Feb 2020) HH rmse.',
        'gee:polarization': 'HH',
      },
      {
        name: 'winter_hh_tau',
        description: 'Winter (Dec 2019-Feb 2020) HH tau.',
        'gee:polarization': 'HH',
      },
      {
        name: 'winter_vv_rho',
        description: 'Winter (Dec 2019-Feb 2020) VV rho.',
        'gee:polarization': 'VV',
      },
      {
        name: 'winter_vv_rmse',
        description: 'Winter (Dec 2019-Feb 2020) VV rmse.',
        'gee:polarization': 'VV',
      },
      {
        name: 'winter_vv_tau',
        description: 'Winter (Dec 2019-Feb 2020) VV tau.',
        'gee:polarization': 'VV',
      },
    ],
    gsd: [92.7],
    'sar:polarizations': ['HH', 'VV'],
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
        display_name: 'Fall HH rho',
        lookat: { lon: -45.2, lat: 64.177, zoom: 5 },
        image_visualization: {
          band_vis: {
            min: [0],
            max: [0.4],
            bands: ['fall_hh_rho'],
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
