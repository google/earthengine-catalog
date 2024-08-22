local id = 'USGS/GMTED2010';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/GMTED2010_versions.libsonnet';

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
    ee_const.ext_ver
  ],
  id: id,
  title: 'GMTED2010: Global Multi-resolution Terrain Elevation Data 2010, Breakline Emphasis [deprecated]',
  version: version,
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The Global Multi-resolution Terrain Elevation Data
    2010 (GMTED2010) dataset contains elevation data for the globe
    collected from various sources. The version of the dataset available
    here is Breakline Emphasis, 7.5 arc-seconds resolution. Breakline
    emphasis maintains the critical topographic features (streams or
    ridges) within the landscape by maintaining any minimum elevation
    or maximum elevation value on a breakline that passes within the
    specified analysis window. More details are available in the dataset
    [report](https://pubs.usgs.gov/of/2011/1073/pdf/of2011-1073.pdf).

    The primary source dataset for GMTED2010 is NGA''s SRTM Digital
    Terrain Elevation Data (DTED&reg;, [https://www2.jpl.nasa.gov/srtm/](https://www2.jpl.nasa.gov/srtm/))
    (void-filled) 1-arc-second data. For the geographic areas outside
    the SRTM coverage area and to fill in remaining holes in the SRTM
    data, the following sources were used: non-SRTM DTED&reg;, Canadian
    Digital Elevation Data (CDED) at two resolutions, Satellite Pour
    l''Observation de la Terre (SPOT 5) Reference3D, National Elevation
    Dataset (NED) for the continental United States and Alaska, GEODATA
    9 second digital elevation model (DEM) for Australia, an Antarctica
    satellite radar and laser altimeter DEM, and a Greenland satellite
    radar altimeter DEM.

    This dataset replaces the GTOPO30 Elevation Model.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'dem',
    'elevation',
    'geophysical',
    'srtm',
    'topography',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://www.usgs.gov/core-science-systems/eros/coastal-changes-and-impacts/gmted2010'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -56.0, 180.0, 84.0,
                    '2010-01-01T00:00:00Z', '2010-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      231.92,
    ],
    'eo:bands': [
      {
        name: 'be75',
        description: 'Elevation',
        'gee:units': units.meter,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Elevation',
        lookat: {
          lat: 7.71,
          lon: 17.93,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              -100.0,
            ],
            max: [
              6500.0,
            ],
            gamma: [
              3.5,
            ],
            bands: [
              'be75',
            ],
          },
        },
      },
    ],
    be75: {
      minimum: -457.0,
      maximum: 8746.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': 'Global Multi-resolution Terrain Elevation Data 2010 courtesy of\nthe U.S. Geological Survey',
  'gee:terms_of_use': |||
    Most U.S. Geological Survey (USGS) information resides
    in the public domain and may be used without restriction. Additional
    information on [Acknowledging or Crediting USGS as Information
    Source](https://www.usgs.gov/information-policies-and-instructions/crediting-usgs) is available.
  |||,
}
