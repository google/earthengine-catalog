local id = 'NOAA/VIIRS/001/VNP43IA1';
local subdir = 'NOAA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local quality_bands = ['I1', 'I2', 'I3'];
local layer_bands = [
  {key:'fiso', value:'Isotropic parameter'},
  {key:'fvol', value:'Volumetric parameter'},
  {key:'fgeo', value:'Geometric parameter'},
];

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
  title: 'VNP43IA1: BRDF/Albedo Model Parameters Daily L3 Global 500m SIN Grid',
  version: '1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Suomi National Polar-Orbiting Partnership (Suomi NPP) NASA Visible
    Infrared Imaging Radiometer Suite (VIIRS) Bidirectional Reflectance
    Distribution Function (BRDF) and Albedo Model Parameters (VNP43IA1) Version
    1 product provides kernel weights (parameters) at 500 resolution. The
    VNP43IA1 product is produced daily using 16 days of VIIRS data, temporally
    weighted to the ninth day, which is reflected in the file name. The VNP43IA1
    product provides three spectrally dependent kernel weights, also known as
    model parameters: isotropic (fiso), volumetric (fvol), and geometric (fgeo),
    which can be used to model anisotropic effects of the Earth's surface.
    All VNP43 data products are designed to promote the continuity of
    NASA's Moderate Resolution Imaging Spectroradiometer (MODIS)
    BRDF/Albedo data product suite.

    Documentation:

    * [User's Guide](https://www.umb.edu/spectralmass/viirs-user-guide/vnp43ia1-and-vnp43ma1-brdf-albedo-model-parameters)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/194/VNP43_ATBD_V1.pdf)

    * [General Documentation](https://lpdaac.usgs.gov/products/vnp43ia1v001/)

    * [Land Product Quality Assessment website](https://landweb.modaps.eosdis.nasa.gov/browse?sensor=VIIRS&sat=SNPP)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/VIIRS/VNP43IA1.001',
    },
  ],
  keywords: [
    'land',
    'nasa',
    'noaa',
    'surface',
    'viirs',
  ],
  providers: [
    ee.producer_provider(
      'NASA LP DAAC at the USGS EROS Center',
      'https://doi.org/10.5067/VIIRS/VNP43IA1.001'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1407099489-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2012-01-17T00:00:00Z', null),
  summaries: {
    gsd: [500],
    platform: ['Suomi NPP'],
    instruments: ['VIIRS'],
    'eo:bands': [
      {
        name: 'BRDF_Albedo_Band_Mandatory_Quality_' + band,
        description: 'BRDF/Albedo mandatory quality for band ' + band,
        'gee:classes': [
          {value: 0, description: 'Full BRDF inversions'},
          {value: 1, description: 'Magnitude BRDF inversions',
          },
        ],
      }
      for band in quality_bands
    ] + [
      {
        name: 'BRDF_Albedo_Parameters_' + layer.key + '_' + band,
        description: layer.value + ' for band ' + band,
      }
      for band in quality_bands
      for layer in layer_bands
    ],
    'gee:visualizations': [
      {
        display_name: 'Isotropic parameter for band I1',
        lookat: {lon: 89, lat: 58, zoom: 3},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [255],
            palette: [
              '000080', '0000d9', '4000ff', '8000ff', '0080ff', '00ffff',
              '00ff80', '80ff00', 'daff00', 'ffff00', 'fff500', 'ffda00',
              'ffb000', 'ffa400', 'ff4f00', 'ff2500', 'ff0a00', 'ff00ff',
            ],
            bands: ['BRDF_Albedo_Parameters_fiso_I1'],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5067/VIIRS/VNP43IA1.001',
  'sci:citation': |||
    Please visit
    [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
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
