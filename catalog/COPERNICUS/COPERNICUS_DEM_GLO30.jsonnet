local id = 'COPERNICUS/DEM/GLO30';
local subdir = 'COPERNICUS';

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
    ee_const.ext_eo
  ],
  id: id,
  title: 'Copernicus DEM GLO-30: Global 30m Digital Elevation Model',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Copernicus DEM is a Digital Surface Model (DSM) which represents the
    surface of the Earth including buildings, infrastructure and vegetation.
    This DEM is derived from an edited DSM named WorldDEM&trade, i.e. flattening of
    water bodies and consistent flow of rivers has been included. Editing of
    shore- and coastlines, special features such as airports and implausible
    terrain structures has also been applied.

    The WorldDEM product is based on the radar satellite data acquired during
    the TanDEM-X Mission, which is funded by a Public Private Partnership
    between the German State, represented by the German Aerospace Centre (DLR)
    and Airbus Defence and Space. More details are available in the dataset
    [documentation](https://spacedata.copernicus.eu/documents/20123/121239/GEO1988-CopernicusDEM-SPE-002_ProductHandbook_I4.0.pdf).

    Earth Engine asset has been ingested from the DGED files.

    Note: See the code example for the recommended way of computing slope.
    Unlike most DEMs in Earth Engine, this is an image collection due to
    multiple resolutions of source files that make it impossible to mosaic them
    into a single asset, so the slope computations need a reprojection.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'copernicus',
    'dem',
    'elevation',
    'geophysical',
  ],
  providers: [
    ee.producer_provider('Copernicus', 'https://spacedata.copernicus.eu/collections/copernicus-digital-elevation-model'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2010-12-01T00:00:00Z', '2015-01-31T00:00:00Z'),
  summaries: {
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'DEM',
        description: 'Digital Surface Model',
      },
      {
        name: 'EDM',
        description: |||
          The Edit Data Mask indicates all DEM pixels that were modified
          during the terrain and hydro editing process.
        |||,
        'gee:classes': [
          {
            value: 0,
            description: 'Void (no data)'
          },
          {
            value: 1,
            description: 'Not edited',
          },
          {
            value: 2,
            description: 'Infill of external elevation data',
          },
          {
            value: 3,
            description: 'Interpolated pixels',
          },
          {
            value: 4,
            description: 'Smoothed pixels',
          },
          {
            value: 5,
            description: 'Airport editing',
          },
          {
            value: 6,
            description: 'Raised negative elevation pixels',
          },
          {
            value: 7,
            description: 'Flattened pixels',
          },
          {
            value: 8,
            description: 'Ocean pixels',
          },
          {
            value: 9,
            description: 'Lake pixels',
          },
          {
            value: 10,
            description: 'River pixels',
          },
          {
            value: 11,
            description: 'Shoreline pixels',
          },
          {
            value: 12,
            description: 'Morphed pixels (series of pixels manually set)',
          },
          {
            value: 13,
            description: 'Shifted pixels',
          },
        ]
      },
      {
        name: 'FLM',
        description: |||
          The Filling Mask is created primarily during the terrain
          editing process.
        |||,
        'gee:classes': [
          {
            value: 0,
            description: 'Void (no data)'
          },
          {
            value: 1,
            description: 'Edited (except filled pixels)',
          },
          {
            value: 2,
            description: 'Not edited / not filled',
          },
          {
            value: 3,
            description: 'ASTER',
          },
          {
            value: 4,
            description: 'SRTM90',
          },
          {
            value: 5,
            description: 'SRTM30',
          },
          {
            value: 6,
            description: 'GMTED2010',
          },
          {
            value: 7,
            description: 'SRTM30plus',
          },
          {
            value: 8,
            description: 'TerraSAR-X Radargrammetric DEM',
          },
          {
            value: 9,
            description: 'AW3D30',
          },
          {
            value: 100,
            description: 'Norway DEM',
          },
          {
            value: 101,
            description: 'DSM05 Spain',
          },
        ]
      },
      {
        name: 'HEM',
        description: |||
          The Height Error Mask represents the corresponding height error
          for each DEM pixel in the form of the standard deviation derived from
          the interferometric coherence and geometrical considerations.
        |||,
      },
      {
        name: 'WBM',
        description: |||
          The Water Body Mask shows all DEM pixels which are classified as water
          and edited according to the categories Ocean, Lake or River.
        |||,
        'gee:classes': [
          {
            value: 0,
            description: 'No water'
          },
          {
            value: 1,
            description: 'Ocean',
          },
          {
            value: 2,
            description: 'Lake',
          },
          {
            value: 3,
            description: 'River',
          },
        ]
      }
    ],
    'gee:visualizations': [
      {
        display_name: 'Elevation',
        lookat: {
          lat: -6.746,
          lon: 46.529,
          zoom: 2,
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
              'DEM',
            ],
          },
        },
      },
    ],
    EDM: {
      minimum: 0,
      maximum: 13,
      'gee:estimated_range': false,
    },
    FLM: {
      minimum: 0,
      maximum: 101,
      'gee:estimated_range': false,
    },
    WBM: {
      minimum: 0,
      maximum: 3,
      'gee:estimated_range': false,
    }
  },
  // Citation will be added once Copernicus fixes the citation link
  'gee:terms_of_use': |||
    The GLO-30 dataset is available worldwide with a free license with the
    exception of two countries (Armenia and Azerbaijan). [License for Copernicus
    DEM](https://docs.sentinel-hub.com/api/latest/static/files/data/dem/resources/license/License-COPDEM-30.pdf).
  |||,
}
