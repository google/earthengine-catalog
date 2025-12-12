local id = 'Earth_Big_Data/GLOBAL_SEASONAL_S1/V2019/INCIDENCE_LAYOVER_SHADOW';
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
  title: 'Global Seasonal Sentinel-1 Interferometric Coherence and Backscatter V' + version + ' Incidence Layover Shadow',
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

    This dataset contains ancillary data to aid in the interpretation and
    processing of the backscatter and coherence products.

    Other datasets derived from Sentinel-1 observations over the same time
    period include:

    * [Backscatter](Earth_Big_Data_GLOBAL_SEASONAL_S1_V2019_BACKSCATTER)
    * [Coherence](Earth_Big_Data_GLOBAL_SEASONAL_S1_V2019_COHERENCE)
    * [Decay Model Parameters](Earth_Big_Data_GLOBAL_SEASONAL_S1_V2019_DECAY_MODEL_PARAMETERS)
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
        name: 'inc',
        description: |||
          The angle between the incoming radar signal path and the normal
          vector to the local ground surface at each pixel.
        |||,
        'gee:units': units.degree,
      },
      {
        name: 'lsmap',
        description: |||
          Layover/Shadow mask:

          * 1 = No Shadow or Layover
          * 5 = Layover: A geometric distortion where features at higher
            elevations are displaced toward the radar (appearing before features
            at lower elevations), making measurement impossible.
          * 17 = Shadow: Areas hidden from the radar beam (behind steep slopes
            or tall objects) where no signal is received, resulting in zero or
            near-zero measured backscatter and coherence.
          * 21 = Shadow in Layover
        |||,
      },
    ],
    gsd: [92.7],

    'gee:schema': [
      {
        name: 'tile_id',
        description: 'Tile ID',
        type: ee_const.var_type.string,
      },
      {
        name: 'relative_orbit_number',
        description: 'Relative orbit number.',
        type: ee_const.var_type.int,
      },
      {
        name: 'flight_direction',
        description: 'Flight direction: "A" for ascending or "D" for descending.',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Incidence Angle',
        lookat: { lon: -45.2, lat: 64.177, zoom: 5 },
        image_visualization: {
          band_vis: {
            min: [30],
            max: [70],
            bands: ['inc'],
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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
