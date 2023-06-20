local id = 'CGIAR/SRTM90_V4';
local subdir = 'CGIAR';

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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'SRTM Digital Elevation Data Version 4',
  version: 'v4',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The Shuttle Radar Topography Mission (SRTM) digital
    elevation dataset was originally produced to provide consistent,
    high-quality elevation data at near global scope. This version
    of the SRTM digital elevation data has been processed to fill data
    voids, and to facilitate its ease of use.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'cgiar',
    'dem',
    'elevation',
    'geophysical',
    'srtm',
    'topography',
  ],
  providers: [
    ee.producer_provider('NASA/CGIAR', 'https://srtm.csi.cgiar.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -56.0, 180.0, 60.0,
                    '2000-02-11T00:00:00Z', '2000-02-22T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'elevation',
        description: 'Elevation',
        'gee:units': units.meter,
        gsd: 90,
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
              8000.0,
            ],
            bands: [
              'elevation',
            ],
          },
        },
      },
    ],
    elevation: {
      minimum: -444.0,
      maximum: 8806.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Jarvis, A., H.I. Reuter, A. Nelson, E. Guevara. 2008. Hole-filled
    SRTM for the globe Version 4, available from the CGIAR-CSI SRTM
    90m Database: [https://srtm.csi.cgiar.org](https://srtm.csi.cgiar.org).
  |||,
  'gee:terms_of_use': |||
    DISTRIBUTION. Users are prohibited from any commercial, non-free resale, or
    redistribution without explicit written permission from CIAT. Users should
    acknowledge CIAT as the source used in the creation of any reports,
    publications, new datasets, derived products, or services resulting from the
    use of this dataset. CIAT also request reprints of any publications and
    notification of any redistributing efforts. For commercial access to
    the data, send requests to [Andy Jarvis](mailto:a.jarvis@cgiar.org).

    NO WARRANTY OR LIABILITY. CIAT provides these data without any warranty of
    any kind whatsoever, either express or implied, including warranties of
    merchantability and fitness for a particular purpose. CIAT shall not be
    liable for incidental, consequential, or special damages arising out of
    the use of any data.

    ACKNOWLEDGMENT AND CITATION. Any users are kindly asked to cite this data
    in any published material produced using this data, and if possible link
    web pages to the [CIAT-CSI SRTM website](https://srtm.csi.cgiar.org).
  |||,
}
