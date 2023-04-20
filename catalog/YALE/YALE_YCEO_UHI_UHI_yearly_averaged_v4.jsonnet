local id = 'YALE/YCEO/UHI/UHI_yearly_averaged/v4';
local subdir = 'YALE';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

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
  title: 'YCEO Surface Urban Heat Islands: Spatially-Averaged Yearly Composites of Annual Daytime and Nighttime Intensity',
  version: '4',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset contains annual, summertime, and wintertime surface urban
    heat island (SUHI) intensities for day and night for over 10,000 urban clusters
    throughout the world. The dataset was created using the MODIS 8-day TERRA and
    AQUA land surface temperature (LST) products, the Landscan urban extent
    database, the Global Multi-resolution Terrain Elevation Data 2010, and the
    European Space Agency (ESA) Climate Change Initiative (CCI) land cover data
    using the Simplified Urban-Extent Algorithm. The product is available both at
    the pixel level (at 300 m resolution after downscaling) and as urban cluster
    means from 2003 to 2018. The monthly composites are only available as urban
    cluster means.

    A summary of older versions,
    including changes from the dataset created and analyzed in the originally
    published manuscript can be found on the
    [Yale Center for Earth Observation website](https://yceo.yale.edu/research/global-surface-uhi-explorer).
    The dataset can also be explored using the [Global Surface UHI
    Explorer web application](https://yceo.users.earthengine.app/view/uhimap).

    The dataset is split into the following six components:

    1. **UHI_all_averaged:** Image containing cluster-mean
    composite daytime and nighttime SUHI intensity for annual, summer,
    and winter.

    2. **UHI_monthly_averaged:** Image containing cluster-mean
    monthly composites of daytime and nighttime SUHI intensity.

    3. **UHI_yearly_averaged:** Image collection of cluster-mean
    yearly composites of daytime and nighttime SUHI intensity from 2003.
    to 2018.

    4. **UHI_yearly_pixel:** Image collection of spatially
    disaggregated (nominal scale of 300 m) annual daytime and nighttime
    SUHI intensity from 2003 to 2018.

    5. **Summer_UHI_yearly_pixel:** Image collection of spatially
    disaggregated (nominal scale of 300 m) summertime daytime and
    nighttime SUHI intensity from 2003 to 2018.

    6. **Winter_UHI_yearly_pixel:** Image collection of spatially
    disaggregated (nominal scale of 300 m) wintertime daytime and
    nighttime SUHI intensity from 2003 to 2018.

    This asset is the third component.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license('https://yceo.yale.edu/research/global-surface-uhi-explorer'),
  ],
  keywords: [
    'climate',
    'uhi',
    'urban',
    'yale',
  ],
  providers: [
    ee.producer_provider('Yale Center for Earth Observation (YCEO)', 'https://yceo.yale.edu/research/global-surface-uhi-explorer'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -49.98, 180.0, 69.7,
                    '2003-01-01T00:00:00Z', '2018-12-31T00:00:00Z'),
  summaries: {
    gsd: [
      300.0,
    ],
    'eo:bands': [
      {
        name: 'Daytime',
        description: 'Daytime UHI',
        'gee:units': units.celsius,
      },
      {
        name: 'Nighttime',
        description: 'Nighttime UHI',
        'gee:units': units.celsius,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Daytime UHI',
        lookat: {
          lat: 40.6,
          lon: -74.7,
          zoom: 7,
        },
        image_visualization: {
          band_vis: {
            min: [
              -1.5,
            ],
            max: [
              7.5,
            ],
            palette: [
              '313695',
              '74add1',
              'fed976',
              'feb24c',
              'fd8d3c',
              'fc4e2a',
              'e31a1c',
              'b10026',
            ],
            bands: [
              'Daytime',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Chakraborty, T., & Lee, X. (2019). A simplified urban-extent algorithm
    to characterize surface urban heat islands on a global scale and examine
    vegetation control on their spatiotemporal variability. International
    Journal of Applied Earth Observation and Geoinformation, 74, 269-280.
    [doi:10.1016/j.jag.2018.09.015](https://doi.org/10.1016/j.jag.2018.09.015)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
