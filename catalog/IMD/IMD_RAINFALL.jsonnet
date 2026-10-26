local id = 'IMD/RAINFALL';
local subdir = 'IMD';

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
  title: 'IMD: Daily Gridded Rainfall Over India (0.25 Degree)',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The India Meteorological Department (IMD) Daily Gridded Rainfall dataset
    provides daily accumulated rainfall at 0.25 x 0.25 degree spatial
    resolution over the Indian mainland from 1901 onwards. The dataset is
    developed and maintained by IMD Climate Research and Services (CRS), Pune,
    for monsoon variability studies, drought and flood monitoring, hydrological
    modeling, and long-term climate trend analysis.

    Daily rainfall grids are generated from quality-controlled observations
    collected across a nationwide archive of up to 6,955 rain gauge stations
    maintained by IMD, state governments, and partner agencies. Station records
    undergo multi-stage quality control checks before being interpolated onto a
    regular 0.25 x 0.25 degree latitude-longitude grid using Shepard's (1968)
    inverse distance weighted (IDW) interpolation scheme, which accounts for
    both radial distance and directional clustering of nearby stations.

    Users should note that the number of active reporting rain gauge stations
    varies over the historical record, and station density is lower in complex
    high-altitude terrain such as the northern Himalayas, which can increase
    interpolation uncertainty in data-sparse areas. Grid cells outside the
    Indian mainland land mask are masked out. Additional documentation is
    available on the
    [IMD Pune Gridded Data Portal](https://www.imdpune.gov.in/cmpg/Griddata/Rainfall_25_NetCDF.html).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.source,
      href: 'https://www.imdpune.gov.in/cmpg/Griddata/Rainfall_25_NetCDF.html',
    },
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.54302/mausam.v65i1.851',
    },
  ],
  'gee:categories': ['precipitation'],
  keywords: [
    'climate',
    'daily',
    'geophysical',
    'precipitation',
    'weather',
  ],
  providers: [
    ee.producer_provider(
      'India Meteorological Department (IMD)',
      'https://www.imdpune.gov.in/cmpg/Griddata/Rainfall_25_NetCDF.html'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(66.375, 6.375, 100.125, 38.625, '1901-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      27830.0,
    ],
    'eo:bands': [
      {
        name: 'rainfall',
        description: 'Daily accumulated rainfall',
        'gee:units': units.millimeter,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Daily Rainfall (mm)',
        lookat: {
          lat: 22.5,
          lon: 82.5,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              50.0,
            ],
            palette: [
              'ffffcc',
              'a1dab4',
              '41b6c4',
              '2c7fb8',
              '253494',
            ],
            bands: [
              'rainfall',
            ],
          },
        },
      },
    ],
    rainfall: {
      minimum: 0.0,
      maximum: 1000.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.54302/mausam.v65i1.851',
  'sci:citation': |||
    Pai, D.S., Latha Sridhar, Rajeevan, M., Sreejith, O.P., Satbhai, N.S. and
    Mukhopadhyay, B., 2014: Development of a new high spatial resolution
    (0.25x0.25 degree) Long period (1901-2010) daily gridded rainfall data set
    over India and its comparison with existing data sets over the region.
    MAUSAM, 65, 1, 1-18.
    [doi:10.54302/mausam.v65i1.851](https://doi.org/10.54302/mausam.v65i1.851)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    This dataset is made openly available by the
    [India Meteorological Department (IMD), Climate Research and Services, Pune](https://www.imdpune.gov.in/cmpg/Griddata/Rainfall_25_NetCDF.html).
    Users should acknowledge the India Meteorological Department (IMD) and cite
    Pai et al. (2014) in publications and derived works.

    Disclaimer from IMD: Although every care has been taken in preparing and
    testing the data set, India Meteorological Department cannot guarantee that
    the data are correct in all circumstances. India Meteorological Department
    also does not accept any liability whatsoever for any error or omission in
    the data, or for any loss or damage arising from its use.
  |||,
}
