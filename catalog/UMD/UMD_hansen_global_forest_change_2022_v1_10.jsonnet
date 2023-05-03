local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local versions = import 'versions.libsonnet';
local version_table = import 'UMD_hansen_global_forest_change.libsonnet';

local subdir = 'UMD';
local version = 'v1.10';
local version_config = versions(subdir, version_table, version);

local license = spdx.cc_by_4_0;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: version_config.id,
  title: 'Hansen Global Forest Change v1.10 (2000-2022)',
  version: version,
  'gee:type': ee_const.gee_type.image,
  description: |||
    Results from time-series analysis of Landsat images in characterizing
    global forest extent and change.

    The 'first' and 'last' bands are reference multispectral imagery from the
    first and last available years for Landsat spectral bands 3, 4, 5, and 7.
    Reference composite imagery represents median observations from a set of
    quality-assessed growing-season observations for each of these bands.

    Please see the [User Notes](https://storage.googleapis.com/earthenginepartners-hansen/GFC-2022-v1.10/download.html)
    for this Version 1.10 update, as well as the associated journal article:
    Hansen, Potapov, Moore, Hancher et al. "High-resolution global maps of
    21st-century forest cover change." Science 342.6160 (2013): 850-853.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, version_config.id) + [
    ee.link.license(license.reference)
  ] + version_config.version_links,
  keywords: [
    'forest',
    'geophysical',
    'hansen',
    'landsat_derived',
    'umd',
  ],
  providers: [
    ee.producer_provider('Hansen/UMD/Google/USGS/NASA', 'https://glad.earthengine.app/view/global-forest-change'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2022-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      30.92,
    ],
    'eo:bands': [
      {
        name: 'treecover2000',
        description: |||
          Tree canopy cover for year 2000, defined as canopy closure for all
          vegetation taller than 5m in height.
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'loss',
        description: |||
          Forest loss during the study period, defined as a stand-replacement
          disturbance (a change from a forest to non-forest state).
        |||,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Forest loss during the study period.',
              bit_count: 1,
              values: [
                {
                  description: 'Not loss',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Loss',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
      {
        name: 'gain',
        description: |||
          Forest gain during the period 2000-2012, defined as the inverse of
          loss (a non-forest to forest change entirely within the study
          period). Note that this has not been updated in subsequent versions.
        |||,
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Forest gain during the period 2000-2012.',
              bit_count: 1,
              values: [
                {
                  description: 'No gain',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Gain',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
      {
        name: 'first_b30',
        description: |||
          Landsat 7 band 3 (red) cloud-free image composite. Reference
          multispectral imagery from the first available year, typically 2000.
        |||,
        center_wavelength: 0.66,
        'gee:wavelength': '0.63-0.69&micro;m',
      },
      {
        name: 'first_b40',
        description: |||
          Landsat 7 band 4 (NIR) cloud-free image composite. Reference
          multispectral imagery from the first available year, typically 2000.
        |||,
        center_wavelength: 0.835,
        'gee:wavelength': '0.77-0.90&micro;m',
      },
      {
        name: 'first_b50',
        description: |||
          Landsat 7 band 5 (SWIR) cloud-free image composite. Reference
          multispectral imagery from the first available year, typically 2000.
        |||,
        center_wavelength: 1.65,
        'gee:wavelength': '1.55-1.75&micro;m',
      },
      {
        name: 'first_b70',
        description: |||
          Landsat 7 band 7 (SWIR) cloud-free image composite. Reference
          multispectral imagery from the first available year, typically 2000.
        |||,
        center_wavelength: 2.22,
        'gee:wavelength': '2.09-2.35&micro;m',
      },
      {
        name: 'last_b30',
        description: |||
          Landsat 7 band 3 (red) cloud-free image composite. Reference
          multispectral imagery from the last available year, typically the last
          year of the study period.
        |||,
        center_wavelength: 0.66,
        'gee:wavelength': '0.63-0.69&micro;m',
      },
      {
        name: 'last_b40',
        description: |||
          Landsat 7 band 4 (NIR) cloud-free image composite. Reference
          multispectral imagery from the last available year, typically the last
          year of the study period.
        |||,
        center_wavelength: 0.835,
        'gee:wavelength': '0.77-0.90&micro;m',
      },
      {
        name: 'last_b50',
        description: |||
          Landsat 7 band 5 (SWIR) cloud-free image composite. Reference
          multispectral imagery from the last available year, typically the last
          year of the study period.
        |||,
        center_wavelength: 1.65,
        'gee:wavelength': '1.55-1.75&micro;m',
      },
      {
        name: 'last_b70',
        description: |||
          Landsat 7 band 7 (SWIR) cloud-free image composite. Reference
          multispectral imagery from the last available year, typically the last
          year of the study period.
        |||,
        center_wavelength: 2.22,
        'gee:wavelength': '2.09-2.35&micro;m',
      },
      {
        name: 'datamask',
        description: 'Three values representing areas of no data, mapped land surface, and permanent water bodies.',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Three values representing areas of no data, mapped land surface, and permanent water bodies.',
              bit_count: 2,
              values: [
                {
                  description: 'No data',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Mapped land surface',
                },
                {
                  value: 2,
                  description: 'Permanent water bodies',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 2,
        },
      },
      {
        name: 'lossyear',
        description: |||
          Year of gross forest cover loss event. Forest loss during the study
          period, defined as a stand-replacement disturbance, or a change from a
          forest to non-forest state. Encoded as either 0 (no loss) or else a value
          in the range 1-22, representing loss detected primarily in the year
          2001-2022, respectively.
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Tree Canopy Cover',
        lookat: {
          lat: -20.0,
          lon: -60.5,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              100.0,
            ],
            palette: [
              '3d3d3d',
              '080a02',
              '080a02',
              '080a02',
              '106e12',
              '37a930',
              '03ff17',
            ],
            bands: [
              'treecover2000',
            ],
          },
        },
      },
    ],
    treecover2000: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    lossyear: {
      minimum: 0.0,
      maximum: 22.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Hansen, M. C., P. V. Potapov, R. Moore, M. Hancher, S. A. Turubanova, A.
    Tyukavina, D. Thau, S. V. Stehman, S. J. Goetz, T. R. Loveland, A.
    Kommareddy, A. Egorov, L. Chini, C. O. Justice, and J. R. G. Townshend.
    2013. "High-Resolution Global Maps of 21st-Century Forest Cover Change."
    Science 342 (15 November): 850-53.
    [10.1126/science.1244693](https://doi.org/10.1126/science.1244693)
    Data available on-line at:
    [https://glad.earthengine.app/view/global-forest-change](https://glad.earthengine.app/view/global-forest-change).
  |||,
  'sci:doi': '10.1126/science.1244693',
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
