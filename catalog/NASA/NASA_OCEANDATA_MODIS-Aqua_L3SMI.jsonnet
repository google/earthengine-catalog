local id = 'NASA/OCEANDATA/MODIS-Aqua/L3SMI';
local subdir = 'NASA';

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
  ],
  id: id,
  title: 'Ocean Color SMI: Standard Mapped Image MODIS Aqua Data',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This level 3 product includes ocean color and satellite ocean biology data
    produced or collected under [EOSDIS](https://earthdata.nasa.gov/about).

    This dataset may be used for studying the biology and hydrology of
    coastal zones, changes in the diversity and geographical distribution of
    coastal marine habitats, biogeochemical fluxes and their influence in
    Earth's oceans and climate over time, and finally the impact of
    climate and environmental variability and change on ocean ecosystems
    and the biodiversity they support.

    Scale factor and offset are already applied.

    Documentation:

    * [Ocean Color Forum](https://oceancolor.gsfc.nasa.gov/forum/oceancolor/forum_show.pl)

    * [Chlorophyll Forum](https://oceancolor.gsfc.nasa.gov/forum/oceancolor/forum_show.pl)

    * [Algorithm Theoretical Basis Document (Chlorophyll)](https://oceancolor.gsfc.nasa.gov/resources/atbd/chlor_a)

    * [Algorithm Theoretical Basis Document (Fluorescence Line Height)](https://oceancolor.gsfc.nasa.gov/resources/atbd/nflh)

    * [Algorithm Theoretical Basis Document (Particulate Organic Carbon)](https://oceancolor.gsfc.nasa.gov/resources/atbd/poc)

    * [Algorithm Theoretical Basis Document (Remote-Sensing Reflectance)](https://oceancolor.gsfc.nasa.gov/resources/atbd/rrs)

    * [Processing History](https://oceancolor.gsfc.nasa.gov/reprocessing)

    Newer datasets have scaled POC values while older ones don't. This
    scaling gets rid of negative values but older datasets still retain them
    hence the -2147.48 estimated minimum value. For more information, visit the
    [Ocean Color Forum](https://oceancolor.gsfc.nasa.gov/forum/oceancolor/topic_show.pl?pid=33202;hl=poc%20values).

    [MODIS-Aqua OceanData](https://oceancolor.gsfc.nasa.gov/about/missions/aqua/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/GHMDA-2PJ19',
    },
  ],
  keywords: [
    'biology',
    'chlorophyll',
    'climate',
    'modis',
    'nasa',
    'ocean',
    'oceandata',
    'reflectance',
    'sst',
    'temperature',
    'weather',
  ],
  providers: [
    ee.producer_provider('NASA OB.DAAC at NASA Goddard Space Flight Center', 'https://oceancolor.gsfc.nasa.gov/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1442922862-OB_DAAC',
    'C1442922863-OB_DAAC',
    'C1442922871-OB_DAAC',
    'C1442922873-OB_DAAC',
    'C1615905770-OB_DAAC',
  ],
  extent: ee.extent_global('2002-07-03T23:40:05Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'Rrs_412_lastModified',
        description: 'Last date this product was modified',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_412_software_name',
        description: "'smigen' or 'l3mapgen'; name of the software used to create\nthis product",
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_412_software_version',
        description: 'Version of the software used to create this product',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_443_lastModified',
        description: 'Last date this product was modified',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_443_software_name',
        description: "'smigen' or 'l3mapgen'; name of the software used to create\nthis product",
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_443_software_version',
        description: 'Version of the software used to create this product',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_555_lastModified',
        description: 'Last date this product was modified',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_555_software_name',
        description: "'smigen' or 'l3mapgen'; name of the software used to create\nthis product",
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_555_software_version',
        description: 'Version of the software used to create this product',
        type: ee_const.var_type.string,
      },
      {
        name: 'chlor_a_lastModified',
        description: 'Last date this product was modified',
        type: ee_const.var_type.string,
      },
      {
        name: 'chlor_a_software_name',
        description: "'smigen' or 'l3mapgen'; name of the software used to create\nthis product",
        type: ee_const.var_type.string,
      },
      {
        name: 'chlor_a_software_version',
        description: 'Version of the software used to create this product',
        type: ee_const.var_type.string,
      },
      {
        name: 'poc_lastModified',
        description: 'Last date this product was modified',
        type: ee_const.var_type.string,
      },
      {
        name: 'poc_software_name',
        description: "'smigen' or 'l3mapgen'; name of the software used to create\nthis product",
        type: ee_const.var_type.string,
      },
      {
        name: 'poc_software_version',
        description: 'Version of the software used to create this product',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_469_lastModified',
        description: 'Last date this product was modified',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_469_software_name',
        description: "'smigen' or 'l3mapgen'; name of the software used to create\nthis product",
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_469_software_version',
        description: 'Version of the software used to create this product',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_488_lastModified',
        description: 'Last date this product was modified',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_488_software_name',
        description: "'smigen' or 'l3mapgen'; name of the software used to create\nthis product",
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_488_software_version',
        description: 'Version of the software used to create this product',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_531_lastModified',
        description: 'Last date this product was modified',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_531_software_name',
        description: "'smigen' or 'l3mapgen'; name of the software used to create\nthis product",
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_531_software_version',
        description: 'Version of the software used to create this product',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_547_lastModified',
        description: 'Last date this product was modified',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_547_software_name',
        description: "'smigen' or 'l3mapgen'; name of the software used to create\nthis product",
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_547_software_version',
        description: 'Version of the software used to create this product',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_645_lastModified',
        description: 'Last date this product was modified',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_645_software_name',
        description: "'smigen' or 'l3mapgen'; name of the software used to create\nthis product",
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_645_software_version',
        description: 'Version of the software used to create this product',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_667_lastModified',
        description: 'Last date this product was modified',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_667_software_name',
        description: "'smigen' or 'l3mapgen'; name of the software used to create\nthis product",
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_667_software_version',
        description: 'Version of the software used to create this product',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_678_lastModified',
        description: 'Last date this product was modified',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_678_software_name',
        description: "'smigen' or 'l3mapgen'; name of the software used to create\nthis product",
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_678_software_version',
        description: 'Version of the software used to create this product',
        type: ee_const.var_type.string,
      },
      {
        name: 'nflh_lastModified',
        description: 'Last date this product was modified',
        type: ee_const.var_type.string,
      },
      {
        name: 'nflh_software_name',
        description: "'smigen' or 'l3mapgen'; name of the software used to create\nthis product",
        type: ee_const.var_type.string,
      },
      {
        name: 'nflh_software_version',
        description: 'Version of the software used to create this product',
        type: ee_const.var_type.string,
      },
      {
        name: 'sst_lastModified',
        description: 'Last date this product was modified',
        type: ee_const.var_type.string,
      },
      {
        name: 'sst_software_name',
        description: "'smigen' or 'l3mapgen'; name of the software used to create\nthis product",
        type: ee_const.var_type.string,
      },
      {
        name: 'sst_software_version',
        description: 'Version of the software used to create this product',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      4616.0,
    ],
    'eo:bands': [
      {
        name: 'chlor_a',
        description: 'Chlorophyll a concentration',
        'gee:units': units.density_mg_per_m_cubed,
      },
      {
        name: 'nflh',
        description: 'Normalized fluorescence line height',
        'gee:units': 'mW cm-2 &mu;m-1 sr-1',
      },
      {
        name: 'poc',
        description: 'Particulate organic carbon',
        'gee:units': units.density_mg_per_m_cubed,
      },
      {
        name: 'Rrs_412',
        description: 'Remote sensing reflectance at band 412nm',
        'gee:units': 'sr-1',
        center_wavelength: 0.412,
        'gee:wavelength': '412nm',
      },
      {
        name: 'Rrs_443',
        description: 'Remote sensing reflectance at band 443nm',
        'gee:units': 'sr-1',
        center_wavelength: 0.443,
        'gee:wavelength': '443nm',
      },
      {
        name: 'Rrs_469',
        description: 'Remote sensing reflectance at band 469nm',
        'gee:units': 'sr-1',
        center_wavelength: 0.469,
        'gee:wavelength': '469nm',
      },
      {
        name: 'Rrs_488',
        description: 'Remote sensing reflectance at band 488nm',
        'gee:units': 'sr-1',
        center_wavelength: 0.488,
        'gee:wavelength': '488nm',
      },
      {
        name: 'Rrs_531',
        description: 'Remote sensing reflectance at band 531nm',
        'gee:units': 'sr-1',
        center_wavelength: 0.531,
        'gee:wavelength': '531nm',
      },
      {
        name: 'Rrs_547',
        description: 'Remote sensing reflectance at band 547nm',
        'gee:units': 'sr-1',
        center_wavelength: 0.547,
        'gee:wavelength': '547nm',
      },
      {
        name: 'Rrs_555',
        description: 'Remote sensing reflectance at band 555nm',
        'gee:units': 'sr-1',
        center_wavelength: 0.555,
        'gee:wavelength': '555nm',
      },
      {
        name: 'Rrs_645',
        description: 'Remote sensing reflectance at band 645nm',
        'gee:units': 'sr-1',
        center_wavelength: 0.645,
        'gee:wavelength': '645nm',
      },
      {
        name: 'Rrs_667',
        description: 'Remote sensing reflectance at band 667nm',
        'gee:units': 'sr-1',
        center_wavelength: 0.667,
        'gee:wavelength': '667nm',
      },
      {
        name: 'Rrs_678',
        description: 'Remote sensing reflectance at band 678nm',
        'gee:units': 'sr-1',
        center_wavelength: 0.678,
        'gee:wavelength': '678nm',
      },
      {
        name: 'sst',
        description: 'Sea surface temperature',
        'gee:units': units.celsius,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Remote Sensing Reflectance',
        lookat: {
          lat: -46.13,
          lon: -52.12,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              0.011,
            ],
            bands: [
              'Rrs_645',
              'Rrs_555',
              'Rrs_443',
            ],
          },
        },
      },
    ],
    chlor_a: {
      minimum: 0.0,
      maximum: 99.99,
      'gee:estimated_range': true,
    },
    nflh: {
      minimum: -0.5,
      maximum: 5.03,
      'gee:estimated_range': true,
    },
    poc: {
      minimum: -2147.48,
      maximum: 12953.4,
      'gee:estimated_range': true,
    },
    Rrs_412: {
      minimum: 0.0,
      maximum: 0.11,
      'gee:estimated_range': true,
    },
    Rrs_443: {
      minimum: 0.0,
      maximum: 0.08,
      'gee:estimated_range': true,
    },
    Rrs_469: {
      minimum: 0.0,
      maximum: 0.08,
      'gee:estimated_range': true,
    },
    Rrs_488: {
      minimum: 0.0,
      maximum: 0.08,
      'gee:estimated_range': true,
    },
    Rrs_531: {
      minimum: 0.0,
      maximum: 0.07,
      'gee:estimated_range': true,
    },
    Rrs_547: {
      minimum: 0.0,
      maximum: 0.07,
      'gee:estimated_range': true,
    },
    Rrs_555: {
      minimum: 0.0,
      maximum: 0.07,
      'gee:estimated_range': true,
    },
    Rrs_645: {
      minimum: 0.0,
      maximum: 0.05,
      'gee:estimated_range': true,
    },
    Rrs_667: {
      minimum: 0.0,
      maximum: 0.04,
      'gee:estimated_range': true,
    },
    Rrs_678: {
      minimum: 0.0,
      maximum: 0.04,
      'gee:estimated_range': true,
    },
    sst: {
      minimum: -2.0,
      maximum: 40.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    NASA Goddard Space Flight Center, Ocean Ecology Laboratory, Ocean Biology
    Processing Group. Moderate-resolution Imaging Spectroradiometer
    (MODIS) Aqua Ocean Color Data, NASA OB.DAAC, Greenbelt, MD, USA.

    *   DOI: 10.5067/AQUA/MODIS/L3M/CHL/2018 [unrecoverable]
  |||,
  'sci:publications': [
    {
      citation: |||
        NASA Ocean Biology Processing Group. (2017). <i>MODIS-Aqua Level 3
        Mapped Fluorescent Line Height Data Version R2018.0</i> [Data set]. NASA
        Ocean Biology DAAC.

        *   DOI: 10.5067/AQUA/MODIS/L3M/FLH/2018 [unrecoverable]
      |||,
    },
    {
      citation: |||
        NASA Ocean Biology Processing Group. (2017). <i>MODIS-Aqua Level 3
        Mapped Particulate Organic Carbon Data Version R2018.0</i> [Data
        set]. NASA Ocean Biology DAAC.

        *   DOI: 10.5067/AQUA/MODIS/L3M/POC/2018 [unrecoverable]
      |||,
    },
    {
      citation: |||
        NASA Ocean Biology Processing Group. (2017). <i>MODIS-Aqua Level 3
        Mapped Remote-Sensing Reflectance Data Version R2018.0</i> [Data
        set]. NASA Ocean Biology DAAC.

        *   DOI: 10.5067/AQUA/MODIS/L3M/RRS/2018 [unrecoverable]
      |||,
    },
    {
      citation: |||
        NASA/JPL. (2020). <i>GHRSST Level 2P Global Sea Surface Skin Temperature
        from the Moderate Resolution Imaging Spectroradiometer (MODIS) on the
        NASA Aqua satellite (GDS2)</i> [Data set]. NASA Physical Oceanography
        DAAC.
      |||,
      doi: '10.5067/GHMDA-2PJ19',
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    This dataset is in the public domain and is available
    without restriction on use and distribution. See [NASA's
    Earth Science Data & Information Policy](https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
}
