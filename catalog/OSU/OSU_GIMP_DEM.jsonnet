local id = 'OSU/GIMP/DEM';
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
  title: 'Greenland DEM - Greenland Mapping Project (GIMP)',
  version: '2.2',
  'gee:type': ee_const.gee_type.image,
  description: |||
    This Digital Elevation Model (DEM) is constructed from a combination
    of ASTER and SPOT-5 DEM's for the ice sheet periphery and margin
    (i.e. below the equilbrium line elevation) south of
    approximately 82.5&deg;N and AVHRR photoclinometry in the ice sheet
    interior and far north (Scambos and Haran, 2002).

    SPOT-5 DEM's were produced and distributed as part of the Spot5
    stereoscopic survey of Polar Ice: Reference Images & Topographies
    (SPIRIT) project (Korona et al., 2009). Ocean surfaces were masked
    using the GIMP Land Classification mask and replaced with the
    CNES CLS11 mean sea surface height (Schaeffer et al., 2012).

    **Note**

    *   All land elevation data is horizontally and vertically registered
    to average ICESat elevations for the 2003-2009 time period, and
    therefore the DEM has a nominal date of 2007, although care must
    be taken when using the DEM in areas of rapid change, such as
    major outlet glaciers south of 70&deg;0N.
    *   The DEM has a resolution of 30 m, although the \"true\" resolution of the
    DEM will vary from 40 m in areas of SPOT-5 coverage
    (see Korona et al. 2009) to 500 m in areas of photoclinometry.
    *   The ice-sheet-wide root-mean-squared validation error
    relative to ICESat is +/-10 m, rangining from close to +/- 1 m
    over most ice surfaces to +/- 30 m in areas of high relief.

    [General documentation](https://doi.org/10.5067/NV34YUIXLP9W)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: 'cite-as',
      href: 'https://doi.org/10.5067/NV34YUIXLP9W',
    },
  ],
  keywords: [
    'arctic',
    'gimp',
    'greenland',
    'nasa',
    'polar',
  ],
  providers: [
    ee.producer_provider('NASA NSIDC DAAC at CIRES', 'https://doi.org/10.5067/NV34YUIXLP9W'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1458574534-NSIDC_ECS',
  ],
  extent: ee.extent(-89.32179714240877, 58.795926930232035, 7.556480769227746, 83.95392768557056,
                    '1999-06-30T00:00:00Z', '2002-09-04T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'elevation',
        description: 'Elevation',
        'gee:units': 'Meters',
        gsd: 30.0,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Elevation',
        lookat: {
          lat: 76.0,
          lon: -41.0,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              2000.0,
            ],
            bands: [
              'elevation',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5067/NV34YUIXLP9W',
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
