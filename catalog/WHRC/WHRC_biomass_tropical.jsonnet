local id = 'WHRC/biomass/tropical';
local subdir = 'WHRC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'WHRC Pantropical National Level Carbon Stock Dataset',
  'gee:type': ee_const.gee_type.image,
  description: |||
    A national-level map of above-ground live woody biomass density for
    tropical countries at 500m. This dataset was assembled from a combination
    of co-located field measurements, LiDAR observations, and imagery recorded
    from the Moderate Resolution Imaging Spectroradiometer (MODIS).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'aboveground',
    'biomass',
    'carbon',
    'geophysical',
    'pantropical',
    'tropical',
    'umd',
    'whrc',
  ],
  providers: [
    ee.producer_provider('WHRC', 'https://www.woodwellclimate.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2012-01-29T00:00:00Z', '2012-01-29T00:00:00Z'),
  summaries: {
    gsd: [
      500.0,
    ],
    'eo:bands': [
      {
        name: 'Mg',
        description: 'Megagrams of aboveground live woody biomass per Hectare',
        'gee:units': 'Mg/ha',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Aboveground Live Woody Biomass',
        lookat: {
          lat: 0.35,
          lon: -69.43,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              350.0,
            ],
            palette: [
              'ffffff',
              'ce7e45',
              'df923d',
              'f1b555',
              'fcd163',
              '99b718',
              '74a901',
              '66a000',
              '529400',
              '3e8601',
              '207401',
              '056201',
              '004c00',
              '023b01',
              '012e01',
              '011d01',
              '011301',
            ],
            bands: [
              'Mg',
            ],
          },
        },
      },
    ],
    Mg: {
      minimum: 0.0,
      maximum: 503.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    A. Baccini, S J. Goetz, W.S. Walker, N. T. Laporte, M. Sun, D.
    Sulla-Menashe, J. Hackler, P.S.A. Beck, R. Dubayah, M.A. Friedl,
    S. Samanta and R. A. Houghton. Estimated carbon dioxide emissions
    from tropical deforestation improved by carbon-density maps. 2012
    Nature Climate Change, [https://doi.org/10.1038/NCLIMATE1354]
    (https://doi.org/10.1038/NCLIMATE1354)
  |||,
  'gee:terms_of_use': |||
    - The national level dataset is freely available for use for
      scientific, conservation, and educational purposes.
    - Users acknowledge that they themselves are responsible for determining
      whether the dataset is of sufficient quality and appropriateness for
      their objectives.
    - Users agree that they will make reasonable efforts to provide appropriate
      feedbacks and notification of any significant errors that they identify
      in the dataset.
  |||,
}
