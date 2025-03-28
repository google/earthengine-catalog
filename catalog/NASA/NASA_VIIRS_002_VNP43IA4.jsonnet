local id = 'NASA/VIIRS/002/VNP43IA4';
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local quality_bands = ['I1', 'I2', 'I3'];

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
  title: 'VNP43IA4: BRDF/Albedo Quality Daily L3 Global 500m SIN Grid',
  version: '002',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The NASA/NOAA Suomi National Polar-orbiting Partnership (Suomi NPP) Visible
    Infrared Imaging Radiometer Suite (VIIRS) Nadir Bidirectional Reflectance
    Distribution Function (BRDF) Adjusted Reflectance (NBAR) Version 2 product
    provides NBAR estimates at 500 meter resolution. The VNP43IA4 product is
    produced daily using 16 days of VIIRS data and is weighted temporally to the
    ninth day, which is reflected in the file name. The view angle effects are
    removed from the directional reflectances, resulting in a stable and
    consistent NBAR product. The VNP43 data products are designed to promote the
    continuity of NASA's Moderate Resolution Imaging Spectroradiometer (MODIS)
    BRDF/Albedo data product suite.

    The VNP43 algorithm uses the RossThick/Li-Sparse-Reciprocal (RTLSR)
    semi-empirical kernel-driven BRDF model, with the three kernel weights from
    VNP43IA1 to reconstruct surface anisotropic effects, correcting the
    directional reflectance to a common view geometry (VNP43IA4), while
    also computing integrated black-sky albedo (BSA) at local solar noon and
    white-sky albedo (WSA) (VNP43IA3). Researchers can use the BRDF model
    parameters with a simple polynomial, to obtain black-sky albedo at any solar
    illumination angle. Likewise, both the BSA and WSA Science Dataset (SDS)
    layers can be used with a simple polynomial, to manually estimate
    instantaneous actual albedo (blue-sky albedo). Additional details regarding
    the methodology are available in the Algorithm Theoretical Basis Document
    (ATBD).

    Documentation:

    * [User's Guide](https://www.umb.edu/spectralmass/viirs-user-guides-c1-and-c2/vnp43ia4-and-vnpma4-nbar-products/)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/194/VNP43_ATBD_V1.pdf)

    * [General Documentation](https://lpdaac.usgs.gov/products/vnp43ia4v002/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/VIIRS/VNP43IA4.002',
    },
  ],
  'gee:categories': ['satellite-imagery'],
  keywords: [
    'land',
    'nasa',
    'noaa',
    'surface',
    'viirs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/VIIRS/VNP43IA4.002'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2545314592-LPCLOUD',
  ],
  extent: ee.extent_global('2012-01-17T00:00:00Z', null),
  summaries: {
    gsd: [
      500.0,
    ],
    platform: [
      'Suomi NPP',
    ],
    instruments: [
      'VIIRS',
    ],
    'eo:bands': [
      {
        name: 'BRDF_Albedo_Band_Mandatory_Quality_' + band,
        description: 'BRDF/Albedo mandatory quality for band ' + band,
      }
      for band in quality_bands
    ] + [
      {
        name: 'Nadir_Reflectance_' + band,
        description: |||
          Nadir BRDF/Albedo Reflectance at local solar noon for band
        ||| + band,
      }
      for band in quality_bands
    ],
    'gee:visualizations': [
      {
        display_name: 'BRDF/Albedo mandatory quality for band I1',
        lookat: {
          lat: 80,
          lon: 66,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              1,
            ],
            palette: [
              '000080',
              '0000d9',
              '4000ff',
              '8000ff',
              '0080ff',
              '00ffff',
              '00ff80',
              '80ff00',
              'daff00',
              'ffff00',
              'fff500',
              'ffda00',
              'ffb000',
              'ffa400',
              'ff4f00',
              'ff2500',
              'ff0a00',
              'ff00ff',
            ],
            bands: [
              'BRDF_Albedo_Band_Mandatory_Quality_I1',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5067/VIIRS/VNP43IA4.002',
  'sci:citation': |||
    Schaaf, C., Z. Wang, A. Erb, I. Paynter. VIIRS/NPP BRDF/Albedo Nadir
    BRDF-Adjusted Ref Daily L3 Global 500m SIN Grid V002. 2024, distributed by
    NASA EOSDIS Land Processes Distributed Active Archive Center,
    [10.5067/VIIRS/VNP43IA4.002](https://doi.org/10.5067/VIIRS/VNP43IA4.002).
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    LP DAAC NASA data are freely accessible; however, when an author
    publishes these data or works based on the data, it is requested that the
    author cite the datasets within the text of the publication and include a
    reference to them in the reference list.
  |||,
}
