local id = 'RUB/RUBCLIM/LCZ/global_lcz_map/latest';
local subdir = 'RUB';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local versions = import 'versions.libsonnet';
local version_table = import 'RUB_RUBCLIM_LCZ_global_lcz_map_versions.libsonnet';

local license = spdx.proprietary;

local version_config = versions(subdir, version_table, id);
local version = version_config.version;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Global map of Local Climate Zones, latest version',
  version: 'latest',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Since their introduction in 2012, Local Climate Zones (LCZs) emerged as
    a new standard for characterizing urban landscapes, providing a holistic
    classification approach that takes into account micro-scale land-cover and
    associated physical properties.

    This global map of Local Climate Zones, at 100m pixel size and
    representative for the nominal year 2018, is derived from multiple earth
    observation datasets and expert LCZ class labels. LCZ_Filter is the
    recommended band for most users. The other classification band, LCZ, is
    only provided as it is used to calculate the LCZ_Probability band.

    The LCZ scheme complements other land use / land cover schemes by
    its focus on urban and rural landscape types, which can be described by
    any of the 17 classes in the LCZ scheme. Out of the 17 LCZ classes, 10
    reflect the 'built' environment, and each LCZ type is associated with
    generic numerical descriptions of key urban canopy parameters critical to
    model atmospheric responses to urbanisation.  In addition, since LCZs were
    originally designed as a new framework for urban heat island studies, they
    also contain a limited set (7) of 'natural' land-cover classes that can be
    used as 'control' or 'natural reference' areas.

    As these seven natural classes in the LCZ scheme can not capture the
    heterogeneity of the world's existing natural ecosystems, we advise
    users - if required - to combine the built LCZ classes with any other
    land-cover product that provides a wider range of natural land-cover
    classes.

    See also:

    * [LCZ Typology](https://doi.org/10.1175/BAMS-D-11-00019.1)

    * [Global map of LCZs - paper](https://doi.org/10.5194/essd-14-3835-2022)

    * [Global map of LCZs - dataset](https://doi.org/10.5281/zenodo.6364593)

    * [LCZ Gaussian filtering](https://doi.org/10.1038/s41597-020-00605-z)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) +
   version_config.version_links + [
    {
      rel: ee_const.rel.source,
      href: 'https://doi.org/10.5194/essd-14-3835-2022',
    },
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5281/zenodo.6364593',
    },
  ],
  keywords: [
    'climate',
    'landcover',
    // 'local_climate_zones',
    // 'rub',
    'urban',
    // 'wudapt',
  ],
  providers: [
    ee.producer_provider(
        'Bochum Urban Climate Lab',
        'https://lcz-generator.rub.de/global-lcz-map'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2018-01-01T00:00:00Z', '2019-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      100.0,
    ],
    'eo:bands': [
      {
        name: 'LCZ',
        description: 'The raw, pixel-based global LCZ map with LCZ classes',
        'gee:classes': [
          {
            value: 1,
            color: '8c0000',
            description: 'Compact highrise',
          },
          {
            value: 2,
            color: 'd10000',
            description: 'Compact midrise',
          },
          {
            value: 3,
            color: 'ff0000',
            description: 'Compact lowrise',
          },
          {
            value: 4,
            color: 'bf4d00',
            description: 'Open highrise',
          },
          {
            value: 5,
            color: 'ff6600',
            description: 'Open midrise',
          },
          {
            value: 6,
            color: 'ff9955',
            description: 'Open lowrise',
          },
          {
            value: 7,
            color: 'faee05',
            description: 'Lightweight lowrise',
          },
          {
            value: 8,
            color: 'bcbcbc',
            description: 'Large lowrise',
          },
          {
            value: 9,
            color: 'ffccaa',
            description: 'Sparsely built',
          },
          {
            value: 10,
            color: '555555',
            description: 'Heavy industry',
          },
          {
            value: 11,
            color: '006a00',
            description: 'Dense Trees (LCZ A)',
          },
          {
            value: 12,
            color: '00aa00',
            description: 'Scattered Trees (LCZ B)',
          },
          {
            value: 13,
            color: '648525',
            description: 'Bush, scrub (LCZ C)',
          },
          {
            value: 14,
            color: 'b9db79',
            description: 'Low plants (LCZ D)',
          },
          {
            value: 15,
            color: '000000',
            description: 'Bare rock or paved (LCZ E)',
          },
          {
            value: 16,
            color: 'fbf7ae',
            description: 'Bare soil or sand (LCZ F)',
          },
          {
            value: 17,
            color: '6a6aff',
            description: 'Water (LCZ G)',
          },
        ],
      },
      {
        name: 'LCZ_Filter',
        description: |||
            The recommended global LCZ map with LCZ classes.  LCZ labels are
            obtained after applying the morphological Gaussian filter
            described in Demuzere et al. (2020)
        |||,
        'gee:classes': [
          {
            value: 1,
            color: '8c0000',
            description: 'Compact highrise',
          },
          {
            value: 2,
            color: 'd10000',
            description: 'Compact midrise',
          },
          {
            value: 3,
            color: 'ff0000',
            description: 'Compact lowrise',
          },
          {
            value: 4,
            color: 'bf4d00',
            description: 'Open highrise',
          },
          {
            value: 5,
            color: 'ff6600',
            description: 'Open midrise',
          },
          {
            value: 6,
            color: 'ff9955',
            description: 'Open lowrise',
          },
          {
            value: 7,
            color: 'faee05',
            description: 'Lightweight lowrise',
          },
          {
            value: 8,
            color: 'bcbcbc',
            description: 'Large lowrise',
          },
          {
            value: 9,
            color: 'ffccaa',
            description: 'Sparsely built',
          },
          {
            value: 10,
            color: '555555',
            description: 'Heavy industry',
          },
          {
            value: 11,
            color: '006a00',
            description: 'Dense Trees (LCZ A)',
          },
          {
            value: 12,
            color: '00aa00',
            description: 'Scattered Trees (LCZ B)',
          },
          {
            value: 13,
            color: '648525',
            description: 'Bush, scrub (LCZ C)',
          },
          {
            value: 14,
            color: 'b9db79',
            description: 'Low plants (LCZ D)',
          },
          {
            value: 15,
            color: '000000',
            description: 'Bare rock or paved (LCZ E)',
          },
          {
            value: 16,
            color: 'fbf7ae',
            description: 'Bare soil or sand (LCZ F)',
          },
          {
            value: 17,
            color: '6a6aff',
            description: 'Water (LCZ G)',
          },
        ],
      },
      {
        name: 'LCZ_Probability',
        description: |||
            A probability layer that identifies how often the modal LCZ was
            chosen per pixel (e.g. a probability of 60% means that the modal
            LCZ class was mapped 30 times out of 50 LCZ models). This is a
            pixel-based probability derived from the LCZ layer
        |||,
        'gee:units': units.percent,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'LCZ',
        lookat: {
          lat: 40.72,
          lon: -73.99,
          zoom: 10,
        },
        image_visualization: {
          band_vis: {
            min: [
              1,
            ],
            max: [
              17,
            ],
            palette: [
              '8c0000',
              'd10000',
              'ff0000',
              'bf4d00',
              'ff6600',
              'ff9955',
              'faee05',
              'bcbcbc',
              'ffccaa',
              '555555',
              '006a00',
              '00aa00',
              '648525',
              'b9db79',
              '000000',
              'fbf7ae',
              '6a6aff'
            ],
            bands: [
              'LCZ_Filter',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5281/zenodo.6364593',
  'sci:citation': |||
    Demuzere M.; Kittner J.; Martilli A.; Mills, G.; Moede, C.; Stewart, I.D.; van Vliet, J.; Bechtel, B.
    A global map of local climate zones to support earth system modelling and urban-scale environmental science.
    Earth System Science Data 2022, 14 Volume 8: 3835-3873.
    [doi:10.5194/essd-14-3835-2022](https://doi.org/10.5194/essd-14-3835-2022)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
