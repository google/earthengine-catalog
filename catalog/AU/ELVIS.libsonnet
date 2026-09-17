local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

{
  license: spdx.cc_by_4_0,
  provider: {
    name: 'Geoscience Australia',
    url: 'https://elevation.fsdf.org.au/',
  },
  common_description: |||
    The ELVIS (Elevation and Depth — Foundation Spatial Data) platform is a
    cloud-based system that enables users to discover and obtain Australian
    elevation and bathymetry data. It was developed as a partnership between
    participating agencies under the Intergovernmental Committee on Surveying
    and Mapping (ICSM) and brings together open data from Commonwealth, state
    and territory governments. Precision elevation products are defined as
    Digital Terrain Models (or bare earth DEMs) captured from either LiDAR
    sources or photogrammetrically derived from aerial photography.

    The data is not hydrologically enforced (breaklines) or hydrologically
    conditioned. The acquisition has been a long-term collaboration between
    Geoscience Australia, the Cooperative Research Centre for Spatial
    Information (CRCSI), the Departments of Climate Change and Environment,
    State and Territory jurisdictions, Local Government, and the Murray Darling
    Basin Authority under the auspices of the National Elevation Data Framework
    and Coastal and Urban DEM Program, with additional data supplied by the
    Australian Department of Defence.

    Coverage is concentrated along Australia's populated coastal zone,
    floodplain areas within the Murray Darling Basin, and individual surveys
    of major and minor population centres. LiDAR coverage is most
    comprehensive along coastal areas, major cities, and flood-prone regions.
    Inland and remote areas have limited coverage.
  |||,
  common_keywords: [
    'australia',
    'dem',
    'elevation',
    'elevation-topography',
    'ga',
    'geoscience-australia',
    'lidar',
  ],
  elevation_band: {
    name: 'elevation',
    description: 'Elevation',
    'gee:units': units.meter,
  },
  visualizations: [
    {
      display_name: 'Elevation',
      lookat: {
        lat: -28.0,
        lon: 135.0,
        zoom: 4,
      },
      image_visualization: {
        band_vis: {
          min: [
            0.0,
          ],
          max: [
            1000.0,
          ],
          palette: [
            '0000ff',
            '00ffff',
            'ffff00',
            'ff0000',
            'ffffff',
          ],
          bands: [
            'elevation',
          ],
        },
      },
    },
  ],
  terms_of_use: |||
    This dataset is made available by Geoscience Australia under the
    Creative Commons Attribution 4.0 International (CC BY 4.0) license.
  |||,
}
