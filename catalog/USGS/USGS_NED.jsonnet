local id = 'USGS/NED';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/NED_versions.libsonnet';

local subdir = 'USGS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
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
  title: 'USGS National Elevation Dataset 1/3 Arc-Second [deprecated]',
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The National Elevation Dataset (NED) used to be* the
    primary elevation data product of the USGS. The NED is a seamless
    dataset with the best available raster elevation data of the
    conterminous United States, parts of Alaska, Hawaii, and some
    territorial islands. The NED is derived from diverse source data
    that are processed to a common coordinate system and unit of
    vertical measure. NED data are distributed in conformance with
    the North American Datum of 1983 (NAD 83). All elevation values
    are in meters and, over the conterminous United States, are referenced
    to the North American Vertical Datum of 1988 (NAVD 88). The vertical
    reference will vary in other areas.

    *For over 15 years, the NED was the primary elevation data product
    of the USGS' National Map. However, it has been renamed and now
    considered just one component of elevation in The National
    Map after the 3D Elevation Program became operational.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'dem',
    'elevation',
    'geophysical',
    'ned',
    'topography',
    'usgs',
  ],
  providers: [
    ee.producer_provider('United States Geological Survey', 'https://nationalmap.gov/elevation.html'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent(-171.0, -15.0, 164.0, 70.0,
                    '2012-02-07T00:00:00Z', '2012-02-07T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'elevation',
        description: 'Elevation',
        'gee:units': units.meter,
        gsd: 10.2,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Elevation',
        lookat: {
          lat: 40.71,
          lon: -100.55,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              4000.0,
            ],
            gamma: [
              1.6,
            ],
            bands: [
              'elevation',
            ],
          },
        },
      },
    ],
    elevation: {
      minimum: -85.61,
      maximum: 4414.22,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': 'USGS National Elevation Dataset courtesy of the U.S. Geological Survey',
  'gee:terms_of_use': |||
    Most U.S. Geological Survey (USGS) information resides
    in the public domain and may be used without restriction. Additional
    information on [Acknowledging or Crediting USGS as Information
    Source](https://www.usgs.gov/information-policies-and-instructions/crediting-usgs) is available.
  |||,
  version: ee_const.version_unknown,
}
