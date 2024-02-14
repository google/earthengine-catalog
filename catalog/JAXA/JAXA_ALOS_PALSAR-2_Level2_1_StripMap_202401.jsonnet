local id = 'JAXA/ALOS/PALSAR-2/Level2_1/StripMap_202401';
local subdir = 'JAXA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local date_table = importstr 'templates/StripMap.md';

local license = spdx.cc_by_nc_sa_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  // TODO(simonf): consider adding https://github.com/stac-extensions/card4l
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sar,
    ee_const.ext_sci
  ],
  id: id,
  title: 'ALOS-2 PALSAR-2 StripMap Level 2.1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Starting from the night of January 1st, 2024, based on the request from
    Japanese ministries and related organization, JAXA implemented ALOS-2
    PALSAR-2 emergency observation. Since JAXA expects these emergency
    observation data to be extremely useful for disaster
    management, JAXA decided to open these data on Google Earth Engine for
    public and research usage.

    JAXA released PALSAR-2 Level 2.1 strip map mode observation data with 3m
    single polarization for January 1-3 and January 8 2024, together with
    some archive
    data. PALSAR-2 Level 2.1 data is orthorectified from level 1.1 data by using
    digital elevation model. The DN values can be converted to sigma naught
    values in decibel unit (dB) using the following equation:

    * &sigma;<sub>0</sub> = 10*log<sub>10</sub>(DN<sup>2</sup>) - 83.0 dB

  ||| + date_table,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'alos2',
    'eroc',
    'jaxa',
    'palsar2',
    'radar',
    'sar',
  ],
  providers: [
    ee.producer_provider(
        'JAXA EORC',
        'https://www.eorc.jaxa.jp/ALOS/en/dataset/palsar2_l22_e.htm'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2022-09-26T00:00:00Z', '2024-01-08T00:00:00Z'),
  summaries: {
    gsd: [
      3.0,
    ],
    'sar:instrument_mode': ['ScanSAR'],
    'sar:frequency_band': ['L'],
    'sar:center_frequency': [1.27],
    'sar:polarizations': ['HH'],
    'sar:product_type': ['Normalised Radar Backscatter'],
    'sar:resolution_range': [3],
    'sar:resolution_azimuth': [3],
    'eo:bands': [
      {
        name: 'b1',
        description: |||
            HH polarization Terrain-flattened Gamma-Nought backscatter
            coefficient.
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'HH polarization',
        lookat: {
          lat: 37.1204,
          lon: 137.2228,
          zoom: 8,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              8000.0,
            ],
            bands: [
              'b1',
            ],
          },
        },
      },
    ],
  },
  'gee:terms_of_use': |||
    Anyone can use this data free of charge subject to non-commercial use only.
    For detailed terms of use see JAXA
    [G-Portal Terms of service](https://gportal.jaxa.jp/gpr/index/eula?lang=en)
    (Section 7. Condition concerning of G-Portal data).
  |||,
  'gee:unusual_terms_of_use': true,
  'sci:citation': |||
    The data used for this paper have been provided by Earth Observation
    Research Center (EORC) of Japan Aerospace Exploration Agency (JAXA).
  |||,
}
