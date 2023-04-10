local id = 'CPOM/CryoSat2/ANTARCTICA_DEM';
local subdir = 'CPOM';

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
  title: 'CryoSat-2 Antarctica 1km DEM',
  version: '1.0',
  'gee:type': ee_const.gee_type.image,
  description: |||
    This dataset is a digital elevation model (DEM) of the
    Antarctic ice sheet and ice shelves based on
    observations recorded by the CryoSat-2 satellite
    radar altimeter between July 2010 and July 2016.

    The DEM is formed from spatio-temporal fits to elevation
    measurements accumulated within 1, 2, and 5 km grid cells,
    and is posted at the modal resolution of 1 km. The median
    and root mean square difference between the DEM and 2.3*10&#8311;
    airborne laser altimeter measurements acquired during
    NASA Operation IceBridge campaigns are -0.30 and 13.50 m,
    respectively.

    The DEM uncertainty rises in regions of high slope,
    especially where elevation measurements were acquired in
    low-resolution mode; taking this into account, we estimate
    the average accuracy to be 9.5 m.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5194/tc-2017-223',
    },
  ],
  keywords: [
    'antarctica',
    'cpom',
    'cryosat_2',
    'dem',
    'elevation',
    'polar',
  ],
  providers: [
    ee.producer_provider('CPOM', 'http://www.cpom.ucl.ac.uk/csopr/icesheets2/dems.php?ais_subject=dem&user_type=normal'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -88.0, 180.0, -60.0,
                    '2010-07-01T00:00:00Z', '2016-07-01T00:00:00Z'),
  summaries: {
    gsd: [
      1000.0,
    ],
    'eo:bands': [
      {
        name: 'elevation',
        description: 'Antarctic ice sheet and ice shelf elevation.',
        'gee:units': units.meters,
      },
      {
        name: 'data_composition',
        description: 'Data processing method of elevation per grid cell.',
        'gee:classes': [
          {
            color: '000000',
            description: 'interpolated',
            value: 0,
          },
          {
            value: 1,
            color: 'cbcbcb',
            description: '1 km fit',
          },
          {
            value: 2,
            color: '377eb7',
            description: 'resampled 2 km fit',
          },
          {
            value: 3,
            color: 'e2191b',
            description: 'resampled 5 km fit',
          },
        ],
      },
      {
        name: 'slope',
        description: 'Slope derived from elevation gradient.',
        'gee:units': 'degrees',
      },
      {
        name: 'z_smoothed',
        description: 'Smoothed version of elevation model using a median filter.',
        'gee:units': units.meters,
      },
      {
        name: 'z_uncertainty',
        description: |||
          Certainty of elevation model derived from RMS of elevation
          residuals in observed grid cells and the kriging variance error
          in interpolated grid cells.
        |||,
        'gee:units': units.meters,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Elevation',
        lookat: {
          lat: -76.0,
          lon: 17.0,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              4000.0,
            ],
            palette: [
              '001fff',
              '00ffff',
              'fbff00',
              'ff0000',
            ],
            bands: [
              'elevation',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5194/tc-2017-223',
  'sci:citation': |||
    Slater, T., Shepherd, A., McMillan, M., Muir, A., Gilbert, L.,
    Hogg, A. E., Konrad, H. and Parrinello, T.: A new Digital Elevation
    Model of Antarctica derived from CryoSat-2 altimetry, The Cryosphere,
    [doi:10.5194/tc-2017-223](https://doi.org/10.5194/tc-2017-223), 2018
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
