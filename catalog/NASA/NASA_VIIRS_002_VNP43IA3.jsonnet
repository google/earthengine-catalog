local id = 'NASA/VIIRS/002/VNP43IA3';
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
  title: 'VNP43IA3: BRDF/Albedo Daily L3 Global 500m SIN Grid',
  version: '002',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The NASA/NOAA Suomi National Polar-orbiting Partnership (Suomi NPP) Visible
    Infrared Imaging Radiometer Suite (VIIRS) Bidirectional Reflectance
    Distribution Function (BRDF) and Albedo (BRDF/Albedo) Version 2 product
    provides albedo estimates at 500 meter resolution. The VNP43IA3 product is
    produced daily using 16 days of VIIRS data and is weighted temporally to the
    ninth day, which is reflected in the file name. It provides both directional
    hemispherical reflectance (black-sky albedo) at local solar noon and
    bihemispherical reflectance (white-sky albedo) for the three VIIRS imagery
    bands (I1, I2, and I3). The VNP43 data products are designed to promote the
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

    * [User's Guide](https://www.umb.edu/spectralmass/viirs-user-guides-c1-and-c2/vnp43ia3-and-vnp43ma3-albedo-products/)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/194/VNP43_ATBD_V1.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/VIIRS/1/VNP43IA3)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/VIIRS/VNP43IA3.002',
    },
  ],
  'gee:categories': ['satellite-imagery'],
  keywords: [
    'albedo',
    'land',
    'nasa',
    'noaa',
    'surface',
    'viirs',
    'brdf',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/VIIRS/VNP43IA3.002'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2545314588-LPCLOUD',
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
        name: 'Albedo_BSA_' + band,
        description: 'Black-sky albedo for band ' + band,
      }
      for band in quality_bands
    ] + [
      {
        name: 'Albedo_WSA_' + band,
        description: 'White-sky albedo for band ' + band,
      }
      for band in quality_bands
    ],
    'gee:visualizations': [
      {
        display_name: 'Black-sky albedo for band I1',
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
              400,
            ],
            bands: [
              'Albedo_BSA_I1',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5067/VIIRS/VNP43IA3.002',
  'sci:citation': |||
    Schaaf, C., Z. Wang, A. Erb, I. Paynter. VIIRS/NPP BRDF/Albedo Albedo Daily L3
    Global 500m SIN Grid V002. 2024, distributed by NASA EOSDIS Land Processes
    Distributed Active Archive Center,
    [10.5067/VIIRS/VNP43IA3.002](https://doi.org/10.5067/VIIRS/VNP43IA3.002).
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
