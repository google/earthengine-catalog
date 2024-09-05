local id = 'USGS/GFSAD1000_V1';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/GFSAD1000_versions.libsonnet';

local subdir = 'USGS';

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
  title: 'GFSAD1000: Cropland Extent 1km Multi-Study Crop Mask, Global Food-Support Analysis Data',
  version: version,
  'gee:type': ee_const.gee_type.image,
  description: |||
    The GFSAD is a NASA-funded project to provide high-resolution global
    cropland data and their water use that contributes towards global food
    security in the twenty-first century. The GFSAD products are derived
    through multi-sensor remote sensing data (e.g., Landsat, MODIS, AVHRR),
    secondary data, and field-plot data and aims at documenting cropland
    dynamics.

    At a nominal 1km scale, V0.1 provides the spatial distribution of a
    disaggregated five-class global cropland extent map derived from four
    major studies: Thenkabail et al. (2009a, 2011), Pittman et al. (2010),
    Yu et al. (2013), and Friedl et al. (2010). V1.0 is a 5-class product that
    provides information on global cropland extent and irrigated versus rainfed
    cropping. There is no crop type or crop type dominance information. Cropping
    intensity (single, double, triple, and continuous crops) can be obtained for
    every pixel using time-series remote sensing data. The GFSAD1000 nominal
    2010 product was created with data from 2007 to 2012.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'crop',
    'gfsad',
    'landcover',
    'usgs',
  ],
  providers: [
    ee.producer_provider('Global Food Security-support Analysis Data at 30m Project (GFSAD30)', 'https://geography.wr.usgs.gov/science/croplands/'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2010-01-01T00:00:00Z', '2010-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      1000.0,
    ],
    'eo:bands': [
      {
        name: 'landcover',
        description: 'Crop mask class descriptions',
        'gee:classes': [
          {
            color: 'black',
            description: 'Non-croplands',
            value: 0,
          },
          {
            value: 1,
            color: 'orange',
            description: 'Croplands: irrigation major',
          },
          {
            value: 2,
            color: 'brown',
            description: 'Croplands: irrigation minor',
          },
          {
            value: 3,
            color: 'darkseagreen',  // was 02a50f
            description: 'Croplands: rainfed',
          },
          {
            value: 4,
            color: 'green',
            description: 'Croplands: rainfed, minor fragments',
          },
          {
            value: 5,
            color: 'yellow',
            description: 'Croplands: rainfed, very minor fragments',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Crop Mask',
        lookat: {
          lat: 26.4,
          lon: -88.6,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              5.0,
            ],
            palette: [
              'black',
              'orange',
              'brown',
              'darkseagreen',  // was 02a50f
              'green',
              'yellow',
            ],
            bands: [
              'landcover',
            ],
          },
        },
      },
    ],
    landcover: {
      minimum: 0.0,
      maximum: 9.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    [Teluguntla, P., Thenkabail, P.S., Xiong, J., Gumma, M.K., Giri, C., Milesi,
    C., Ozdogan, M., Congalton, R., Tilton, J., Sankey, T.R., Massey, R.,
    Phalke, A., and Yadav, K. 2014. Global Cropland Area Database (GCAD)
    derived from Remote Sensing in Support of Food Security in the Twenty-first
    Century: Current Achievements and Future Possibilities. Chapter 7, Vol. II.
    Land Resources: Monitoring, Modelling, and Mapping, Remote Sensing Handbook
    edited by Prasad S. Thenkabail. In Press.](https://lpdaac.usgs.gov/documents/173/GFSAD1K_ATBD.pdf)
  |||,
  'gee:terms_of_use': |||
    Most U.S. Geological Survey (USGS) information resides
    in the public domain and may be used without restriction. Additional
    information on [Acknowledging or Crediting USGS as Information
    Source](https://www.usgs.gov/information-policies-and-instructions/acknowledging-or-crediting-usgs)
    is available.
  |||,
}
