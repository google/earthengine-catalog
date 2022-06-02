local id = 'WWF/HydroSHEDS/30DIR';
local subdir = 'WWF';

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
  title: 'WWF HydroSHEDS Drainage Direction, 30 Arc-Seconds',
  'gee:type': ee_const.gee_type.image,
  description: |||
    HydroSHEDS is a mapping product that provides hydrographic
    information for regional and global-scale applications in a consistent
    format. It offers a suite of geo-referenced datasets (vector and
    raster) at various scales, including river networks, watershed
    boundaries, drainage directions, and flow accumulations. HydroSHEDS
    is based on elevation data obtained in 2000 by NASA's Shuttle Radar
    Topography Mission (SRTM).

    This drainage direction dataset defines the direction
    of flow from each cell in the conditioned DEM to its steepest
    down-slope neighbor. Values of drainage direction vary from 1
    to 128. All final outlet cells to the ocean are flagged with
    a value of 0. All cells that mark the lowest point of an endorheic
    basin (inland sink) are flagged with a value of -1. The drainage
    direction values follow the convention adopted by ESRI's flow
    direction implementation: 1=E, 2=SE, 4=S, 8=SW, 16=W, 32=NW,
    64=N, 128=NE. \
    \
     This dataset is at 30 arc-second resolution.
    The datasets available at 30 arc-seconds are the Hydrologically
    Conditioned DEM, Drainage (Flow) Direction, and Flow Accumulation.

    Note that the quality of the HydroSHEDS data is significantly lower for regions above
    60 degrees northern latitude as there is no underlying SRTM elevation data available
    and thus a coarser-resolution DEM was (HYDRO1k provided by USGS).

    HydroSHEDS was developed by the World Wildlife Fund (WWF)
    Conservation Science Program in partnership with the U.S. Geological
    Survey, the International Centre for Tropical Agriculture, The
    Nature Conservancy, and the Center for Environmental Systems Research
    of the University of Kassel, Germany.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'direction',
    'drainage',
    'flow',
    'geophysical',
    'hydrography',
    'hydrology',
    'hydrosheds',
    'srtm',
    'water',
    'wwf',
  ],
  providers: [
    ee.producer_provider('WWF', 'https://www.hydrosheds.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -67.3, 180.0, 62.0,
                    '2000-02-11T00:00:00Z', '2000-02-22T00:00:00Z'),
  summaries: {
    gsd: [
      927.67,
    ],
    'eo:bands': [
      {
        name: 'b1',
        description: |||
          Drainage direction possible values: 1=E, 2=SE, 4=S,
          8=SW, 16=W, 32=NW, 64=N, 128=NE; final outlet cells to the ocean
          are flagged with a value of 0 and cells that mark the lowest
          point of an endorheic basin (inland sink) are flagged with a
          value of 255 (original value of -1)
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Drainage Direction',
        lookat: {
          lat: 38.022,
          lon: -121.652,
          zoom: 8,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              128.0,
            ],
            palette: [
              '000000',
              '023858',
              '006837',
              '1a9850',
              '66bd63',
              'a6d96a',
              'd9ef8b',
              'ffffbf',
              'fee08b',
              'fdae61',
              'f46d43',
              'd73027',
            ],
            bands: [
              'b1',
            ],
          },
        },
      },
    ],
    b1: {
      minimum: 0.0,
      maximum: 255.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Lehner, B., Verdin, K., Jarvis, A. (2008): New global hydrography
    derived from spaceborne elevation data. Eos, Transactions, AGU,
    89(10): 93-94.
  |||,
  'gee:terms_of_use': |||
    HydroSHEDS data are free for non-commercial and commercial
    use. For more information, please refer to the [License Agreement](https://www.hydrosheds.org/page/license).
  |||,
}
