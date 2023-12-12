local id = 'JAXA/ALOS/PALSAR/YEARLY/SAR';
local subdir = 'JAXA';
local version = '1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Global PALSAR-2/PALSAR Yearly Mosaic, version ' + version,
  'gee:type': ee_const.gee_type.image_collection,
  # TODO(simonf): add version links between this and SAR_EPOCH dataset
  # once reprocessed data for earlier years are released and ingested.
  version: version,
  description: |||
    A newer version of this dataset with data for 2015-2021 can be found in
    [JAXA/ALOS/PALSAR/YEARLY/SAR_EPOCH](JAXA_ALOS_PALSAR_YEARLY_SAR_EPOCH.html)

    The global 25m PALSAR/PALSAR-2 mosaic is a seamless global
    SAR image created by mosaicking strips of SAR imagery
    from PALSAR/PALSAR-2. For each year and location,
    the strip data were selected through visual inspection of the
    browse mosaics available over the period, with those showing minimum
    response to surface moisture preferentially used. In cases
    where the availability was limited (e.g., because of the requirement
    for observations during specific emergencies), data were necessarily
    selected from the year before or after, including from 2006.
    [Shimada et al. 2014](https://doi.org/10.1016/j.rse.2014.04.014)

    There is no data for 2011-2014 due to the gap between ALOS and ALOS-2
    temporal coverage.

    The SAR imagery was ortho-rectificatied and slope corrected
    using the 90m SRTM Digital Elevation Model.
    A destriping process (Shimada & Isoguchi, 2002, 2010) was applied
    to equalize the intensity differences between neighboring strips,
    occurring largely due to seasonal and daily differences
    in surface moisture conditions.

    Polarization data are stored as 16-bit digital numbers (DN).
    The DN values can be converted to gamma naught values
    in decibel unit (dB) using the following equation:

      *    &#947;&#8320; = 10log&#8321;&#8320;(DN&#178;) - 83.0 dB

    Attention:

    *   Backscatter values may vary significantly from path to path
        over high latitude forest areas. This is due to the change of
        backscattering intensity caused by freezing trees in winter.

    More information is available in the provider's
    [Dataset Description](https://www.eorc.jaxa.jp/ALOS/en/palsar_fnf/DatasetDescription_PALSAR2_Mosaic_FNF_revH.pdf).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'alos',
    'alos2',
    'eroc',
    'jaxa',
    'palsar',
    'palsar2',
    'sar',
  ],
  providers: [
    ee.producer_provider('JAXA EORC', 'https://www.eorc.jaxa.jp/ALOS/en/dataset/fnf_e.htm'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2007-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      25.0,
    ],
    'eo:bands': [
      {
        name: 'HH',
        description: 'HH polarization backscattering coefficient, 16-bit DN.',
      },
      {
        name: 'HV',
        description: 'HV polarization backscattering coefficient, 16-bit DN.',
      },
      {
        name: 'angle',
        description: 'Local incidence angle.',
        'gee:units': units.degree,
      },
      {
        name: 'date',
        description: 'Observation date (days since Jan 1, 1970).',
      },
      {
        name: 'qa',
        description: 'Processing information.',
        'gee:classes': [
          {
            color: '000000',
            description: 'No data',
            value: 0,
          },
          {
            value: 50,
            color: '0000ff',
            description: 'Ocean and water',
          },
          {
            value: 100,
            color: 'aaaa00',
            description: 'Radar layover',
          },
          {
            value: 150,
            color: '005555',
            description: 'Radar shadowing',
          },
          {
            value: 255,
            color: 'aa9988',
            description: 'Land',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'SAR HH',
        lookat: {
          lat: 37.37,
          lon: 136.85,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              10000.0,
            ],
            bands: [
              'HH',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Masanobu Shimada, Takuya Itoh, Takeshi Motooka, Manabu Watanabe,
    Shiraishi Tomohiro, Rajesh Thapa, and Richard Lucas, "New Global
    Forest/Non-forest Maps from ALOS PALSAR Data (2007-2010)", Remote Sensing
    of Environment, 155, pp. 13-31, December 2014.
    [doi:10.1016/j.rse.2014.04.014.](https://doi.org/10.1016/j.rse.2014.04.014)
  |||,
  'gee:terms_of_use': |||
    JAXA retains ownership of the dataset and cannot guarantee
    any problem caused by or possibly caused by using the datasets.
    Anyone wishing to publish any results using the datasets should
    clearly acknowledge the ownership of the data in the publication.
  |||,
}
