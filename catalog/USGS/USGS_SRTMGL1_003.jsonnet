local id = 'USGS/SRTMGL1_003';
local subdir = 'USGS';

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
  title: 'NASA SRTM Digital Elevation 30m',
  version: '3',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The Shuttle Radar Topography Mission (SRTM, see [Farr
    et al. 2007](https://onlinelibrary.wiley.com/doi/10.1029/2005RG000183/full))
    digital elevation data is an international research effort that
    obtained digital elevation models on a near-global scale. This
    SRTM V3 product (SRTM Plus) is provided by NASA JPL
    at a resolution of 1 arc-second (approximately 30m).

    This dataset has undergone a void-filling process using open-source data
    (ASTER GDEM2, GMTED2010, and NED), as opposed to other versions that
    contain voids or have been void-filled with commercial sources.
    For more information on the different versions see the
    [SRTM Quick Guide](https://lpdaac.usgs.gov/documents/13/SRTM_Quick_Guide.pdf).

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/179/SRTM_User_Guide_V3.pdf)

    * [General Documentation](https://lpdaac.usgs.gov/documents/13/SRTM_Quick_Guide.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://doi.org/10.1029/2005RG000183)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'dem',
    'elevation',
    'geophysical',
    'nasa',
    'srtm',
    'topography',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA / USGS / JPL-Caltech', 'https://doi.org/10.5067/MEaSUREs/SRTM/SRTMGL1_NC.003'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2763266362-LPCLOUD',
  ],
  extent: ee.extent(-180.0, -56.0, 180.0, 60.0,
                    '2000-02-11T00:00:00Z', '2000-02-22T00:00:00Z'),
  summaries: {
    platform: [
      'Space Shuttle Endeavour',
    ],
    instruments: [
      'Shuttle Imaging Radar-C (SIR-C)',
    ],
    'eo:bands': [
      {
        name: 'elevation',
        description: 'Elevation',
        'gee:units': units.meter,
        gsd: 30.0,
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
              0.0,
            ],
            max: [
              6000.0,
            ],
            gamma: [
              1.6,
            ],
            bands: [
              'elevation',
            ],
          },
        },
      },
    ],
    elevation: {
      minimum: -10.0,
      maximum: 6500.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Farr, T.G., Rosen, P.A., Caro, E., Crippen, R., Duren, R., Hensley,
    S., Kobrick, M., Paller, M., Rodriguez, E., Roth, L., Seal, D.,
    Shaffer, S., Shimada, J., Umland, J., Werner, M., Oskin, M., Burbank,
    D., and Alsdorf, D.E., 2007, The shuttle radar topography mission:
    Reviews of Geophysics, v. 45, no. 2, RG2004, at
    [https://doi.org/10.1029/2005RG000183](https://doi.org/10.1029/2005RG000183).
  |||,
  'gee:terms_of_use': |||
    Unless otherwise noted, images and video on JPL public
    web sites (public sites ending with a jpl.nasa.gov address) may
    be used for any purpose without prior permission. For more information
    and exceptions visit the [JPL Image Use Policy site](https://www.jpl.nasa.gov/imagepolicy/).
  |||,
}
