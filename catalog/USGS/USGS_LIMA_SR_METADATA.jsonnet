local id = 'USGS/LIMA/SR_METADATA';
local subdir = 'USGS';

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
    ee_const.ext_sci,
  ],
  id: id,
  title: 'Landsat Image Mosaic of Antarctica (LIMA) - Processed Landsat Scenes (16 bit) Metadata',
  'gee:type': ee_const.gee_type.table,
  description: |||
    The Landsat Image Mosaic of Antarctica (LIMA) is a seamless
    and virtually cloudless mosaic created from processed
    Landsat 7 ETM+ scenes.

    Processed Landsat Scenes (16 bit) are Level 1Gt NLAPS
    scenes converted to 16 bit, processed with sun-angle
    correction, and converted to reflectance values
    ([Bindschadler 2008](https://lima.usgs.gov/LIMA_paper.pdf)).

    Each Landsat scene is processed with elevation
    data and sun-angle correction to ensure surface features
    were accurately represented. The sun's angle in Antarctica
    gives the appearance of a setting sun. Because of the low
    sun angle, as Landsat passes over Antarctica, the outer
    edges of the continent appear brighter than areas closer
    to the South Pole, so scenes have bright and dark areas.
    Inconsistent sun angles and shadows where corrected for
    these scenes. Without this process, mosaicking would produce
    a patchwork of scenes since each scene would have a brighter
    and a darker side.

    This is a table which contains metadata for the Image Collection
    [USGS/LIMA/SR](USGS_LIMA_SR)

  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'antarctica',
    'ice',
    'landsat_derived',
    'lima',
    'mosaic',
    'sr',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://lima.usgs.gov/index.php'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -90.0, 180.0, -55.0,
                    '1999-06-30T00:00:00Z', '2002-09-04T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'ACQ_DATE',
        description: 'Acquisition date in YYYY-MM-DD format',
        type: ee_const.var_type.string,
      },
      {
        name: 'PATH',
        description: 'WRS path',
        type: ee_const.var_type.int,
      },
      {
        name: 'POLY_ID',
        description: 'Unique ID assigned to a polygon',
        type: ee_const.var_type.int,
      },
      {
        name: 'ROW',
        description: 'WRS row',
        type: ee_const.var_type.int,
      },
      {
        name: 'SCENE_ID',
        description: 'Scene ID',
        type: ee_const.var_type.string,
      },
      {
        name: 'SENSOR',
        description: 'Sensor',
        type: ee_const.var_type.string,
      },
      {
        name: 'SPACE',
        description: 'Name of the satellite used to gather data',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Antarctica',
        table_visualization: {
        color: 'black',
        point_size: 1,
      },
      lookat: {
        lon: 4.1,
        lat: -76.8,
        zoom: 2,
      },
      },
    ],
  },
  'gee:skip_featureview_generation': true,
  'sci:citation': |||
    Bindschadler, R., Vornberger, P., Fleming, A., Fox, A., Mullins, J.,
    Binnie, D., Paulson, S., Granneman, B., and Gorodetzky, D., 2008,
    The Landsat Image Mosaic of Antarctica, Remote Sensing of
    Environment, 112, pp. 4214-4226.
    [PDF](https://lima.usgs.gov/LIMA_paper.pdf)
  |||,
  'gee:terms_of_use': |||
    These images are in the public domain and can be used freely
    and without acknowledgement. However, credit to the Landsat
    Image Mosaic of Antarctica (LIMA) Project is greatly appreciated.
  |||,
}
