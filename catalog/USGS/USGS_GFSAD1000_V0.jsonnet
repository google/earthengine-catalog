local id = 'USGS/GFSAD1000_V0';
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
  title: 'GFSAD1000: Cropland Extent 1km Crop Dominance, Global Food-Support Analysis Data [deprecated]',
  version: version,
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The GFSAD is a NASA-funded project to provide high-resolution global
    cropland data and their water use that contributes towards global food
    security in the twenty-first century. The GFSAD products are derived
    through multi-sensor remote sensing data (e.g., Landsat, MODIS, AVHRR),
    secondary data, and field-plot data and aims at documenting cropland
    dynamics.

    At a nominal 1km scale, V0.0 provides the spatial distribution of the
    five major global cropland types (wheat, rice, corn, barley, and soybeans)
    which occupy 60% of all global cropland areas. The map is produced by
    overlaying these crops over the remote sensing derived global irrigated and
    rainfed cropland area map of the International Water Management Institute.
    V0.0 an 8-class product that provides information on global: cropland
    extent, crop dominance, irrigated versus rainfed cropping, and cropping
    intensity (single, double, triple, and continuous crops). The GFSAD1000
    nominal 2010 product was created with data from 2007 to 2012.
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
  extent: ee.extent_global('2010-01-01T00:00:00Z', '2011-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      1000.0,
    ],
    'eo:bands': [
      {
        name: 'landcover',
        description: 'Crop dominance class descriptions',
        'gee:classes': [
          {
            color: 'black',
            description: 'Non-croplands',
            value: 0,
          },
          {
            value: 1,
            color: 'white',
            description: 'Irrigated: wheat and rice',
          },
          {
            value: 2,
            color: 'green',
            description: 'Irrigated mixed crops 1: Wheat, rice, barley, soybeans',
          },
          {
            value: 3,
            color: 'yellow',
            description: 'Irrigated mixed crops 2: wheat, rice, cotton, orchards',
          },
          {
            value: 4,
            color: 'brown',
            description: 'Rainfed: wheat, rice, soybeans, sugarcane, corn, cassava',
          },
          {
            value: 5,
            color: 'orange',
            description: 'Rainfed: wheat, barley',
          },
          {
            value: 6,
            color: 'forestgreen',  // was 02be11
            description: 'Rainfed: corn, soybens',
          },
          {
            value: 7,
            color: 'darkgreen',  // was 015e08
            description: 'Rainfed mixed crops: wheat, corn, rice, barley, soybeans',
          },
          {
            value: 8,
            color: 'darkseagreen',  // was 02a50f
            description: 'Fractions of mixed crops: wheat, maize, rice, barley, soybeans',
          },
          {
            value: 9,
            color: 'purple',
            description: 'Other classes',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Crop Dominance',
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
              9.0,
            ],
            palette: [
              'black',
              'white',
              'green',
              'yellow',
              'brown',
              'orange',
              'forestgreen',  // was 02be11
              'darkgreen',  // was 015e08
              'darkseagreen',  // was 02a50f
              'purple',
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
    Thenkabail P.S., Knox J.W., Ozdogan, M., Gumma, M.K., Congalton, R.G., Wu,
    Z., Milesi, C., Finkral, A., Marshall, M., Mariotto, I., You, S. Giri, C.
    and Nagler, P. 2012. Assessing future risks to agricultural productivity,
    water resources and food security: how can remote sensing help?.
    Photogrammetric Engineering and Remote Sensing, August 2012 Special Issue
    on Global Croplands: Highlight Article. 78(8): 773-782.
  |||,
  'gee:terms_of_use': |||
    Most U.S. Geological Survey (USGS) information resides
    in the public domain and may be used without restriction. Additional
    information on [Acknowledging or Crediting USGS as Information
    Source](https://www.usgs.gov/information-policies-and-instructions/crediting-usgs) is available.
  |||,
}
