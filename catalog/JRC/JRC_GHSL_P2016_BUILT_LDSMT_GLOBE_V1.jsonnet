local id = 'JRC/GHSL/P2016/BUILT_LDSMT_GLOBE_V1';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/jrc_ldsmt_versions.libsonnet';

local subdir = 'JRC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'GHSL: Global Human Settlement Layers, Built-Up Grid 1975-1990-2000-2015 (P2016) [deprecated]',
  'gee:status': 'deprecated',
  version: version,
  'gee:type': ee_const.gee_type.image,
  description: |||
    The GHSL relies on the design and implementation of new spatial data mining
    technologies allowing to automatically process and extract analytics and
    knowledge from large amount of heterogeneous data including: global,
    fine-scale satellite image data streams, census data, and crowd sources or
    volunteered geographic information sources.

    These data contain a multitemporal information layer on built-up presence as
    derived from Landsat image collections (GLS1975, GLS1990, GLS2000, and
    ad-hoc Landsat 8 collection 2013/2014).

    The data have been produced by means of [Global Human Settlement Layer
    methodology](https://publications.jrc.ec.europa.eu/repository/handle/JRC97705)
    in 2015.

    For more information visit: [https://ghsl.jrc.ec.europa.eu/ghs_bu.php](https://ghsl.jrc.ec.europa.eu/ghs_bu.php)
    and [https://ghsl.jrc.ec.europa.eu/documents/GHSL_data_access.pdf](https://ghsl.jrc.ec.europa.eu/documents/GHSL_data_access.pdf).

    The Global Human Settlement Layer (GHSL) project is supported by the
    European Commission, Joint Research Center, and Directorate-General for
    Regional and Urban Policy. The GHSL produces new global spatial information,
    evidence-based analytics, and knowledge describing the human presence in
    the planet.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'built',
    'builtup',
    'jrc',
    'landsat_derived',
  ],
  providers: [
    ee.producer_provider('EC JRC', 'https://ghsl.jrc.ec.europa.eu/index.php'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('1975-01-01T00:00:00Z', '2014-12-31T00:00:00Z'),
  summaries: {
    gsd: [
      38.0,
    ],
    'eo:bands': [
      {
        name: 'built',
        description: 'Multitemporal built-up presence',
        'gee:classes': [
          {
            value: 1,
            color: '0c1d60',
            description: 'Water surface',
          },
          {
            value: 2,
            color: '000000',
            description: 'Land no built-up in any epoch',
          },
          {
            value: 3,
            color: '448564',
            description: 'Built-up from 2000 to 2014 epochs',
          },
          {
            value: 4,
            color: '70daa4',
            description: 'Built-up from 1990 to 2000 epochs',
          },
          {
            value: 5,
            color: '83ffbf',
            description: 'Built-up from 1975 to 1990 epochs',
          },
          {
            value: 6,
            color: 'ffffff',
            description: 'built-up up to 1975 epoch',
          },
        ],
      },
      {
        name: 'cnfd',
        description: |||
          Gaps-filled confidence grid on the built-up class aggregated
          for 2014. 0 = 100% confidence of no built-up, 127 = 50% decision cut off,
          255 = 100% conficence of yes built-up
        |||,
      },
      {
        name: 'dm',
        description: 'Mosaic of data availability in the different epochs.',
        'gee:classes': [
          {
            value: 1,
            description: 'No data availability for any epoch',
          },
          {
            value: 2,
            description: '1975',
          },
          {
            value: 3,
            description: '1990',
          },
          {
            value: 4,
            description: '1975 and 1990',
          },
          {
            value: 5,
            description: '2000',
          },
          {
            value: 6,
            description: '1975 and 2000',
          },
          {
            value: 7,
            description: '1990 and 2000',
          },
          {
            value: 8,
            description: '1975, 1990, and 2000',
          },
          {
            value: 9,
            description: '2015',
          },
          {
            value: 10,
            description: '1975 and 2015',
          },
          {
            value: 11,
            description: '1990 and 2015',
          },
          {
            value: 12,
            description: '1975, 1990, and 2015',
          },
          {
            value: 13,
            description: '2000 and 2015',
          },
          {
            value: 14,
            description: '1975, 2000, and 2015',
          },
          {
            value: 15,
            description: '1990, 2000. and 2015',
          },
          {
            value: 16,
            description: '1995, 1190, 2000, and 2015',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Built-Up Multitemporal',
        lookat: {
          lat: 45.5718,
          lon: 8.9957,
          zoom: 12,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              6.0,
            ],
            palette: [
              '0c1d60',
              '000000',
              '448564',
              '70daa4',
              '83ffbf',
              'ffffff',
            ],
            bands: [
              'built',
            ],
          },
        },
      },
    ],
    cnfd: {
      minimum: 0.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Pesaresi, Martino; Ehrilch, Daniele; Florczyk, Aneta J.; Freire,
    Sergio; Julea, Andreea; Kemper, Thomas; Soille, Pierre; Syrris, Vasileios
    (2015): GHS built-up grid, derived from Landsat, multitemporal (1975, 1990,
    2000, 2014). European Commission, Joint Research Centre (JRC) [Dataset]
    [PID: https://data.europa.eu/89h/jrc-ghsl-ghs_built_ldsmt_globe_r2015b](https://data.europa.eu/89h/jrc-ghsl-ghs_built_ldsmt_globe_r2015b)
  |||,
  'sci:publications': [
    {
      citation: |||
        Pesaresi, Martino; Ehrlich, Daniele; Florczyk, Aneta J.; Freire, Sergio;
        Julea, Andreea; Kemper, Thomas; Soille, Pierre; Syrris, Vasileios (2015):
        GHS built-up confidence grid, derived from Landsat, multitemporal (1975,
        1990, 2000, 2014). European Commission, Joint Research Centre (JRC)
        [Dataset] [PID: https://data.europa.eu/89h/jrc-ghsl-ghs_built_ldsmtcnfd_globe_r2015b](https://data.europa.eu/89h/jrc-ghsl-ghs_built_ldsmtcnfd_globe_r2015b)
      |||,
    },
    {
      citation: |||
        Pesaresi, Martino; Ehrlich, Daniele; Florczyk, Aneta J.; Freire, Sergio;
        Julea, Andreea; Kemper, Thomas; Soille, Pierre; Syrris, Vasileios (2015):
        GHS built-up datamask grid derived from Landsat, multitemporal (1975, 1990,
        2000, 2014). European Commission, Joint Research Centre (JRC) [Dataset]
        [PID: https://data.europa.eu/89h/jrc-ghsl-ghs_built_ldsmtdm_globe_r2015b](https://data.europa.eu/89h/jrc-ghsl-ghs_built_ldsmtdm_globe_r2015b)
      |||,
    },
  ],
  'gee:terms_of_use': |||
    The GHSL has been produced by the EC JRC as open and free data. Reuse is
    authorised, provided the source is acknowledged. For more information,
    please read the use conditions ([European Commission Reuse and Copyright
    Notice](https://ec.europa.eu/info/legal-notice_en)).
  |||,
  'gee:user_uploaded': true,
}
