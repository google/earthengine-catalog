local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

{
  common(
      id,
      subdir,
      title,
      description,
      self_ee_catalog_url,
      extent,
      terms_of_use,
      license,
      version_config
  ): {
    stac_version: ee_const.stac_version,
    type: ee_const.stac_type.collection,
    stac_extensions: [
      ee_const.ext_eo,
      ee_const.ext_ver,
    ],
    id: id,
    version: version_config.version,
    title: title,
    'gee:type': ee_const.gee_type.image_collection,
    description: description,
    license: license,
    links: ee.standardLinks(subdir, id) + version_config.version_links,
    'gee:categories': ['elevation-topography'],
    keywords: [
      'copernicus',
      'dem',
      'elevation',
      'geophysical',
    ],
    providers: [
      ee.producer_provider(
          'Copernicus',
          'https://dataspace.copernicus.eu/explore-data/data-collections/copernicus-contributing-missions/collections-description/COP-DEM'
      ),
      ee.host_provider(self_ee_catalog_url),
    ],
    extent: extent,
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
    'gee:terms_of_use': terms_of_use,
  }
}
