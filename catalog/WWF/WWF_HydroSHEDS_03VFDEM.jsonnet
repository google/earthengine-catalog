local id = 'WWF/HydroSHEDS/03VFDEM';
local subdir = 'WWF';

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
  ],
  id: id,
  title: 'WWF HydroSHEDS Void-Filled DEM, 3 Arc-Seconds',
  'gee:type': ee_const.gee_type.image,
  description: |||
    HydroSHEDS is a mapping product that provides hydrographic
    information for regional and global-scale applications in a consistent
    format. It offers a suite of geo-referenced datasets (vector and
    raster) at various scales, including river networks, watershed
    boundaries, drainage directions, and flow accumulations. HydroSHEDS
    is based on elevation data obtained in 2000 by NASA's Shuttle Radar
    Topography Mission (SRTM).

    This void-filled elevation dataset is the first step
    towards producing the conditioned DEM datasets. Spikes and wells
    in the SRTM data were detected and voided out. Small voids were
    filled by interpolation of surrounding elevations. The ocean
    was set to an elevation of 0 meters, and lakes, islands, and
    rivers were filled using other techniques. Full details of the
    underlying digital elevation model are available in the HydroSHEDS
    website and documentation.

    This dataset is at 3 arc-second
    resolution. The datasets available at 3 arc-seconds are the Void-Filled
    DEM, Hydrologically Conditioned DEM, and Drainage (Flow) Direction.

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
    'dem',
    'elevation',
    'geophysical',
    'hydrography',
    'hydrology',
    'hydrosheds',
    'srtm',
    'topography',
    'void_filled',
    'water',
    'wwf',
  ],
  providers: [
    ee.producer_provider('WWF', 'https://www.hydrosheds.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -67.3, 180.0, 60.0,
                    '2000-02-11T00:00:00Z', '2000-02-22T00:00:00Z'),
  summaries: {
    gsd: [
      92.77,
    ],
    'eo:bands': [
      {
        name: 'b1',
        description: 'Elevation',
        'gee:units': units.meters,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Elevation',
        lookat: {
          lat: 38.022,
          lon: -121.652,
          zoom: 8,
        },
        image_visualization: {
          band_vis: {
            min: [
              -50.0,
            ],
            max: [
              3000.0,
            ],
            gamma: [
              2.0,
            ],
            bands: [
              'b1',
            ],
          },
        },
      },
    ],
    b1: {
      minimum: -424.0,
      maximum: 8642.0,
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
