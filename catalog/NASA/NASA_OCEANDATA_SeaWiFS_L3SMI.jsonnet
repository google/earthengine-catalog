local id = 'NASA/OCEANDATA/SeaWiFS/L3SMI';
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
  title: 'Ocean Color SMI: Standard Mapped Image SeaWiFS Data',
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

    * [Processing History](https://oceancolor.gsfc.nasa.gov/data/reprocessing)

    - There are number of missing data dates in this dataset. For example,
      most dates are missing between 2009-04-29 and 2009-12-01.

    - The estimated values for POC might be a result of the data being generated
      without a scale. For more information, visit the
      [SeaWiFS OceanData](https://oceancolor.gsfc.nasa.gov/about/missions/seawifs)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/ORBVIEW-2/SEAWIFS/L3M/CHL/2018',
    },
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/ORBVIEW-2/SEAWIFS/L3M/POC/2018',
    },
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/ORBVIEW-2/SEAWIFS/L3M/RRS/2018',
    },
  ],
  keywords: [
    'biology',
    'chlorophyll',
    'climate',
    'nasa',
    'ocean',
    'oceandata',
    'reflectance',
    'seawifs',
    'temperature',
    'weather',
  ],
  providers: [
    ee.producer_provider('NASA OB.DAAC at NASA Goddard Space Flight Center', 'https://oceancolor.gsfc.nasa.gov/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1449645599-OB_DAAC',
    'C1449645607-OB_DAAC',
    'C1449645609-OB_DAAC',
  ],
  extent: ee.extent_global('1997-09-04T15:26:33Z', '2010-12-10T19:42:17Z'),
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
        name: 'Rrs_490_lastModified',
        description: 'Last date this product was modified',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_490_software_name',
        description: "'smigen' or 'l3mapgen'; name of the software used to create\nthis product",
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_490_software_version',
        description: 'Version of the software used to create this product',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_510_lastModified',
        description: 'Last date this product was modified',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_510_software_name',
        description: "'smigen' or 'l3mapgen'; name of the software used to create\nthis product",
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_510_software_version',
        description: 'Version of the software used to create this product',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_670_lastModified',
        description: 'Last date this product was modified',
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_670_software_name',
        description: "'smigen' or 'l3mapgen'; name of the software used to create\nthis product",
        type: ee_const.var_type.string,
      },
      {
        name: 'Rrs_670_software_version',
        description: 'Version of the software used to create this product',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      9200.0,
    ],
    'eo:bands': [
      {
        name: 'chlor_a',
        description: 'Chlorophyll a concentration',
        'gee:units': units.density_mg_per_m_cubed,
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
        name: 'Rrs_490',
        description: 'Remote sensing reflectance at band 469nm',
        'gee:units': 'sr-1',
        center_wavelength: 0.49,
        'gee:wavelength': '490nm',
      },
      {
        name: 'Rrs_510',
        description: 'Remote sensing reflectance at band 488nm',
        'gee:units': 'sr-1',
        center_wavelength: 0.51,
        'gee:wavelength': '510nm',
      },
      {
        name: 'Rrs_555',
        description: 'Remote sensing reflectance at band 555nm',
        'gee:units': 'sr-1',
        center_wavelength: 0.555,
        'gee:wavelength': '555nm',
      },
      {
        name: 'Rrs_670',
        description: 'Remote sensing reflectance at band 531nm',
        'gee:units': 'sr-1',
        center_wavelength: 0.67,
        'gee:wavelength': '670nm',
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
              0.03,
            ],
            bands: [
              'Rrs_670',
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
    Rrs_412: {
      minimum: 0.0,
      maximum: 0.11,
      'gee:estimated_range': true,
    },
    Rrs_443: {
      minimum: 0.0,
      maximum: 0.11,
      'gee:estimated_range': true,
    },
    Rrs_490: {
      minimum: 0.0,
      maximum: 0.11,
      'gee:estimated_range': true,
    },
    Rrs_510: {
      minimum: 0.0,
      maximum: 0.11,
      'gee:estimated_range': true,
    },
    Rrs_555: {
      minimum: 0.0,
      maximum: 0.11,
      'gee:estimated_range': true,
    },
    Rrs_670: {
      minimum: 0.0,
      maximum: 0.11,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.5067/ORBVIEW-2/SEAWIFS/L3M/CHL/2018',
  'sci:citation': |||
    NASA Goddard Space Flight Center, Ocean Ecology Laboratory, Ocean Biology
    Processing Group. Sea-viewing Wide Field-of-view Sensor (SeaWiFS) Data,
    NASA OB.DAAC, Greenbelt, MD, USA.
    [doi:10.5067/ORBVIEW-2/SEAWIFS/L1/DATA/1](
      https://doi.org/10.5067/ORBVIEW-2/SEAWIFS/L1/DATA/1)
  |||,
  'sci:publications': [
    {
      citation: |||
        NASA Ocean Biology Processing Group. (2018). <i>SEAWIFS-ORBVIEW-2 Level
        3 Mapped Particulate Organic Carbon Data Version R2018.0</i> [Data
        set]. NASA Ocean Biology DAAC.
      |||,
      doi: '10.5067/ORBVIEW-2/SEAWIFS/L3M/POC/2018',
    },
    {
      citation: |||
        NASA Ocean Biology Processing Group. (2018). <i>SEAWIFS-ORBVIEW-2 Level
        3 Mapped Remote-Sensing Reflectance Data Version R2018.0</i> [Data
        set]. NASA Ocean Biology DAAC.
      |||,
      doi: '10.5067/ORBVIEW-2/SEAWIFS/L3M/RRS/2018'
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
    Earth Science Data & Information Policy](
      https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
}
