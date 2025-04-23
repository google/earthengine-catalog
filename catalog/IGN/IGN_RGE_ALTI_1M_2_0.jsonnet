local id = 'IGN/RGE_ALTI/1M/2_0';
local subdir = 'IGN';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.etalab_2_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'RGE ALTI: IGN RGE ALTI Digital Elevation 1m',
  version: '2.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The RGE ALTI dataset describes the digital elevation model (DEM) of France
    with the pixel size of 1m.  It was created from surveys obtained by airborne
    lidar or by correlation of aerial images.

    Lidar was deployed for flood-prone, coastal, and large forest
    areas. The vertical accuracy of the DEM in these areas is between
    0.2m and 0.5m. Radar was used in mountain areas (Alps, Pyrenees,
    Cevennes, Corsica). Caution: in areas with steep slopes, the average
    vertical accuracy is the order of 7m.

    The accuracy of these fields has been checked against various sources:
    the road and hydrographic networks of the
    [BD TOPO](https://geoservices.ign.fr/bdtopo), geodetic terminals and
    points calculated on the ground.

    Aerial photo correlation techniques are used in the rest of the territory.
    On certain zones treated by correlation, ground measurements are absent
    over large extents due to the presence of vegetation
    (wooded areas, for example). 1987-2001 altimetry data (BD Alti) are used
    to fill these gaps. The vertical accuracy of the DEM on these areas
    is between 0.5m and 0.7m.

    Currently the collection includes a single image IGN/RGE_ALTI/1M/2_0/FXX
    showing metropolitan France.

    This dataset was prepared and ingested with the support of Guillaume Attard
    and Julien Bardonnet ([AGEOCE](https://www.ageoce.com)).
    The preparation process is
    [described here](https://medium.com/@gui.attard/pre-processing-the-dem-of-france-rge-alti-5m-for-implementation-into-earth-engine-de9a0778e0d9).

    See also:
    [user's guide](https://geoservices.ign.fr/sites/default/files/2021-07/DC_RGEALTI_2-0.pdf).

  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['elevation-topography'],
  keywords: [
    'dem',
    'elevation',
    'geophysical',
  ],
  providers: [
    ee.producer_provider('IGN', 'https://geoservices.ign.fr/rgealti'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-5.2, 41.35, 9.85, 51.14,
                    '2009-01-01T00:00:00Z', '2021-01-01T00:00:00Z'),
  summaries: {
    'gsd': [1.0],
    'eo:bands': [
      {
        name: 'MNT',
        description: 'Terrain elevation in meters.',
        'gee:units': units.meter,
      },
      {
        name: 'SRC',
        description: |||
          The main source of the data used to calculate the altitude
          of the node. See Appendix B page 26 in the
          [user guide](https://geoservices.ign.fr/sites/default/files/2021-07/DC_RGEALTI_2-0.pdf).
        |||,
      },
      {
        name: 'DST',
        description: |||
          The distance in meters between the node and the nearest point used to
          calculate its altitude.
        |||,
        'gee:units': units.meter,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'MNT (elevation)',
        lookat: {
          lat: 47,
          lon: 3,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              1000.0,
            ],
            palette: [
              '006600', '002200', 'fff700', 'ab7634', 'c4d0ff', 'ffffff'
            ],
            bands: [
              'MNT',
            ],
          },
        },
      },
    ],
    MNT: {
      minimum: -40.0,
      maximum: 4810.0,
      'gee:estimated_range': true,
    },
    DST: {
      minimum: 0.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    IGN (2021). RGE ALTI 1m [Data set]. Accessed 2022-07-01 from
    [IGN website](https://geoservices.ign.fr/rgealti#telechargement1m)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
