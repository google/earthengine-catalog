local id = 'OSU/GIMP/2000_IMAGERY_MOSAIC';
local subdir = 'OSU';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: '2000 Greenland Mosaic - Greenland Ice Mapping Project (GIMP)',
  version: '1',
  'gee:type': ee_const.gee_type.image,
  description: |||
    This dataset provides a complete 15 m resolution image mosaic
    of the Greenland ice sheet derived from Landsat 7 ETM+ and
    RADARSAT-1 SAR imagery from the years 1999 to 2002. The methods
    include a combination of image cloud masking, pan sharpening,
    image sampling and resizing, and image coregistration.
    Please see Howat, 2014 for more information regarding
    processing methods.

    **Note**

    *  Users of GIMP DEM or GIMP 2000 Image Mosaic images may find
    it helpful to mask out areas outside of the Greenland coastline
    using the corresponding 15 m ocean mask image
    Greenland Ice Mapping Project (GIMP) Land Ice and Ocean
    Classification Mask,
    *  The SAR data are distributed at 20 m resolution. Data were
    up-sampled through bilinear interpolation to 15 m to match
    the resolution of Landsat band-8.

    [General documentation](https://doi.org/10.5067/4RNTRRE4JCYD)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: 'cite-as',
      href: 'https://doi.org/10.5067/4RNTRRE4JCYD',
    },
  ],
  keywords: [
    'arctic',
    'gimp',
    'greenland',
    'imagery',
    'nasa',
    'polar',
    'radarsat-1',
  ],
  providers: [
    ee.producer_provider('NASA NSIDC DAAC at CIRES', 'https://doi.org/10.5067/4RNTRRE4JCYD'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1602494076-NSIDC_ECS',
  ],
  extent: ee.extent(-89.3211593425295, 58.79601275381146, 7.555941634834938, 83.95386175580668,
                    '1999-06-30T00:00:00Z', '2002-09-04T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'B1',
        description: 'Landsat 7 ETM+ blue',
        gsd: 15.0,
        'gee:wavelength': '0.45 - 0.52 µm',
      },
      {
        name: 'B2',
        description: 'Landsat 7 ETM+ green',
        gsd: 15.0,
        'gee:wavelength': '0.52 - 0.60 µm',
      },
      {
        name: 'B3',
        description: 'Landsat 7 ETM+ red',
        gsd: 15.0,
        'gee:wavelength': '0.63 - 0.69 µm',
      },
      {
        name: 'B4',
        description: 'Landsat 7 ETM+ near infrared',
        gsd: 15.0,
        'gee:wavelength': '0.77 - 0.90 µm',
      },
      {
        name: 'B5',
        description: 'Landsat 7 ETM+ shortwave infrared 1',
        gsd: 30.0,
        'gee:wavelength': '1.55 - 1.75 µm',
      },
      {
        name: 'B6_low_gain',
        description: |||
          Landsat 7 ETM+ low-gain thermal Infrared 1.
          This band has expanded dynamic range and lower radiometric
          resolution (sensitivity), with less
          saturation at high Digital Number (DN) values. Resampled from
          60m to 30m.
        |||,
        gsd: 30.0,
        'gee:wavelength': '10.40 - 12.50 µm',
      },
      {
        name: 'B6_high_gain',
        description: |||
          Landsat 7 ETM+ high-gain thermal Infrared 1.
          This band has higher radiometric resolution (sensitivity),
          although it has a more restricted dynamic range.
          Resampled from 60m to 30m.
        |||,
        gsd: 30.0,
        'gee:wavelength': '10.40 - 12.50 µm',
      },
      {
        name: 'B7',
        description: 'Landsat 7 ETM+ shortwave infrared 2',
        gsd: 30.0,
        'gee:wavelength': '2.08 - 2.35 µm',
      },
      {
        name: 'B8',
        description: 'Landsat 7 ETM+ panchromatic',
        gsd: 15.0,
        'gee:wavelength': '0.52 - 0.90 µm',
      },
      {
        name: 'B8_radarsat',
        description: 'RADARSAT-1 synthetic aperture radar amplitude imagery',
        gsd: 15.0,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Greenland Pansharpened Image Mosaic RGB',
        lookat: {
          lat: 70.4,
          lon: -29.1605,
          zoom: 9,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              255.0,
            ],
            bands: [
              'B3',
              'B2',
              'B1',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5067/4RNTRRE4JCYD',
  'sci:citation': |||
    Howat, I.M., A. Negrete, B.E. Smith, 2014, The Greenland Ice
    Mapping Project (GIMP) land classification and surface elevation
    datasets, The Cryosphere, 8, 1509-1518,
    [doi:10.5194/tc-8-1509-2014](https://doi.org/10.5194/tc-8-1509-2014)
    [article pdf](https://www.the-cryosphere.net/8/1509/2014/tc-8-1509-2014.pdf)
  |||,
  'gee:terms_of_use': |||
    As a condition of using these data, you must cite the use of this
    data set using the given citation.
  |||,
}
